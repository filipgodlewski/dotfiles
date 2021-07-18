set include=^\\s*\\(from\\\|import\\)\\s*\\zs\\(\\S\\+\\s\\{-}\\)*\\ze\\($\\\|\ as\\)
function! PyInclude(fname)
    let parts = split(a:fname, ' import ')
    let left = parts[0]
    if len(parts) > 1
        let right = parts[1]
        let joined = join([left, right], '.')
        let fp = substitute(joined, '\.', '/', 'g') . '.py'
        let found = glob(fp, 1)
        if len(found)
            return found
        endif
    endif
    return substitute(l, '\.', '/', 'g') . '.py'
endfunction
setlocal includeexpr=PyInclude(v:fname)
setlocal define=^\\s*\\<\\(def\\\|class\\)\\>
setlocal foldmethod=indent
setlocal nofoldenable
let g:pyindent_open_paren = 'shiftwidth()'
let g:pyindent_disable_parentheses_indenting = 1
