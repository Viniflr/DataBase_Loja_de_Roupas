USE lojaRoupas;

-- Inserções em clientes (sem alterações, pois os dados parecem consistentes)
INSERT INTO clientes (CPF, nome, nomeSocial, dataNasc, sexo, email, telefone) VALUES
('111.111.111-11', 'Lucas Pereira', NULL, '1990-01-15', 'M', 'lucas.pereira@email.com', '(11) 91234-5678'),
('222.222.222-22', 'Mariana Costa', 'Mari Costa', '1985-03-22', 'F', 'mariana.costa@email.com', '(21) 99987-6543'),
('333.333.333-33', 'Ricardo Alves', NULL, '1988-07-30', 'M', 'ricardo.alves@email.com', '(31) 92345-6789'),
('444.444.444-44', 'Fernanda Souza', NULL, '1995-12-10', 'F', 'fernanda.souza@email.com', '(41) 93456-7890'),
('555.555.555-55', 'Eduardo Silva', NULL, '1982-06-18', 'M', 'eduardo.silva@email.com', '(51) 98765-4321'),
('666.666.666-66', 'Ana Oliveira', 'Aninha', '1993-09-25', 'F', 'ana.oliveira@email.com', '(61) 95321-4321'),
('777.777.777-77', 'Carlos Rocha', NULL, '1989-11-02', 'M', 'carlos.rocha@email.com', '(71) 98876-5432'),
('888.888.888-88', 'Juliana Santos', 'Ju Santos', '1997-02-12', 'F', 'juliana.santos@email.com', '(81) 92345-6789'),
('999.999.999-99', 'Paulo Ferreira', NULL, '1983-04-05', 'M', 'paulo.ferreira@email.com', '(91) 93456-7890'),
('000.000.000-00', 'Roberta Lima', NULL, '1991-05-20', 'F', 'roberta.lima@email.com', '(41) 96543-2109');

-- Inserções em enderecoCli (sem alterações, pois os dados parecem consistentes)
INSERT INTO enderecoCli (clientes_cpf, uf, cidade, bairro, rua, numero, complemento, cep) VALUES
('111.111.111-11', 'SP', 'São Paulo', 'Centro', 'Rua A', 100, 'Casa 1', '01000-000'),
('222.222.222-22', 'RJ', 'Rio de Janeiro', 'Copacabana', 'Rua B', 200, 'Ap 302', '22000-000'),
('333.333.333-33', 'MG', 'Belo Horizonte', 'Savassi', 'Rua C', 300, NULL, '30100-000'),
('444.444.444-44', 'PR', 'Curitiba', 'Batel', 'Rua D', 400, 'Casa de fundos', '80000-000'),
('555.555.555-55', 'RS', 'Porto Alegre', 'Moinhos de Vento', 'Rua E', 500, NULL, '90000-000'),
('666.666.666-66', 'DF', 'Brasília', 'Asa Norte', 'Rua F', 600, 'Bloco A', '70000-000'),
('777.777.777-77', 'BA', 'Salvador', 'Barra', 'Rua G', 700, 'Ap 101', '40000-000'),
('888.888.888-88', 'PE', 'Recife', 'Boa Viagem', 'Rua H', 800, NULL, '50000-000'),
('999.999.999-99', 'CE', 'Fortaleza', 'Aldeota', 'Rua I', 900, 'Loja 1', '60000-000'),
('000.000.000-00', 'SC', 'Florianópolis', 'Trindade', 'Rua J', 1000, 'Apto 12', '88000-000');

-- Inserções em funcionarios (sem alterações, pois os dados parecem consistentes)
INSERT INTO funcionarios (CPF, nome, nomeSocial, estadoCivil, dataNasc, sexo, email, telefone, salario, cargaHora, comissao, dataAdm, dataDem) VALUES
('111.222.333-44', 'Rodrigo Silva', NULL, 'Casado', '1985-08-15', 'M', 'rodrigo.silva@email.com', '(11) 91234-5678', 5000.00, 40, 800.00, '2015-05-01 08:00:00', NULL),
('222.333.444-55', 'Patrícia Souza', 'Paty Souza', 'Solteira', '1990-12-03', 'F', 'patricia.souza@email.com', '(21) 99876-1234', 4000.00, 40, 500.00, '2016-07-15 09:00:00', NULL),
('333.444.555-66', 'José Almeida', NULL, 'Divorciado', '1980-02-10', 'M', 'jose.almeida@email.com', '(31) 92345-6789', 3500.00, 38, 400.00, '2014-09-20 08:30:00', NULL),
('444.555.666-77', 'Ana Costa', NULL, 'Solteira', '1995-04-20', 'F', 'ana.costa@email.com', '(41) 91234-5678', 3500.00, 40, 450.00, '2018-03-01 08:00:00', NULL),
('555.666.777-88', 'Carlos Pereira', NULL, 'Casado', '1992-05-30', 'M', 'carlos.pereira@email.com', '(51) 98765-4321', 4800.00, 44, 600.00, '2020-08-10 08:00:00', NULL),
('666.777.888-99', 'Juliana Mendes', 'Ju Mendes', 'Casada', '1988-11-11', 'F', 'juliana.mendes@email.com', '(61) 95321-4321', 4500.00, 40, 700.00, '2017-06-01 08:00:00', NULL),
('777.888.999-00', 'Rafael Barbosa', NULL, 'Solteiro', '1993-01-22', 'M', 'rafael.barbosa@email.com', '(81) 92345-6789', 4200.00, 40, 550.00, '2019-10-25 08:30:00', NULL),
('888.999.000-11', 'Mariana Lima', NULL, 'Solteira', '1992-06-30', 'F', 'mariana.lima@email.com', '(71) 98987-6543', 4600.00, 42, 600.00, '2019-04-14 08:15:00', NULL),
('999.000.111-22', 'Thiago Rocha', NULL, 'Casado', '1987-02-28', 'M', 'thiago.rocha@email.com', '(85) 92345-6789', 5500.00, 44, 750.00, '2016-12-05 09:00:00', NULL),
('000.111.222-33', 'Fabiana Oliveira', NULL, 'Divorciada', '1982-07-22', 'F', 'fabiana.oliveira@email.com', '(41) 98765-4321', 3800.00, 40, 500.00, '2014-03-10 08:00:00', NULL);

-- Inserções em enderecoFunc (sem alterações, pois os dados parecem consistentes)
INSERT INTO enderecoFunc (funcionario_cpf, uf, cidade, bairro, rua, numero, comp, cep) VALUES
('111.222.333-44', 'SP', 'São Paulo', 'Moema', 'Rua das Flores', 101, 'Ap 12', '04500-000'),
('222.333.444-55', 'RJ', 'Rio de Janeiro', 'Laranjeiras', 'Rua do Sol', 202, NULL, '22240-000'),
('333.444.555-66', 'MG', 'Belo Horizonte', 'Funcionários', 'Rua das Palmeiras', 303, 'Casa', '30130-000'),
('444.555.666-77', 'PR', 'Curitiba', 'Centro Cívico', 'Av. República', 404, 'Bloco B', '80030-000'),
('555.666.777-88', 'RS', 'Porto Alegre', 'Menino Deus', 'Rua da Esperança', 505, NULL, '90880-000'),
('666.777.888-99', 'DF', 'Brasília', 'Lago Norte', 'Rua do Ipê', 606, 'Casa 3', '71530-000'),
('777.888.999-00', 'PE', 'Recife', 'Boa Vista', 'Rua das Mangueiras', 707, NULL, '50070-000'),
('888.999.000-11', 'BA', 'Salvador', 'Itapuã', 'Av. das Gaivotas', 808, 'Ap 101', '41610-000'),
('999.000.111-22', 'CE', 'Fortaleza', 'Meireles', 'Rua do Mar', 909, NULL, '60160-000'),
('000.111.222-33', 'SC', 'Florianópolis', 'Ingleses', 'Rua das Ondas', 1001, 'Casa', '88058-000');

-- Inserções em ferias (ajustando os CPFs para corresponder aos funcionários existentes)
INSERT INTO ferias (funcionario_cpf, qtdDias, anoRef, dataInicio, dataFim) VALUES
('111.222.333-44', 30, 2024, '2025-01-05', '2025-02-03'),
('222.333.444-55', 15, 2024, '2025-02-10', '2025-02-24'),
('333.444.555-66', 20, 2024, '2025-03-01', '2025-03-20'),
('444.555.666-77', 10, 2024, '2025-04-15', '2025-04-24'),
('555.666.777-88', 30, 2024, '2025-05-10', '2025-06-08'),
('666.777.888-99', 20, 2024, '2025-06-20', '2025-07-09'),
('777.888.999-00', 25, 2024, '2025-07-15', '2025-08-08'),
('888.999.000-11', 30, 2024, '2025-08-10', '2025-09-08'),
('999.000.111-22', 10, 2024, '2025-09-20', '2025-09-29'),
('000.111.222-33', 15, 2024, '2025-10-05', '2025-10-19');
-- As duas últimas entradas foram removidas, pois não há funcionários com esses CPFs.

-- Inserções em dependentes (ajustando os CPFs para corresponder aos funcionários existentes)
INSERT INTO dependentes (CPF, funcionario_cpf, nome, dataNasc, parentesco) VALUES
('321.654.987-00', '111.222.333-44', 'Lucas Andrade', '2012-05-10', 'Filho'),
('456.789.123-11', '222.333.444-55', 'Marina Costa', '2015-07-20', 'Filha'),
('654.987.321-22', '333.444.555-66', 'Paulo Lima', '1975-03-15', 'Pai'),
('789.123.456-33', '444.555.666-77', 'Sofia Mendes', '2018-12-01', 'Filha'),
('987.321.654-44', '555.666.777-88', 'Joana Prado', '2010-10-25', 'Filha'),
('147.258.369-55', '666.777.888-99', 'Carlos Prado', '2008-08-15', 'Filho'),
('258.369.147-66', '777.888.999-00', 'Ana Beatriz', '2016-04-30', 'Filha'),
('369.147.258-77', '888.999.000-11', 'João Henrique', '2011-06-18', 'Filho'),
('741.852.963-88', '999.000.111-22', 'Laura Silva', '2017-03-22', 'Filha'),
('852.963.741-99', '000.111.222-33', 'Roberta Lima', '1980-09-09', 'Esposa');
-- As duas últimas entradas foram removidas, pois não há funcionários com esses CPFs.

-- Inserções em departamento (ajustando os CPFs para corresponder aos funcionários existentes como gerentes)
INSERT INTO departamento (nome, telefone, email, respDepartamento, cpfGerente) VALUES
('Recursos Humanos', '11987654321', 'rh@empresa.com', 'Maria Oliveira', '111.222.333-44'),
('Financeiro', '11976543210', 'financeiro@empresa.com', 'Carlos Eduardo', '222.333.444-55'),
('Tecnologia da Informação', '11888888888', 'ti@empresa.com', 'Ana Paula Santos', '333.444.555-66'),
('Marketing', '11777777777', 'marketing@empresa.com', 'Fernanda Souza', '444.555.666-77'),
('Logística', '11666666666', 'logistica@empresa.com', 'Ricardo Martins', '555.666.777-88'),
('Jurídico', '11555555555', 'juridico@empresa.com', 'João Mendes', '666.777.888-99'),
('Comercial', '11444444444', 'comercial@empresa.com', 'Beatriz Lima', '777.888.999-00'),
('Atendimento ao Cliente', '11333333333', 'atendimento@empresa.com', 'Lucas Farias', '888.999.000-11'),
('Pesquisa e Desenvolvimento', '11222222222', 'pesquisa@empresa.com', 'Juliana Reis', '999.000.111-22'),
('Engenharia', '11111111111', 'engenharia@empresa.com', 'Marcos Dias', '000.111.222-33');
-- As duas últimas entradas foram removidas, pois não há funcionários com esses CPFs.

-- Inserções em cargo (sem alterações)
INSERT INTO cargo (cbo, nome, faixaSalarial) VALUES
(252515, 'Analista de Sistemas', 5500.00),
(411010, 'Assistente Administrativo', 3000.00),
(141205, 'Gerente Financeiro', 8800.00),
(123605, 'Diretor de Recursos Humanos', 10500.00),
(313105, 'Técnico em Informática', 3500.00),
(252120, 'Analista de Marketing', 4200.00),
(142205, 'Gerente de Projetos', 9500.00),
(414105, 'Auxiliar de Escritório', 2200.00),
(241005, 'Contador', 5800.00),
(414205, 'Recepcionista', 2000.00),
(132305, 'Gerente de Logística', 7800.00),
(223505, 'Enfermeiro do Trabalho', 6300.00);

-- Inserções em planoSaude (ajustando os CPFs para corresponder aos funcionários existentes)
INSERT INTO planoSaude (funcionario_cpf, numero, nome) VALUES
('111.222.333-44', 'PSF-2001-A', 'Amil Saúde'),
('222.333.444-55', 'PSF-2002-B', 'Unimed Nacional'),
('333.444.555-66', 'PSF-2003-C', 'Bradesco Saúde'),
('444.555.666-77', 'PSF-2004-D', 'NotreDame Intermédica'),
('555.666.777-88', 'PSF-2005-E', 'Hapvida Saúde'),
('666.777.888-99', 'PSF-2006-F', 'SulAmérica Saúde'),
('777.888.999-00', 'PSF-2007-G', 'Porto Saúde'),
('888.999.000-11', 'PSF-2008-H', 'GreenLine Saúde'),
('999.000.111-22', 'PSF-2009-I', 'Golden Cross'),
('000.111.222-33', 'PSF-2010-J', 'Prevent Senior');
-- As duas últimas entradas foram removidas, pois não há funcionários com esses CPFs.

-- Inserções em categProduto (sem alterações)
INSERT INTO categProduto (nomeCateg, descricao) VALUES
('Esportes', 'Produtos voltados para atividades físicas e esportivas'),
('Eletrônicos', 'Dispositivos eletrônicos, acessórios e gadgets'),
('Moda', 'Roupas e acessórios de moda'),
('Alimentos', 'Produtos alimentícios e bebidas'),
('Móveis', 'Móveis para casa e escritório'),
('Beleza', 'Produtos de cuidado pessoal e cosméticos'),
('Saúde', 'Produtos para cuidados com a saúde'),
('Automotivo', 'Acessórios e peças para automóveis'),
('Informática', 'Equipamentos e acessórios de informática'),
('Papelaria', 'Artigos de papelaria para escritórios e escolas'),
('Livros', 'Livros diversos para todas as idades'),
('Casa e Decoração', 'Produtos para decoração e organização da casa');

-- Inserções em fornecedor (CORRIGIDO: Removidas as duplicações de CNPJ)
INSERT INTO fornecedor (CNPJ, email, telefone, razaoSocial) VALUES
('12.345.678/0001-90', 'contato@nike.com', '11-987654321', 'Nike Brasil'),
('98.765.432/0001-01', 'contato@adidas.com', '21-976543210', 'Adidas Brasil'),
('23.456.789/0001-12', 'contato@puma.com', '31-965432109', 'Puma Brasil'),
('34.567.890/0001-23', 'contato@reebok.com', '41-954321098', 'Reebok Brasil'),
('45.678.901/0001-34', 'contato@underarmour.com', '51-943210987', 'Under Armour Brasil'),
('56.789.012/0001-45', 'contato@asics.com', '61-932109876', 'Asics Brasil');

-- Inserções em produto (ajustando os id_fornecedor e id_categoria para corresponderem aos dados existentes)
-- Os id_categoria foram ajustados para corresponder aos primeiros 6 da tabela categProduto, se necessário.
-- O tamanho 'U' (Único) foi corrigido para 'G' ou 'M' como nos exemplos de roupas. Se 'U' for um tamanho válido na sua modelagem, pode ser mantido.
INSERT INTO produto (id_fornecedor, id_categoria, preco, marca, descricao, cor, nomeProduto, tamanho) VALUES
('12.345.678/0001-90', 1, 299.99, 'Nike', 'Tênis de corrida Nike Air Zoom', 'Preto', 'Nike Air Zoom', 'M'),
('98.765.432/0001-01', 2, 1599.00, 'Adidas', 'Smartwatch Adidas Sport', 'Preto', 'Adidas SportWatch', 'G'),
('23.456.789/0001-12', 3, 99.90, 'Puma', 'Camiseta Puma para treino', 'Branco', 'Puma Train', 'M'),
('34.567.890/0001-23', 4, 50.00, 'Reebok', 'Saco de batata Reebok', 'Verde', 'Reebok Bag', 'G'),
('45.678.901/0001-34', 5, 799.99, 'Under Armour', 'Sofa Relax Under Armour', 'Cinza', 'Under Armour Sofa', 'G'),
('56.789.012/0001-45', 6, 69.90, 'Asics', 'Protetor solar Asics', 'Amarelo', 'Asics SunBlock', 'M');
-- As demais entradas foram removidas, pois os CNPJs do fornecedor foram removidos.

-- Inserções em enderecoForne (ajustando os fornecedor_cnpj para corresponderem aos fornecedores existentes)
INSERT INTO enderecoForne (fornecedor_cnpj, uf, cidade, bairro, rua, numero, comp, cep) VALUES
('12.345.678/0001-90', 'SP', 'São Paulo', 'Vila Progredior', 'Rua da Nike', 100, 'Sala 101', '01010-001'),
('98.765.432/0001-01', 'RJ', 'Rio de Janeiro', 'Leblon', 'Av. Atlântica', 200, 'Loja 12', '22021-110'),
('23.456.789/0001-12', 'MG', 'Belo Horizonte', 'Centro', 'Rua das Palmeiras', 300, 'Bloco A', '30130-003'),
('34.567.890/0001-23', 'PR', 'Curitiba', 'Centro', 'Av. Sete de Setembro', 400, 'Loja B', '80010-000'),
('45.678.901/0001-34', 'RS', 'Porto Alegre', 'Cidade Baixa', 'Rua dos Móveis', 500, 'Pavimento 2', '90010-200'),
('56.789.012/0001-45', 'DF', 'Brasília', 'Asa Norte', 'Av. das Nações', 600, 'Andar 3', '70050-100');
-- As demais entradas foram removidas, pois os CNPJs do fornecedor foram removidos.

-- Inserções em estoque (ajustando id_produto para corresponder aos produtos existentes)
-- Assumindo que id_produto é auto-incremento e começou do 1.
INSERT INTO estoque (id_produto, qtdDisponivel, localizacao) VALUES
(1, 100, 'Depósito 1 - Rua A'),
(2, 50, 'Depósito 2 - Rua B'),
(3, 200, 'Depósito 1 - Rua C'),
(4, 150, 'Depósito 2 - Rua D'),
(5, 30, 'Depósito 1 - Rua E'),
(6, 80, 'Depósito 3 - Rua F');
-- As demais entradas foram removidas, pois os produtos correspondentes foram removidos.

-- Inserções em pedidos (sem alterações, pois os dados parecem consistentes com os clientes existentes)
INSERT INTO pedidos (clientes_cpf, dataPedido, statusPedido) VALUES
('111.111.111-11', '2025-04-29 10:00:00', 'Aprovado'),
('222.222.222-22', '2025-04-29 10:05:00', 'Aprovado'),
('333.333.333-33', '2025-04-29 10:10:00', 'Aguardando pagamento'),
('444.444.444-44', '2025-04-29 10:15:00', 'Aprovado'),
('555.555.555-55', '2025-04-29 10:20:00', 'Enviado'),
('666.666.666-66', '2025-04-29 10:25:00', 'Aprovado'),
('777.777.777-77', '2025-04-29 10:30:00', 'Aguardando envio'),
('888.888.888-88', '2025-04-29 10:35:00', 'Enviado'),
('999.999.999-99', '2025-04-29 10:40:00', 'Aprovado'),
('000.000.000-00', '2025-04-29 10:45:00', 'Aguardando envio'),
('111.111.111-11', '2025-04-29 10:50:00', 'Enviado'),
('222.222.222-22', '2025-04-29 10:55:00', 'Aprovado');

-- Inserções em vendas (ajustando os CPFs para corresponderem aos clientes e funcionários existentes)
-- Além disso, os CPFs de clientes '123.456.789-00', etc., não existem na sua tabela 'clientes'.
-- Ajustei para usar os CPFs de clientes existentes e os CPFs de funcionários existentes.
INSERT INTO vendas (clientes_cpf, funcionario_cpf, dataVenda, valorTotal, desconto) VALUES
('111.111.111-11', '111.222.333-44', '2024-03-01 14:30:00', 350.00, 10.00),
('222.222.222-22', '222.333.444-55', '2024-03-03 09:15:00', 620.00, 25.00),
('333.333.333-33', '333.444.555-66', '2024-03-05 16:45:00', 470.50, 0.00),
('444.444.444-44', '444.555.666-77', '2024-03-07 11:10:00', 250.00, 15.00),
('555.555.555-55', '555.666.777-88', '2024-03-10 18:00:00', 1280.00, 50.00),
('666.666.666-66', '666.777.888-99', '2024-03-11 13:20:00', 780.00, 30.00),
('777.777.777-77', '777.888.999-00', '2024-03-14 10:00:00', 310.00, 5.00),
('888.888.888-88', '888.999.000-11', '2024-03-17 15:45:00', 590.00, 20.00),
('999.999.999-99', '999.000.111-22', '2024-03-20 17:30:00', 920.00, 40.00),
('000.000.000-00', '000.111.222-33', '2024-03-23 12:10:00', 430.00, 0.00),
('111.111.111-11', '111.222.333-44', '2024-03-25 16:25:00', 810.00, 35.00),
('222.222.222-22', '222.333.444-55', '2024-03-28 08:55:00', 1100.00, 60.00);


-- Inserções em formaPag (sem alterações, assumindo que id_vendas são sequenciais de 1 a 12)
INSERT INTO formaPag (id_vendas, valorPago, tipo, parcela) VALUES
(1, 315.00, 'Cartão de Crédito', 3),
(2, 595.00, 'Débito', NULL),
(3, 470.50, 'Boleto', NULL),
(4, 235.00, 'Cartão de Crédito', 2),
(5, 1230.00, 'Dinheiro', NULL),
(6, 750.00, 'Pix', NULL),
(7, 295.00, 'Cartão de Crédito', 1),
(8, 470.00, 'Débito', NULL),
(9, 880.00, 'Cartão de Crédito', 4),
(10, 430.00, 'Dinheiro', NULL),
(11, 775.00, 'Boleto', NULL),
(12, 1040.00, 'Cartão de Crédito', 5);

-- Inserções em itemPedidos (ajustando o precoUnitario para ser o valor unitário do produto)
-- E garantindo que id_produto e id_pedido existem.
-- O precoUnitario em itemPedidos deve ser o preço de UMA unidade do produto, não o total.
-- Ajustei os id_produto para corresponder aos 6 produtos que foram inseridos.
INSERT INTO itemPedidos (id_pedido, id_produto, quantidade, precoUnitario) VALUES
(1, 1, 2, 299.99), -- 2 * 299.99 = 599.98
(2, 2, 1, 1599.00),
(3, 3, 5, 99.90),  -- 5 * 99.90 = 499.50
(4, 4, 3, 50.00),  -- 3 * 50.00 = 150.00
(5, 5, 1, 799.99),
(6, 6, 4, 69.90),  -- 4 * 69.90 = 279.60
(7, 1, 2, 299.99), -- usando produto 1 novamente
(8, 2, 3, 1599.00), -- usando produto 2 novamente
(9, 3, 1, 99.90),  -- usando produto 3 novamente
(10, 4, 2, 50.00),  -- usando produto 4 novamente
(11, 5, 1, 799.99), -- usando produto 5 novamente
(12, 6, 1, 69.90);  -- usando produto 6 novamente

-- Inserir dados na tabela funcionario_cargo
INSERT INTO funcionario_cargo (funcionario_cpf, cbo, data_inicio) VALUES
('111.222.333-44', 123605, '2015-05-01'),
('222.333.444-55', 141205, '2016-07-15'),
('333.444.555-66', 252515, '2014-09-20'),
('444.555.666-77', 252120, '2018-03-01'),
('555.666.777-88', 132305, '2020-08-10'),
('666.777.888-99', 142205, '2017-06-01'),
('777.888.999-00', 252120, '2019-10-25'),
('888.999.000-11', 414105, '2019-04-14'),
('999.000.111-22', 142205, '2016-12-05'),
('000.111.222-33', 241005, '2014-03-10');

-- Inserir dados na tabela avaliacoes
INSERT INTO avaliacoes (id_produto, clientes_cpf, nota, comentario, data_avaliacao) VALUES
(1, '111.111.111-11', 5, 'Excelente tênis, muito confortável', '2024-03-15 10:00:00'),
(1, '222.222.222-22', 4, 'Bom tênis, mas demorou para entregar', '2024-03-16 11:30:00'),
(2, '333.333.333-33', 3, 'Funciona bem, mas a bateria poderia durar mais', '2024-03-17 09:15:00'),
(3, '444.444.444-44', 5, 'Camiseta de ótima qualidade', '2024-03-18 14:20:00'),
(4, '555.555.555-55', 2, 'Saco veio com defeito', '2024-03-19 16:45:00'),
(5, '666.666.666-66', 4, 'Sofá confortável, mas montagem complicada', '2024-03-20 13:10:00');

-- Inserir dados na tabela promocoes
INSERT INTO promocoes (nome, descricao, data_inicio, data_fim, desconto, id_produto) VALUES
('Black Friday Tênis', 'Desconto especial em tênis para Black Friday', '2024-11-25', '2024-11-29', 30.00, 1),
('Verão 2024', 'Promoção de verão em todos os produtos esportivos', '2024-12-01', '2025-02-28', 15.00, NULL);