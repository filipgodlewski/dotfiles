function TrailingCharacters()
    let l:save=winsaveview()
    keeppatterns %s/\s\+$//e
    if !exists('b:noInsertFinalNewline')
        keeppatterns $s/.\zs$/\r/e
    endif
    call winrestview(l:save)
endfunction

function LineReturn()
    if line("'\"") > 0 && line("'\"") <= line("$")
        if exists('b:noLineReturn')
            return
        endif
        execute 'normal! g`"zvzz'
    endif
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function InsertUS()
    execute 'r !echo $(git branch --show-current) | cut -d";" -f1'
    execute 'normal! ggdd'
    execute 'normal! A; CC'
    execute 'startinsert!'
endfunction

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction


