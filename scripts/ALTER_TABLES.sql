USE lojaRoupas;

-- 1. Adiciona coluna 'rg' na tabela clientes
ALTER TABLE clientes ADD COLUMN rg VARCHAR(12);

-- 2. Altera tipo da coluna 'telefone' em funcionarios para VARCHAR(20);
ALTER TABLE funcionarios MODIFY COLUMN telefone VARCHAR(20);

-- 3. Adiciona uma nova coluna 'genero' na tabela dependentes
ALTER TABLE dependentes ADD COLUMN genero CHAR(1);

-- 4. Renomeia a coluna 'comp' da tabela enderecoCli para complemento
ALTER TABLE enderecoCli CHANGE COLUMN comp complemento VARCHAR(45);

-- 5. Define 'email' de fornecedores como único
ALTER TABLE fornecedor ADD CONSTRAINT fornecedor_email_unico UNIQUE (email);

-- 6. Adiciona coluna 'observacoes' em planoSaude
ALTER TABLE planoSaude ADD COLUMN observacoes TEXT;

-- 8. Define valor padrão para 'statusPedido' na tabela pedidos
ALTER TABLE pedidos MODIFY COLUMN statusPedido VARCHAR(45) DEFAULT 'Pendente';

-- 9. Adiciona foreign key do departamento em funcionarios
ALTER TABLE funcionarios ADD CONSTRAINT fk_func_dep FOREIGN KEY (idDepartamento) REFERENCES departamento(idDepartamento);

-- 10. Altera nome da coluna 'nomeForne' para 'razaoSocial'
ALTER TABLE fornecedor CHANGE COLUMN nomeForne razaoSocial VARCHAR(60);

-- 11. Adiciona índice para 'dataVenda' em vendas
ALTER TABLE vendas ADD INDEX idx_dataVenda (dataVenda);

-- 12. Aumenta limite do campo 'descricao' em produto
ALTER TABLE produto MODIFY COLUMN descricao VARCHAR(255);

-- 13. Torna 'comissao' opcional em funcionarios
ALTER TABLE funcionarios MODIFY COLUMN comissao DECIMAL(6,2) NULL;

-- 15. Altera tipo da coluna 'tamanho' para VARCHAR(5) em produto
ALTER TABLE produto MODIFY COLUMN tamanho VARCHAR(5);