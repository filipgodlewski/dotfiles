command! Javac call java_workflow#compile()
command! -nargs=* -bang Java call java_workflow#run(<bang>0, [<f-args>])

nnoremap <silent> <Leader>jc :Javac<CR>
nnoremap <silent> <Leader>jr :Java<CR>
nnoremap <silent> <Leader>jf :silent! Javac<CR> :Java<CR>
