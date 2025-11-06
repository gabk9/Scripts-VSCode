# Scripts-VSCode

Scripts e configurações para facilitar o uso do **Visual Studio Code** com múltiplas linguagens e ambientes.  
Este repositório contém arquivos de automação (`tasks.json`, `run.bat`, `run.sh`) que simplificam o processo de **compilação e execução** de projetos diretamente pelo VSCode.

---

## Estrutura do Repositório

- `.vscode/tasks.json` → Contém as tarefas automatizadas do VSCode.  
- `run.bat` → Script para execução no **Windows**.  
- `run.sh` → Script para execução no **Linux**.  

Cada script foi configurado para detectar a linguagem automaticamente (quando possível) e executar o comando apropriado para **compilar** e/ou **rodar** o código.

---

## Linguagens Suportadas

Esses scripts oferecem suporte para múltiplas linguagens de programação, tanto no **Windows** quanto no **Linux**:

- 🟦 **C**
- 🟩 **C++**
- 🟨 **Python**
- 🟪 **Java**
- 🔵 **JavaScript / Node.js**
- ⚪ **Assembly (NASM / x86-64)**
- 🟠 **Batch / Shell Script**
- 🟥 **COBOL**
- 🟫 **Fortran**
- 🧩 **PHP**
- 🦀 **Rust** *(apenas Linux)*

---

## Personalização

Você pode modificar livremente os scripts para se adequar ao seu ambiente ou preferências pessoais.

Por exemplo:
- Alterar os comandos de compilação ou execução.
- Adicionar suporte a novas linguagens.
- Integrar variáveis de ambiente, argumentos e flags adicionais.
- Ajustar caminhos e nomes de arquivos conforme o seu projeto.

Tudo foi feito para ser **simples de editar e expandir** — basta abrir o `tasks.json` ou os scripts (`.bat` / `.sh`) e adaptar.

---

## Como Usar

### Windows
1. Copie o `run.bat` e a pasta `.vscode` para o diretório do seu projeto.
2. No VSCode, pressione `Ctrl + Shift + B` para executar a tarefa configurada.
3. O script irá compilar e/ou executar o código automaticamente.

### 🐧 Linux
1. Copie o `run.sh` e a pasta `.vscode` para o diretório do seu projeto.
2. Dê permissão de execução com:
   ```bash
   chmod +x run.sh

---

## Observações

- Os scripts são **independentes por sistema operacional** — você pode usar apenas o que precisar.
- O tasks.json é compatível com **VSCode em qualquer plataforma**.
- O repositório serve como modelo base, podendo ser clonado e modificado para uso pessoal.

---

## Licença

Este projeto está sob a licença **MIT**, permitindo uso, modificação e redistribuição livre, desde que os créditos sejam mantidos.
