function mv --wraps=mv --description 'mv and mdkir if missing' -a source destination
    command mkdir -p (dirname $destination) && command mv $source $destination
end
