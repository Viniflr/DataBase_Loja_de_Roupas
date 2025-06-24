USE lojaRoupas;

-- Procedure 1: Adiciona um novo produto e o coloca no estoque
DELIMITER //
CREATE PROCEDURE AdicionarProduto(
    IN p_id_fornecedor VARCHAR(18),
    IN p_id_categoria INT,
    IN p_preco DECIMAL(10,2),
    IN p_marca VARCHAR(45),
    IN p_descricao VARCHAR(255),
    IN p_cor VARCHAR(45),
    IN p_nomeProduto VARCHAR(60),
    IN p_tamanho VARCHAR(5),
    IN p_qtdInicial BIGINT,
    IN p_localizacaoEstoque VARCHAR(60)
)
BEGIN
    DECLARE v_idProduto INT;

    -- Comando 1: Inserir o novo produto
    INSERT INTO produto (id_fornecedor, id_categoria, preco, marca, descricao, cor, nomeProduto, tamanho)
    VALUES (p_id_fornecedor, p_id_categoria, p_preco, p_marca, p_descricao, p_cor, p_nomeProduto, p_tamanho);

    -- Comando 2: Obter o ID do produto recém-inserido
    SET v_idProduto = LAST_INSERT_ID();

    -- Comando 3: Inserir o produto no estoque
    INSERT INTO estoque (id_produto, qtdDisponivel, localizacao)
    VALUES (v_idProduto, p_qtdInicial, p_localizacaoEstoque);

    -- Comando 4: Selecionar o produto adicionado para confirmação
    SELECT 'Produto adicionado com sucesso e estoque inicial registrado.' AS Mensagem,
           p.nomeProduto, p.marca, p.preco, e.qtdDisponivel, e.localizacao
    FROM produto p
    JOIN estoque e ON p.idProduto = e.id_produto
    WHERE p.idProduto = v_idProduto;
END //
DELIMITER ;

-- Procedure 2: Atualiza a quantidade disponível de um produto no estoque
DELIMITER //
CREATE PROCEDURE AtualizarEstoque(
    IN p_idProduto INT,
    IN p_novaQtd BIGINT
)
BEGIN
    UPDATE estoque
    SET qtdDisponivel = p_novaQtd
    WHERE id_produto = p_idProduto;

    SELECT 'Estoque atualizado com sucesso.' AS Mensagem,
           p.nomeProduto, e.qtdDisponivel
    FROM produto p
    JOIN estoque e ON p.idProduto = e.id_produto
    WHERE p.idProduto = p_idProduto;
END //
DELIMITER ;

-- Procedure 3: Registrar Pagamento de Venda
DELIMITER //
CREATE PROCEDURE RegistrarPagamentoVenda(
    IN p_idVendas INT,
    IN p_valorRecebido DECIMAL(10,2),
    IN p_tipoPagamento VARCHAR(45),
    IN p_observacoes TEXT
)
BEGIN
    DECLARE v_idFormaPag INT;

    SELECT idFormaPag INTO v_idFormaPag FROM formaPag WHERE tipo = p_tipoPagamento;

    IF v_idFormaPag IS NULL THEN
        INSERT INTO formaPag (tipo) VALUES (p_tipoPagamento);
        SET v_idFormaPag = LAST_INSERT_ID();
    END IF;

    UPDATE vendas
    SET id_formaPag = v_idFormaPag 
    WHERE idVendas = p_idVendas;

    SELECT 'Pagamento registrado e forma de pagamento atualizada para a venda.' AS Mensagem,
           v.idVendas, fp.tipo AS FormaPagamento, v.valorTotal
    FROM vendas v
    JOIN formaPag fp ON v.id_formaPag = fp.idFormaPag
    WHERE v.idVendas = p_idVendas;
END //
DELIMITER ;

-- Procedure 4: Obter Histórico de Compras de um Cliente
DELIMITER //
CREATE PROCEDURE ObterHistoricoComprasCliente(
    IN p_cpfCliente VARCHAR(14)
)
BEGIN
    SELECT
        p.idPedidos AS NumeroPedido,
        p.dataPedido AS DataPedido,
        p.statusPedido AS StatusPedido,
        p.valorTotal AS ValorTotalPedido,
        GROUP_CONCAT(CONCAT(prod.nomeProduto, ' (Qtd: ', ip.quantidade, ', Preço Unit.: ', ip.precoUnitario, ')') SEPARATOR '; ') AS Itens
    FROM pedidos p
    JOIN itemPedidos ip ON p.idPedidos = ip.id_pedido
    JOIN produto prod ON ip.id_produto = prod.idProduto
    WHERE p.clientes_cpf = p_cpfCliente
    GROUP BY p.idPedidos, p.dataPedido, p.statusPedido, p.valorTotal
    ORDER BY p.dataPedido DESC;
END //
DELIMITER ;

-- Procedure 5: Atualizar Salário e Comissão de um Funcionário
DELIMITER //
CREATE PROCEDURE AtualizarSalarioComissao(
    IN p_cpfFuncionario VARCHAR(14),
    IN p_novoSalario DECIMAL(10,2),
    IN p_novaComissao DECIMAL(6,2)
)
BEGIN
    UPDATE funcionarios
    SET
        salario = p_novoSalario,
        comissao = p_novaComissao
    WHERE CPF = p_cpfFuncionario;

    SELECT 'Salário e comissão atualizados com sucesso.' AS Mensagem,
           nome, salario, comissao
    FROM funcionarios
    WHERE CPF = p_cpfFuncionario;
END //
DELIMITER ;

-- Procedure 6: Gerar Relatório de Vendas por Período
DELIMITER //
CREATE PROCEDURE GerarRelatorioVendasPeriodo(
    IN p_dataInicio DATE,
    IN p_dataFim DATE
)
BEGIN
    SELECT
        v.idVendas,
        c.nome AS NomeCliente,
        f.nome AS NomeFuncionario,
        fp.tipo AS FormaPagamento, 
        v.dataVenda,
        v.valorTotal
    FROM vendas v
    JOIN clientes c ON v.clientes_cpf = c.CPF
    JOIN funcionarios f ON v.funcionario_cpf = f.CPF
    JOIN formaPag fp ON v.id_formaPag = fp.idFormaPag 
    WHERE v.dataVenda BETWEEN p_dataInicio AND p_dataFim
    ORDER BY v.dataVenda ASC;
END //
DELIMITER ;

-- Delimitador resetado
DELIMITER ;