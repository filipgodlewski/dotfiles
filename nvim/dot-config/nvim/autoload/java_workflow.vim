function! java_workflow#compile()
    execute "wa"
    let l:source = split(expand("%:r"), "/")[0]
    let l:project = split(expand("$PWD"), "/")[-1]
    execute '!cd '.l:source.'; javac **/*.java -d ../out/production/'.l:project
endfunction

function! java_workflow#run(bang, args)
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
