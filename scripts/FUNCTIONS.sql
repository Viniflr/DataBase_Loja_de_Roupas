USE lojaRoupas;

-- Function 1: CalcularIdadeCliente
DELIMITER //
CREATE FUNCTION CalcularIdadeCliente(p_dataNasc DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    IF p_dataNasc IS NULL THEN
        RETURN NULL;
    ELSEIF p_dataNasc > CURDATE() THEN
        RETURN 0; 
    END IF;
    
    RETURN TIMESTAMPDIFF(YEAR, p_dataNasc, CURDATE());
END //
DELIMITER ;

-- Function 2: ObterQtdVendidaProduto
DELIMITER //
CREATE FUNCTION ObterQtdVendidaProduto(p_idProduto INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE totalQtd INT DEFAULT 0;
    
    IF p_idProduto IS NULL THEN
        RETURN NULL;
    END IF;
    
    SELECT COALESCE(SUM(quantidade), 0) INTO totalQtd
    FROM itemPedidos
    WHERE id_produto = p_idProduto;
    
    RETURN totalQtd;
END //
DELIMITER ;

-- Function 3: CalcularValorTotalPedido
DELIMITER //
CREATE FUNCTION CalcularValorTotalPedido(p_idPedido INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE total DECIMAL(10,2) DEFAULT 0.00;
    
    IF p_idPedido IS NULL THEN
        RETURN NULL;
    END IF;
    
    SELECT COALESCE(SUM(quantidade * precoUnitario), 0.00) INTO total
    FROM itemPedidos
    WHERE id_pedido = p_idPedido;
    
    RETURN total;
END //
DELIMITER ;

-- Function 4: VerificarEstoqueBaixo
DELIMITER //
CREATE FUNCTION VerificarEstoqueBaixo(p_idProduto INT, p_limite INT)
RETURNS VARCHAR(50)
READS SQL DATA
BEGIN
    DECLARE v_qtdAtual INT;

    IF p_idProduto IS NULL OR p_limite IS NULL THEN
        RETURN 'Parâmetros inválidos';
    END IF;

    SELECT qtdDisponivel INTO v_qtdAtual
    FROM estoque
    WHERE id_produto = p_idProduto;

    IF v_qtdAtual IS NULL THEN
        RETURN 'Produto não encontrado no estoque';
    END IF;

    IF v_qtdAtual < p_limite THEN
        RETURN 'Baixo!';
    ELSE
        RETURN 'Suficiente!';
    END IF;
END //
DELIMITER ;

-- Function 5: FormatarCPF
DELIMITER //
CREATE FUNCTION FormatarCPF(p_cpf VARCHAR(14))
RETURNS VARCHAR(14)
DETERMINISTIC
BEGIN
    DECLARE resultado VARCHAR(14);
    
    IF p_cpf IS NULL THEN
        RETURN NULL;
    END IF;
    
    SET p_cpf = REGEXP_REPLACE(p_cpf, '[^0-9]', '');
    
    IF LENGTH(p_cpf) = 11 THEN
        SET resultado = CONCAT(
            SUBSTRING(p_cpf, 1, 3), '.',
            SUBSTRING(p_cpf, 4, 3), '.',
            SUBSTRING(p_cpf, 7, 3), '-',
            SUBSTRING(p_cpf, 10, 2)
        );
        RETURN resultado;
    ELSE
        RETURN p_cpf; 
    END IF;
END //
DELIMITER ;

-- Function 6: CalcularDescontoVenda
DELIMITER //
CREATE FUNCTION CalcularDescontoVenda(p_valorTotal DECIMAL(10,2), p_percentualDesconto DECIMAL(5,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    IF p_valorTotal IS NULL OR p_percentualDesconto IS NULL THEN
        RETURN NULL;
    ELSEIF p_percentualDesconto <= 0 THEN
        RETURN 0.00;
    ELSEIF p_percentualDesconto > 100 THEN
        RETURN p_valorTotal; 
    END IF;
    
    RETURN ROUND(p_valorTotal * (p_percentualDesconto / 100), 2);
END //
DELIMITER ;
