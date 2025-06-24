USE lojaRoupas;

-- 1. Listar todos os clientes com seus endereços completos.
SELECT c.nome AS NomeCliente, c.email AS EmailCliente, ec.rua, ec.numero, ec.bairro, ec.cidade, ec.uf, ec.cep
FROM clientes c
JOIN enderecoCli ec ON c.CPF = ec.clientes_cpf;

-- 2. Listar todos os funcionários com seus endereços completos e departamento.
SELECT f.nome AS NomeFuncionario, f.email AS EmailFuncionario, ef.rua, ef.numero, ef.bairro, ef.cidade, ef.uf, ef.cep, d.nome AS Departamento
FROM funcionarios f
JOIN enderecoFunc ef ON f.CPF = ef.funcionario_cpf
LEFT JOIN departamento d ON f.idDepartamento = d.idDepartamento;

-- 3.  Vendas por Forma de Pagamento
SELECT fp.tipo AS FormaPagamento, SUM(v.valorTotal) AS TotalVendas
FROM vendas v
JOIN formaPag fp ON v.idVendas = fp.id_vendas
GROUP BY fp.tipo;

-- 4. Produtos com Preço em uma Faixa
SELECT nomeProduto, preco
FROM produto
WHERE preco BETWEEN 50.00 AND 100.00;

-- 5. Total de vendas por funcionário.
SELECT f.nome AS NomeFuncionario, SUM(v.valorTotal) AS TotalVendas
FROM vendas v
JOIN funcionarios f ON v.funcionario_cpf = f.CPF
GROUP BY f.nome
ORDER BY TotalVendas DESC;

-- 6. Produtos mais vendidos (baseado em itens de pedidos).
SELECT p.nomeProduto, SUM(ip.quantidade) AS QuantidadeVendida
FROM itemPedidos ip
JOIN produto p ON ip.id_produto = p.idProduto
GROUP BY p.nomeProduto
ORDER BY QuantidadeVendida DESC
LIMIT 10;

-- 7. Pedidos com os nomes dos clientes.
SELECT pe.idPedidos, c.nome AS NomeCliente, pe.dataPedido, pe.statusPedido
FROM pedidos pe
JOIN clientes c ON pe.clientes_cpf = c.CPF
ORDER BY pe.dataPedido DESC;

-- 8. Itens de um pedido específico (ex: ID 5).
SELECT p.nomeProduto, ip.quantidade, ip.precoUnitario, (ip.quantidade * ip.precoUnitario) AS Subtotal
FROM itemPedidos ip
JOIN produto p ON ip.id_produto = p.idProduto
WHERE ip.id_pedido = 5;

-- 9. Fornecedores com seus endereços.
SELECT f.razaoSocial, f.email, f.telefone, ef.rua, ef.numero, ef.bairro, ef.cidade, ef.uf, ef.cep
FROM fornecedor f
JOIN enderecoForne ef ON f.CNPJ = ef.fornecedor_cnpj;

-- 10. Produtos de uma determinada categoria (ex: 'Moda').
SELECT p.nomeProduto, p.preco, p.marca, p.cor, p.tamanho
FROM produto p
JOIN categProduto cp ON p.id_categoria = cp.idCategoria
WHERE cp.nomeCateg = 'Moda';

-- 11. Produtos com quantidade em estoque abaixo de um certo limite (ex: 50).
SELECT p.nomeProduto, e.qtdDisponivel, e.localizacao
FROM produto p
JOIN estoque e ON p.idProduto = e.id_produto
WHERE e.qtdDisponivel < 50;

-- 12. Clientes que fizeram pedidos em um determinado período (ex: último mês).
SELECT DISTINCT c.nome AS NomeCliente, c.email AS EmailCliente
FROM clientes c
JOIN pedidos pe ON c.CPF = pe.clientes_cpf
WHERE pe.dataPedido >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

-- 13. Funcionários admitidos após uma determinada data.
SELECT nome AS NomeFuncionario, dataAdm
FROM funcionarios
WHERE dataAdm > '2017-01-01';

-- 14. Valor total gasto por cada cliente em todos os pedidos.
SELECT c.nome AS NomeCliente, SUM(ip.quantidade * ip.precoUnitario) AS TotalGasto
FROM clientes c
JOIN pedidos pe ON c.CPF = pe.clientes_cpf
JOIN itemPedidos ip ON pe.idPedidos = ip.id_pedido
GROUP BY c.nome
ORDER BY TotalGasto DESC;

-- 15. Último pedido de cada cliente.
SELECT c.nome AS NomeCliente, MAX(pe.dataPedido) AS UltimoPedido
FROM clientes c
JOIN pedidos pe ON c.CPF = pe.clientes_cpf
GROUP BY c.nome
ORDER BY UltimoPedido DESC;

-- 16. Produtos fornecidos por um determinado fornecedor (ex: 'Nike Brasil').
SELECT p.nomeProduto, p.preco, p.marca
FROM produto p
JOIN fornecedor f ON p.id_fornecedor = f.CNPJ
WHERE f.razaoSocial = 'Nike Brasil';

-- 17. Produtos por Categoria
SELECT cp.nomeCateg, COUNT(p.idProduto) AS NumeroProdutos
FROM produto p
JOIN categProduto cp ON p.id_categoria = cp.idCategoria
GROUP BY cp.nomeCateg;

-- 18. Funcionários com Salário Acima da Média
SELECT nome AS NomeFuncionario, salario
FROM funcionarios
WHERE salario > (SELECT AVG(salario) FROM funcionarios);

-- 19. Funcionários Admitidos em um Intervalo de Datas
SELECT nome AS NomeFuncionario, dataAdm
FROM funcionarios
WHERE dataAdm BETWEEN '2015-01-01' AND '2018-12-31';

-- 20. Categorias de produtos com o número total de produtos em cada uma.
SELECT cp.nomeCateg, COUNT(p.idProduto) AS TotalProdutos
FROM categProduto cp
LEFT JOIN produto p ON cp.idCategoria = p.id_categoria
GROUP BY cp.nomeCateg
ORDER BY TotalProdutos DESC;

-- 21. Total de vendas por categoria de produto.
SELECT cp.nomeCateg, SUM(v.valorTotal) AS TotalVendas
FROM vendas v
JOIN itemPedidos ip ON v.idVendas = ip.id_pedido
JOIN produto p ON ip.id_produto = p.idProduto
JOIN categProduto cp ON p.id_categoria = cp.idCategoria
GROUP BY cp.nomeCateg
ORDER BY TotalVendas DESC;

-- 22. Funcionários com o maior número de vendas realizadas.
SELECT f.nome AS NomeFuncionario, COUNT(v.idVendas) AS NumeroVendas
FROM funcionarios f
LEFT JOIN vendas v ON f.CPF = v.funcionario_cpf
GROUP BY f.nome
ORDER BY NumeroVendas DESC
LIMIT 5;

-- 23. Produtos com o maior preço de venda.
SELECT nomeProduto, preco
FROM produto
ORDER BY preco DESC
LIMIT 10;