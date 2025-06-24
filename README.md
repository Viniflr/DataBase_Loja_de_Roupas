# 🏬 Sistema de Banco de Dados para Loja de Roupas

[![My Skills](https://skillicons.dev/icons?i=mysql,github)](https://skillicons.dev)

## 🎯 Objetivo do Projeto

O objetivo principal deste projeto é simular e gerenciar as operações de uma loja de roupas, organizando informações sobre:

* Clientes
* Funcionários e seus departamentos/cargos/dependentes
* Fornecedores
* Categorias de Produtos
* Produtos e seus estoques
* Vendas e Formas de Pagamento
* Pedidos e Itens de Pedido

O sistema permite não apenas o armazenamento desses dados, mas também a execução de consultas complexas, automação de processos via triggers e procedures, e o fornecimento de informações sumarizadas através de views, otimizando a gestão do negócio.

## 📂 Estrutura de Arquivos

* `DROP.sql`: Remove todos os objetos do banco de dados para iniciar um ambiente limpo.
* `SCHEMA.sql`: Cria o esquema (`lojaRoupas`) e todas as tabelas principais.
* `ALTER_TABLES.sql`: Realiza modificações na estrutura das tabelas existentes (adição/alteração de colunas, constraints, etc.).
* `FUNCTIONS.sql`: Define funções personalizadas para lógicas de negócio.
* `PROCEDURES.sql`: Contém procedures armazenadas para automação de tarefas.
* `TRIGGERS.sql`: Define triggers que são disparadas automaticamente por eventos no banco.
* `INSERT.sql`: Popula as tabelas com dados iniciais para testes.
* `UPDATE_DELETE.sql`: Exemplos de scripts para atualização e exclusão de dados.
* `VIEWS.sql`: Cria views para facilitar consultas e relatórios.
* `QUERIES.sql`: Contém consultas DQL complexas e exemplos de uso das funcionalidades.
* `TEST.sql`: Script dedicado a testar o funcionamento de todas as Functions, Procedures e Triggers.

## ⚙️ Como Configurar e Executar o Projeto

Para configurar e executar o banco de dados em seu ambiente, siga os passos abaixo na ordem indicada:

1.  **Crie o Banco de Dados:** Abra seu cliente MySQL (ex: MySQL Workbench, DBeaver) e conecte-se ao seu servidor MySQL.
    ```sql
    CREATE SCHEMA IF NOT EXISTS lojaRoupas;
    USE lojaRoupas;
    ```
2.  **Execute os Scripts em Ordem:**
    * `DROP.sql`: Execute este script primeiro para garantir que não haja objetos anteriores que possam causar conflito.
    * `SCHEMA.sql`: Execute para criar as tabelas e o esquema inicial.
    * `ALTER_TABLES.sql`: Execute para aplicar todas as alterações estruturais nas tabelas.
    * `FUNCTIONS.sql`: Execute para criar todas as funções personalizadas.
    * `PROCEDURES.sql`: Execute para criar todas as procedures armazenadas.
    * `TRIGGERS.sql`: Execute para criar todas as triggers.
    * `INSERT.sql`: Execute para popular o banco de dados com os dados iniciais.
3.  **Teste as Funcionalidades:**
    * `TEST.sql`: Este arquivo contém chamadas para as funções e procedures, além de exemplos que disparam as triggers. Execute-o para verificar se tudo está funcionando como esperado.
    * `QUERIES.sql`: Explore este arquivo para ver exemplos de consultas complexas e como extrair informações valiosas do banco de dados.

## 📊 Modelagem do Banco de Dados

### Modelo Entidade-Relacionamento (MER)
![image](https://github.com/user-attachments/assets/39bc67b9-3377-4f7f-aa16-fc7d82cb07b8)

**Principais Entidades:**
- `clientes` - Cadastro completo de clientes
- `funcionarios` - Dados dos colaboradores
- `produto` - Catálogo de roupas
- `vendas` - Transações comerciais
- `fornecedor` - Parceiros comerciais

## ✨ Funcionalidades Destacadas

* **Controle de Estoque Automatizado:** Triggers que atualizam a quantidade de produtos em estoque automaticamente após vendas e ajustes.
* **Cálculo de Pedidos:** Functions e Triggers que calculam e atualizam o valor total dos pedidos dinamicamente.
* **Gerenciamento de Funcionários:** Procedures para atualizar salários e comissões, e Triggers para formatação de dados e datas de admissão.
* **Relatórios de Vendas:** Views e Procedures para gerar relatórios detalhados de vendas por período, funcionário, cliente, etc.
* **Verificação de Estoque Baixo:** Função para identificar rapidamente produtos com estoque abaixo de um limite definido e Trigger para registrar esses eventos em um log.
* **Formatação de Dados:** Funções para padronizar a entrada de dados como CPF.

## 👨‍💻 Autores
| [<img loading="lazy" src="https://avatars.githubusercontent.com/u/119247208?s=400&u=a41a122510e3447159fb98c4797d79ff19b43e39&v=4" width=115><br><sub>Vinícius Fernandes</sub>](https://github.com/Viniflr) |  [<img loading="lazy" src="https://avatars.githubusercontent.com/u/198750490?v=4" width=115><br><sub>Larissa Beatriz</sub>](https://github.com/laags6) |  [<img loading="lazy" src="https://avatars.githubusercontent.com/u/198752208?v=4" width=115><br><sub>Pedro Enrico</sub>](https://github.com/pedrocaribe06) |
| :---: | :---: | :---: |

---

🔹 *Projeto desenvolvido para a disciplina de Banco de Dados*  
🔹 *Atualizado em: 20/06/2024*
