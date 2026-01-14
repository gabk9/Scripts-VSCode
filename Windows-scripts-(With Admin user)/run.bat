@echo off
cls
setlocal enabledelayedexpansion

if "%~1"=="" (
    echo.
    echo ERROR: empty input
    echo.
    echo use:
    echo     "run file" or "run path/file" 
    exit /b
)

REM ---------------------------
REM MAIN VARIABLES
REM ---------------------------
set "file=%~1"
for %%I in ("%file%") do set "file=%%~fI"

set "ext=%~x1"
set "dirFile=%~dp1"
set "fileName=%~n1"

REM DEBUG - show what's happening
REM echo File: %file%
echo Extension: %ext%
echo.

REM ---------------------------
REM MinGW path (edit if needed)
REM ---------------------------
set "MINGW_BIN=C:\MinGW-w64\bin"
set "PATH=%MINGW_BIN%;%PATH%"

pushd "%dirFile%"

REM ---------------------------
REM ASM 64-bit
REM ---------------------------
if /i "%ext%"==".asm" (
    echo Mounting...
    nasm -f win64 "%file%" -o "%fileName%.obj"
    if errorlevel 1 (
        echo ERROR: ASM assembly failed
        goto end
    )
    gcc "%fileName%.obj" -o "%fileName%.exe" -lmsvcrt -Wl,--subsystem,console
    if errorlevel 1 (
        echo ERROR: ASM link failed
        goto end
    )
    "%fileName%.exe"
    goto stop
)

REM ---------------------------
REM ASM 64-bit
REM ---------------------------
if /i "%ext%"==".s" (
    echo Mounting...
    nasm -f win64 "%file%" -o "%fileName%.obj"
    if errorlevel 1 (
        echo ERROR: ASM assembly failed
        goto end
    )
    gcc "%fileName%.obj" -o "%fileName%.exe" -lmsvcrt -Wl,--subsystem,console
    if errorlevel 1 (
        echo ERROR: ASM link failed
        goto end
    )
    echo.
    echo Running...
    "%fileName%.exe"
    goto stop
)

REM ---------------------------
REM C
REM ---------------------------
if /i "%ext%"==".c" (
    echo Compiling C code...

    REM for the normal files
    gcc "%file%" -o "%fileName%.exe"

    REM Verification
    if errorlevel 1 (
        echo ERROR: C compilation failed
        goto end
    )

    echo.
    echo Running...
    "%fileName%.exe"
    goto stop
)


REM ---------------------------
REM C++
REM ---------------------------
if /i "%ext%"==".cpp" (
    echo Compiling C++...
    g++ "%file%" -o "%fileName%.exe"
    if errorlevel 1 (
        echo ERROR: C++ compilation failed
        goto end
    )
    echo.
    echo Running...
    "%fileName%.exe"
    goto stop
)

REM ---------------------------
REM RUST
REM ---------------------------
if /i "%ext%"==".rs" (
    echo Compiling rust...
    rustc "%file%" -o "%fileName%.exe"
    if errorlevel 1 (
        echo ERROR: Rust compilation failed
        goto end
    )
    echo.
    echo Running...
    "%fileName%.exe"
    goto stop
)


REM ---------------------------
REM PYTHON
REM ---------------------------
if /i "%ext%"==".py" (
    echo.
    echo Running python...
    python "%file%"
    goto stop
)

REM ---------------------------
REM COBOL
REM ---------------------------
if /i "%ext%"Compiling COBOL... (
    cobc -x -o "%fileName%.exe" "%file%"
    if errorlevel 1 (
        echo ERROR: COBOL compilation failed
        goto end
    )
    echo.
    echo Running...
    "%fileName%.exe"
    goto stop
)

REM ---------------------------
REM COBOL
REM ---------------------------
if /i "%ext%"==".cobc" (
    echo Executando Cobol...
    cobc -x -o "%fileName%.exe" "%file%"
    if errorlevel 1 (
        echo ERROR: compilacao COBOL falhou
        goto end
    )
    echo.
    echo Running...
    "%fileName%.exe"
    goto stop
)

REM ---------------------------
REM JAVASCRIPT (Node)
REM ---------------------------
if /i "%ext%"==".js" (
    echo.
    echo Running JavaScript...
    node "%file%"
    goto stop
)

REM ---------------------------
REM HTML
REM ---------------------------
if /i "%ext%"==".html" (
    echo.
    echo Running HTML...
    start "" "%file%"
    goto stop
)

REM ---------------------------
REM JAVA
REM ---------------------------
if /i "%ext%"==".java" (
    echo Compiling Java...
    del /f /q "%fileName%.class" 2>nul
    javac --release 8 -Xlint:-options "%file%"
    if errorlevel 1 (
        echo ERROR: Java compilation failed
        goto end
    )
    echo.
    echo Running...
    java "%fileName%"
    goto stop
)

REM ---------------------------
REM GO
REM ---------------------------
if /i "%ext%"==".go" (
    echo Compiling golang...
    go build -o "%fileName%.exe" "%file%"
    if errorlevel 1 (
        echo ERROR: Golang compilation failed
        goto end
    )
    echo.
    echo Running...
    "%fileName%.exe"
    goto stop
)

REM ---------------------------
REM FORTRAN
REM ---------------------------
if /i "%ext%"==".f90" (
    echo Compiling Fortran...
    gfortran "%file%" -o "%fileName%.exe"
    if errorlevel 1 (
        echo ERROR: Fortran compilation failed
        goto end
    )
    echo.
    echo Running...
    "%fileName%.exe"
    goto stop
)

REM ---------------------------
REM PHP (terminal + servidor)
REM ---------------------------
if /i "%ext%"==".php" (
    echo -------------------------------
    echo Running PHP in the terminal...
    echo -------------------------------
    php "%file%"
    echo.
    echo -------------------------------
    echo Initializing PHP server...
    echo Server: http://localhost:8000
    echo (New Window)
    echo -------------------------------
    start "PHP SERVER" php -S localhost:8000 -t "%dirArquivo%"
    goto stop
)

REM ---------------------------
REM UNSUPPORTED EXTENSION
REM ---------------------------
echo Unsupported extension: %ext%
goto stop

:end
echo Process ended with errors.
goto stop

:stop
echo.
pause
popd
exit /b
