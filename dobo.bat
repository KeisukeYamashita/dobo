@rem #!/dos/rocks!
@setlocal EnableDelayedExpansion
@echo off

rem Script for easily accessing dockerignore boilerplates from
rem https://github.com/KeisukeYamashita/dobo
rem
rem Change log
rem v1.0    15-Feb-2021  First public release

goto :setup

:version
    echo %basename% 1.0 by KeisukeYamashita ^<19yamashita15@gmail.com^>
    echo https://github.com/KeisukeYamashita/dobo
    goto :eof

:usage
    call :version
    echo.
    echo Fetches dockerignore boilerplates from github.com/KeisukeYamashita/dockerignore
    echo.
    echo Usage:
    echo     %basename% [command]
    echo.
    echo Example:
    echo     %basename% dump Python NotepadPP ^>^> .dockerignore
    echo.
    echo Options:
    echo     dump expr...  Dump boilerplate(s) to stdout
    echo     help          Display this help text
    echo     list          List available boilerplates
    echo     root          Show the directory where gibo stores its boilerplates
    echo     search expr   Search inside boilerplates for expr
    echo     update        Update list of available boilerplates
    echo     version       Display current script version

    goto :eof


:setup
    set "basename=%~n0"
    set "baseext=%~x0"
    set "basepath=%~dp0"

    set "__cloned="

    set "dumping="

    set "remote_repo=https://github.com/KeisukeYamashita/dockerignore.git"

    rem Allow using the `DOBO_BOILERPLATES` system envar
    rem for specifying the boilerplates directory.
    if defined DOBO_BOILERPLATES set "local_repo=%DOBO_BOILERPLATES%"
    if not defined DOBO_BOILERPLATES set "local_repo=%AppData%\.dockerignore-boilerplates"

    rem No args passed in, so show usage.
    if "%~1"=="" call :usage && goto :end

:parse
    rem Parse comand-line options.

    if "%~1"=="" goto :end

    set a=%~1

    rem The batch file's equivalent 'Sanity check' is that any
    rem options (-, --, and / for Windows) are executed then
    rem the batch file exits, ignoring any other commands, such
    rem as Python, etc.

    if /i "%a%"=="help"     call :usage         & goto :end
    if /i "%a%"=="/?"       call :usage         & goto :end
    if /i "%a%"=="version"  call :version       & goto :end
    if /i "%a%"=="/v"       call :version       & goto :end
    if /i "%a%"=="list"     call :list "%~2"    & goto :end
    if /i "%a%"=="root"     call :root          & goto :end
    if /i "%a%"=="search"   call :search "%~2"  & goto :end
    if /i "%a%"=="update"   call :update        & goto :end

    if /i "%a%"=="dump"     set "dumping=1"     & shift & goto :parse

    if defined dumping      call :dump "%a%"    & shift & goto :parse

    goto :invalid_argument "%a%"

:end
    @endlocal && exit /B 0


:invalid_argument "arg"
    echo Invalid argument: %~1
    echo Did you mean:

    rem Is there a .dockerignore file?
    set "_foundfile="
    if exist "%local_repo%\%~1.dockerignore" set "_foundfile=yes"
    if exist "%local_repo%\Global\%~1.dockerignore" set "_foundfile=yes"
    if defined _foundfile (
        echo     `%basename% dump %*`
        echo     `%basename% list %*`
    )

    rem Did the user mean to search within .dockerignore files?
    echo     `%basename% search %*`

    endlocal && exit /B 1

:clone [--silently]
    if "%~1"=="--silently" ( set "opt=-q" ) else ( set "opt=" )
    git clone %opt% "%remote_repo%" "%local_repo%"
    goto :eof


:init [--silently]
    if not exist "%local_repo%\.git" set "__cloned=yes" && call :clone "%~1"
    goto :eof


:list
    call :init

    echo === Languages ===
    echo.
    for /f %%G in ('dir /b /on "%local_repo%\*%~1*.dockerignore"') do (
        echo %%~nG
    )

    echo.
    echo === Global ===
    echo.
    for /f %%G in ('dir /b /on "%local_repo%\Global\*%~1*.dockerignore"') do (
        echo %%~nG
    )

    goto :eof

:root
    echo %local_repo%
    goto :eof

:search
    if "%~1"=="" echo %basename%: missing search expr.. && goto :eof

    call :init

    rem `findstr` options:
    rem   /R         Uses search strings as regular expressions.
    rem   /S         Searches for matching files in the current directory and all
    rem              subdirectories.
    rem   /I         Specifies that the search is not to be case-sensitive.
    rem   /N         Prints the line number before each line that matches.
    rem   /P         Skip files with non-printable characters.
    rem   /A:attr    Specifies color attribute with two hex digits. See "color /?"
    rem   strings    Text to be searched for.
    rem   [drive:][path]filename
    rem              Specifies a file or files to search.

    pushd "%local_repo%"
    findstr /S /R /I /N /P /A:03 "%~1" *.dockerignore
    popd

    goto :eof

:update
    call :init

    rem If the repo was just cloned, don't perform a `pull`
    if not defined __cloned (
        echo updating..
        pushd "%local_repo%"
        git pull -q --ff origin master
        popd
    )

    goto :eof


:dump
    call :init --silently

    set "language_file=%local_repo%\%~1.dockerignore"
    set "global_file=%local_repo%\Global\%~1.dockerignore"

    if exist "%language_file%" (
        echo ### %~1
        echo.
        type "%language_file%"
        echo.
        echo.
    ) else if exist "%global_file%" (
        echo ### %~1
        echo.
        type "%global_file%"
        echo.
        echo.
    ) else (
        echo Unknown argument: %~1
    )

    goto :eof
