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
           p.nomeProduto, p.preco, e.qtdDisponivel, e.localizacao
    FROM produto p
    JOIN estoque e ON p.idProduto = e.id_produto
    WHERE p.idProduto = v_idProduto;
END //
DELIMITER ;

-- Procedure 2: Atualiza a quantidade de um produto no estoque
DELIMITER //
CREATE PROCEDURE AtualizarEstoque(
    IN p_idProduto INT,
    IN p_novaQtd BIGINT
)
BEGIN
    DECLARE v_qtdAtual BIGINT;

    -- Comando 1: Obter a quantidade atual em estoque
    SELECT qtdDisponivel INTO v_qtdAtual
    FROM estoque
    WHERE id_produto = p_idProduto;

    IF v_qtdAtual IS NOT NULL THEN
        -- Comando 2: Atualizar a quantidade disponível
        UPDATE estoque
        SET qtdDisponivel = p_novaQtd
        WHERE id_produto = p_idProduto;

        -- Comando 3: Selecionar o status atualizado do estoque
        SELECT 'Estoque atualizado com sucesso.' AS Mensagem,
               p.nomeProduto, e.qtdDisponivel AS NovaQuantidade, v_qtdAtual AS QuantidadeAntiga
        FROM produto p
        JOIN estoque e ON p.idProduto = e.id_produto
        WHERE p.idProduto = p_idProduto;
    ELSE
        -- Comando 4: Mensagem de erro se o produto não for encontrado no estoque
        SELECT 'Erro: Produto não encontrado no estoque.' AS Mensagem;
    END IF;
END //
DELIMITER ;

-- Procedure 3: Registra um novo pagamento para uma venda existente
DELIMITER //
CREATE PROCEDURE RegistrarPagamentoVenda(
    IN p_idVendas INT,
    IN p_valorPago DECIMAL(10,2),
    IN p_tipoPag VARCHAR(45),
    IN p_parcela INT
)
BEGIN
    DECLARE v_totalVenda DECIMAL(10,2);
    DECLARE v_valorAtualPago DECIMAL(10,2);

    -- Comando 1: Obter o valor total da venda
    SELECT valorTotal INTO v_totalVenda
    FROM vendas
    WHERE idVendas = p_idVendas;

    IF v_totalVenda IS NOT NULL THEN
        -- Comando 2: Inserir o registro na tabela formaPag
        INSERT INTO formaPag (id_vendas, valorPago, tipo, parcela)
        VALUES (p_idVendas, p_valorPago, p_tipoPag, p_parcela);

        -- Comando 3: Calcular o total já pago para esta venda
        SELECT SUM(valorPago) INTO v_valorAtualPago
        FROM formaPag
        WHERE id_vendas = p_idVendas;

        -- Comando 4: Retornar o status da venda e pagamento
        SELECT CONCAT('Pagamento registrado para Venda ', p_idVendas, '. Valor total da venda: ', v_totalVenda, '. Valor já pago: ', v_valorAtualPago, '.') AS Mensagem;
    ELSE
        -- Comando 5: Mensagem de erro se a venda não for encontrada
        SELECT 'Erro: Venda não encontrada.' AS Mensagem;
    END IF;
END //
DELIMITER ;

-- Procedure 4: Obtém o histórico de compras de um cliente
DELIMITER //
CREATE PROCEDURE ObterHistoricoComprasCliente(
    IN p_cpfCliente VARCHAR(14)
)
BEGIN
    -- Comando 1: Selecionar as vendas do cliente
    SELECT v.idVendas, v.dataVenda, v.valorTotal, v.desconto, fp.tipo AS FormaPagamento
    FROM vendas v
    LEFT JOIN formaPag fp ON v.idVendas = fp.id_vendas
    WHERE v.clientes_cpf = p_cpfCliente
    ORDER BY v.dataVenda DESC;

    -- Comando 2: Selecionar os pedidos do cliente
    SELECT p.idPedidos, p.dataPedido, p.statusPedido, COALESCE(p.valorTotal, 0) AS ValorTotalPedido
    FROM pedidos p
    WHERE p.clientes_cpf = p_cpfCliente
    ORDER BY p.dataPedido DESC;

    -- Comando 3: Mensagem de conclusão (opcional, para ter 4 comandos)
    SELECT 'Histórico de compras e pedidos do cliente consultado.' AS Mensagem;
END //
DELIMITER ;

-- Procedure 5: Atualiza o salário e a comissão de um funcionário
DELIMITER //
CREATE PROCEDURE AtualizarSalarioComissao(
    IN p_cpfFuncionario VARCHAR(14),
    IN p_novoSalario DECIMAL(10,2),
    IN p_novaComissao DECIMAL(6,2)
)
BEGIN
    DECLARE v_salarioAtual DECIMAL(10,2);
    DECLARE v_comissaoAtual DECIMAL(6,2);

    -- Comando 1: Obter salário e comissão atuais
    SELECT salario, comissao INTO v_salarioAtual, v_comissaoAtual
    FROM funcionarios
    WHERE CPF = p_cpfFuncionario;

    IF v_salarioAtual IS NOT NULL THEN
        -- Comando 2: Atualizar o salário e comissão
        UPDATE funcionarios
        SET salario = p_novoSalario,
            comissao = p_novaComissao
        WHERE CPF = p_cpfFuncionario;

        -- Comando 3: Selecionar os dados atualizados
        SELECT 'Salário e comissão atualizados com sucesso.' AS Mensagem,
               nome, salario AS NovoSalario, comissao AS NovaComissao,
               v_salarioAtual AS SalarioAntigo, v_comissaoAtual AS ComissaoAntiga
        FROM funcionarios
        WHERE CPF = p_cpfFuncionario;
    ELSE
        -- Comando 4: Mensagem de erro se o funcionário não for encontrado
        SELECT 'Erro: Funcionário não encontrado.' AS Mensagem;
    END IF;
END //
DELIMITER ;

-- Procedure 6: Gera um relatório de vendas por período
DELIMITER //
CREATE PROCEDURE GerarRelatorioVendasPeriodo(
    IN p_dataInicio DATE,
    IN p_dataFim DATE
)
BEGIN
    -- Comando 1: Sumário de vendas por dia
    SELECT DATE(dataVenda) AS Data,
           SUM(valorTotal) AS TotalVendasDia,
           COUNT(idVendas) AS NumeroVendas
    FROM vendas
    WHERE dataVenda BETWEEN p_dataInicio AND p_dataFim
    GROUP BY DATE(dataVenda)
    ORDER BY Data;

    -- Comando 2: Total geral de vendas no período
    SELECT SUM(valorTotal) AS TotalGeralVendas,
           AVG(valorTotal) AS MediaPorVenda,
           COUNT(idVendas) AS TotalTransacoes
    FROM vendas
    WHERE dataVenda BETWEEN p_dataInicio AND p_dataFim;

    -- Comando 3: Produtos mais vendidos no período (baseado em itemPedidos, que agora terá valorTotal)
    SELECT p.nomeProduto,
           SUM(ip.quantidade) AS QuantidadeVendida,
           SUM(ip.quantidade * ip.precoUnitario) AS ReceitaProduto
    FROM itemPedidos ip
    JOIN produto p ON ip.id_produto = p.idProduto
    JOIN pedidos ped ON ip.id_pedido = ped.idPedidos
    WHERE ped.dataPedido BETWEEN p_dataInicio AND p_dataFim
    GROUP BY p.nomeProduto
    ORDER BY QuantidadeVendida DESC
    LIMIT 5;

    -- Comando 4: Top 3 clientes no período
    SELECT c.nome AS NomeCliente,
           SUM(v.valorTotal) AS TotalGasto
    FROM vendas v
    JOIN clientes c ON v.clientes_cpf = c.CPF
    WHERE v.dataVenda BETWEEN p_dataInicio AND p_dataFim
    GROUP BY c.nome
    ORDER BY TotalGasto DESC
    LIMIT 3;
END //
DELIMITER ;