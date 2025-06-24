USE lojaRoupas;

-- Desabilita a verificação de chaves estrangeiras para permitir a exclusão de tabelas com dependências
SET FOREIGN_KEY_CHECKS = 0;

-- Drop de Triggers
DROP TRIGGER IF EXISTS tr_after_insert_itemPedidos;
DROP TRIGGER IF EXISTS tr_after_update_itemPedidos;
DROP TRIGGER IF EXISTS tr_after_delete_itemPedidos;
DROP TRIGGER IF EXISTS tr_before_insert_funcionarios;
DROP TRIGGER IF EXISTS tr_before_insert_clientes;
DROP TRIGGER IF EXISTS tr_after_update_estoque_log;

-- Drop de Procedures
DROP PROCEDURE IF EXISTS AdicionarProduto;
DROP PROCEDURE IF EXISTS AtualizarEstoque;
DROP PROCEDURE IF EXISTS RegistrarPagamentoVenda;
DROP PROCEDURE IF EXISTS ObterHistoricoComprasCliente;
DROP PROCEDURE IF EXISTS AtualizarSalarioComissao;
DROP PROCEDURE IF EXISTS GerarRelatorioVendasPeriodo;

-- Drop de Functions
DROP FUNCTION IF EXISTS CalcularIdadeCliente;
DROP FUNCTION IF EXISTS ObterQtdVendidaProduto;
DROP FUNCTION IF EXISTS CalcularValorTotalPedido;
DROP FUNCTION IF EXISTS VerificarEstoqueBaixo;
DROP FUNCTION IF EXISTS FormatarCPF;
DROP FUNCTION IF EXISTS CalcularDescontoVenda;

-- Drop de Views
DROP VIEW IF EXISTS vw_clientes_endereco;
DROP VIEW IF EXISTS vw_funcionarios_endereco_departamento;
DROP VIEW IF EXISTS vw_vendas_clientes_funcionarios;
DROP VIEW IF EXISTS vw_total_vendas_cliente;
DROP VIEW IF EXISTS vw_total_vendas_funcionario;
DROP VIEW IF EXISTS vw_produtos_mais_vendidos;
DROP VIEW IF EXISTS vw_pedidos_clientes;
DROP VIEW IF EXISTS vw_itens_pedido;
DROP VIEW IF EXISTS vw_fornecedores_endereco;
DROP VIEW IF EXISTS vw_produtos_categoria_moda;
DROP VIEW IF EXISTS vw_produtos_estoque_baixo;
DROP VIEW IF EXISTS vw_clientes_ultimos_pedidos;
DROP VIEW IF EXISTS vw_funcionarios_admitidos_2017;

-- Drop de Tabelas
DROP TABLE IF EXISTS itemPedidos;
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS estoque;
DROP TABLE IF EXISTS enderecoForne;
DROP TABLE IF EXISTS produto;
DROP TABLE IF EXISTS fornecedor;
DROP TABLE IF EXISTS categProduto;
DROP TABLE IF EXISTS formaPag;
DROP TABLE IF EXISTS vendas;
DROP TABLE IF EXISTS planoSaude;
DROP TABLE IF EXISTS cargo;
DROP TABLE IF EXISTS departamento;
DROP TABLE IF EXISTS dependentes;
DROP TABLE IF EXISTS ferias;
DROP TABLE IF EXISTS enderecoFunc;
DROP TABLE IF EXISTS funcionarios;
DROP TABLE IF EXISTS enderecoCli;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS logEstoqueBaixo; -- Tabela de log a ser criada para o trigger

-- Reabilita a verificação de chaves estrangeiras
SET FOREIGN_KEY_CHECKS = 1;

-- Remover o esquema (banco de dados) completo
DROP SCHEMA IF EXISTS lojaRoupas;