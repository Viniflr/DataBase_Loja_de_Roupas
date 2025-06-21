-- TESTE DAS PROCEDURES
CALL sp_cadastrar_cliente_com_endereco(
    '123.456.789-99', 'Teste Cliente', '1990-01-01', 'M',
    'teste@email.com', '(99) 91234-5678',
    'SP', 'São Paulo', 'Centro', 'Rua Teste', 100, 'Ap 10', '01000-000'
);

-- Testar com um ID de venda já existente no seu banco, exemplo:
CALL sp_detalhes_venda(1);

-- Testar com um ID de categoria existente, exemplo:
CALL sp_resumo_categoria(1);

-- Testar com um ID de produto existente que tenha avaliações:
CALL sp_avaliacoes_por_produto(1);

-- TESTE DAS FUNCTIONS

SELECT fn_valor_total_item(3, 99.90) AS total_item;
-- Resultado esperado: 299.70

-- CPF precisa existir em `clientes`
SELECT fn_idade_cliente('111.111.111-11') AS idade;

SELECT fn_produtos_em_promocao() AS total_em_promocao;

SELECT fn_total_vendas_funcionario('111.222.333-44') AS total_vendas_func;

SELECT fn_estoque_critico() AS produtos_criticos;

SELECT fn_desconto_total_cliente('111.111.111-11') AS total_descontos;
