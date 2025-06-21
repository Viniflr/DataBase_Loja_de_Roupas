-- 1. Total de vendas por funcionário
SELECT f.nome, COUNT(v.idVendas) AS total_vendas, SUM(v.valorTotal) AS total_valor
FROM vendas v
JOIN funcionarios f ON v.funcionario_cpf = f.CPF
GROUP BY f.nome;

-- 2. Clientes que mais gastaram
SELECT c.nome, SUM(v.valorTotal) AS total_gasto
FROM clientes c
JOIN vendas v ON c.CPF = v.clientes_cpf
GROUP BY c.nome
ORDER BY total_gasto DESC;

-- 3. Produtos com estoque menor que 20
SELECT p.nomeProduto, e.qtdDisponivel
FROM produto p
JOIN estoque e ON p.idProduto = e.id_produto
WHERE e.qtdDisponivel < 20;

-- 4. Produtos mais vendidos (top 5)
SELECT p.nomeProduto, SUM(ip.quantidade) AS total_vendido
FROM itemPedidos ip
JOIN produto p ON ip.id_produto = p.idProduto
GROUP BY p.nomeProduto
ORDER BY total_vendido DESC
LIMIT 5;

-- 5. Clientes que fizeram mais de uma compra
SELECT c.nome, COUNT(v.idVendas) AS compras
FROM clientes c
JOIN vendas v ON c.CPF = v.clientes_cpf
GROUP BY c.nome
HAVING compras > 1;

-- 6. Departamentos com maior número de funcionários
SELECT d.nome, COUNT(f.CPF) AS total_funcionarios
FROM departamento d
JOIN funcionarios f ON d.idDepartamento = f.idDepartamento
GROUP BY d.nome;

-- 7. Produtos com avaliação acima de 4
SELECT p.nomeProduto, AVG(a.nota) AS media_nota
FROM avaliacoes a
JOIN produto p ON a.id_produto = p.idProduto
GROUP BY p.nomeProduto
HAVING media_nota > 4;

-- 8. Vendas com desconto maior que 10 reais
SELECT v.idVendas, c.nome, v.valorTotal, v.desconto
FROM vendas v
JOIN clientes c ON v.clientes_cpf = c.CPF
WHERE v.desconto > 10;

-- 9. Pedidos e os nomes dos produtos comprados
SELECT p.idPedidos, c.nome AS cliente, pr.nomeProduto, ip.quantidade
FROM pedidos p
JOIN clientes c ON p.clientes_cpf = c.CPF
JOIN itemPedidos ip ON p.idPedidos = ip.id_pedido
JOIN produto pr ON ip.id_produto = pr.idProduto;

-- 10. Lista de fornecedores e seus produtos
SELECT f.razaoSocial, p.nomeProduto, p.preco
FROM fornecedor f
JOIN produto p ON f.CNPJ = p.id_fornecedor
ORDER BY f.razaoSocial;

-- 11. Produtos sem avaliação
SELECT nomeProduto
FROM produto
WHERE idProduto NOT IN (
    SELECT DISTINCT id_produto FROM avaliacoes
);

-- 12. Funcionários com plano de saúde
SELECT f.nome, ps.nome AS plano
FROM funcionarios f
JOIN planoSaude ps ON f.CPF = ps.funcionario_cpf;

-- 13. Clientes que compraram produtos com desconto
SELECT DISTINCT c.nome
FROM clientes c
JOIN vendas v ON c.CPF = v.clientes_cpf
WHERE v.desconto > 0;

-- 14. Produtos em promoção atualmente
SELECT p.nomeProduto, pr.desconto
FROM promocoes pr
JOIN produto p ON pr.id_produto = p.idProduto
WHERE CURDATE() BETWEEN pr.data_inicio AND pr.data_fim;

-- 15. Última venda de cada cliente
SELECT c.nome, MAX(v.dataVenda) AS ultima_compra
FROM clientes c
JOIN vendas v ON c.CPF = v.clientes_cpf
GROUP BY c.nome;

-- 16. Produtos e categorias
SELECT p.nomeProduto, c.nomeCateg
FROM produto p
JOIN categProduto c ON p.id_categoria = c.idCategoria;

-- 17. Endereços de clientes e cidades
SELECT c.nome, e.cidade, e.rua, e.numero
FROM clientes c
JOIN enderecoCli e ON c.CPF = e.clientes_cpf;

-- 18. Funcionários e os cargos que já ocuparam
SELECT f.nome, cg.nome AS cargo, fc.data_inicio
FROM funcionario_cargo fc
JOIN funcionarios f ON fc.funcionario_cpf = f.CPF
JOIN cargo cg ON fc.cbo = cg.cbo;

-- 19. Produtos com histórico de alteração de preço
SELECT p.nomeProduto, h.preco_antigo, h.preco_novo, h.data_alteracao
FROM produto p
JOIN historico_preco h ON p.idProduto = h.id_produto;

-- 20. Clientes com mais de uma avaliação
SELECT c.nome, COUNT(*) AS total_avaliacoes
FROM clientes c
JOIN avaliacoes a ON c.CPF = a.clientes_cpf
GROUP BY c.nome
HAVING total_avaliacoes > 1;
