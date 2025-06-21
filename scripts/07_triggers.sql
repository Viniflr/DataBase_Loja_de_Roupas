-- Trigger para auditoria de produtos
DELIMITER //
CREATE TRIGGER after_produto_update
AFTER UPDATE ON produto
FOR EACH ROW
BEGIN
    INSERT INTO auditoria (tabela_afetada, operacao, id_registro, usuario, data_hora, dados_antigos, dados_novos)
    VALUES ('produto', 'UPDATE', OLD.idProduto, CURRENT_USER(), NOW(), 
           CONCAT('Preço:', OLD.preco, '|Descrição:', OLD.descricao), 
           CONCAT('Preço:', NEW.preco, '|Descrição:', NEW.descricao));
END//
DELIMITER ;

-- Trigger para auditoria de preços
DELIMITER //
CREATE TRIGGER after_preco_update
AFTER UPDATE ON produto
FOR EACH ROW
BEGIN
    IF OLD.preco != NEW.preco THEN
        INSERT INTO historico_preco (id_produto, preco_antigo, preco_novo, data_alteracao, responsavel)
        VALUES (NEW.idProduto, OLD.preco, NEW.preco, NOW(), CURRENT_USER());
    END IF;
END//
DELIMITER ;

-- Garante que nenhum cliente seja inserido com CPF já existente.
DELIMITER //
CREATE TRIGGER before_insert_clientes
BEFORE INSERT ON clientes
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM clientes WHERE CPF = NEW.CPF) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'CPF já cadastrado para outro cliente.';
    END IF;
END;
//
DELIMITER ;

-- TESTE: Já existe esse CPF na tabela
INSERT INTO clientes (CPF, nome, dataNasc, sexo, email, telefone)
VALUES ('111.111.111-11', 'Cliente Duplicado', '1995-01-01', 'M', 'duplicado@email.com', '(11) 99999-9999');
-- Deve gerar erro: 'CPF já cadastrado para outro cliente.'

-- Valida que a nota esteja entre 1 e 5 (proteção extra além do CHECK).
DELIMITER //
CREATE TRIGGER before_insert_avaliacoes
BEFORE INSERT ON avaliacoes
FOR EACH ROW
BEGIN
    IF NEW.nota < 1 OR NEW.nota > 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nota da avaliação deve ser entre 1 e 5.';
    END IF;
END;
//
DELIMITER ;

-- TESTE: Tentando inserir nota inválida
INSERT INTO avaliacoes (id_produto, clientes_cpf, nota, comentario, data_avaliacao)
VALUES (1, '111.111.111-11', 6, 'Nota inválida', NOW());
-- Deve gerar erro: 'Nota da avaliação deve ser entre 1 e 5.'

-- Diminui o estoque ao inserir item de pedido.
DELIMITER //
CREATE TRIGGER after_insert_itemPedidos
AFTER INSERT ON itemPedidos
FOR EACH ROW
BEGIN
    UPDATE estoque 
    SET qtdDisponivel = qtdDisponivel - NEW.quantidade
    WHERE id_produto = NEW.id_produto;
END;
//
DELIMITER ;

-- TESTE: Verificar estoque antes
SELECT * FROM estoque WHERE id_produto = 1;

-- Inserir item de pedido (deve abater do estoque):
INSERT INTO itemPedidos (id_pedido, id_produto, quantidade, precoUnitario)
VALUES (1, 1, 1, 299.99);

-- Verificar estoque após:
SELECT * FROM estoque WHERE id_produto = 1;

-- Registra na tabela auditoria sempre que um funcionário for excluído.
DELIMITER //
CREATE TRIGGER after_delete_funcionario
AFTER DELETE ON funcionarios
FOR EACH ROW
BEGIN
    INSERT INTO auditoria (tabela_afetada, operacao, id_registro, usuario, data_hora, dados_antigos)
    VALUES (
        'funcionarios', 'DELETE', OLD.CPF, CURRENT_USER(), NOW(),
        CONCAT('Nome:', OLD.nome, '|Email:', OLD.email, '|Telefone:', OLD.telefone)
    );
END;
//
DELIMITER ;

-- TESTE: Verifique que o funcionário existe
SELECT * FROM funcionarios WHERE CPF = '999.000.111-22';

-- Apagar funcionário:
DELETE FROM funcionarios WHERE CPF = '999.000.111-22';

-- Verificar log:
SELECT * FROM auditoria WHERE tabela_afetada = 'funcionarios';
