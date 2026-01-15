#!/bin/bash

file="$1"

# Check if file was provided
if [[ -z "$file" ]]; then
    echo "Error: empty input"
    echo "Usage: ./run.sh <file.c|.cpp|.py|.php|.js|.asm|.java|.go|.cob|.f90|.rs>"
    exit 1
fi

# Check if file exists
if [[ ! -f "$file" ]]; then
    echo "Error: file '$file' not found."
    exit 1
fi

# Resolve paths
dirName="$(dirname "$file")"
baseName="$(basename "${file%.*}")"
extension="${file##*.}"

# Make sure dirName is not empty
if [[ -z "$dirName" ]]; then
    dirName="."
fi

# Compilation/execution per language
case "$extension" in
    c)
	    clear
        echo "Compiling and running C..."
        if [[ -f "$dirName/main.c" ]]; then
            gcc "$dirName/main.c" "$dirName/libs/terminal.c" "$dirName/libs/CheckCmd.c" "$dirName/libs/utils.c" "$dirName/libs/s_math.c" -o "$dirName/main" -lm && "$dirName/main"
        else
            gcc "$file" -o "$dirName/$baseName" -lm && "$dirName/$baseName"
        fi
        ;;
    cpp)
	    clear
        echo "Compiling and running C++..."
        g++ "$file" -o "$dirName/$baseName" -lm && "$dirName/$baseName"
        ;;
    py)
	    clear
        echo "Running Python..."
        python3 "$file"
        ;;
    php)
	    clear
        echo "Running PHP..."
        php "$file"
        ;;
    js)
	    clear
        echo "Running JavaScript..."
        node "$file"
        ;;
    asm|s)
	clear
        echo "Assembling and running ASM..."
        nasm -f elf64 "$file" -o "$dirName/$baseName.o" || exit 1
        ld "$dirName/$baseName.o" -o "$dirName/$baseName" || exit 1
        "$dirName/$baseName"
        ;;
    java)
	    clear
        echo "Compiling and running Java..."
        javac "$file" -d "$dirName" && java -cp "$dirName" "$baseName"
        ;;
    go)
	    clear
        echo "Compiling and running Go..."
        go build -o "$dirName/$baseName" "$file" && "$dirName/$baseName"
        ;;
    cob|cbl)
	    clear
        echo "Compiling and running COBOL..."
        cobc -x -o "$dirName/$baseName" "$file" && "$dirName/$baseName"
        ;;
    f90)
	    clear
        echo "Compiling and running Fortran..."
        gfortran "$file" -o "$dirName/$baseName" && "$dirName/$baseName"
        ;;
    rs)
	    clear
        echo "Compiling and running Rust..."
        rustc "$file" -o "$dirName/$baseName" && "$dirName/$baseName"
        ;;
    *)
        echo "Error: extension '$extension' not supported."
        echo "Supported: c, cpp, py, php, js, asm, java, go, cob/cbl, f90, rs"
        exit 1
        ;;
esac
