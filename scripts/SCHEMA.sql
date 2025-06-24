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
    comp VARCHAR(45),
    cep VARCHAR(9) NOT NULL,
    FOREIGN KEY (clientes_cpf) REFERENCES clientes(CPF) ON DELETE CASCADE
);

-- --------------------------------------------------------------------------------
-- Tabelas de Funcionários
CREATE TABLE departamento (
    idDepartamento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE cargo (
    idCargo INT AUTO_INCREMENT PRIMARY KEY,
    nomeCargo VARCHAR(60) NOT NULL UNIQUE,
    descricao VARCHAR(255)
);

CREATE TABLE planoSaude (
    idPlano INT AUTO_INCREMENT PRIMARY KEY,
    nomePlano VARCHAR(60) NOT NULL,
    cobertura TEXT,
    valor DECIMAL(10,2)
);

CREATE TABLE funcionarios (
    CPF VARCHAR(14) NOT NULL PRIMARY KEY,
    nome VARCHAR(60) NOT NULL,
    nomeSocial VARCHAR(60),
    estadoCivil VARCHAR(20),
    dataNasc DATE NOT NULL,
    sexo CHAR(1) NOT NULL,
    email VARCHAR(60) NOT NULL UNIQUE,
    telefone VARCHAR(15) NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    cargaHora INT NOT NULL,
    comissao DECIMAL(6,2),
    dataAdm DATE NOT NULL,
    dataDem DATE,
    idDepartamento INT,
    idCargo INT,
    idPlanoSaude INT,
    FOREIGN KEY (idDepartamento) REFERENCES departamento(idDepartamento),
    FOREIGN KEY (idCargo) REFERENCES cargo(idCargo),
    FOREIGN KEY (idPlanoSaude) REFERENCES planoSaude(idPlano)
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

CREATE TABLE dependentes (
    idDependente INT AUTO_INCREMENT PRIMARY KEY,
    funcionario_cpf VARCHAR(14) NOT NULL,
    nome VARCHAR(60) NOT NULL,
    dataNasc DATE NOT NULL,
    parentesco VARCHAR(45),
    FOREIGN KEY (funcionario_cpf) REFERENCES funcionarios(CPF) ON DELETE CASCADE
);

CREATE TABLE ferias (
    idFerias INT AUTO_INCREMENT PRIMARY KEY,
    funcionario_cpf VARCHAR(14) NOT NULL,
    dataInicio DATE NOT NULL,
    dataFim DATE NOT NULL,
    FOREIGN KEY (funcionario_cpf) REFERENCES funcionarios(CPF) ON DELETE CASCADE
);

-- --------------------------------------------------------------------------------
-- Tabelas de Produtos e Fornecedores
CREATE TABLE fornecedor (
    CNPJ VARCHAR(18) NOT NULL PRIMARY KEY,
    nomeForne VARCHAR(60) NOT NULL,
    email VARCHAR(60) NOT NULL,
    telefone VARCHAR(15) NOT NULL
);

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

CREATE TABLE categProduto (
    idCategoria INT AUTO_INCREMENT PRIMARY KEY,
    nomeCateg VARCHAR(60) NOT NULL UNIQUE,
    descricao TEXT
);

CREATE TABLE produto (
    idProduto INT AUTO_INCREMENT PRIMARY KEY,
    id_fornecedor VARCHAR(18) NOT NULL,
    id_categoria INT NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    marca VARCHAR(45) NOT NULL,
    descricao VARCHAR(150),
    cor VARCHAR(45),
    nomeProduto VARCHAR(60) NOT NULL,
    tamanho VARCHAR(45),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(CNPJ) ON DELETE CASCADE,
    FOREIGN KEY (id_categoria) REFERENCES categProduto(idCategoria) ON DELETE CASCADE
);

-- --------------------------------------------------------------------------------
-- Tabelas de Vendas
CREATE TABLE formaPag (
    idFormaPag INT AUTO_INCREMENT PRIMARY KEY, -- Adicionado PK
    tipo VARCHAR(45) NOT NULL UNIQUE
);

CREATE TABLE vendas (
    idVendas INT AUTO_INCREMENT PRIMARY KEY,
    clientes_cpf VARCHAR(14) NOT NULL,
    funcionario_cpf VARCHAR(14) NOT NULL,
    id_formaPag INT NOT NULL, -- Adicionada FK para formaPag
    dataVenda DATETIME NOT NULL,
    valorTotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (clientes_cpf) REFERENCES clientes(CPF) ON DELETE CASCADE,
    FOREIGN KEY (funcionario_cpf) REFERENCES funcionarios(CPF) ON DELETE CASCADE,
    FOREIGN KEY (id_formaPag) REFERENCES formaPag(idFormaPag) -- FK para formaPag
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
    valorTotal DECIMAL(10,2), -- Adicionado aqui, será preenchido por trigger
    FOREIGN KEY (clientes_cpf) REFERENCES clientes(CPF) ON DELETE CASCADE
);

CREATE TABLE itemPedidos (
    idItemPedidos INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    precoUnitario DECIMAL(10,2) NOT NULL,
    frete DECIMAL(6,2) DEFAULT 0, -- Adicionado frete aqui para consistência com ALTER_TABLES
    FOREIGN KEY (id_pedido) REFERENCES pedidos(idPedidos) ON DELETE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES produto(idProduto) ON DELETE CASCADE
);

-- --------------------------------------------------------------------------------
-- Tabela de Log de Estoque Baixo (Movida para SCHEMA.sql)
CREATE TABLE IF NOT EXISTS logEstoqueBaixo (
    idLog INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT NOT NULL,
    nomeProduto VARCHAR(60) NOT NULL,
    qtdAtual BIGINT NOT NULL,
    limiteEstoque INT NOT NULL,
    dataHoraLog DATETIME DEFAULT CURRENT_TIMESTAMP,
    mensagem TEXT
);

-- Restaura as configurações de integridade
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;