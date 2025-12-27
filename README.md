# Scripts-VSCode

Scripts and configurations to facilitate using **Visual Studio Code** with multiple languages and environments.  
This repository contains automation files (`tasks.json`, `run.bat`, `run.sh`) that simplify the process of **compiling and running** projects directly from VSCode.

---

## Repository Structure

- `.vscode/tasks.json` → Contains the automated tasks for VSCode.  
- `run.bat` → Script for execution on **Windows**.  
- `run.sh` → Script for execution on **Linux**.  

Each script is configured to automatically detect the language (when possible) and run the appropriate command to **compile** and/or **execute** the code.

---

## Supported Languages

These scripts support multiple programming languages on both **Windows** and **Linux**:

- 🟦 **C**
- 🟩 **C++**
- 🟨 **Python**
- 🟪 **Java**
- 🔵 **JavaScript / Node.js**
- ⚪ **Assembly (NASM / x86-64)**
- 🟥 **COBOL**
- 🟫 **Fortran**
- 🧩 **PHP**
- 🩵 **GO**
- 🟠 **Rust** *(Linux only)*

---

## Customization

You can freely modify the scripts to suit your environment or personal preferences.

For example:
- Change compilation or execution commands.
- Add support for new languages.
- Integrate environment variables, arguments, and additional flags.
- Adjust file paths and names according to your project.

Everything is made to be **easy to edit and expand** — just open the `tasks.json` or the scripts (`.bat` / `.sh`) and adapt.

---

## How to Use

### Windows
1. Copy the `run.bat` file and the `.vscode` folder to your project directory.
2. In VSCode, press `Ctrl + Shift + B` to run the configured task.
3. The script will automatically compile and/or run your code.
4. Remember that you need the compilers in your PATH if you **have administrator privileges** on the machine.
5. **If you don't have Administrator privileges**, create a folder where you will store the compilers. I recommend naming it `COMPILADORES`, otherwise modify it in run.bat.
6. Remember to modify the compiler folder name in run.bat or in the actual compiler folder for it to work, **if you don't have administrator privileges**.

### 🐧 Linux
1. Copy the `run.sh` file and the `.vscode` folder to your project directory.
2. Give execution permission with:
   ```bash
   sudo chmod +x run.sh
