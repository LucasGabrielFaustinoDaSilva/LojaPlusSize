-- =============================================
-- BELLA PLUS - BANCO DE DADOS COMPLETO
-- =============================================

-- Criar Banco de Dados
CREATE DATABASE IF NOT EXISTS LojaPlusSize;
USE LojaPlusSize;

-- =============================================
-- TABELAS
-- =============================================

-- Tabela de Categorias
CREATE TABLE IF NOT EXISTS Categorias (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Descricao TEXT,
    DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Produtos
CREATE TABLE IF NOT EXISTS Produtos (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(200) NOT NULL,
    Descricao TEXT,
    Preco DECIMAL(10,2) NOT NULL,
    TamanhosDisponiveis VARCHAR(100) NOT NULL,
    CategoriaId INT,
    ImagemUrl VARCHAR(500),
    EmEstoque BOOLEAN DEFAULT TRUE,
    DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CategoriaId) REFERENCES Categorias(Id)
);

-- Tabela de Clientes
CREATE TABLE IF NOT EXISTS Clientes (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(200) NOT NULL,
    Email VARCHAR(200) UNIQUE NOT NULL,
    Telefone VARCHAR(20),
    DataNascimento DATE,
    DataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Pedidos
CREATE TABLE IF NOT EXISTS Pedidos (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    ClienteId INT,
    DataPedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status ENUM('Pendente', 'Processando', 'Enviado', 'Entregue') DEFAULT 'Pendente',
    Total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (ClienteId) REFERENCES Clientes(Id)
);

-- =============================================
-- DADOS DE EXEMPLO
-- =============================================

-- Inserir Categorias
INSERT INTO Categorias (Nome, Descricao) VALUES
('Vestidos', 'Vestidos elegantes e casuais para todos os momentos'),
('Blusas', 'Blusas confortáveis e estilosas para o dia a dia'),
('Calças', 'Calças que valorizam o corpo com conforto'),
('Saias', 'Saias modernas e confortáveis'),
('Conjuntos', 'Conjuntos prontos para looks completos');

-- Inserir Produtos
INSERT INTO Produtos (Nome, Descricao, Preco, TamanhosDisponiveis, CategoriaId, ImagemUrl) VALUES
('Vestido Floral Plus Size', 'Vestido com estampa floral, ideal para verão e ocasiões especiais', 89.90, '44,46,48,50', 1, 'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=500&h=500&fit=crop'),
('Blusa Manga Curta Comfort', 'Blusa em malha confortável para o dia a dia, com caimento perfeito', 49.90, '42,44,46,48,50', 2, 'https://images.unsplash.com/photo-1581044777550-4cfa60707c03?w=500&h=500&fit=crop'),
('Calça Jeans Elástica', 'Calça jeans com elastano para maior conforto e mobilidade', 119.90, '44,46,48,50,52', 3, 'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=500&h=500&fit=crop'),
('Saia Evasê Plus Size', 'Saia evasê em tecido fluido, perfeita para compor looks elegantes', 69.90, '42,44,46,48', 4, 'https://images.unsplash.com/photo-1583496661160-fb5886a13d77?w=500&h=500&fit=crop'),
('Vestido Midi Elegante', 'Vestido midi perfeito para ocasiões especiais e eventos', 129.90, '46,48,50,52', 1, 'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=500&h=500&fit=crop'),
('Blusa Tricot Conforto', 'Blusa em tricot super confortável para os dias mais frios', 79.90, '44,46,48,50', 2, 'https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=500&h=500&fit=crop'),
('Calça Wide Leg', 'Calça wide leg da moda, super estilosa e confortável', 139.90, '44,46,48,50,52', 3, 'https://images.unsplash.com/photo-1582418702059-97ebafb35d09?w=500&h=500&fit=crop'),
('Conjunto Camiseta e Saia', 'Conjunto prático e moderno para looks do dia a dia', 159.90, '42,44,46,48,50', 5, 'https://images.unsplash.com/photo-1594633312681-425c7b97ccd1?w=500&h=500&fit=crop');

-- Inserir Clientes Exemplo
INSERT INTO Clientes (Nome, Email, Telefone, DataNascimento) VALUES
('Maria Silva', 'maria.silva@email.com', '(11) 99999-9999', '1985-03-15'),
('Ana Santos', 'ana.santos@email.com', '(11) 98888-8888', '1990-07-22'),
('Carla Oliveira', 'carla.oliveira@email.com', '(11) 97777-7777', '1988-11-30');

-- =============================================
-- CONSULTAS ÚTEIS
-- =============================================

-- Consulta para ver todos os produtos com suas categorias
SELECT 
    p.Id,
    p.Nome AS Produto,
    p.Preco,
    p.TamanhosDisponiveis,
    c.Nome AS Categoria,
    p.EmEstoque
FROM Produtos p
LEFT JOIN Categorias c ON p.CategoriaId = c.Id
ORDER BY p.DataCriacao DESC;

-- Consulta para produtos em estoque
SELECT 
    Nome,
    Preco,
    TamanhosDisponiveis
FROM Produtos 
WHERE EmEstoque = TRUE
ORDER BY Preco ASC;

-- Consulta para produtos por categoria
SELECT 
    c.Nome AS Categoria,
    COUNT(p.Id) AS TotalProdutos,
    AVG(p.Preco) AS PrecoMedio
FROM Categorias c
LEFT JOIN Produtos p ON c.Id = p.CategoriaId
GROUP BY c.Id, c.Nome;

-- =============================================
-- BACKUP E MANUTENÇÃO
-- =============================================

-- Comando para fazer backup (executar no terminal MySQL)
-- mysqldump -u root -p LojaPlusSize > backup_loja_plus_size.sql

-- Comando para restaurar backup
-- mysql -u root -p LojaPlusSize < backup_loja_plus_size.sql

-- Verificar tamanho das tabelas
SELECT 
    TABLE_NAME AS 'Tabela',
    TABLE_ROWS AS 'Registros',
    ROUND(DATA_LENGTH/1024/1024, 2) AS 'Tamanho (MB)'
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = 'LojaPlusSize'
ORDER BY DATA_LENGTH DESC;