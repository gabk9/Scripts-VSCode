@echo off
cls
setlocal enabledelayedexpansion

REM -------------------------------
REM ARQUIVO E EXTENSAO
REM -------------------------------
set "ARQUIVO=%~1"
set "EXT=%~x1"
set "EXT=%EXT:"=%"   REM remove aspas

REM Caminhos baseados na posição deste script: C:\PROGRAMACAO\
set "BASE=%~dp0"
set "DIR_COMP=%BASE%C:\COMPILADORES\"

echo Arquivo: %ARQUIVO%
echo Extensao: %EXT%
echo.

REM ===============================
REM PYTHON
REM ===============================
if /i "%EXT%"==".py" (
    pushd "%~dp1"
    "%DIR_COMP%\WinPython\python.exe" "%ARQUIVO%"
    popd
    goto :EOF
)

REM ===============================
REM C - COMPILACAO ESPECIAL PARA TERMINAL
REM ===============================
if /i "%EXT%"==".c" (
    set "PATH=%DIR_COMP%\MinGW\bin;%PATH%"
    
    REM Verifica se é o arquivo main.c para adicionar bibliotecas especiais
    if /i "%~nx1"=="main.c" (
        "%DIR_COMP%\MinGW\bin\gcc.exe" libs/aux.c libs/terminal.c -o "%~dp1%~n1.exe" -Ilibs
    ) else (
        REM Compilacao normal para outros arquivos C
        "%DIR_COMP%\MinGW\bin\gcc.exe" "%ARQUIVO%" -o "%~dp1%~n1.exe"
    )
    
    if errorlevel 1 (
        echo Erro na compilacao do C/C++.
        pause
        goto :EOF
    )
    "%~dp1%~n1.exe"
    goto :EOF
)

REM ===============================
REM CPP
REM ===============================
if /i "%EXT%"==".cpp" (
    set "PATH=%DIR_COMP%\MinGW\bin;%PATH%"
    "%DIR_COMP%\MinGW\bin\g++.exe" "%ARQUIVO%" -o "%~dp1%~n1.exe"
    if errorlevel 1 (
        echo Erro na compilacao do C/C++.
        pause
        goto :EOF
    )
    "%~dp1%~n1.exe"
    goto :EOF
)

REM ===============================
REM JAVA
REM ===============================
if /i "%EXT%"==".java" (
    pushd "%~dp1"
    "%DIR_COMP%\Java\app\bin\javac.exe" -source 1.8 -target 1.8 -Xlint:-options "%ARQUIVO%"
    if errorlevel 1 (
        echo Erro na compilacao do Java.
        pause
        popd
        goto :EOF
    )
    "%DIR_COMP%\Java\app\bin\java.exe" "%~n1"
    popd
    goto :EOF
)

REM ===============================
REM JAVASCRIPT (Node)
REM ===============================
if /i "%EXT%"==".js" (
    "%DIR_COMP%\NodeJS\node.exe" "%ARQUIVO%"
    goto :EOF
)

REM ===============================
REM ASM (NASM) - 64-bit
REM ===============================
if /i "%EXT%"==".asm" (
    "%DIR_COMP%\NASM\nasm.exe" -f win64 "%ARQUIVO%" -o "%~dp1%~n1.obj"
    if errorlevel 1 (
        echo Erro na compilacao do Assembly.
        pause
        goto :EOF
    )
    "%DIR_COMP%\MinGW\bin\gcc.exe" -m64 "%~dp1%~n1.obj" -o "%~dp1%~n1.exe" -nostartfiles -e main -lkernel32 -lmsvcrt
    if errorlevel 1 (
        echo Erro ao linkar o arquivo Assembly.
        pause
        goto :EOF
    )
    "%~dp1%~n1.exe"
    goto :EOF
)

REM ===============================
REM COBOL
REM ===============================
if /i "%EXT%"==".cob" (
    set "PATH=%DIR_COMP%\GnuCOBOL\bin;%PATH%"
    cobc -x -o "%~dp1%~n1.exe" "%ARQUIVO%"
    if errorlevel 1 (
        echo Erro na compilacao do COBOL.
        pause
        goto :EOF
    )
    "%~dp1%~n1.exe"
    goto :EOF
)

REM ===============================
REM HTML
REM ===============================
if /i "%EXT%"==".html" (
    start "" "%ARQUIVO%"
    goto :EOF
)

REM ===============================
REM FORTRAN
REM ===============================
if /i "%EXT%"==".f90" (
    set "PATH=%DIR_COMP%\MinGW\bin;%PATH%"
    "%DIR_COMP%\MinGW\bin\gfortran.exe" "%ARQUIVO%" -o "%~dp1%~n1.exe"
    if errorlevel 1 (
        echo Erro na compilacao do Fortran.
        pause
        goto :EOF
    )
    "%~dp1%~n1.exe"
    goto :EOF
)

REM ===============================
REM GO
REM ===============================
if /i "%EXT%"==".go" (
    set "PATH=%DIR_COMP%\Go\bin;%PATH%"
    pushd "%~dp1"
    go build -o "%~dp1%~n1.exe" "%ARQUIVO%"
    if errorlevel 1 (
        echo Erro na compilacao do Go.
        pause
        popd
        goto :EOF
    )
    "%~dp1%~n1.exe"
    popd
    goto :EOF
)

REM ===============================
REM PHP (terminal + servidor em nova janela)
REM ===============================
if /i "%EXT%"==".php" (
    pushd "%~dp1"
    echo -------------------------------
    echo Rodando no TERMINAL:
    echo -------------------------------
    "%DIR_COMP%\PHP\php.exe" "%ARQUIVO%"
    echo.
    echo -------------------------------
    echo Servidor LOCALHOST em: http://localhost:8000
    echo (Nova janela aberta, feche-a para parar)
    echo -------------------------------
    start "Servidor PHP" cmd /k "cd /d %~dp1 && %DIR_COMP%\PHP\php.exe -S localhost:8000 -t %~dp1"
    popd
    goto :EOF
)

REM ===============================
REM EXTENSAO NAO SUPORTADA
REM ===============================
echo Extensao nao suportada: %EXT%
pause
exit
