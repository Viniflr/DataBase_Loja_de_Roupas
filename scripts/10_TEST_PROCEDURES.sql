USE lojaRoupas;

-- Teste da Procedure 1: AdicionarProduto
-- Primeiro, encontre um fornecedor e uma categoria existentes
SELECT CNPJ FROM fornecedor LIMIT 1; -- Ex: '12.345.678/0001-90'
SELECT idCategoria FROM categProduto LIMIT 1; -- Ex: 1

CALL AdicionarProduto('12.345.678/0001-90', 1, 129.99, 'NovaMarca', 'Blusa de verão', 'Azul', 'Blusa Casual', 'P', 50, 'Corredor 5, Prateleira 2');

-- Teste da Procedure 2: AtualizarEstoque
-- Primeiro, encontre um id_produto existente no estoque
SELECT idProduto FROM produto LIMIT 1; -- Ex: 1
CALL AtualizarEstoque(1, 120); -- Atualiza o estoque do produto 1 para 120 unidades
CALL AtualizarEstoque(999, 10); -- Teste com produto inexistente

-- Teste da Procedure 3: RegistrarPagamentoVenda
-- Primeiro, encontre um idVendas existente
SELECT idVendas FROM vendas LIMIT 1; -- Ex: 1
CALL RegistrarPagamentoVenda(1, 150.00, 'Cartão de Débito', NULL);
CALL RegistrarPagamentoVenda(1, 200.00, 'Pix', NULL); -- Adicionar outro pagamento à mesma venda
CALL RegistrarPagamentoVenda(999, 50.00, 'Dinheiro', NULL); -- Teste com venda inexistente

-- Teste da Procedure 4: ObterHistoricoComprasCliente
-- Use um CPF de cliente existente
SELECT CPF FROM clientes LIMIT 1;
CALL ObterHistoricoComprasCliente('111.111.111-11');
CALL ObterHistoricoComprasCliente('999.999.999-99'); -- Cliente com histórico

-- Teste da Procedure 5: AtualizarSalarioComissao
-- Use um CPF de funcionário existente
SELECT CPF FROM funcionarios LIMIT 1; -- Ex: '222.333.444-55'
CALL AtualizarSalarioComissao('222.333.444-55', 4200.00, 550.00);
CALL AtualizarSalarioComissao('999.999.999-99', 5000.00, 700.00); -- Teste com funcionário inexistente (ou com erro, se o CPF não existir)

-- Teste da Procedure 6: GerarRelatorioVendasPeriodo
CALL GerarRelatorioVendasPeriodo('2024-03-01', '2024-03-31');
CALL GerarRelatorioVendasPeriodo('2025-01-01', '2025-12-31');