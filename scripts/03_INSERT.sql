USE lojaRoupas;

-- Inserção de Clientes
INSERT INTO clientes (CPF, nome, nomeSocial, dataNasc, sexo, email, telefone, rg) VALUES
('111.111.111-11', 'Lucas Pereira', NULL, '1990-01-15', 'M', 'lucas.pereira@email.com', '(11) 91234-5678', '1111111'),
('222.222.222-22', 'Mariana Costa', 'Mari Costa', '1985-03-22', 'F', 'mariana.costa@email.com', '(21) 99987-6543', '2222222'),
('333.333.333-33', 'Ricardo Alves', NULL, '1988-07-30', 'M', 'ricardo.alves@email.com', '(31) 92345-6789', '3333333'),
('444.444.444-44', 'Fernanda Souza', NULL, '1995-12-10', 'F', 'fernanda.souza@email.com', '(41) 93456-7890', '4444444'),
('555.555.555-55', 'Eduardo Silva', NULL, '1982-06-18', 'M', 'eduardo.silva@email.com', '(51) 98765-4321', '5555555'),
('666.666.666-66', 'Ana Oliveira', 'Aninha', '1993-09-25', 'F', 'ana.oliveira@email.com', '(61) 95321-4321', '6666666'),
('777.777.777-77', 'Carlos Rocha', NULL, '1989-11-02', 'M', 'carlos.rocha@email.com', '(71) 98876-5432', '7777777'),
('888.888.888-88', 'Juliana Santos', 'Ju Santos', '1997-02-12', 'F', 'juliana.santos@email.com', '(81) 92345-6789', '8888888'),
('999.999.999-99', 'Paulo Ferreira', NULL, '1983-04-05', 'M', 'paulo.ferreira@email.com', '(91) 93456-7890', '9999999'),
('000.000.000-00', 'Roberta Lima', NULL, '1991-05-20', 'F', 'roberta.lima@email.com', '(41) 96543-2109', '0000000');

-- Inserção de Categorias de Produtos
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

-- Inserção de Fornecedores (com 'razaoSocial' já corrigida)
INSERT INTO fornecedor (CNPJ, email, telefone, razaoSocial) VALUES
('12.345.678/0001-90', 'contato@nike.com', '11-987654321', 'Nike Brasil'),
('98.765.432/0001-01', 'contato@adidas.com', '21-976543210', 'Adidas Brasil'),
('23.456.789/0001-12', 'contato@puma.com', '31-965432109', 'Puma Brasil'),
('34.567.890/0001-23', 'contato@reebok.com', '41-954321098', 'Reebok Brasil'),
('45.678.901/0001-34', 'contato@underarmour.com', '51-943210987', 'Under Armour Brasil'),
('56.789.012/0001-45', 'contato@asics.com', '61-932109876', 'Asics Brasil'),
('67.890.123/0001-56', 'contato@nikebr.com', '71-922109876', 'Nike Brasil'),
('78.901.234/0001-67', 'contato@adidasbr.com', '81-921109876', 'Adidas Brasil'),
('89.012.345/0001-78', 'contato@pumabr.com', '91-920109876', 'Puma Brasil'),
('90.123.456/0001-89', 'contato@reebokbr.com', '61-919109876', 'Reebok Brasil'),
('01.234.567/0001-90', 'contato@underarmourbr.com', '51-918109876', 'Under Armour Brasil'),
('12.345.678/0001-91', 'contato@asicsbr.com', '41-917109876', 'Asics Brasil');

-- Inserção de Departamentos (para obter os IDs antes de inserir funcionários)
INSERT INTO departamento (nome, telefone, email, respDepartamento, cpfGerente) VALUES
('Recursos Humanos', '11987654321', 'rh@empresa.com', 'Maria Oliveira', NULL), -- Gerente CPF será atualizado depois
('Financeiro', '11976543210', 'financeiro@empresa.com', 'Carlos Eduardo', NULL),
('Tecnologia da Informação', '11888888888', 'ti@empresa.com', 'Ana Paula Santos', NULL),
('Marketing', '11777777777', 'marketing@empresa.com', 'Fernanda Souza', NULL),
('Logística', '11666666666', 'logistica@empresa.com', 'Ricardo Martins', NULL),
('Jurídico', '11555555555', 'juridico@empresa.com', 'João Mendes', NULL),
('Comercial', '11444444444', 'comercial@empresa.com', 'Beatriz Lima', NULL),
('Atendimento ao Cliente', '11333333333', 'atendimento@empresa.com', 'Lucas Farias', NULL),
('Pesquisa e Desenvolvimento', '11222222222', 'pesquisa@empresa.com', 'Juliana Reis', NULL),
('Engenharia', '11111111111', 'engenharia@empresa.com', 'Marcos Dias', NULL),
('Compras', '11234567890', 'compras@empresa.com', 'Patrícia Campos', NULL),
('Operações', '11999999999', 'operacoes@empresa.com', 'Renato Pires', NULL);

-- Inserção de Funcionários (com idDepartamento populado e os dois funcionários que faltavam)
-- Note: idDepartamento assume auto-incremento sequencial a partir de 1
INSERT INTO funcionarios (CPF, nome, nomeSocial, estadoCivil, dataNasc, sexo, email, telefone, salario, cargaHora, comissao, dataAdm, dataDem, idDepartamento) VALUES
('111.222.333-44', 'Rodrigo Silva', NULL, 'Casado', '1985-08-15', 'M', 'rodrigo.silva@email.com', '(11) 91234-5678', 5000.00, 40, 800.00, '2015-05-01 08:00:00', NULL, 1), -- RH
('222.333.444-55', 'Patrícia Souza', 'Paty Souza', 'Solteira', '1990-12-03', 'F', 'patricia.souza@email.com', '(21) 99876-1234', 4000.00, 40, 500.00, '2016-07-15 09:00:00', NULL, 2), -- Financeiro
('333.444.555-66', 'José Almeida', NULL, 'Divorciado', '1980-02-10', 'M', 'jose.almeida@email.com', '(31) 92345-6789', 3500.00, 38, 400.00, '2014-09-20 08:30:00', NULL, 3), -- TI
('444.555.666-77', 'Ana Costa', NULL, 'Solteira', '1995-04-20', 'F', 'ana.costa@email.com', '(41) 91234-5678', 3500.00, 40, 450.00, '2018-03-01 08:00:00', NULL, 4), -- Marketing
('555.666.777-88', 'Carlos Pereira', NULL, 'Casado', '1992-05-30', 'M', 'carlos.pereira@email.com', '(51) 98765-4321', 4800.00, 44, 600.00, '2020-08-10 08:00:00', NULL, 5), -- Logística
('666.777.888-99', 'Juliana Mendes', 'Ju Mendes', 'Casada', '1988-11-11', 'F', 'juliana.mendes@email.com', '(61) 95321-4321', 4500.00, 40, 700.00, '2017-06-01 08:00:00', NULL, 6), -- Jurídico
('777.888.999-00', 'Rafael Barbosa', NULL, 'Solteiro', '1993-01-22', 'M', 'rafael.barbosa@email.com', '(81) 92345-6789', 4200.00, 40, 550.00, '2019-10-25 08:30:00', NULL, 7), -- Comercial
('888.999.000-11', 'Mariana Lima', NULL, 'Solteira', '1992-06-30', 'F', 'mariana.lima@email.com', '(71) 98987-6543', 4600.00, 42, 600.00, '2019-04-14 08:15:00', NULL, 8), -- Atendimento ao Cliente
('999.000.111-22', 'Thiago Rocha', NULL, 'Casado', '1987-02-28', 'M', 'thiago.rocha@email.com', '(85) 92345-6789', 5500.00, 44, 750.00, '2016-12-05 09:00:00', NULL, 9), -- P&D
('000.111.222-33', 'Fabiana Oliveira', NULL, 'Divorciada', '1982-07-22', 'F', 'fabiana.oliveira@email.com', '(41) 98765-4321', 3800.00, 40, 500.00, '2014-03-10 08:00:00', NULL, 10), -- Engenharia
('123.234.345-56', 'Patrícia Campos', NULL, 'Solteira', '1991-03-08', 'F', 'patricia.campos@email.com', '(11) 91111-2222', 4100.00, 40, 520.00, '2021-01-20 09:00:00', NULL, 11), -- Compras
('234.345.456-67', 'Renato Pires', NULL, 'Casado', '1986-09-19', 'M', 'renato.pires@email.com', '(11) 93333-4444', 5300.00, 40, 680.00, '2020-04-01 08:30:00', NULL, 12); -- Operações

-- Atualiza os cpfGerente dos departamentos com funcionários existentes
UPDATE departamento SET cpfGerente = '111.222.333-44' WHERE idDepartamento = 1; -- RH
UPDATE departamento SET cpfGerente = '222.333.444-55' WHERE idDepartamento = 2; -- Financeiro
UPDATE departamento SET cpfGerente = '333.444.555-66' WHERE idDepartamento = 3; -- TI
UPDATE departamento SET cpfGerente = '444.555.666-77' WHERE idDepartamento = 4; -- Marketing
UPDATE departamento SET cpfGerente = '555.666.777-88' WHERE idDepartamento = 5; -- Logística
UPDATE departamento SET cpfGerente = '666.777.888-99' WHERE idDepartamento = 6; -- Jurídico
UPDATE departamento SET cpfGerente = '777.888.999-00' WHERE idDepartamento = 7; -- Comercial
UPDATE departamento SET cpfGerente = '888.999.000-11' WHERE idDepartamento = 8; -- Atendimento ao Cliente
UPDATE departamento SET cpfGerente = '999.000.111-22' WHERE idDepartamento = 9; -- P&D
UPDATE departamento SET cpfGerente = '000.111.222-33' WHERE idDepartamento = 10; -- Engenharia
UPDATE departamento SET cpfGerente = '123.234.345-56' WHERE idDepartamento = 11; -- Compras
UPDATE departamento SET cpfGerente = '234.345.456-67' WHERE idDepartamento = 12; -- Operações

-- Inserção de Endereços de Clientes (com 'complemento' já renomeado)
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

-- Inserção de Endereços de Funcionários (mantém 'comp')
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
('000.111.222-33', 'SC', 'Florianópolis', 'Ingleses', 'Rua das Ondas', 1001, 'Casa', '88058-000'),
('123.234.345-56', 'SP', 'São Paulo', 'Centro', 'Rua XYZ', 11, NULL, '01000-011'),
('234.345.456-67', 'MG', 'Uberlândia', 'Morada', 'Rua ABC', 22, 'Casa 2', '38400-022');

-- Inserção de Férias
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
('000.111.222-33', 15, 2024, '2025-10-05', '2025-10-19'),
('123.234.345-56', 20, 2024, '2025-11-01', '2025-11-20'),
('234.345.456-67', 30, 2024, '2025-12-01', '2025-12-30');

-- Inserção de Dependentes (com 'genero' adicionado)
INSERT INTO dependentes (CPF, funcionario_cpf, nome, dataNasc, parentesco, genero) VALUES
('321.654.987-00', '111.222.333-44', 'Lucas Andrade', '2012-05-10', 'Filho', 'M'),
('456.789.123-11', '222.333.444-55', 'Marina Costa', '2015-07-20', 'Filha', 'F'),
('654.987.321-22', '333.444.555-66', 'Paulo Lima', '1975-03-15', 'Pai', 'M'),
('789.123.456-33', '444.555.666-77', 'Sofia Mendes', '2018-12-01', 'Filha', 'F'),
('987.321.654-44', '555.666.777-88', 'Joana Prado', '2010-10-25', 'Filha', 'F'),
('147.258.369-55', '666.777.888-99', 'Carlos Prado', '2008-08-15', 'Filho', 'M'),
('258.369.147-66', '777.888.999-00', 'Ana Beatriz', '2016-04-30', 'Filha', 'F'),
('369.147.258-77', '888.999.000-11', 'João Henrique', '2011-06-18', 'Filho', 'M'),
('741.852.963-88', '999.000.111-22', 'Laura Silva', '2017-03-22', 'Filha', 'F'),
('852.963.741-99', '000.111.222-33', 'Roberta Lima', '1980-09-09', 'Esposa', 'F'),
('963.741.852-00', '123.234.345-56', 'Bruno Henrique', '2013-02-05', 'Filho', 'M'),
('159.753.486-11', '234.345.456-67', 'Daniela Castro', '2019-01-11', 'Filha', 'F');

-- Inserção de Cargos
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

-- Inserção de Planos de Saúde (com 'observacoes' adicionado)
INSERT INTO planoSaude (funcionario_cpf, numero, nome, observacoes) VALUES
('111.222.333-44', 'PSF-2001-A', 'Amil Saúde', 'Plano básico'),
('222.333.444-55', 'PSF-2002-B', 'Unimed Nacional', 'Plano completo'),
('333.444.555-66', 'PSF-2003-C', 'Bradesco Saúde', NULL),
('444.555.666-77', 'PSF-2004-D', 'NotreDame Intermédica', 'Com cobertura odontológica'),
('555.666.777-88', 'PSF-2005-E', 'Hapvida Saúde', NULL),
('666.777.888-99', 'PSF-2006-F', 'SulAmérica Saúde', 'Plano premium'),
('777.888.999-00', 'PSF-2007-G', 'Porto Saúde', NULL),
('888.999.000-11', 'PSF-2008-H', 'GreenLine Saúde', 'Plano regional'),
('999.000.111-22', 'PSF-2009-I', 'Golden Cross', NULL),
('000.111.222-33', 'PSF-2010-J', 'Prevent Senior', 'Focado na terceira idade'),
('123.234.345-56', 'PSF-2011-K', 'São Francisco Saúde', NULL),
('234.345.456-67', 'PSF-2012-L', 'Blue Med Saúde', 'Plano ambulatorial');

-- Inserção de Produtos
INSERT INTO produto (id_fornecedor, id_categoria, preco, marca, descricao, cor, nomeProduto, tamanho) VALUES
('12.345.678/0001-90', 1, 299.99, 'Nike', 'Tênis de corrida Nike Air Zoom', 'Preto', 'Nike Air Zoom', 'M'),
('98.765.432/0001-01', 2, 1599.00, 'Adidas', 'Smartwatch Adidas Sport', 'Preto', 'Adidas SportWatch', 'G'),
('23.456.789/0001-12', 3, 99.90, 'Puma', 'Camiseta Puma para treino', 'Branco', 'Puma Train', 'M'),
('34.567.890/0001-23', 4, 50.00, 'Reebok', 'Saco de batata Reebok', 'Verde', 'Reebok Bag', 'G'),
('45.678.901/0001-34', 5, 799.99, 'Under Armour', 'Sofa Relax Under Armour', 'Cinza', 'Under Armour Sofa', 'G'),
('56.789.012/0001-45', 6, 69.90, 'Asics', 'Protetor solar Asics', 'Amarelo', 'Asics SunBlock', 'M'),
('67.890.123/0001-56', 1, 259.99, 'Nike', 'Tênis Nike Free', 'Azul', 'Nike Free', 'M'),
('78.901.234/0001-67', 2, 1999.99, 'Adidas', 'Fone de ouvido Adidas', 'Branco', 'Adidas Headphones', 'U'),
('89.012.345/0001-78', 3, 79.90, 'Puma', 'Short Puma Fitness', 'Cinza', 'Puma Fitness', 'G'),
('90.123.456/0001-89', 4, 129.90, 'Reebok', 'Mochila Reebok', 'Preto', 'Reebok Backpack', 'U'),
('01.234.567/0001-90', 5, 899.99, 'Under Armour', 'Mesa de escritório Under Armour', 'Preto', 'Under Armour Desk', 'U'),
('12.345.678/0001-91', 6, 79.90, 'Asics', 'Tênis Asics Gel', 'Branco', 'Asics Gel', 'G');

-- Inserção de Endereços de Fornecedores
INSERT INTO enderecoForne (fornecedor_cnpj, uf, cidade, bairro, rua, numero, comp, cep) VALUES
('12.345.678/0001-90', 'SP', 'São Paulo', 'Vila Progredior', 'Rua da Nike', 100, 'Sala 101', '01010-001'),
('98.765.432/0001-01', 'RJ', 'Rio de Janeiro', 'Leblon', 'Av. Atlântica', 200, 'Loja 12', '22021-110'),
('23.456.789/0001-12', 'MG', 'Belo Horizonte', 'Centro', 'Rua das Palmeiras', 300, 'Bloco A', '30130-003'),
('34.567.890/0001-23', 'PR', 'Curitiba', 'Centro', 'Av. Sete de Setembro', 400, 'Loja B', '80010-000'),
('45.678.901/0001-34', 'RS', 'Porto Alegre', 'Cidade Baixa', 'Rua dos Móveis', 500, 'Pavimento 2', '90010-200'),
('56.789.012/0001-45', 'DF', 'Brasília', 'Asa Norte', 'Av. das Nações', 600, 'Andar 3', '70050-100'),
('67.890.123/0001-56', 'SP', 'São Paulo', 'Itaim Bibi', 'Rua da Adidas', 700, 'Loja 3', '04520-001'),
('78.901.234/0001-67', 'MG', 'Belo Horizonte', 'Centro', 'Rua das Palmeiras', 800, 'Bloco B', '30130-004'),
('89.012.345/0001-78', 'RS', 'Porto Alegre', 'Cidade Baixa', 'Rua dos Móveis', 900, 'Pavimento 3', '90010-201'),
('90.123.456/0001-89', 'PR', 'Curitiba', 'Centro', 'Av. Sete de Setembro', 1000, 'Loja C', '80010-001'),
('01.234.567/0001-90', 'RJ', 'Rio de Janeiro', 'Leblon', 'Av. Atlântica', 1100, 'Loja 13', '22021-111'),
('12.345.678/0001-91', 'SP', 'São Paulo', 'Vila Progredior', 'Rua da Nike', 1200, 'Sala 102', '01010-002');

-- Inserção de Estoque
INSERT INTO estoque (id_produto, qtdDisponivel, localizacao) VALUES
(1, 100, 'Depósito 1 - Rua A'),
(2, 50, 'Depósito 2 - Rua B'),
(3, 200, 'Depósito 1 - Rua C'),
(4, 150, 'Depósito 2 - Rua D'),
(5, 30, 'Depósito 1 - Rua E'),
(6, 80, 'Depósito 3 - Rua F'),
(7, 120, 'Depósito 4 - Rua G'),
(8, 60, 'Depósito 5 - Rua H'),
(9, 100, 'Depósito 6 - Rua I'),
(10, 75, 'Depósito 7 - Rua J'),
(11, 50, 'Depósito 8 - Rua K'),
(12, 90, 'Depósito 9 - Rua L');

-- Inserção de Vendas (CPFs de clientes e funcionários corrigidos)
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
('111.111.111-11', '123.234.345-56', '2024-03-25 16:25:00', 810.00, 35.00), -- Usando cliente 111
('222.222.222-22', '234.345.456-67', '2024-03-28 08:55:00', 1100.00, 60.00); -- Usando cliente 222

-- Inserção de Formas de Pagamento
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

-- Inserção de Pedidos (CPFs de clientes corrigidos, status padrão já definido por ALTER TABLE)
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

-- Inserção de Itens de Pedidos (precoUnitario corrigido para ser o preço unitário do produto)
INSERT INTO itemPedidos (id_pedido, id_produto, quantidade, precoUnitario, frete) VALUES
(1, 1, 2, 299.99, 10.00), -- Produto 1 preco 299.99
(2, 2, 1, 1599.00, 15.00), -- Produto 2 preco 1599.00
(3, 3, 5, 99.90, 5.00), -- Produto 3 preco 99.90
(4, 4, 3, 50.00, 7.50), -- Produto 4 preco 50.00
(5, 5, 1, 799.99, 20.00), -- Produto 5 preco 799.99
(6, 6, 4, 69.90, 8.00), -- Produto 6 preco 69.90
(7, 7, 2, 259.99, 12.00), -- Produto 7 preco 259.99
(8, 8, 3, 1999.99, 25.00), -- Produto 8 preco 1999.99
(9, 9, 1, 79.90, 3.00), -- Produto 9 preco 79.90
(10, 10, 2, 129.90, 6.00), -- Produto 10 preco 129.90
(11, 11, 1, 899.99, 18.00), -- Produto 11 preco 899.99
(12, 12, 1, 79.90, 4.00); -- Produto 12 preco 79.90