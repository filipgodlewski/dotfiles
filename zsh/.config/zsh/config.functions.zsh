#!/bin/zsh


function _fzf_on_projects() {
  local bookmarks=$XDG_CACHE_HOME/bookmarks
  mkdir -p $bookmarks ~/personal ~/learning ~/projects ~/dotfiles

  local projects=(
    "${(@f)$(cat $bookmarks/list 2> /dev/null)}"
    "${(@f)$(fd -c never -t d -H --base-directory ~ -g \.git personal learning projects dotfiles | awk '{sub(/\/.git\//, "");print}')}"
  )

  echo ${(F)projects} \
  | fzf \
    --cycle \
    --header-first \
    --header 'Open project in neovim' \
    --height 100% \
    --border \
    --preview 'bat --color always --wrap auto --style plain $HOME/{}/README.*' \
    --preview-window down,80% \
}

function edit() {
  local selected=$(_fzf_on_projects)

  [[ -z $selected ]] && return 127
  cd $HOME/$selected
  nvim
  popd
}

function add() {
  local bookmarks=$XDG_CACHE_HOME/bookmarks
  mkdir -p $bookmarks
  [[ $(grep $1 $bookmarks/list) ]] || echo $1 >> $bookmarks
}

function remove() {
  local selected=$(_fzf_on_projects)

  [[ -z $selected ]] && return 127
  rip $HOME/$selected
}

function rationalise-dot() {
  [[ $LBUFFER = *.. ]] && LBUFFER+=/.. || LBUFFER+=.
}
zle -N rationalise-dot 
bindkey . rationalise-dot

bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search

if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi
