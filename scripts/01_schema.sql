-- Define o esquema do banco de dados
CREATE SCHEMA IF NOT EXISTS lojaRoupas;
USE lojaRoupas;

-- Configurações para desabilitar verificações de integridade temporariamente
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- --------------------------------------------------------------------------------
-- Tabelas de Clientes
CREATE TABLE clientes (
    CPF VARCHAR(14) NOT NULL PRIMARY KEY,
    nome VARCHAR(60) NOT NULL,
    nomeSocial VARCHAR(60),
    dataNasc DATE NOT NULL,
    sexo CHAR(1) NOT NULL,
    email VARCHAR(60) NOT NULL,
    telefone VARCHAR(15) NOT NULL
);

CREATE TABLE enderecoCli (
    idEnderecoCli INT AUTO_INCREMENT PRIMARY KEY,
    clientes_cpf VARCHAR(14) NOT NULL,
    uf CHAR(2) NOT NULL,
    cidade VARCHAR(60) NOT NULL,
    bairro VARCHAR(60) NOT NULL,
    rua VARCHAR(80) NOT NULL,
    numero INT NOT NULL,
    comp VARCHAR(45), -- Mantido 'comp' aqui, será renomeado via ALTER TABLE
    cep VARCHAR(9) NOT NULL,
    FOREIGN KEY (clientes_cpf) REFERENCES clientes(CPF) ON DELETE CASCADE
);

-- --------------------------------------------------------------------------------
-- Tabelas de Funcionários
CREATE TABLE funcionarios (
    CPF VARCHAR(14) NOT NULL PRIMARY KEY,
    nome VARCHAR(60) NOT NULL,
    nomeSocial VARCHAR(60),
    estadoCivil VARCHAR(30) NOT NULL,
    dataNasc DATE NOT NULL,
    sexo CHAR(1) NOT NULL,
    email VARCHAR(60) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    cargaHora INT NOT NULL,
    comissao DECIMAL(6,2) NOT NULL,
    dataAdm DATETIME NOT NULL,
    dataDem DATETIME,
    idDepartamento INT -- Adicionado aqui para ser populado no INSERT
);

CREATE TABLE enderecoFunc (
    idEnderecoFunc INT AUTO_INCREMENT PRIMARY KEY,
    funcionario_cpf VARCHAR(14) NOT NULL,
    uf CHAR(2) NOT NULL,
    cidade VARCHAR(60) NOT NULL,
    bairro VARCHAR(60) NOT NULL,
    rua VARCHAR(80) NOT NULL,
    numero INT NOT NULL,
    comp VARCHAR(45),
    cep VARCHAR(9) NOT NULL,
    FOREIGN KEY (funcionario_cpf) REFERENCES funcionarios(CPF) ON DELETE CASCADE
);

CREATE TABLE ferias (
    idFerias INT AUTO_INCREMENT PRIMARY KEY,
    funcionario_cpf VARCHAR(14) NOT NULL,
    qtdDias INT NOT NULL,
    anoRef YEAR NOT NULL,
    dataInicio DATE NOT NULL,
    dataFim DATE NOT NULL,
    FOREIGN KEY (funcionario_cpf) REFERENCES funcionarios(CPF) ON DELETE CASCADE
);

CREATE TABLE dependentes (
    CPF VARCHAR(14) NOT NULL PRIMARY KEY,
    funcionario_cpf VARCHAR(14) NOT NULL,
    nome VARCHAR(60) NOT NULL,
    dataNasc DATE NOT NULL,
    parentesco VARCHAR(20) NOT NULL,
    FOREIGN KEY (funcionario_cpf) REFERENCES funcionarios(CPF) ON DELETE CASCADE
);

-- --------------------------------------------------------------------------------
-- Departamento e Cargo
CREATE TABLE departamento (
    idDepartamento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    email VARCHAR(60) NOT NULL,
    respDepartamento VARCHAR(60) NOT NULL,
    cpfGerente VARCHAR(14),
    FOREIGN KEY (cpfGerente) REFERENCES funcionarios(CPF) ON DELETE SET NULL -- Gerente pode ser removido, mas o departamento fica
);

CREATE TABLE cargo (
    cbo INT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    faixaSalarial DECIMAL(10,2) NOT NULL
);

-- --------------------------------------------------------------------------------
-- Plano de Saúde
CREATE TABLE planoSaude (
    idPlanoSaude INT AUTO_INCREMENT PRIMARY KEY,
    funcionario_cpf VARCHAR(14) NOT NULL,
    numero VARCHAR(45) NOT NULL,
    nome VARCHAR(60) NOT NULL,
    FOREIGN KEY (funcionario_cpf) REFERENCES funcionarios(CPF) ON DELETE CASCADE
);

-- --------------------------------------------------------------------------------
-- Vendas
CREATE TABLE vendas (
    idVendas INT AUTO_INCREMENT PRIMARY KEY,
    clientes_cpf VARCHAR(14) NOT NULL,
    funcionario_cpf VARCHAR(14) NOT NULL,
    dataVenda DATETIME NOT NULL,
    valorTotal DECIMAL(10,2) NOT NULL,
    desconto DECIMAL(5,2),
    FOREIGN KEY (clientes_cpf) REFERENCES clientes(CPF) ON DELETE CASCADE,
    FOREIGN KEY (funcionario_cpf) REFERENCES funcionarios(CPF) ON DELETE CASCADE
);

CREATE TABLE formaPag (
    idFormaPag INT AUTO_INCREMENT PRIMARY KEY,
    id_vendas INT NOT NULL,
    valorPago DECIMAL(10,2) NOT NULL,
    tipo VARCHAR(45) NOT NULL,
    parcela INT,
    FOREIGN KEY (id_vendas) REFERENCES vendas(idVendas) ON DELETE CASCADE
);

-- --------------------------------------------------------------------------------
-- Produto, Categoria e Fornecedor
CREATE TABLE categProduto (
    idCategoria INT AUTO_INCREMENT PRIMARY KEY,
    nomeCateg VARCHAR(45) NOT NULL,
    descricao VARCHAR(100) NOT NULL
);

CREATE TABLE fornecedor (
    CNPJ VARCHAR(18) NOT NULL PRIMARY KEY,
    email VARCHAR(60) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    nomeForne VARCHAR(60) NOT NULL -- Mantido 'nomeForne' aqui, será renomeado via ALTER TABLE
);

CREATE TABLE produto (
    idProduto INT AUTO_INCREMENT PRIMARY KEY,
    id_fornecedor VARCHAR(18) NOT NULL,
    id_categoria INT NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    marca VARCHAR(45),
    descricao VARCHAR(100) NOT NULL,
    cor VARCHAR(45) NOT NULL,
    nomeProduto VARCHAR(60) NOT NULL,
    tamanho CHAR(3) NOT NULL,
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(CNPJ),
    FOREIGN KEY (id_categoria) REFERENCES categProduto(idCategoria)
);

-- --------------------------------------------------------------------------------
-- Endereço Fornecedor
CREATE TABLE enderecoForne (
    idEnderecoForne INT AUTO_INCREMENT PRIMARY KEY,
    fornecedor_cnpj VARCHAR(18) NOT NULL,
    uf CHAR(2) NOT NULL,
    cidade VARCHAR(60) NOT NULL,
    bairro VARCHAR(60) NOT NULL,
    rua VARCHAR(80) NOT NULL,
    numero INT NOT NULL,
    comp VARCHAR(45),
    cep VARCHAR(9) NOT NULL,
    FOREIGN KEY (fornecedor_cnpj) REFERENCES fornecedor(CNPJ) ON DELETE CASCADE
);

-- --------------------------------------------------------------------------------
-- Estoque
CREATE TABLE estoque (
    idEstoque INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT NOT NULL,
    qtdDisponivel BIGINT NOT NULL,
    localizacao VARCHAR(60) NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES produto(idProduto) ON DELETE CASCADE
);

-- --------------------------------------------------------------------------------
-- Pedidos e Itens dos Pedidos
CREATE TABLE pedidos (
    idPedidos INT AUTO_INCREMENT PRIMARY KEY,
    clientes_cpf VARCHAR(14) NOT NULL,
    dataPedido DATETIME NOT NULL,
    statusPedido VARCHAR(45) NOT NULL,
    FOREIGN KEY (clientes_cpf) REFERENCES clientes(CPF) ON DELETE CASCADE
);

CREATE TABLE itemPedidos (
    idItemPedidos INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    precoUnitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(idPedidos) ON DELETE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES produto(idProduto) ON DELETE CASCADE
);

-- Restaura as configurações de integridade
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;