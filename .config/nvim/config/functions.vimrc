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
    let l:answer = a:completion != '' ? input(a:message, '', a:completion) : input(a:message)
    call inputrestore()
    return l:answer
endfunction

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

function! ReplaceLocalList(placement)
    if a:placement == "."
        let l:text = "on line ".getcurpos()[1]
    elseif a:placement == "%"
        let l:text = "in this buffer"
    endif
    let l:last = exists("g:before") && !empty(g:before) ? ' [last: '.g:before.']: ' : ': '
    let g:before = UserInput('Search '.l:text.' for'.l:last, 'tag')
    let after = UserInput('Replace with: ', '')
    execute a:placement.'s/'.g:before.'/'.after.'/gc'
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
        execute quickfix_command
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

function! JavaCompile()
    execute "wa"
    let l:source = split(expand("%:r"), "/")[0]
    let l:project = split(expand("$PWD"), "/")[-1]
    execute '!cd '.l:source.'; javac **/*.java -d ../out/production/'.l:project
endfunction
command! Javac call JavaCompile()

function! JavaRun(bang, args)
    if a:bang == 0
        let l:class = join(split(expand("%:r"), "/")[1:], ".")
        let l:args = a:args == [] ? "" : join(a:args, " ")
    else
        if a:args == []
            echom "Provide class name as the first argument!"
            return 0
        else
            let l:class_name = a:args[0]
            let l:class = join(split(expand("**/".l:class_name.".java")[:-6], "/")[1:], ".")
            let l:args = a:args[1:] == [] ? "" : join(a:args[1:], " ")
        endif
    endif
    let l:project = split(expand("$PWD"), "/")[-1]
    call VimuxRunCommand("clear; java -cp out/production/".l:project." ".l:class." ".l:args)
endfunction
command! -nargs=* -bang Java call JavaRun(<bang>0, [<f-args>])

function! GetHighlightGroupNames()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val,"name")')
endfunc
