if [[ -z $TMUX ]]; then
  tmux new-session -s home 2>/dev/null || tmux a -t home
fi
