function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

function! UserInput(message)
    call inputsave()
    let answer = input(a:message)
    call inputrestore()
    return answer
endfunction

function! ToggleCodeHelpers()
    execute "Semshi toggle"
    call deoplete#toggle()
endfunction

function! SearchForQuickFix()
    let g:quickfix_search = UserInput('Search globally for: ')
    let answer = confirm("What to do next?", "&List\n&Abort", 1)
    if answer == 1
        execute "silent! grep! '".g:quickfix_search."'"
        execute "cope"
        execute "set modifiable"
        return g:quickfix_search
    elseif answer == 2
        return
    endif
endfunction

function! ReplaceLocalList()
    let before = UserInput('Search locally for: ')
    let after = UserInput('Replace with: ')
    execute '%s/'.before.'/'.after.'/gc'
endfunction

function! SaveQuickFix()
    execute "silent! %s/|/:/"
    execute "silent! %s/ col /:/"
    execute "silent! %s/| /:/"
    execute "silent! w! /tmp/vim_quickfix_list"
    execute "silent! cg /tmp/vim_quickfix_list"
    execute "silent! cclo"
endfunction

function! ReplaceOnQuickFix(before)
    echo "Replace: ".a:before
    let after = UserInput('With: ')
    let cfdo_command = 'cfdo s/'.a:before.'/'.after.'/g | update'
    let choice = confirm("Is it ok?", "&Ok\n&Abort", 1)
    if choice == 1
        call ToggleCodeHelpers()
        execute cfdo_command
        call ToggleCodeHelpers()
    endif
endfunction
