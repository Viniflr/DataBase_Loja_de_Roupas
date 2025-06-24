USE lojaRoupas;

-- Inserção de Clientes
INSERT INTO clientes (CPF, nome, nomeSocial, dataNasc, sexo, email, telefone, rg) VALUES
('111.111.111-11', 'Lucas Pereira', NULL, '1990-01-15', 'M', 'lucas.pereira@email.com', '(11) 91234-5678', '1111111'),
('222.222.222-22', 'Mariana Costa', 'Mari Costa', '1985-03-22', 'F', 'mariana.costa@email.com', '(21) 99987-6543', '2222222'),
('333.333.333-33', 'Ricardo Alves', NULL, '1988-07-30', 'M', 'ricardo.alves@email.com', '(31) 92345-6789', '3333333'),
('444.444.444-44', 'Fernanda Souza', NULL, '1995-12-10', 'F', 'fernanda.souza@email.com', '(41) 93456-7890', '4444444'),
('555.555.555-55', 'Eduardo Silva', NULL, '1982-06-18', 'M', 'eduardo.silva@email.com', '(51) 94567-8901', '5555555'),
('666.666.666-66', 'Patrícia Lima', 'Pati', '1992-09-03', 'F', 'patricia.lima@email.com', '(11) 95678-9012', '6666666'),
('777.777.777-77', 'André Martins', NULL, '1975-04-25', 'M', 'andre.martins@email.com', '(21) 96789-0123', '7777777'),
('888.888.888-88', 'Camila Rocha', NULL, '1998-11-01', 'F', 'camila.rocha@email.com', '(31) 97890-1234', '8888888'),
('999.999.999-99', 'Thiago Oliveira', NULL, '1980-02-14', 'M', 'thiago.oliveira@email.com', '(41) 98901-2345', '9999999'),
('000.000.000-00', 'Roberta Almeida', NULL, '1993-08-07', 'F', 'roberta.almeida@email.com', '(51) 90123-4567', '0000000');

-- Inserção de Endereços de Clientes
INSERT INTO enderecoCli (clientes_cpf, uf, cidade, bairro, rua, numero, complemento, cep) VALUES
('111.111.111-11', 'SP', 'São Paulo', 'Centro', 'Rua A', 100, 'Apto 101', '01000-000'),
('222.222.222-22', 'RJ', 'Rio de Janeiro', 'Copacabana', 'Av. B', 200, NULL, '22000-000'),
('333.333.333-33', 'MG', 'Belo Horizonte', 'Savassi', 'Rua C', 300, 'Casa', '30000-000'),
('444.444.444-44', 'PR', 'Curitiba', 'Batel', 'Rua D', 400, NULL, '80000-000'),
('555.555.555-55', 'RS', 'Porto Alegre', 'Moinhos de Vento', 'Av. E', 500, 'Sala 505', '90000-000');

-- Inserção de Departamentos
INSERT INTO departamento (nome) VALUES
('Recursos Humanos'),
('Comercial'),
('Marketing'),
('Financeiro'),
('Logística'),
('TI');

-- Inserção de Cargos
INSERT INTO cargo (nomeCargo, descricao) VALUES
('Gerente de Vendas', 'Responsável pela equipe de vendas e metas.'),
('Vendedor', 'Realiza vendas e atendimento ao cliente.'),
('Analista de RH', 'Cuida de processos de recrutamento e pessoal.'),
('Contador', 'Gerencia as finanças da empresa.'),
('Estoquista', 'Organiza e controla o estoque.'),
('Desenvolvedor', 'Desenvolve e mantém sistemas.');

-- Inserção de Planos de Saúde
INSERT INTO planoSaude (nomePlano, cobertura, valor) VALUES
('Básico', 'Consultas e exames básicos', 150.00),
('Standard', 'Cobertura ambulatorial e hospitalar', 300.00),
('Premium', 'Cobertura completa com rede credenciada ampla', 500.00);

-- Inserção de Funcionários
INSERT INTO funcionarios (CPF, nome, nomeSocial, estadoCivil, dataNasc, sexo, email, telefone, salario, cargaHora, comissao, dataAdm, idDepartamento, idCargo, idPlanoSaude) VALUES
('111.222.333-44', 'João Silva', NULL, 'Casado', '1980-01-01', 'M', 'joao.silva@email.com', '(11) 98765-4321', 5000.00, 40, 500.00, '2010-03-10', 2, 1, 2), -- Comercial, Gerente de Vendas
('222.333.444-55', 'Maria Oliveira', 'Maria O.', 'Solteira', '1990-02-02', 'F', 'maria.oliveira@email.com', '(21) 97654-3210', 3500.00, 40, 350.00, '2015-05-20', 2, 2, 1), -- Comercial, Vendedor
('000.111.222-33', 'José Almeida', NULL, 'Casado', '1975-03-03', 'M', 'jose.almeida@email.com', '(31) 96543-2109', 4000.00, 40, NULL, '2012-07-01', 1, 3, 3), -- RH, Analista de RH
('333.444.555-66', 'Ana Paula', NULL, 'Divorciada', '1988-04-04', 'F', 'ana.paula@email.com', '(41) 95432-1098', 4200.00, 40, NULL, '2018-01-15', 4, 4, 2), -- Financeiro, Contador
('444.555.666-77', 'Carlos Rocha', NULL, 'Solteiro', '1992-05-05', 'M', 'carlos.rocha@email.com', '(51) 94321-0987', 2800.00, 40, 280.00, '2017-09-01', 2, 2, 1); -- Comercial, Vendedor

-- Inserção de Endereços de Funcionários
INSERT INTO enderecoFunc (funcionario_cpf, uf, cidade, bairro, rua, numero, comp, cep) VALUES
('111.222.333-44', 'SP', 'São Paulo', 'Morumbi', 'Av. F', 600, 'Apto 606', '05000-000'),
('222.333.444-55', 'RJ', 'Niterói', 'Icaraí', 'Rua G', 700, NULL, '24000-000'),
('000.111.222-33', 'MG', 'Contagem', 'Industrial', 'Av. H', 800, 'Sala 808', '32000-000');

-- Inserção de Dependentes
INSERT INTO dependentes (funcionario_cpf, nome, dataNasc, parentesco, genero) VALUES
('111.222.333-44', 'Filho João', '2005-01-01', 'Filho(a)', 'M'),
('111.222.333-44', 'Filha Maria', '2008-03-15', 'Filho(a)', 'F'),
('222.333.444-55', 'Mãe Maria', '1960-07-20', 'Mãe', 'F');

-- Inserção de Férias
INSERT INTO ferias (funcionario_cpf, dataInicio, dataFim) VALUES
('111.222.333-44', '2024-07-01', '2024-07-30'),
('222.333.444-55', '2025-01-10', '2025-01-25');

-- Inserção de Fornecedores
INSERT INTO fornecedor (CNPJ, razaoSocial, email, telefone) VALUES
('00.000.000/0001-00', 'Nike Brasil', 'contato@nike.com.br', '(11) 1111-1111'),
('11.111.111/0001-11', 'Adidas do Brasil', 'sac@adidas.com.br', '(11) 2222-2222'),
('22.222.222/0001-22', 'Puma Brasil', 'faleconosco@puma.com.br', '(11) 3333-3333');

-- Inserção de Endereços de Fornecedores
INSERT INTO enderecoForne (fornecedor_cnpj, uf, cidade, bairro, rua, numero, comp, cep) VALUES
('00.000.000/0001-00', 'SP', 'São Paulo', 'Barra Funda', 'Av. M', 1000, NULL, '01100-000'),
('11.111.111/0001-11', 'SP', 'Osasco', 'Centro', 'Rua N', 1100, NULL, '06000-000');

-- Inserção de Categorias de Produtos
INSERT INTO categProduto (nomeCateg, descricao) VALUES
('Calçados', 'Tênis, sapatos, sandálias, etc.'),
('Roupas Masculinas', 'Camisetas, calças, bermudas para homens.'),
('Roupas Femininas', 'Vestidos, saias, blusas para mulheres.'),
('Acessórios', 'Bonés, meias, mochilas, etc.');

-- Inserção de Produtos
INSERT INTO produto (id_fornecedor, id_categoria, preco, marca, descricao, cor, nomeProduto, tamanho) VALUES
('00.000.000/0001-00', 1, 299.99, 'Nike', 'Tênis de corrida masculino', 'Preto', 'Air Max 270', '42'),
('11.111.111/0001-11', 1, 1599.00, 'Adidas', 'Tênis de basquete unissex', 'Branco', 'Dame 8', '43'),
('00.000.000/0001-00', 2, 99.90, 'Nike', 'Camiseta esportiva', 'Azul', 'Dry-Fit Tee', 'M'),
('22.222.222/0001-22', 3, 50.00, 'Puma', 'Top fitness feminino', 'Rosa', 'Fitness Bra', 'P'),
('11.111.111/0001-11', 2, 799.99, 'Adidas', 'Jaqueta corta-vento', 'Preto', 'Essentials Windbreaker', 'G'),
('00.000.000/0001-00', 4, 69.90, 'Nike', 'Boné esportivo', 'Vermelho', 'Heritage Cap', 'Único');

-- Inserção de Estoque (CORRIGIDO)
INSERT INTO estoque (id_produto, qtdDisponivel, localizacao) VALUES
(1, 100, 'Corredor A, Prateleira 1'), -- Usando Produto 1
(2, 50, 'Corredor B, Prateleira 2'),  -- Usando Produto 2
(3, 200, 'Corredor C, Prateleira 3'), -- Usando Produto 3
(4, 150, 'Corredor D, Prateleira 4'), -- Usando Produto 4
(5, 75, 'Corredor E, Prateleira 5');  -- Usando Produto 5


-- Inserção de Formas de Pagamento (Conforme o novo SCHEMA.sql)
INSERT INTO formaPag (tipo) VALUES
('Cartão de Crédito'),
('Cartão de Débito'),
('Pix'),
('Boleto'),
('Dinheiro');

-- Inserção de Vendas (Agora com id_formaPag)
INSERT INTO vendas (clientes_cpf, funcionario_cpf, id_formaPag, dataVenda, valorTotal) VALUES
('111.111.111-11', '111.222.333-44', 1, '2025-04-20 10:00:00', 599.98), 
('222.222.222-22', '222.333.444-55', 2, '2025-04-21 11:30:00', 1599.00), 
('333.333.333-33', '111.222.333-44', 3, '2025-04-22 14:00:00', 499.50), 
('444.444.444-44', '222.333.444-55', 1, '2025-04-23 16:45:00', 150.00), 
('555.555.555-55', '111.222.333-44', 4, '2025-04-24 09:15:00', 799.99), 
('666.666.666-66', '222.333.444-55', 5, '2025-04-25 10:30:00', 279.60); 

-- Inserção de Pedidos (statusPedido já com default 'Pendente' pelo ALTER TABLE, valorTotal preenchido por trigger)
INSERT INTO pedidos (clientes_cpf, dataPedido, statusPedido) VALUES
('000.000.000-00', '2025-04-29 10:45:00', 'Aguardando envio'), -- idPedidos = 1
('111.111.111-11', '2025-04-29 10:50:00', 'Enviado'),           -- idPedidos = 2
('222.222.222-22', '2025-04-29 10:55:00', 'Aprovado'),          -- idPedidos = 3
('333.333.333-33', '2025-04-30 10:00:00', 'Pendente'),          -- idPedidos = 4 <<-- ADICIONADO
('444.444.444-44', '2025-04-30 11:00:00', 'Processando'),       -- idPedidos = 5 <<-- ADICIONADO
('555.555.555-55', '2025-04-30 12:00:00', 'Pendente');          -- idPedidos = 6 <<-- ADICIONADO

-- Inserção de Itens de Pedidos (agora os id_pedido 1-6 existem)
INSERT INTO itemPedidos (id_pedido, id_produto, quantidade, precoUnitario, frete) VALUES
(1, 1, 2, 299.99, 10.00),
(2, 2, 1, 1599.00, 15.00),
(3, 3, 5, 99.90, 5.00),
(4, 4, 3, 50.00, 7.50),
(5, 5, 1, 799.99, 20.00),
(6, 6, 4, 69.90, 8.00);
