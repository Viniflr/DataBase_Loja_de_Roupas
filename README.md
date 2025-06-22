# 🏬 Sistema de Banco de Dados para Loja de Roupas

[![My Skills](https://skillicons.dev/icons?i=mysql,github)](https://skillicons.dev)

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
| [<img loading="lazy" src="https://avatars.githubusercontent.com/u/119247208?s=400&u=a41a122510e3447159fb98c4797d79ff19b43e39&v=4" width=115><br><sub>Vinícius Fernandes</sub>](https://github.com/Viniflr) |  [<img loading="lazy" src="https://avatars.githubusercontent.com/u/198750490?v=4" width=115><br><sub>Larissa Beatriz</sub>](https://github.com/laags6) |  [<img loading="lazy" src="https://avatars.githubusercontent.com/u/198752208?v=4" width=115><br><sub>Pedro Enrico</sub>](https://github.com/pedrocaribe06) |
| :---: | :---: | :---: |

---

🔹 *Projeto desenvolvido para a disciplina de Banco de Dados*  
🔹 *Atualizado em: 20/06/2024*
