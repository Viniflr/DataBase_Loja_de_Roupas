# 🏬 Sistema de Banco de Dados para Loja de Roupas

![MySQL](https://img.shields.io/badge/MySQL-8.0+-005C84?logo=mysql&logoColor=white)
![Workbench](https://img.shields.io/badge/MySQL%20Workbench-8.0+-4479A1)
![GitHub](https://img.shields.io/badge/GitHub-Repository-181717?logo=github)

## 📋 Tabela de Conteúdos
- [Estrutura de Arquivos](#-estrutura-de-arquivos)
- [Implementação](#-implementação)
- [Destaques Técnicos](#-destaques-técnicos)
- [Diagrama ER](#-diagrama-er)
- [Recriação do Ambiente](#-recriação-do-ambiente)
- [Autor](#-autor)

## 📂 Estrutura de Arquivos

```bash
├── 01_schema.sql          # Criação do schema e tabelas base
├── 02_alter_tables.sql    # Modificações estruturais (ALTER TABLE)
├── 03_insert_into.sql     # Dados iniciais para todas as tabelas
├── 04_indices.sql         # Índices para otimização
├── 05_views.sql           # Views para relatórios
├── 06_procedures.sql      # Stored procedures
├── 07_triggers.sql        # Triggers de auditoria
├── 08_personalizados.sql  # Consultas personalizadas
├── 09_destroy_all.sql     # Script de limpeza (DROP)
├── 10-functions.sql       # Funções customizadas
├── 11-testes.sql          # Casos de teste
```

## 🚀 Implementação

### Ordem de Execução Obratória
1. `01_schema.sql` - Criação da estrutura básica
2. `02_alter_tables.sql` - Ajustes estruturais
3. `03_insert_into.sql` - Popular tabelas
4. `04_indices.sql` - Otimizações
5. `05_views.sql` - Criação de views
6. `06_procedures.sql` - Procedures armazenadas
7. `07_triggers.sql` - Triggers de auditoria
8. `10-functions.sql` - Funções customizadas

### Execução no MySQL Workbench
```sql
-- Para cada arquivo:
SOURCE caminho/para/o/arquivo.sql;
-- Ou use a interface gráfica (File > Open SQL Script)
```

## 📊 Diagrama ER

![image](https://github.com/user-attachments/assets/39bc67b9-3377-4f7f-aa16-fc7d82cb07b8)

**Principais Entidades:**
- `clientes` - Cadastro completo de clientes
- `funcionarios` - Dados dos colaboradores
- `produto` - Catálogo de roupas
- `vendas` - Transações comerciais
- `fornecedor` - Parceiros comerciais

## ✨ Destaques Técnicos

### Principais Funcionalidades
✅ **Gestão Completa de Estoque**  
✅ **Controle de Vendas com Múltiplas Formas de Pagamento**  
✅ **Sistema de Comissões Automatizado**  
✅ **Auditoria com Triggers**  

## 👨‍💻 Autores
**Vinícius Fernandes**  
**Pedro Enrico**
**Larissa Beatriz**
[![GitHub](https://img.shields.io/badge/GitHub-Profile-181717?logo=github)](https://github.com/Viniflr)  
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Profile-0077B5?logo=linkedin)](https://www.linkedin.com/in/seu-perfil)

---

🔹 *Projeto desenvolvido para a disciplina de Banco de Dados*  
🔹 *Atualizado em: 20/06/2024*
