#!/bin/bash

file="$1"

# Check if file was provided
if [[ -z "$file" ]]; then
    echo "Error: empty input"
    echo -n "Usage: ./run.sh <file.c|.cpp|.py|.php|.js|.asm|.java|.go|.cob|.f90|.rs>"
    exit 1
fi

# Check if file exists
if [[ ! -f "$file" ]]; then
    echo -n "Error: file '$file' not found."
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
    echo "Compiling and running C..."
    clang -Wall -Wextra -Wpedantic "$file" -o "$dirName/$baseName" -lm && "$dirName/$baseName"
    ;;
cpp)
    echo "Compiling and running C++..."
    g++ "$file" -o "$dirName/$baseName" -lm && "$dirName/$baseName"
    ;;
py)
    echo "Running Python..."
    python3 "$file"
    ;;
php)
    echo "Running PHP..."
    php "$file"
    ;;
js)
    echo "Running JavaScript..."
    node "$file"
    ;;
asm | s)
    echo "Assembling and running ASM..."
    nasm -f macho64 "$file" -o "$dirName/$baseName.o" || exit 1
    ld -macos_version_min 13.0 "$dirName/$baseName.o" -o "$dirName/$baseName" || exit 1
    "$dirName/$baseName"
    ;;
java)
    echo "Compiling and running Java..."
    javac "$file" -d "$dirName" && java -cp "$dirName" "$baseName"
    ;;
go)
    echo "Compiling and running Go..."
    go build -o "$dirName/$baseName" "$file" && "$dirName/$baseName"
    ;;
cob | cbl)
    echo "Compiling and running COBOL..."
    cobc -x -o "$dirName/$baseName" "$file" && "$dirName/$baseName"
    ;;
f90)
    echo "Compiling and running Fortran..."
    gfortran "$file" -o "$dirName/$baseName" && "$dirName/$baseName"
    ;;
rs)
    echo "Compiling and running Rust..."
    rustc "$file" -o "$dirName/$baseName" && "$dirName/$baseName"
    ;;
*)
    echo "Error: extension '$extension' not supported."
    echo -n "Supported: c, cpp, py, php, js, asm, java, go, cob/cbl, f90, rsi"
    exit 1
    ;;
esac
