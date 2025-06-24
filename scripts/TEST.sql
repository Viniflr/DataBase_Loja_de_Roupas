-- ===============================
-- TESTES DE FUNCTIONS
-- ===============================

-- FUNCTION 1: CalcularIdadeCliente
SELECT CalcularIdadeCliente('1990-01-15') AS IdadeLucas;

-- FUNCTION 2: ObterQtdVendidaProduto
SELECT ObterQtdVendidaProduto(3) AS TotalVendidoProduto1;

-- FUNCTION 3: CalcularValorTotalPedido
SELECT CalcularValorTotalPedido(1) AS TotalPedido1;

-- FUNCTION 4: VerificarEstoqueBaixo
SELECT id_produto, qtdDisponivel FROM estoque WHERE id_produto = 2;
SELECT VerificarEstoqueBaixo(2, 30) AS Estoque;

-- FUNCTION 5: FormatarCPF
SELECT FormatarCPF('11111111111') AS CPFFormatado;
SELECT FormatarCPF('abc.123.456-78') AS CPFInvalido;

-- FUNCTION 6: CalcularDescontoVenda
SELECT 1000.00 - CalcularDescontoVenda(1000.00, 10.00) AS Desconto10;
SELECT CalcularDescontoVenda(500.00, 0) AS SemDesconto;
SELECT CalcularDescontoVenda(800.00, 150) AS DescontoAcimaLimite;

-- ===============================
-- TESTES DE PROCEDURES
-- ===============================

-- PROCEDURE 1: Adiciona um novo produto e o coloca no estoque
-- ANTES
SELECT idProduto, nomeProduto FROM produto ORDER BY idProduto DESC LIMIT 5;
SELECT id_produto, qtdDisponivel FROM estoque ORDER BY idEstoque DESC LIMIT 5;

CALL AdicionarProduto('00.000.000/0001-00', 4, 89.90, 'Nike', 'Meia esportiva', 'Cinza', 'Meia Dry-Fit', '40', 80, 'Corredor F, Prateleira 6');

-- DEPOIS
SELECT idProduto, nomeProduto FROM produto ORDER BY idProduto DESC LIMIT 5;
SELECT id_produto, qtdDisponivel, localizacao FROM estoque WHERE id_produto = (SELECT MAX(idProduto) FROM produto);

-- PROCEDURE 2: Atualiza a quantidade disponível de um produto no estoque
SELECT id_produto, qtdDisponivel FROM estoque WHERE id_produto = 1;
CALL AtualizarEstoque(1, 120); 
SELECT id_produto, qtdDisponivel FROM estoque WHERE id_produto = 1; 

-- PROCEDURE 3: Registrar Pagamento Venda
CALL RegistrarPagamentoVenda(1, 599.98, 'Pix', 'Pagamento confirmado via Pix.');
SELECT * FROM vendas WHERE idVendas = 1;

-- PROCEDURE 4: Histórico de Compras
CALL ObterHistoricoComprasCliente('000.000.000-00');

-- PROCEDURE 5: Atualizar salário e comissão
SELECT nome, salario, comissao FROM funcionarios WHERE CPF = '222.333.444-55';
CALL AtualizarSalarioComissao('222.333.444-55', 3800.00, 400.00);
SELECT nome, salario, comissao FROM funcionarios WHERE CPF = '222.333.444-55';

-- PROCEDURE 6: Relatório de Vendas por Período
CALL GerarRelatorioVendasPeriodo('2025-04-20', '2025-04-25');

-- ===============================
-- TESTES DE TRIGGERS
-- ===============================

-- TRIGGER 1: AFTER INSERT ON itemPedidos
SELECT idPedidos, valorTotal FROM pedidos WHERE idPedidos = 1; 
SELECT id_produto, qtdDisponivel FROM estoque WHERE id_produto = 1;

INSERT INTO itemPedidos (id_pedido, id_produto, quantidade, precoUnitario, frete)
VALUES (1, 1, 1, 299.99, 0.00);

SELECT idPedidos, valorTotal FROM pedidos WHERE idPedidos = 1; 
SELECT id_produto, qtdDisponivel FROM estoque WHERE id_produto = 1;

-- TRIGGER 2: AFTER UPDATE ON itemPedidos
SELECT * FROM pedidos WHERE idPedidos = 2;
UPDATE itemPedidos SET quantidade = 2 WHERE id_pedido = 2 AND id_produto = 2;
SELECT * FROM pedidos WHERE idPedidos = 2;

-- TRIGGER 3: AFTER DELETE ON itemPedidos
SELECT valorTotal FROM pedidos WHERE idPedidos = 3;
SELECT qtdDisponivel FROM estoque WHERE id_produto = 3;
DELETE FROM itemPedidos WHERE id_pedido = 3 AND id_produto = 3;
SELECT valorTotal FROM pedidos WHERE idPedidos = 3;
SELECT qtdDisponivel FROM estoque WHERE id_produto = 3;

-- TRIGGER 4: BEFORE INSERT ON funcionarios
INSERT INTO funcionarios (CPF, nome, estadoCivil, dataNasc, sexo, email, telefone, salario, cargaHora, idDepartamento, idCargo, idPlanoSaude)
VALUES ('999.888.777-66', 'Teste Admissao', 'Solteiro', '1990-10-10', 'M', 'teste@teste.com', '(11) 90000-0000', 3000.00, 40, 1, 2, 1);
SELECT nome, dataAdm FROM funcionarios WHERE CPF = '999.888.777-66';
DELETE FROM funcionarios WHERE CPF = '999.888.777-66';

-- TRIGGER 5: BEFORE INSERT ON clientes
INSERT INTO clientes (CPF, nome, dataNasc, sexo, email, telefone, rg)
VALUES ('12345678901', 'Cliente Sem Ponto', '1990-01-01', 'F', 'sem.ponto@email.com', '(11) 99999-9999', '1234567');
SELECT CPF FROM clientes WHERE email = 'sem.ponto@email.com';
DELETE FROM clientes WHERE email = 'sem.ponto@email.com';

-- TRIGGER 6: AFTER UPDATE ON estoque (log de estoque baixo)
SELECT * FROM logEstoqueBaixo; 
UPDATE estoque SET qtdDisponivel = 15 WHERE id_produto = 1; 
SELECT * FROM logEstoqueBaixo ORDER BY idLog DESC LIMIT 1;
