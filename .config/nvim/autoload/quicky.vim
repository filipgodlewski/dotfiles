function! quicky#input(message, completion)
    call inputsave()
    let l:answer = a:completion != '' ? input(a:message, '', a:completion) : input(a:message)
    call inputrestore()
    return l:answer
endfunction

function! quicky#parse()
    execute "silent! %s/|/:/"
    execute "silent! %s/ col /:/"
    execute "silent! %s/| /:/"
    execute "silent! w! /tmp/vim_quickfix_list"
    execute "silent! cg /tmp/vim_quickfix_list"
    execute "silent! cclo"
endfunction

function! quicky#search()
    let g:quickfix_search = quicky#input('Search globally for: ', '')
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

function! quicky#replace_global(before)
    echo "Replace: ".a:before
    let after = quicky#input('With: ', '')
    let quickfix_command = 'silent! cdo s/'.a:before.'/'.after.'/ | update'
    let choice = confirm("Is it ok?", "&Ok\n&Abort", 1)
    if choice == 1
        execute quickfix_command
    endif
endfunction

function! quicky#replace_local(placement)
    if a:placement == "."
        let l:text = "on line ".getcurpos()[1]
    elseif a:placement == "%"
        let l:text = "in this buffer"
    endif
    let l:last = exists("g:before") && !empty(g:before) ? ' [last: '.g:before.']: ' : ': '
    let g:before = quicky#input('Search '.l:text.' for'.l:last, 'tag')
    let after = quicky#input('Replace with: ', '')
    execute a:placement.'s/'.g:before.'/'.after.'/gc'
endfunction
