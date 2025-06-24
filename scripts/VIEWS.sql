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

-- 3. View para relatório de vendas com nome do cliente, funcionário e forma de pagamento
CREATE VIEW vw_vendas_clientes_funcionarios_formasPag AS 
SELECT v.idVendas, c.nome AS NomeCliente, f.nome AS NomeFuncionario, fp.tipo AS FormaPagamento, v.dataVenda, v.valorTotal
FROM vendas v
JOIN clientes c ON v.clientes_cpf = c.CPF
JOIN funcionarios f ON v.funcionario_cpf = f.CPF
JOIN formaPag fp ON v.id_formaPag = fp.idFormaPag 
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

-- 6. View para produtos mais vendidos
CREATE VIEW vw_produtos_mais_vendidos AS
SELECT p.nomeProduto, SUM(ip.quantidade) AS QuantidadeVendidaTotal
FROM produto p
JOIN itemPedidos ip ON p.idProduto = ip.id_produto
GROUP BY p.idProduto
ORDER BY QuantidadeVendidaTotal DESC;

-- 7. View para pedidos com informações do cliente
CREATE VIEW vw_pedidos_clientes AS
SELECT
    ped.idPedidos,
    cli.nome AS NomeCliente,
    ped.dataPedido,
    ped.statusPedido,
    ped.valorTotal
FROM pedidos ped
JOIN clientes cli ON ped.clientes_cpf = cli.CPF;

-- 8. View para itens de pedidos detalhados
CREATE VIEW vw_itens_pedido AS
SELECT
    ip.idItemPedidos,
    ip.id_pedido,
    p.nomeProduto,
    ip.quantidade,
    ip.precoUnitario,
    (ip.quantidade * ip.precoUnitario) AS SubtotalItem,
    ip.frete
FROM itemPedidos ip
JOIN produto p ON ip.id_produto = p.idProduto;

-- 9. View para fornecedores com seus endereços
CREATE VIEW vw_fornecedores_endereco AS
SELECT f.razaoSocial AS NomeFornecedor, f.email, ef.rua, ef.numero, ef.bairro, ef.cidade, ef.uf, ef.cep
FROM fornecedor f
JOIN enderecoForne ef ON f.CNPJ = ef.fornecedor_cnpj;

-- 10. View para produtos da categoria 'Moda'
CREATE VIEW vw_produtos_categoria_moda AS
SELECT p.nomeProduto, p.marca, p.preco, cp.nomeCateg
FROM produto p
JOIN categProduto cp ON p.id_categoria = cp.idCategoria
WHERE cp.nomeCateg = 'Roupas Femininas' OR cp.nomeCateg = 'Roupas Masculinas'; 

-- 11. View para produtos com estoque baixo (exemplo: abaixo de 30 unidades)
CREATE VIEW vw_produtos_estoque_baixo AS
SELECT p.nomeProduto, e.qtdDisponivel, e.localizacao
FROM produto p
JOIN estoque e ON p.idProduto = e.id_produto
WHERE e.qtdDisponivel < 30;

-- 12. View para clientes e seus últimos pedidos
CREATE VIEW vw_clientes_ultimos_pedidos AS
SELECT
    c.nome AS NomeCliente,
    c.email,
    MAX(p.dataPedido) AS UltimoPedidoData,
    MAX(p.valorTotal) AS UltimoPedidoValor
FROM clientes c
LEFT JOIN pedidos p ON c.CPF = p.clientes_cpf
GROUP BY c.CPF, c.nome, c.email;

-- 13. View para funcionários admitidos em 2017 (exemplo)
CREATE VIEW vw_funcionarios_admitidos_2017 AS
SELECT
    f.nome AS NomeFuncionario, 
    f.dataAdm,      
    d.nome AS NomeDepartamento
FROM funcionarios AS f      
JOIN Departamento AS d ON f.idDepartamento = d.idDepartamento 
WHERE YEAR(f.dataAdm) = 2017; 
