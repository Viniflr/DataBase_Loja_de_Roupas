USE lojaRoupas;

-- Teste da Function 1: CalcularIdadeCliente
SELECT CalcularIdadeCliente('1990-01-15') AS IdadeLucas;
SELECT c.nome, CalcularIdadeCliente(c.dataNasc) AS Idade
FROM clientes
WHERE c.CPF = '111.111.111-11';

-- Teste da Function 2: ObterQtdVendidaProduto
-- Primeiro, obtenha um id_produto existente
SELECT idProduto, nomeProduto FROM produto LIMIT 1; -- Ex: idProduto 1
SELECT ObterQtdVendidaProduto(1) AS QtdVendidaProd1;
SELECT ObterQtdVendidaProduto(999) AS QtdVendidaProdInexistente;

-- Teste da Function 3: CalcularValorTotalPedido
-- Primeiro, obtenha um id_pedido existente
SELECT idPedidos FROM pedidos LIMIT 1; -- Ex: idPedidos 1
SELECT CalcularValorTotalPedido(1) AS ValorTotalPedido1;
SELECT p.idPedidos, p.statusPedido, CalcularValorTotalPedido(p.idPedidos) AS ValorCalculado
FROM pedidos p
WHERE p.idPedidos = 3;

-- Teste da Function 4: VerificarEstoqueBaixo
-- Primeiro, obtenha um id_produto existente e sua qtdDisponivel
SELECT idProduto, qtdDisponivel FROM estoque LIMIT 1; -- Ex: idProduto 1, Qtd: 100
SELECT VerificarEstoqueBaixo(1, 50) AS Prod1EstoqueBaixo; -- Deve ser FALSE (100 < 50 é falso)
SELECT VerificarEstoqueBaixo(2, 70) AS Prod2EstoqueBaixo; -- Deve ser TRUE (50 < 70 é verdadeiro)
SELECT VerificarEstoqueBaixo(999, 10) AS ProdInexistente; -- Deve ser FALSE

-- Teste da Function 5: FormatarCPF
SELECT FormatarCPF('12345678900') AS CPFFormatado1;
SELECT FormatarCPF('123.456.789-00') AS CPFFormatado2; -- Já formatado
SELECT FormatarCPF('12345') AS CPFInvalido;

-- Teste da Function 6: CalcularDescontoVenda
SELECT CalcularDescontoVenda(100.00, 10.00) AS Desconto10Pct;
SELECT CalcularDescontoVenda(500.00, 5.50) AS Desconto5_5Pct;
SELECT CalcularDescontoVenda(200.00, NULL) AS DescontoNulo;
SELECT CalcularDescontoVenda(200.00, 0) AS DescontoZero;
