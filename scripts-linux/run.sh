#!/bin/bash
clear

arquivo="$1"

# Verifica se foi passado um arquivo
if [[ -z "$arquivo" ]]; then
    echo "Erro: nenhum arquivo especificado."
    echo "Uso: ./run.sh <arquivo.c|.cpp|.py|.php|.js|.asm|.java|.go|.cob|.f90|.rs>"
    exit 1
fi
S
# Verifica se o arquivo existe
if [[ ! -f "$arquivo" ]]; then
    echo "Erro: arquivo '$arquivo' não encontrado."
    exit 1
fi

# Pega extensão e nome base
ext="${arquivo##*.}"
nomeArquivo="${arquivo%.*}"

# Mudar para o diretório do arquivo
cd "$(dirname "$arquivo")" || exit 1

case "$ext" in
    c)
        echo "Compilando e executando C..."
        if [[ -f "main.c" ]]; then
            gcc main.c libs/terminal.c libs/aux.c libs/s_math.c -o main -lm && ./main
        else
            echo "→ Compilando arquivo especificado..."
            gcc "$arquivo" -o "$(basename "$nomeArquivo")" -lm && "./$(basename "$nomeArquivo")"
        fi
        ;;
    cpp)
        echo "Compilando e executando C++..."
        g++ "$arquivo" -o "$(basename "$nomeArquivo")" -lm && "./$(basename "$nomeArquivo")"
        ;;
    py)
        echo "Executando Python..."
        python3 "$arquivo"
        ;;
    php)
        if grep -q "<!DOCTYPE html>" "$arquivo"; then
            echo "--------------------------------------------"
            echo "Abrindo servidor..."
            echo "Servidor LOCALHOST em: http://localhost:8000"
            echo "(Pressione CTRL+C para parar)"
            echo "--------------------------------------------"
            gnome-terminal -- bash -c "php -S localhost:8000 -t \"$(dirname "$arquivo")\"; exec bash"
        else
            echo "Executando php no terminal..."
            php "$arquivo"
        fi
        ;;
    js)
        echo "Executando JavaScript..."
        node "$arquivo"
        ;;
    asm)
        echo "Montando e executando ASM..."
        out_file="$(basename "$nomeArquivo")"
        nasm -f elf64 "$arquivo" -o "${out_file}.o" || exit 1

        if grep -q 'extern ' "$arquivo"; then
            ld "${out_file}.o" -o "$out_file" -dynamic-linker /lib64/ld-linux-x86-64.so.2 -lc || exit 1
        else
            ld "${out_file}.o" -o "$out_file" || exit 1
        fi

        "./$out_file"
        ;;
    java)
        echo "Compilando e executando Java..."
        rm -f "$(basename "$nomeArquivo").class"
        javac "$arquivo" && java "$(basename "$nomeArquivo")"
        ;;
    go)
        echo "Compilando e executando Go..."
        go build -o "$(basename "$nomeArquivo")" "$arquivo" && "./$(basename "$nomeArquivo")"
        ;;
    cob|cbl)
        echo "Compilando e executando COBOL..."
        cobc -x -o "$(basename "$nomeArquivo")" "$arquivo" && "./$(basename "$nomeArquivo")"
        ;;
    f90)
        echo "Compilando e executando Fortran..."
        gfortran "$arquivo" -o "$(basename "$nomeArquivo")" && "./$(basename "$nomeArquivo")"
        ;;
    rs)
        echo "Compilando e executando Rust..."
        rustc "$arquivo" -o "$(basename "$nomeArquivo")" && "./$(basename "$nomeArquivo")"
        ;;
    *)
        echo "Erro: extensão '$ext' não suportada."
        echo "Suportadas: c, cpp, py, php, js, asm, java, go, cob/cbl, f90, rs"
        exit 1
        ;;
esac
