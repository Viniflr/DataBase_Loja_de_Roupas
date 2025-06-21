-- View para relatório de vendas por funcionário
CREATE VIEW vw_vendas_por_funcionario AS
SELECT 
    f.nome AS funcionario,
    d.nome AS departamento,
    COUNT(v.idVendas) AS total_vendas,
    SUM(v.valorTotal) AS valor_total,
    AVG(v.valorTotal) AS media_por_venda
FROM 
    vendas v
    JOIN funcionarios f ON v.funcionario_cpf = f.CPF
    JOIN departamento d ON f.idDepartamento = d.idDepartamento
GROUP BY 
    f.nome, d.nome
ORDER BY 
    valor_total DESC;

-- View para estoque crítico
CREATE VIEW vw_estoque_critico AS
SELECT 
    p.nomeProduto,
    p.marca,
    e.qtdDisponivel,
    c.nomeCateg AS categoria
FROM 
    estoque e
    JOIN produto p ON e.id_produto = p.idProduto
    JOIN categProduto c ON p.id_categoria = c.idCategoria
WHERE 
    e.qtdDisponivel < 10
ORDER BY 
    e.qtdDisponivel ASC;

-- View para clientes mais ativos
CREATE VIEW vw_clientes_ativos AS
SELECT 
    c.nome,
    c.email,
    COUNT(v.idVendas) AS total_compras,
    SUM(v.valorTotal) AS valor_total_gasto,
    MAX(v.dataVenda) AS ultima_compra
FROM 
    clientes c
    JOIN vendas v ON c.CPF = v.clientes_cpf
GROUP BY 
    c.nome, c.email
ORDER BY 
    valor_total_gasto DESC;