@echo off
setlocal enabledelayedexpansion

REM ---------------------------
REM Check input
REM ---------------------------
if "%~1"=="" (
    echo ERROR: empty input
    echo Usage: run file.c or run path\file.c
    exit /b
)

REM ---------------------------
REM Resolve full paths
REM ---------------------------
set "file=%~1"
for %%I in ("%file%") do set "file=%%~fI"

set "ext=%~x1"
set "dirFile=%~dp1"
set "fileName=%~n1"

REM Debug info (optional)
REM echo File: %file%
REM echo Directory: %dirFile%
REM echo FileName: %fileName%
REM echo Extension: %ext%

REM ---------------------------
REM MinGW path (edit if needed)
REM ---------------------------
set "MINGW_BIN=C:\MinGW-w64\bin"
set "PATH=%MINGW_BIN%;%PATH%"

REM Move to file directory
pushd "%dirFile%" || (
    echo ERROR: Cannot enter directory "%dirFile%"
    exit /b
)

REM ---------------------------
REM C compilation
REM ---------------------------
if /i "%ext%"==".c" (
    cls
    echo Compiling C code...

    REM Special compilation if main.c exists
    if /i "%fileName%"=="main" (
        REM Make sure libs exist
        if not exist "libs\utils.c" (
            echo ERROR: libs not found in "%dirFile%\libs"
            goto end
        )
        gcc "%file%" "libs\utils.c" "libs\s_math.c" "libs\CheckCmd.c" "libs\terminal.c" -o "%fileName%.exe" -I"libs"
    ) else (
        gcc "%file%" -o "%fileName%.exe"
    )

    if errorlevel 1 (
        echo ERROR: C compilation failed
        goto end
    )

    echo Running...
    "%fileName%.exe"
    goto stop
)

REM ---------------------------
REM C++
REM ---------------------------
if /i "%ext%"==".cpp" (
    cls
    echo Compiling C++...
    g++ "%file%" -o "%fileName%.exe"
    if errorlevel 1 (
        echo ERROR: C++ compilation failed
        goto end
    )
    echo Running...
    "%fileName%.exe"
    goto stop
)

REM ---------------------------
REM Rust
REM ---------------------------
if /i "%ext%"==".rs" (
    cls
    echo Compiling Rust...
    rustc "%file%" -o "%fileName%.exe"
    if errorlevel 1 (
        echo ERROR: Rust compilation failed
        goto end
    )
    echo Running...
    "%fileName%.exe"
    goto stop
)

REM ---------------------------
REM Python
REM ---------------------------
if /i "%ext%"==".py" (
    cls
    echo Running Python...
    python "%file%"
    goto stop
)

REM ---------------------------
REM COBOL
REM ---------------------------
if /i "%ext%"==".cob" (
    cls
    echo Compiling COBOL...
    cobc -x -o "%fileName%.exe" "%file%"
    if errorlevel 1 (
        echo ERROR: COBOL compilation failed
        goto end
    )
    echo Running...
    "%fileName%.exe"
    goto stop
)

REM ---------------------------
REM ASM 64-bit
REM ---------------------------
if /i "%ext%"==".asm" (
    cls
    echo Assembling ASM...
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
    echo Running...
    "%fileName%.exe"
    goto stop
)

if /i "%ext%"==".s" (
    cls
    echo Assembling ASM...
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
    echo Running...
    "%fileName%.exe"
    goto stop
)

REM ---------------------------
REM Java
REM ---------------------------
if /i "%ext%"==".java" (
    cls
    echo Compiling Java...
    del /f /q "%fileName%.class" 2>nul
    javac "%file%"
    if errorlevel 1 (
        echo ERROR: Java compilation failed
        goto end
    )
    echo Running...
    java "%fileName%"
    goto stop
)

REM ---------------------------
REM Go
REM ---------------------------
if /i "%ext%"==".go" (
    cls
    echo Compiling Go...
    go build -o "%fileName%.exe" "%file%"
    if errorlevel 1 (
        echo ERROR: Go compilation failed
        goto end
    )
    echo Running...
    "%fileName%.exe"
    goto stop
)

REM ---------------------------
REM Fortran
REM ---------------------------
if /i "%ext%"==".f90" (
    cls
    echo Compiling Fortran...
    gfortran "%file%" -o "%fileName%.exe"
    if errorlevel 1 (
        echo ERROR: Fortran compilation failed
        goto end
    )
    echo Running...
    "%fileName%.exe"
    goto stop
)

REM ---------------------------
REM JavaScript
REM ---------------------------
if /i "%ext%"==".js" (
    cls
    echo Running JavaScript...
    node "%file%"
    goto stop
)

REM ---------------------------
REM PHP
REM ---------------------------
if /i "%ext%"==".php" (
    cls
    echo Running PHP...
    php "%file%"
    goto stop
)

REM ---------------------------
REM HTML
REM ---------------------------
if /i "%ext%"==".html" (
    cls
    echo Running HTML...
    start "" "%file%"
    goto stop
)

REM ---------------------------
REM Unsupported
REM ---------------------------
echo Unsupported extension: %ext%
goto stop

:end
echo Process ended with errors.

:stop
popd
pause
exit /b
