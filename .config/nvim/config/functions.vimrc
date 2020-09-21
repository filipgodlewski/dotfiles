function TrailingCharacters()
    let l:save=winsaveview()
    keeppatterns %s/\s\+$//e
    let lastLine = line('$')
    let lastNonblankLine = prevnonblank(lastLine)
    if lastLine > 0 && lastNonblankLine != lastLine
        silent! execute lastNonblankLine + 1 . ',$delete _'
    endif
    silent! execute 'set fileformat=unix'
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

function InsertUS()
    execute '0r !echo $(git branch --show-current) | cut -d";" -f1'
    execute 'normal! A; CC'
    execute 'startinsert!'
endfunction

function SaveOnLeave()
    if exists('b:noSaveOnLeave')
        return
    endif
    silent! execute 'w'
endfunction

function UT()
    execute '!pytest -vvlsx'
endfunction

function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
