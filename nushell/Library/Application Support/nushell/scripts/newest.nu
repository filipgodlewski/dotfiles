export def brew [] {
    ^brew update
    ^brew upgrade
    ^brew upgrade --cask
    ^brew cleanup --prune=all
}

export def npm [] {
    ^npm install --global npm
    ^npm update --global
}
