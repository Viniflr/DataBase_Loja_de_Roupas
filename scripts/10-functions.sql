-- Retorna valor total de um item do pedido.
CREATE FUNCTION fn_valor_total_item(qtd INT, preco DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN qtd * preco;

-- Retorna a idade de um cliente baseado no CPF.
CREATE FUNCTION fn_idade_cliente(cpf_cliente VARCHAR(14))
RETURNS INT
DETERMINISTIC
RETURN TIMESTAMPDIFF(YEAR, (SELECT dataNasc FROM clientes WHERE CPF = cpf_cliente), CURDATE());

-- Retorna o total de produtos em promoção no momento.
CREATE FUNCTION fn_produtos_em_promocao()
RETURNS INT
DETERMINISTIC
RETURN (
    SELECT COUNT(*) FROM promocoes
    WHERE CURDATE() BETWEEN data_inicio AND data_fim
);

-- Retorna o total de vendas de um funcionário.
CREATE FUNCTION fn_total_vendas_funcionario(cpf VARCHAR(14))
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN (
    SELECT SUM(valorTotal) FROM vendas WHERE funcionario_cpf = cpf
);

-- Retorna a quantidade de produtos com estoque crítico (<10).
CREATE FUNCTION fn_estoque_critico()
RETURNS INT
DETERMINISTIC
RETURN (
    SELECT COUNT(*) FROM estoque WHERE qtdDisponivel < 10
);

-- Retorna quanto um cliente já economizou com descontos.
CREATE FUNCTION fn_desconto_total_cliente(cpf VARCHAR(14))
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN (
    SELECT SUM(desconto) FROM vendas WHERE clientes_cpf = cpf
);
