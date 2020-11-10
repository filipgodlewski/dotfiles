function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

function! UserInput(message, completion)
    call inputsave()
    if a:completion != ''
        let l:answer = input(a:message, '', a:completion)
    else
        let l:answer = input(a:message)
    endif
    call inputrestore()
    return l:answer
endfunction

"function! ToggleCodeHelpers()
"    execute 'Semshi toggle'
"    call deoplete#toggle()
"endfunction

function! SearchForQuickFix()
    let g:quickfix_search = UserInput('Search globally for: ', '')
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
    if exists("g:before")
        let g:before = UserInput('Search locally for [last: '.g:before.']: ', 'tag')
    else
        let g:before = UserInput('Search locally for: ', 'tag')
    endif
    let after = UserInput('Replace with: ', '')
    execute '%s/'.g:before.'/'.after.'/gc'
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
    let after = UserInput('With: ', '')
    let quickfix_command = 'silent! cdo s/'.a:before.'/'.after.'/ | update'
    let choice = confirm("Is it ok?", "&Ok\n&Abort", 1)
    if choice == 1
        "call ToggleCodeHelpers()
        execute quickfix_command
        "call ToggleCodeHelpers()
    endif
endfunction

" Pytest

function! GetPTArg(arg)
    if a:arg == "f"
        let l:answer = UserInput("File path: ", "file")
        return l:answer == "" ? "" : '"'.l:answer.'"'
    elseif a:arg == "k"
        let l:answer = UserInput("Keyword expression: ", "")
        return l:answer == "" ? "" : ' -k "'.l:answer.'"'
    elseif a:arg == "m"
        let l:answer = UserInput("Mark expression: ", "")
        return l:answer == "" ? "" : ' -m "'.l:answer.'"'
    elseif a:arg == "c"
        let l:answer = UserInput("Custom arguments: ", "")
        return l:answer == "" ? "" : ' "'.l:answer.'"'
    endif
endfunction

function! PT(file_path, pt_keywords, markers, custom_args)
    let l:args = a:file_path.a:pt_keywords.a:markers.a:custom_args
    execute "silent! wa"
    execute "VimuxRunCommand('clear; pytest ".l:args."')"
endfunction

function! Pytester(call)
    if a:call == "file"
        call PT(expand('%'), '', '', '')
    elseif a:call == "all"
        call PT('', '', '', '')
    elseif a:call == "ask"
        call PT(GetPTArg('f'), GetPTArg('k'), GetPTArg('m'), GetPTArg('c'))
    endif
endfunction
command! -nargs=1 Pytest call Pytester(<f-args>)

function! BetterBrackets(action, count)
    if a:count > 1
        for i in range(1,a:count)
            let l:dir = search("(.", "cn", line(".")) ? "f)" : "F("
            execute "normal! ".l:dir."di("
        endfor
    else
        call search(")", "cze", line("."))
        execute "normal! di("
    endif
    if a:action == "c"
        startinsert
    endif
endfunction
nnoremap <silent> <Plug>DeleteInsideBrackets :<C-U>call BetterBrackets("d", v:count1) \| call repeat#set("\<Plug>DeleteInsideBrackets")<CR>
nnoremap <silent> <Plug>ChangeInsideBrackets :call BetterBrackets("c", 1) \| call repeat#set("\<Plug>ChangeInsideBrackets")<CR>
