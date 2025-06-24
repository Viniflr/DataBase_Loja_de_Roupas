-- 1. View para listar clientes com seus endereços completos
CREATE VIEW vw_clientes_endereco AS
SELECT c.nome AS NomeCliente, c.email AS EmailCliente, ec.rua, ec.numero, ec.bairro, ec.cidade, ec.uf, ec.cep
FROM clientes c
JOIN enderecoCli ec ON c.CPF = ec.clientes_cpf;

-- 2. View para listar funcionários com seus endereços completos e departamento
CREATE VIEW vw_funcionarios_endereco_departamento AS
SELECT
    f.nome AS NomeFuncionario,
    f.email AS EmailFuncionario,
    ef.rua, ef.numero, ef.bairro, ef.cidade, ef.uf, ef.cep,
    d.nome AS Departamento
FROM funcionarios f
JOIN enderecoFunc ef ON f.CPF = ef.funcionario_cpf
LEFT JOIN departamento d ON f.idDepartamento = d.idDepartamento;

-- 3. View para relatório de vendas com nome do cliente e do funcionário
CREATE VIEW vw_vendas_clientes_funcionarios AS
SELECT v.idVendas, c.nome AS NomeCliente, f.nome AS NomeFuncionario, v.dataVenda, v.valorTotal
FROM vendas v
JOIN clientes c ON v.clientes_cpf = c.CPF
JOIN funcionarios f ON v.funcionario_cpf = f.CPF
ORDER BY v.dataVenda DESC;

-- 4. View para total de vendas por cliente
CREATE VIEW vw_total_vendas_cliente AS
SELECT c.nome AS NomeCliente, SUM(v.valorTotal) AS TotalVendas
FROM vendas v
JOIN clientes c ON v.clientes_cpf = c.CPF
GROUP BY c.CPF
ORDER BY TotalVendas DESC;

-- 5. View para total de vendas por funcionário
CREATE VIEW vw_total_vendas_funcionario AS
SELECT f.nome AS NomeFuncionario, SUM(v.valorTotal) AS TotalVendas
FROM vendas v
JOIN funcionarios f ON v.funcionario_cpf = f.CPF
GROUP BY f.CPF
ORDER BY TotalVendas DESC;

-- 6. View para produtos mais vendidos (baseado em itens de pedidos)
CREATE VIEW vw_produtos_mais_vendidos AS
SELECT p.nomeProduto, SUM(ip.quantidade) AS QuantidadeVendida
FROM itemPedidos ip
JOIN produto p ON ip.id_produto = p.idProduto
GROUP BY p.nomeProduto
ORDER BY QuantidadeVendida DESC
LIMIT 10;

-- 7. View para pedidos com os nomes dos clientes
CREATE VIEW vw_pedidos_clientes AS
SELECT pe.idPedidos, c.nome AS NomeCliente, pe.dataPedido, pe.statusPedido
FROM pedidos pe
JOIN clientes c ON pe.clientes_cpf = c.CPF
ORDER BY pe.dataPedido DESC;

-- 8. View para itens de um pedido específico
CREATE VIEW vw_itens_pedido AS
SELECT ip.id_pedido, p.nomeProduto, ip.quantidade, ip.precoUnitario,
       (ip.quantidade * ip.precoUnitario) AS Subtotal
FROM itemPedidos ip
JOIN produto p ON ip.id_produto = p.idProduto;

-- 9. View para fornecedores com seus endereços (agora usando 'razaoSocial')
CREATE VIEW vw_fornecedores_endereco AS
SELECT f.razaoSocial, f.email, f.telefone, ef.rua, ef.numero, ef.bairro, ef.cidade, ef.uf, ef.cep
FROM fornecedor f
JOIN enderecoForne ef ON f.CNPJ = ef.fornecedor_cnpj;

-- 10. View para produtos de uma determinada categoria (ex: 'Moda')
CREATE VIEW vw_produtos_categoria_moda AS
SELECT p.nomeProduto, p.preco, p.marca, p.cor, p.tamanho
FROM produto p
JOIN categProduto cp ON p.id_categoria = cp.idCategoria
WHERE cp.nomeCateg = 'Moda';

-- 11. View para produtos com quantidade em estoque abaixo de um certo limite (ex: 50)
CREATE VIEW vw_produtos_estoque_baixo AS
SELECT p.nomeProduto, e.qtdDisponivel, e.localizacao
FROM produto p
JOIN estoque e ON p.idProduto = e.id_produto
WHERE e.qtdDisponivel < 50;

-- 12. View para clientes que fizeram pedidos em um determinado período (ex: último mês)
CREATE VIEW vw_clientes_ultimos_pedidos AS
SELECT DISTINCT c.nome AS NomeCliente, c.email AS EmailCliente
FROM clientes c
JOIN pedidos pe ON c.CPF = pe.clientes_cpf
WHERE pe.dataPedido >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

-- 13. View para funcionários admitidos após uma determinada data
CREATE VIEW vw_funcionarios_admitidos_2017 AS
SELECT nome AS NomeFuncionario, dataAdm
FROM funcionarios
WHERE dataAdm > '2017-01-01';

-- Consulta DQL 14: Clientes que nunca fizeram um pedido (usando SUBSELECT)
SELECT c.nome, c.email
FROM clientes c
WHERE c.CPF NOT IN (SELECT DISTINCT clientes_cpf FROM pedidos);

-- Consulta DQL 15: Funcionários sem dependentes
SELECT f.nome, f.CPF, f.email
FROM funcionarios f
LEFT JOIN dependentes d ON f.CPF = d.funcionario_cpf
WHERE d.CPF IS NULL;

-- Consulta DQL 16: Produtos com estoque baixo e seu fornecedor (JOIN)
SELECT p.nomeProduto, e.qtdDisponivel, f.razaoSocial AS NomeFornecedor
FROM produto p
JOIN estoque e ON p.idProduto = e.id_produto
JOIN fornecedor f ON p.id_fornecedor = f.CNPJ
WHERE e.qtdDisponivel < 30; -- Exemplo de limite

-- Consulta DQL 17: Vendas com forma de pagamento 'Cartão de Crédito' e o nome do cliente
SELECT v.idVendas, c.nome AS NomeCliente, v.dataVenda, v.valorTotal
FROM vendas v
JOIN clientes c ON v.clientes_cpf = c.CPF
JOIN formaPag fp ON v.idVendas = fp.id_vendas
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
WHERE cli.CPF = '999.999.999-99'; -- Exemplo: CPF do cliente

-- Consulta DQL 20: Quantidade de produtos por categoria
SELECT cp.nomeCateg, COUNT(p.idProduto) AS TotalProdutos
FROM categProduto cp
LEFT JOIN produto p ON cp.idCategoria = p.id_categoria
GROUP BY cp.nomeCateg
ORDER BY TotalProdutos DESC;