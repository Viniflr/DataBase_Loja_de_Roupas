USE lojaRoupas;

-- Function 1: Calcula a idade de um cliente a partir da data de nascimento
DELIMITER //
CREATE FUNCTION CalcularIdadeCliente(p_dataNasc DATE)
RETURNS INT READS SQL DATA
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, p_dataNasc, CURDATE());
END //
DELIMITER ;

-- Function 2: Obtém a quantidade total vendida de um produto específico (em todos os pedidos)
DELIMITER //
CREATE FUNCTION ObterQtdVendidaProduto(p_idProduto INT)
RETURNS INT READS SQL DATA
BEGIN
    DECLARE totalQtd INT;
    SELECT SUM(quantidade) INTO totalQtd
    FROM itemPedidos
    WHERE id_produto = p_idProduto;

    RETURN COALESCE(totalQtd, 0);
END //
DELIMITER ;

-- Function 3: Calcula o valor total de um pedido com base nos seus itens
DELIMITER //
CREATE FUNCTION CalcularValorTotalPedido(p_idPedido INT)
RETURNS DECIMAL(10,2) READS SQL DATA
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(quantidade * precoUnitario) INTO total
    FROM itemPedidos
    WHERE id_pedido = p_idPedido;

    RETURN COALESCE(total, 0.00);
END //
DELIMITER ;

-- Function 4: Verifica se um produto está com estoque abaixo de um limite
DELIMITER //
CREATE FUNCTION VerificarEstoqueBaixo(p_idProduto INT, p_limite INT)
RETURNS BOOLEAN READS SQL DATA
BEGIN
    DECLARE qtdAtual BIGINT;
    SELECT qtdDisponivel INTO qtdAtual
    FROM estoque
    WHERE id_produto = p_idProduto;

    IF qtdAtual IS NULL THEN
        RETURN FALSE; -- Produto não encontrado no estoque
    END IF;

    RETURN qtdAtual < p_limite;
END //
DELIMITER ;

-- Function 5: Formata um CPF, adicionando pontos e hífen (XXX.XXX.XXX-XX)
DELIMITER //
CREATE FUNCTION FormatarCPF(p_cpf VARCHAR(14))
RETURNS VARCHAR(14) DETERMINISTIC
BEGIN
    -- Remove caracteres não numéricos
    SET p_cpf = REGEXP_REPLACE(p_cpf, '[^0-9]', '');

    -- Verifica se o CPF tem 11 dígitos
    IF LENGTH(p_cpf) = 11 THEN
        RETURN CONCAT(SUBSTRING(p_cpf, 1, 3), '.',
                      SUBSTRING(p_cpf, 4, 3), '.',
                      SUBSTRING(p_cpf, 7, 3), '-',
                      SUBSTRING(p_cpf, 10, 2));
    ELSE
        RETURN p_cpf; -- Retorna o CPF original se não tiver 11 dígitos
    END IF;
END //
DELIMITER ;

-- Function 6: Calcula o valor do desconto em uma venda
DELIMITER //
CREATE FUNCTION CalcularDescontoVenda(p_valorTotal DECIMAL(10,2), p_percentualDesconto DECIMAL(5,2))
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    IF p_percentualDesconto IS NULL OR p_percentualDesconto <= 0 THEN
        RETURN 0.00;
    ELSE
        RETURN p_valorTotal * (p_percentualDesconto / 100);
    END IF;
END //
DELIMITER ;
