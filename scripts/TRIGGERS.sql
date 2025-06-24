USE lojaRoupas;

-- Tabela para Log de Estoque Baixo (Criada para a trigger)
CREATE TABLE IF NOT EXISTS logEstoqueBaixo (
    idLog INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT NOT NULL,
    nomeProduto VARCHAR(60) NOT NULL,
    qtdAtual BIGINT NOT NULL,
    limiteEstoque INT NOT NULL,
    dataHoraLog DATETIME DEFAULT CURRENT_TIMESTAMP,
    mensagem TEXT
);

DELIMITER //
CREATE TRIGGER tr_after_insert_itemPedidos
AFTER INSERT ON itemPedidos
FOR EACH ROW
BEGIN
    UPDATE pedidos
    SET valorTotal = COALESCE(valorTotal, 0) + (NEW.quantidade * NEW.precoUnitario)
    WHERE idPedidos = NEW.id_pedido;

    UPDATE estoque
    SET qtdDisponivel = qtdDisponivel - NEW.quantidade
    WHERE id_produto = NEW.id_produto;
END //
DELIMITER ;

-- Trigger 2: AFTER UPDATE ON itemPedidos
-- Ajusta o valor total do pedido e a quantidade no estoque quando um item de pedido é atualizado.
DELIMITER //
CREATE TRIGGER tr_after_update_itemPedidos
AFTER UPDATE ON itemPedidos
FOR EACH ROW
BEGIN
    UPDATE pedidos
    SET valorTotal = COALESCE(valorTotal, 0) - (OLD.quantidade * OLD.precoUnitario) + (NEW.quantidade * NEW.precoUnitario)
    WHERE idPedidos = NEW.id_pedido;
    
    UPDATE estoque
    SET qtdDisponivel = qtdDisponivel + OLD.quantidade - NEW.quantidade
    WHERE id_produto = NEW.id_produto;
END //
DELIMITER ;

-- Trigger 3: AFTER DELETE ON itemPedidos
-- Ajusta o valor total do pedido e retorna a quantidade ao estoque quando um item de pedido é deletado.
DELIMITER //
CREATE TRIGGER tr_after_delete_itemPedidos
AFTER DELETE ON itemPedidos
FOR EACH ROW
BEGIN
    UPDATE pedidos
    SET valorTotal = COALESCE(valorTotal, 0) - (OLD.quantidade * OLD.precoUnitario)
    WHERE idPedidos = OLD.id_pedido;

    UPDATE estoque
    SET qtdDisponivel = qtdDisponivel + OLD.quantidade
    WHERE id_produto = OLD.id_produto;
END //
DELIMITER ;

-- Trigger 4: BEFORE INSERT ON funcionarios
-- Garante que a data de admissão seja preenchida se for NULL
DELIMITER //
CREATE TRIGGER tr_before_insert_funcionarios
BEFORE INSERT ON funcionarios
FOR EACH ROW
BEGIN
    IF NEW.dataAdm IS NULL THEN
        SET NEW.dataAdm = CURRENT_TIMESTAMP;
    END IF;
END //
DELIMITER ;

-- Trigger 5: BEFORE INSERT ON clientes
-- Formata o CPF do cliente antes de inserir
DELIMITER //
CREATE TRIGGER tr_before_insert_clientes
BEFORE INSERT ON clientes
FOR EACH ROW
BEGIN
    IF NEW.CPF IS NOT NULL AND NEW.CPF REGEXP '^[0-9]{11}$' THEN
        SET NEW.CPF = CONCAT(SUBSTRING(NEW.CPF, 1, 3), '.',
                             SUBSTRING(NEW.CPF, 4, 3), '.',
                             SUBSTRING(NEW.CPF, 7, 3), '-',
                             SUBSTRING(NEW.CPF, 10, 2));
    END IF;
END //
DELIMITER ;

-- Trigger 6: AFTER UPDATE ON estoque (para log de estoque baixo)
-- Registra um log quando a quantidade disponível de um produto cai abaixo de um limite
DELIMITER //
CREATE TRIGGER tr_after_update_estoque_log
AFTER UPDATE ON estoque
FOR EACH ROW
BEGIN
    DECLARE limite INT DEFAULT 20;
    DECLARE prod_nome VARCHAR(60);

    IF NEW.qtdDisponivel < limite AND OLD.qtdDisponivel >= limite THEN
        SELECT nomeProduto INTO prod_nome FROM produto WHERE idProduto = NEW.id_produto;
        INSERT INTO logEstoqueBaixo (id_produto, nomeProduto, qtdAtual, limiteEstoque, mensagem)
        VALUES (NEW.id_produto, prod_nome, NEW.qtdDisponivel, limite, CONCAT('O produto ', prod_nome, ' atingiu nível de estoque baixo.'));
    END IF;
END //
DELIMITER ;

DELIMITER ; 