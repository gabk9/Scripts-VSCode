@echo off
cls
setlocal enabledelayedexpansion

REM ---------------------------
REM VARIÁVEIS PRINCIPAIS
REM ---------------------------
set "arquivo=%~1"
set "ext=%~x1"
set "dirArquivo=%~dp1"
set "nomeArquivo=%~n1"

REM DEBUG - Mostrar o que está sendo detectado
echo Arquivo: %arquivo%
echo Extensao: %ext%
echo.

REM ---------------------------
REM Caminho MinGW (ajuste se necessário)
REM ---------------------------
set "MINGW_BIN=C:\MinGW-w64\bin"
set "PATH=%MINGW_BIN%;%PATH%"

pushd "%dirArquivo%"

REM ---------------------------
REM ASM 64-bit
REM ---------------------------
if /i "%ext%"==".asm" (
    echo Executando Assembly...
    nasm -f win64 "%arquivo%" -o "%nomeArquivo%.obj"
    if errorlevel 1 (
        echo ERRO: montagem ASM falhou
        goto fim
    )
    gcc "%nomeArquivo%.obj" -o "%nomeArquivo%.exe" -lmsvcrt -Wl,--subsystem,console
    if errorlevel 1 (
        echo ERRO: link ASM falhou
        goto fim
    )
    "%nomeArquivo%.exe"
    goto pausa
)

REM ---------------------------
REM C
REM ---------------------------
if /i "%ext%"==".c" (
    echo Compilando C...

    REM Se for main.c, compile também os outros arquivos
    if /i "%nomeArquivo%"=="main" (
        gcc "%arquivo%" libs/aux.c libs/terminal.c -o "%nomeArquivo%.exe" -Ilibs
    ) else (
        REM Para outros arquivos, compile sozinho
        gcc "%arquivo%" -o "%nomeArquivo%.exe"
    )

    REM Verifica se a compilação falhou
    if errorlevel 1 (
        echo ERRO: compilacao C falhou
        goto fim
    )

    echo.
    echo Executando...
    "%nomeArquivo%.exe"
    goto pausa
)


REM ---------------------------
REM C++
REM ---------------------------
if /i "%ext%"==".cpp" (
    echo Executando C++...
    g++ "%arquivo%" -o "%nomeArquivo%.exe"
    if errorlevel 1 (
        echo ERRO: compilacao C++ falhou
        goto fim
    )
    "%nomeArquivo%.exe"
    goto pausa
)

REM ---------------------------
REM RUST
REM ---------------------------
if /i "%ext%"==".rs" (
    echo Compilando Rust...
    rustc "%arquivo%" -o "%nomeArquivo%.exe"
    if errorlevel 1 (
        echo ERRO: compilacao Rust falhou
        goto fim
    )
    echo.
    echo Executando...
    "%nomeArquivo%.exe"
    goto pausa
)


REM ---------------------------
REM PYTHON
REM ---------------------------
if /i "%ext%"==".py" (
    python "%arquivo%"
    goto pausa
)

REM ---------------------------
REM COBOL
REM ---------------------------
if /i "%ext%"==".cob" (
    echo Executando Cobol...
    cobc -x -o "%nomeArquivo%.exe" "%arquivo%"
    if errorlevel 1 (
        echo ERRO: compilacao COBOL falhou
        goto fim
    )
    "%nomeArquivo%.exe"
    goto pausa
)

REM ---------------------------
REM JAVASCRIPT (Node)
REM ---------------------------
if /i "%ext%"==".js" (
    node "%arquivo%"
    goto pausa
)

REM ---------------------------
REM HTML
REM ---------------------------
if /i "%ext%"==".html" (
    start "" "%arquivo%"
    goto pausa
)

REM ---------------------------
REM JAVA
REM ---------------------------
if /i "%ext%"==".java" (
    echo Executando Java...
    del /f /q "%nomeArquivo%.class" 2>nul
    javac --release 8 -Xlint:-options "%arquivo%"
    if errorlevel 1 (
        echo ERRO: compilacao Java falhou
        goto fim
    )
    java "%nomeArquivo%"
    goto pausa
)

REM ---------------------------
REM GO
REM ---------------------------
if /i "%ext%"==".go" (
    echo Executando Golang...
    go build -o "%nomeArquivo%.exe" "%arquivo%"
    if errorlevel 1 (
        echo ERRO: compilacao Go falhou
        goto fim
    )
    "%nomeArquivo%.exe"
    goto pausa
)

REM ---------------------------
REM FORTRAN
REM ---------------------------
if /i "%ext%"==".f90" (
    echo Executando Fortran...
    gfortran "%arquivo%" -o "%nomeArquivo%.exe"
    if errorlevel 1 (
        echo ERRO: compilacao Fortran falhou
        goto fim
    )
    "%nomeArquivo%.exe"
    goto pausa
)

REM ---------------------------
REM PHP (terminal + servidor)
REM ---------------------------
if /i "%ext%"==".php" (
    echo -------------------------------
    echo Executando PHP no terminal...
    echo -------------------------------
    php "%arquivo%"
    echo.
    echo -------------------------------
    echo Iniciando servidor PHP...
    echo Servidor: http://localhost:8000
    echo (Nova janela)
    echo -------------------------------
    start "Servidor PHP" php -S localhost:8000 -t "%dirArquivo%"
    goto pausa
)

REM ---------------------------
REM EXTENSÃO NÃO SUPORTADA
REM ---------------------------
echo Extensao nao suportada: %ext%
goto pausa

:fim
echo Processo terminado com erros.
goto pausa

:pausa
echo.
pause
popd
exit /b
