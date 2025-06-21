-- Procedure para atualizar estoque após venda
DELIMITER //
CREATE PROCEDURE sp_atualiza_estoque_venda(IN p_id_produto INT, IN p_quantidade INT)
BEGIN
    DECLARE v_estoque_atual INT;
    
    SELECT qtdDisponivel INTO v_estoque_atual FROM estoque WHERE id_produto = p_id_produto;
    
    IF v_estoque_atual >= p_quantidade THEN
        UPDATE estoque SET qtdDisponivel = qtdDisponivel - p_quantidade 
        WHERE id_produto = p_id_produto;
    ELSE
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Quantidade em estoque insuficiente';
    END IF;
END//
DELIMITER ;

-- Procedure para calcular comissão de funcionários
DELIMITER //
CREATE PROCEDURE sp_calcular_comissao(IN p_cpf_funcionario VARCHAR(14), IN p_data_inicio DATE, IN p_data_fim DATE)
BEGIN
    SELECT 
        f.nome,
        SUM(v.valorTotal) AS total_vendas,
        SUM(v.valorTotal) * (f.comissao/100) AS comissao_calculada
    FROM 
        vendas v
        JOIN funcionarios f ON v.funcionario_cpf = f.CPF
    WHERE 
        f.CPF = p_cpf_funcionario
        AND v.dataVenda BETWEEN p_data_inicio AND p_data_fim
    GROUP BY 
        f.nome;
END//
DELIMITER ;

-- Cadastra um cliente e seu endereço em uma única chamada.
DELIMITER //
CREATE PROCEDURE sp_cadastrar_cliente_com_endereco(
    IN p_cpf VARCHAR(14),
    IN p_nome VARCHAR(60),
    IN p_dataNasc DATE,
    IN p_sexo CHAR(1),
    IN p_email VARCHAR(60),
    IN p_telefone VARCHAR(15),
    IN p_uf CHAR(2),
    IN p_cidade VARCHAR(60),
    IN p_bairro VARCHAR(60),
    IN p_rua VARCHAR(80),
    IN p_numero INT,
    IN p_complemento VARCHAR(45),
    IN p_cep VARCHAR(9)
)
BEGIN
    INSERT INTO clientes (CPF, nome, dataNasc, sexo, email, telefone)
    VALUES (p_cpf, p_nome, p_dataNasc, p_sexo, p_email, p_telefone);

    INSERT INTO enderecoCli (clientes_cpf, uf, cidade, bairro, rua, numero, complemento, cep)
    VALUES (p_cpf, p_uf, p_cidade, p_bairro, p_rua, p_numero, p_complemento, p_cep);

    SELECT 'Cliente cadastrado com sucesso' AS mensagem;
END//
DELIMITER ;

-- Retorna os detalhes completos de uma venda específica.
DELIMITER //
CREATE PROCEDURE sp_detalhes_venda(IN p_idVenda INT)
BEGIN
    SELECT 
        v.idVendas,
        c.nome AS cliente,
        f.nome AS funcionario,
        v.valorTotal,
        v.desconto,
        v.dataVenda
    FROM vendas v
    JOIN clientes c ON v.clientes_cpf = c.CPF
    JOIN funcionarios f ON v.funcionario_cpf = f.CPF
    WHERE v.idVendas = p_idVenda;

    SELECT 
        p.nomeProduto,
        ip.quantidade,
        ip.precoUnitario
    FROM itemPedidos ip
    JOIN produto p ON ip.id_produto = p.idProduto
    WHERE ip.id_pedido = (
        SELECT idPedidos FROM pedidos 
        WHERE clientes_cpf = (SELECT clientes_cpf FROM vendas WHERE idVendas = p_idVenda)
        LIMIT 1
    );
END//
DELIMITER ;

-- Traz estatísticas de uma categoria de produtos.
DELIMITER //
CREATE PROCEDURE sp_resumo_categoria(IN p_idCategoria INT)
BEGIN
    SELECT COUNT(*) AS total_produtos, AVG(preco) AS preco_medio
    FROM produto
    WHERE id_categoria = p_idCategoria;

    SELECT nomeProduto, preco
    FROM produto
    WHERE id_categoria = p_idCategoria
    ORDER BY preco DESC
    LIMIT 3;
END//
DELIMITER ;

-- Mostra média, total e comentários das avaliações de um produto.
DELIMITER //
CREATE PROCEDURE sp_avaliacoes_por_produto(IN p_idProduto INT)
BEGIN
    SELECT 
        AVG(nota) AS media,
        COUNT(*) AS total_avaliacoes
    FROM avaliacoes
    WHERE id_produto = p_idProduto;

    SELECT 
        c.nome, a.nota, a.comentario, a.data_avaliacao
    FROM avaliacoes a
    JOIN clientes c ON a.clientes_cpf = c.CPF
    WHERE a.id_produto = p_idProduto
    ORDER BY a.data_avaliacao DESC;
END//
DELIMITER ;
