#!/usr/bin/env zsh

# For more info run: man zshoptions
# Changing Directories
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS
setopt PUSHD_SILENT

# Completion
setopt ALWAYS_TO_END
setopt AUTO_LIST
setopt AUTO_PARAM_SLASH
setopt AUTO_REMOVE_SLASH
setopt COMPLETE_IN_WORD
setopt HASH_LIST_ALL
setopt MENU_COMPLETE

# Expansion and Globbing
setopt BAD_PATTERN
setopt EXTENDED_GLOB

# History
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt SHARE_HISTORY

# Input/Output
setopt INTERACTIVE_COMMENTS
setopt PATH_DIRS
setopt RM_STAR_SILENT

# Job Control
setopt NOTIFY

# Prompting
setopt PROMPT_SUBST

# Shell Emulation
setopt NO_SH_WORD_SPLIT

# Zle
setopt NO_BEEP
