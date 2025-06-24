USE lojaRoupas;

-- Teste da Trigger 1, 2, 3 (itemPedidos - valorTotal e estoque)
-- (Certifique-se de que a tabela 'pedidos' tem 'valorTotal' e as tabelas 'produto' e 'estoque' têm dados)

-- 1. Inserir um novo item em um pedido existente (ID 1, produto 1, qtd 2, preco unitario 299.99)
-- (o pedido 1 já tem valorTotal calculado para itens existentes, vamos adicionar mais)
-- Assumindo id_pedido 1 existe e id_produto 7 (Tênis Nike Free, preco 259.99) existe
SELECT p.valorTotal FROM pedidos p WHERE p.idPedidos = 1; -- Valor original do pedido 1
SELECT e.qtdDisponivel FROM estoque e WHERE e.id_produto = 7; -- Estoque original do produto 7

INSERT INTO itemPedidos (id_pedido, id_produto, quantidade, precoUnitario, frete) VALUES
(1, 7, 1, 259.99, 0.00); -- Adiciona 1 unidade do produto 7 ao pedido 1

SELECT p.valorTotal FROM pedidos p WHERE p.idPedidos = 1; -- Valor do pedido 1 deve ter aumentado em 259.99
SELECT e.qtdDisponivel FROM estoque e WHERE e.id_produto = 7; -- Estoque do produto 7 deve ter diminuído em 1 unidade

-- 2. Atualizar um item de pedido existente (ID do item de pedido 1, que é produto 1)
-- Aumenta a quantidade do produto 1 no pedido 1 de 2 para 3
SELECT p.valorTotal FROM pedidos p WHERE p.idPedidos = 1; -- Valor atual do pedido 1
SELECT e.qtdDisponivel FROM estoque e WHERE e.id_produto = 1; -- Estoque atual do produto 1

UPDATE itemPedidos SET quantidade = 3 WHERE idItemPedidos = 1; -- Item de pedido 1 (produto 1)

SELECT p.valorTotal FROM pedidos p WHERE p.idPedidos = 1; -- Valor do pedido 1 deve ter aumentado em 299.99 (1 unidade extra)
SELECT e.qtdDisponivel FROM estoque e WHERE e.id_produto = 1; -- Estoque do produto 1 deve ter diminuído em 1 unidade

-- 3. Deletar um item de pedido (o item de pedido 1, que é produto 1)
SELECT p.valorTotal FROM pedidos p WHERE p.idPedidos = 1; -- Valor atual do pedido 1
SELECT e.qtdDisponivel FROM estoque e WHERE e.id_produto = 1; -- Estoque atual do produto 1

DELETE FROM itemPedidos WHERE idItemPedidos = 1;

SELECT p.valorTotal FROM pedidos p WHERE p.idPedidos = 1; -- Valor do pedido 1 deve ter diminuído pelo valor do item deletado
SELECT e.qtdDisponivel FROM estoque e WHERE e.id_produto = 1; -- Estoque do produto 1 deve ter aumentado em 3 unidades (o que foi removido)

-- Teste da Trigger 4 (BEFORE INSERT ON funcionarios)
-- Inserir um novo funcionário sem dataAdm
INSERT INTO funcionarios (CPF, nome, nomeSocial, estadoCivil, dataNasc, sexo, email, telefone, salario, cargaHora, comissao, dataAdm, dataDem, idDepartamento) VALUES
('101.000.111-22', 'Novo Func', NULL, 'Solteiro', '1990-01-01', 'M', 'novo.func@email.com', '(11) 90000-0000', 3000.00, 40, 100.00, NULL, NULL, 1);
SELECT CPF, nome, dataAdm FROM funcionarios WHERE CPF = '101.000.111-22'; -- dataAdm deve ter sido preenchida automaticamente

-- Teste da Trigger 5 (BEFORE INSERT ON clientes)
-- Inserir um novo cliente com CPF não formatado
INSERT INTO clientes (CPF, nome, nomeSocial, dataNasc, sexo, email, telefone, rg) VALUES
('12345678901', 'Cliente Novo', NULL, '2000-05-10', 'F', 'cliente.novo@email.com', '(11) 91111-1111', '123456');
SELECT CPF, nome FROM clientes WHERE CPF = '123.456.789-01'; -- CPF deve estar formatado

-- Teste da Trigger 6 (AFTER UPDATE ON estoque_log)
-- Reduzir o estoque de um produto para abaixo do limite (20)
-- Primeiro, encontre um produto com estoque acima de 20
SELECT idProduto, qtdDisponivel FROM estoque WHERE qtdDisponivel > 20 LIMIT 1; -- Ex: idProduto 1, qtdDisponivel (deve ser >20)

-- Atualiza o estoque para um valor abaixo de 20
UPDATE estoque SET qtdDisponivel = 15 WHERE id_produto = (SELECT idProduto FROM estoque WHERE qtdDisponivel > 20 LIMIT 1);
-- Verifique a tabela de log
SELECT * FROM logEstoqueBaixo ORDER BY dataHoraLog DESC LIMIT 1;
