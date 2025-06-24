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

-- 3. Vendas por Forma de Pagamento (Correção na junção)
SELECT fp.tipo AS FormaPagamento, SUM(v.valorTotal) AS TotalVendas
FROM vendas v
JOIN formaPag fp ON v.id_formaPag = fp.idFormaPag 
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
FROM produto p
JOIN itemPedidos ip ON p.idProduto = ip.id_produto
GROUP BY p.nomeProduto
ORDER BY QuantidadeVendida DESC;

-- 7. Clientes que fizeram mais de um pedido.
SELECT c.nome AS NomeCliente, COUNT(p.idPedidos) AS NumeroDePedidos
FROM clientes c
JOIN pedidos p ON c.CPF = p.clientes_cpf
GROUP BY c.nome
HAVING COUNT(p.idPedidos) > 1;

-- 8. Funcionários e seus dependentes.
SELECT f.nome AS NomeFuncionario, d.nome AS NomeDependente, d.parentesco
FROM funcionarios f
JOIN dependentes d ON f.CPF = d.funcionario_cpf;

-- 9. Produtos em estoque com quantidade disponível abaixo de 50 unidades.
SELECT p.nomeProduto, e.qtdDisponivel, e.localizacao
FROM produto p
JOIN estoque e ON p.idProduto = e.id_produto
WHERE e.qtdDisponivel < 50;

-- 10. Pedidos com status 'Pendente' e os clientes associados.
SELECT p.idPedidos, c.nome AS NomeCliente, p.dataPedido
FROM pedidos p
JOIN clientes c ON p.clientes_cpf = c.CPF
WHERE p.statusPedido = 'Pendente';

-- 11. Categorias de produtos sem nenhum produto associado.
SELECT cp.nomeCateg
FROM categProduto cp
LEFT JOIN produto p ON cp.idCategoria = p.id_categoria
WHERE p.idProduto IS NULL;

-- 12. Funcionários que não têm dependentes.
SELECT f.nome AS NomeFuncionario
FROM funcionarios f
LEFT JOIN dependentes d ON f.CPF = d.funcionario_cpf
WHERE d.idDependente IS NULL;

-- 13. Vendas realizadas em um determinado mês e ano (ex: Abril de 2025).
SELECT idVendas, dataVenda, valorTotal
FROM vendas
WHERE MONTH(dataVenda) = 4 AND YEAR(dataVenda) = 2025;

-- 14. Média salarial por departamento.
SELECT d.nome AS NomeDepartamento, AVG(f.salario) AS MediaSalarial
FROM departamento d
JOIN funcionarios f ON d.idDepartamento = f.idDepartamento
GROUP BY d.nome;

-- 15. Fornecedores que fornecem produtos de 'Calçados'.
SELECT DISTINCT f.razaoSocial AS NomeFornecedor 
FROM fornecedor f
JOIN produto p ON f.CNPJ = p.id_fornecedor
JOIN categProduto cp ON p.id_categoria = cp.idCategoria
WHERE cp.nomeCateg = 'Calçados';

-- 16. Produtos de um Fornecedor Específico (Correção no nome da coluna)
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
JOIN vendas v ON f.CPF = v.funcionario_cpf
GROUP BY f.nome
ORDER BY NumeroVendas DESC
LIMIT 1;

-- 23. Clientes com pedidos com valor total acima de 500.00.
SELECT c.nome AS NomeCliente, p.idPedidos, p.valorTotal
FROM clientes c
JOIN pedidos p ON c.CPF = p.clientes_cpf
WHERE p.valorTotal > 500.00;

-- 24. Produtos que nunca foram vendidos.
SELECT p.nomeProduto, p.marca
FROM produto p
LEFT JOIN itemPedidos ip ON p.idProduto = ip.id_produto
WHERE ip.idItemPedidos IS NULL;

-- 25. Fornecedores que não têm produtos em estoque.
SELECT f.razaoSocial AS NomeFornecedor 
FROM fornecedor f
LEFT JOIN produto p ON f.CNPJ = p.id_fornecedor
LEFT JOIN estoque e ON p.idProduto = e.id_produto
WHERE e.idEstoque IS NULL
GROUP BY f.razaoSocial;

-- Consulta DQL 14: Estoque de produtos agrupados por localização
SELECT localizacao, COUNT(idEstoque) AS QuantidadeProdutosDiferentes, SUM(qtdDisponivel) AS QuantidadeTotalItens
FROM estoque
GROUP BY localizacao;

-- Consulta DQL 15: Média de itens por pedido
SELECT AVG(quantidade) AS MediaItensPorPedido
FROM itemPedidos;

-- Consulta DQL 16: Produtos com estoque baixo e seu fornecedor (JOIN)
SELECT p.nomeProduto, e.qtdDisponivel, f.razaoSocial AS NomeFornecedor
FROM produto p
JOIN estoque e ON p.idProduto = e.id_produto
JOIN fornecedor f ON p.id_fornecedor = f.CNPJ
WHERE e.qtdDisponivel < 30;

-- Consulta DQL 17: Vendas com forma de pagamento 'Cartão de Crédito' e o nome do cliente
SELECT v.idVendas, c.nome AS NomeCliente, v.dataVenda, v.valorTotal
FROM vendas v
JOIN clientes c ON v.clientes_cpf = c.CPF
JOIN formaPag fp ON v.id_formaPag = fp.idFormaPag 
WHERE fp.tipo = 'Cartão de Crédito';

-- Consulta DQL 18: Departamentos que possuem funcionários com salário acima da média geral
SELECT d.nome AS NomeDepartamento, AVG(f.salario) AS MediaSalarialDepartamento
FROM departamento d
JOIN funcionarios f ON d.idDepartamento = f.idDepartamento
GROUP BY d.nome
HAVING AVG(f.salario) > (SELECT AVG(salario) FROM funcionarios);

-- Consulta DQL 19: Produtos comprados por um cliente específico em pedidos (JOINs múltiplos)
SELECT DISTINCT p.nomeProduto, p.marca, p.preco
FROM clientes cli
JOIN pedidos ped ON cli.CPF = ped.clientes_cpf
JOIN itemPedidos ip ON ped.idPedidos = ip.id_pedido
JOIN produto p ON ip.id_produto = p.idProduto
WHERE cli.CPF = '999.999.999-99'; 