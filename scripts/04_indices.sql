-- Índices para campos frequentemente pesquisados
CREATE INDEX idx_produto_nome ON produto(nomeProduto);
CREATE INDEX idx_produto_marca ON produto(marca);
CREATE INDEX idx_produto_categoria ON produto(id_categoria);
CREATE INDEX idx_vendas_cliente ON vendas(clientes_cpf);
CREATE INDEX idx_vendas_funcionario ON vendas(funcionario_cpf);
CREATE INDEX idx_vendas_data ON vendas(dataVenda);