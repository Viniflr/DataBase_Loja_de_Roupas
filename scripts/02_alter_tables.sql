USE lojaRoupas;

-- 1. Adiciona coluna 'rg' na tabela clientes
ALTER TABLE clientes ADD rg VARCHAR(12);

-- 2. Altera tipo da coluna 'telefone' em funcionarios para VARCHAR(20)
ALTER TABLE funcionarios MODIFY telefone VARCHAR(20);

-- 3. Adiciona uma nova coluna 'genero' na tabela dependentes
ALTER TABLE dependentes ADD genero CHAR(1);

-- 4. Renomeia a coluna 'comp' da tabela enderecoCli para complemento
ALTER TABLE enderecoCli CHANGE comp complemento VARCHAR(45);

-- 5. Define 'email' de fornecedores como único
ALTER TABLE fornecedor ADD CONSTRAINT fornecedor_email_unico UNIQUE (email);

-- 6. Adiciona coluna 'observacoes' em planoSaude
ALTER TABLE planoSaude ADD observacoes TEXT;

-- 7. Define valor padrão para 'statusPedido' na tabela pedidos
ALTER TABLE pedidos MODIFY statusPedido VARCHAR(45) DEFAULT 'Pendente';

-- 8. Adiciona foreign key do departamento em funcionarios
ALTER TABLE funcionarios ADD idDepartamento INT;
ALTER TABLE funcionarios ADD FOREIGN KEY (idDepartamento) REFERENCES departamento(idDepartamento);

-- 9. Cria a foreign key entre funcionarios e departamento
ALTER TABLE funcionarios ADD CONSTRAINT fk_func_dep FOREIGN KEY (idDepartamento) REFERENCES departamento(idDepartamento);

-- 10. Altera nome da coluna 'nomeForne' para 'razaoSocial'
ALTER TABLE fornecedor CHANGE nomeForne razaoSocial VARCHAR(60);

-- 11. Adiciona índice para 'dataVenda' em vendas
ALTER TABLE vendas ADD INDEX idx_dataVenda (dataVenda);

-- 12. Aumenta limite do campo 'descricao' em produto
ALTER TABLE produto MODIFY descricao VARCHAR(255);

-- 13. Torna 'comissao' opcional em funcionarios
ALTER TABLE funcionarios MODIFY comissao DECIMAL(6,2) NULL;

-- 14. Adiciona coluna 'frete' na tabela itemPedidos
ALTER TABLE itemPedidos ADD frete DECIMAL(6,2) DEFAULT 0;

-- 15. Altera tipo da coluna 'tamanho' para VARCHAR(5) em produto
ALTER TABLE produto MODIFY tamanho VARCHAR(5);

-- 16. Aletrar YEAR
ALTER TABLE ferias MODIFY anoRef YEAR;


ALTER TABLE cargo MODIFY COLUMN funcionario_cpf VARCHAR(14) NULL;

-- Remover a foreign key existente
ALTER TABLE cargo DROP FOREIGN KEY cargo_ibfk_1;

-- Modificar a tabela cargo
ALTER TABLE cargo DROP COLUMN funcionario_cpf;