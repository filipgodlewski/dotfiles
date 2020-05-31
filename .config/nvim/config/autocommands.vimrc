au BufWritePre * call TrailingCharacters()
au BufReadPost * call LineReturn()
autocmd CursorHold * silent call CocActionAsync('highlight')

