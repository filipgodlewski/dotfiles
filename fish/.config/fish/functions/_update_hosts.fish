set -g emoji 🏡
set -g HOSTS_FILE /etc/hosts
set -g HOSTS_URL "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts"

function _update_hosts_download
    # Get sudo access, without it the script will fail...
    _update_assert_sudo hosts

    # Replace the old file with a new one...
    set -l message (_update_std_message "$emoji 🫨 Replacing %s file..." "hosts")
    gum spin --title "$message" --timeout 5m --show-error -- sudo curl $HOSTS_URL -o $HOSTS_FILE
    _update_status "$emoji" hosts replaced

    # Apply my custom whitelist...
    while read -la line
        set -l message (_update_std_message "$emoji 🫣 Whitelisting '%s'..." "$line")
        gum spin --title "$message" --timeout 5m --show-error -- sudo nvim --clean --headless "+g/$line/d" +x $HOSTS_FILE
        _update_status "$emoji" "$line" whitelisted
    end <~/dotfiles/.excluded/whitelist_hosts
end

function _update_hosts
    # First check if the hosts file even exists...
    if not test -e $HOSTS_FILE; or not test -s $HOSTS_FILE
        _update_hosts_download
        _update_status "$emoji" hosts downloaded
        return
    end

    # Check if the hosts file is even outdated compared to the remote file...
    set pattern '# Date: (\d{2} \w+ \d{4})'
    set local_file_date (head -n 6 $HOSTS_FILE | string match -rg $pattern; or echo "")
    set remote_file_date (curl --silent $HOSTS_URL | head -n 6 | string match -rg $pattern; or echo "")
    if string match -iq $remote_file_date $local_file_date
        _update_nothing "$emoji" hosts
        return
    end

    # Finally, download fresh file...
    _update_hosts_download
    _update_status "$emoji" hosts downloaded
end
