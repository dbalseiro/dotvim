function! ProjectBuildAll()
    redir => projectList
    execute ":silent ProjectList"
    redir END
    
    let lista = split(projectList, '\n')

    for proyecto in lista
        let parseProyecto = split(proyecto)
        let nombreProyecto = parseProyecto[0]
        if nombreProyecto == "RemoteSystemsTempFiles"
            continue
        endif
        execute ":ProjectBuild ".nombreProyecto
    endfor
endfunction

command! ProjectBuildAll :call ProjectBuildAll()
