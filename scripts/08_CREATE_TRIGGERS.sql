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

-- Trigger 1: AFTER INSERT ON itemPedidos
-- Atualiza o valor total do pedido e diminui a quantidade no estoque.
-- Adiciona um ALTER TABLE para adicionar valorTotal na tabela de pedidos
ALTER TABLE pedidos ADD COLUMN valorTotal DECIMAL(10,2);

DELIMITER //
CREATE TRIGGER tr_after_insert_itemPedidos
AFTER INSERT ON itemPedidos
FOR EACH ROW
BEGIN
    DECLARE v_precoUnitario DECIMAL(10,2);
    -- Atualiza o valor total na tabela 'pedidos'
    UPDATE pedidos
    SET valorTotal = COALESCE(valorTotal, 0) + (NEW.quantidade * NEW.precoUnitario)
    WHERE idPedidos = NEW.id_pedido;

    -- Diminui a quantidade disponível no estoque
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
    DECLARE v_diferencaQtd INT;
    DECLARE v_diferencaValor DECIMAL(10,2);

    SET v_diferencaQtd = NEW.quantidade - OLD.quantidade;
    SET v_diferencaValor = (NEW.quantidade * NEW.precoUnitario) - (OLD.quantidade * OLD.precoUnitario);

    -- Atualiza o valor total na tabela 'pedidos'
    UPDATE pedidos
    SET valorTotal = COALESCE(valorTotal, 0) + v_diferencaValor
    WHERE idPedidos = NEW.id_pedido;

    -- Ajusta a quantidade disponível no estoque
    UPDATE estoque
    SET qtdDisponivel = qtdDisponivel - v_diferencaQtd
    WHERE id_produto = NEW.id_produto;
END //
DELIMITER ;

-- Trigger 3: AFTER DELETE ON itemPedidos
-- Ajusta o valor total do pedido e devolve a quantidade para o estoque quando um item de pedido é deletado.
DELIMITER //
CREATE TRIGGER tr_after_delete_itemPedidos
AFTER DELETE ON itemPedidos
FOR EACH ROW
BEGIN
    -- Atualiza o valor total na tabela 'pedidos'
    UPDATE pedidos
    SET valorTotal = COALESCE(valorTotal, 0) - (OLD.quantidade * OLD.precoUnitario)
    WHERE idPedidos = OLD.id_pedido;

    -- Devolve a quantidade para o estoque
    UPDATE estoque
    SET qtdDisponivel = qtdDisponivel + OLD.quantidade
    WHERE id_produto = OLD.id_produto;
END //
DELIMITER ;

-- Trigger 4: BEFORE INSERT ON funcionarios
-- Define a data de admissão como a data e hora atual se não for fornecida.
DELIMITER //
CREATE TRIGGER tr_before_insert_funcionarios
BEFORE INSERT ON funcionarios
FOR EACH ROW
BEGIN
    IF NEW.dataAdm IS NULL THEN
        SET NEW.dataAdm = NOW();
    END IF;
END //
DELIMITER ;

-- Trigger 5: BEFORE INSERT ON clientes
-- Garante que o CPF esteja formatado antes da inserção.
-- Requer a função FormatarCPF, que deve ser criada antes deste trigger.
DELIMITER //
CREATE TRIGGER tr_before_insert_clientes
BEFORE INSERT ON clientes
FOR EACH ROW
BEGIN
    SET NEW.CPF = FormatarCPF(NEW.CPF);
END //
DELIMITER ;

-- Trigger 6: AFTER UPDATE ON estoque
-- Registra um log quando a quantidade de um produto em estoque cai abaixo de um limite (ex: 20 unidades).
DELIMITER //
CREATE TRIGGER tr_after_update_estoque_log
AFTER UPDATE ON estoque
FOR EACH ROW
BEGIN
    DECLARE v_nomeProduto VARCHAR(60);
    DECLARE v_limite INT DEFAULT 20; -- Define o limite para estoque baixo

    IF NEW.qtdDisponivel < v_limite AND NEW.qtdDisponivel != OLD.qtdDisponivel THEN
        SELECT nomeProduto INTO v_nomeProduto
        FROM produto
        WHERE idProduto = NEW.id_produto;

        INSERT INTO logEstoqueBaixo (id_produto, nomeProduto, qtdAtual, limiteEstoque, mensagem)
        VALUES (NEW.id_produto, v_nomeProduto, NEW.qtdDisponivel, v_limite,
                CONCAT('Produto ', v_nomeProduto, ' atingiu estoque baixo: ', NEW.qtdDisponivel, ' unidades.'));
    END IF;
END //
DELIMITER ;
