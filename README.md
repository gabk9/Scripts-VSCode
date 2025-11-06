# ⚙️ Scripts-VSCode

Scripts e configurações para facilitar o uso do **Visual Studio Code** com múltiplas linguagens e ambientes.  
Este repositório contém arquivos de automação (`tasks.json`, `run.bat` e `run.sh`) prontos para compilar e executar projetos com apenas um comando — seja no **Windows** ou no **Linux**.

---

## 🧩 O que está incluído

### 📁 Estrutura
- `.vscode/tasks.json` → Arquivo de tarefas automatizadas para o VSCode.  
- `run.bat` → Script de execução para **Windows**.  
- `run.sh` → Script equivalente para **Linux**.

Esses arquivos permitem que o VSCode reconheça e execute comandos personalizados para compilar e rodar seus projetos sem precisar abrir o terminal manualmente.

---

## 🖥️ Plataformas suportadas

| Sistema Operacional | Script | Descrição |
|----------------------|---------|------------|
| 🪟 **Windows** | `run.bat` | Automatiza a compilação e execução via terminal do Windows |
| 🐧 **Linux** | `run.sh` | Realiza as mesmas tarefas usando Bash |

---

## 🧠 Linguagens suportadas

Os scripts foram pensados para funcionar com várias linguagens populares.  
Você pode adicionar, remover ou adaptar linguagens conforme seu uso.

Atualmente, há suporte (ou base configurável) para:

- 🟦 **C**
- 🟩 **C++**
- 🟨 **Python**
- 🟪 **Java**
- 🔵 **JavaScript / Node.js**
- ⚪ **Assembly (NASM / x86-64)**  
- 🟠 **Batch / Shell Script**
- 🟤 **COBOL**
- 🟣 **Fortran**
- 🟢 **PHP**
- 🟧 **Rust** *(somente Linux)*

---

## ⚙️ Como usar

### 🔧 No VSCode
1. Copie a pasta `.vscode` e os scripts para o diretório do seu projeto.  
2. Abra o projeto no VSCode.  
3. Pressione **Ctrl + Shift + B** para executar a tarefa configurada.  
4. O VSCode compilará e executará automaticamente o arquivo atual.

### 💻 Manualmente
- **Windows:**  
  ```bash
  run.bat
****
