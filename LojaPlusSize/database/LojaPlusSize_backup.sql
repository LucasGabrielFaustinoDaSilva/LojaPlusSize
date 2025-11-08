-- =============================================
-- LOJAPLUSSIZE - BACKUP COM PÁGINA COLEÇÃO
-- =============================================

DROP DATABASE IF EXISTS LojaPlusSize;
CREATE DATABASE LojaPlusSize;
USE LojaPlusSize;

-- =============================================
-- TABELAS
-- =============================================

CREATE TABLE Categorias (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao TEXT,
    ImagemUrl VARCHAR(255),
    DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    Ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE Produtos (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(200) NOT NULL,
    Descricao TEXT,
    ImagemUrl VARCHAR(255),
    Preco DECIMAL(10,2) NOT NULL,
    PrecoPromocional DECIMAL(10,2),
    CategoriaId INT,
    TamanhosDisponiveis VARCHAR(100),
    Material VARCHAR(100),
    Cor VARCHAR(50),
    Destaque BOOLEAN DEFAULT FALSE,
    EmEstoque BOOLEAN DEFAULT TRUE,
    Ativo BOOLEAN DEFAULT TRUE,
    DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    DataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (CategoriaId) REFERENCES Categorias(Id)
);

CREATE TABLE ProdutoImagens (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    ProdutoId INT NOT NULL,
    ImagemUrl VARCHAR(255) NOT NULL,
    ImagemPrincipal BOOLEAN DEFAULT FALSE,
    Ordem INT DEFAULT 0,
    DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProdutoId) REFERENCES Produtos(Id) ON DELETE CASCADE,
    UNIQUE KEY unique_imagem_produto (ProdutoId, ImagemUrl)
);

CREATE TABLE Estoque (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    ProdutoId INT NOT NULL,
    Tamanho VARCHAR(10) NOT NULL,
    Quantidade INT DEFAULT 0,
    DataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ProdutoId) REFERENCES Produtos(Id) ON DELETE CASCADE,
    UNIQUE KEY unique_produto_tamanho (ProdutoId, Tamanho)
);

-- =============================================
-- DADOS - CATEGORIAS
-- =============================================
INSERT INTO Categorias (Nome, Descricao, ImagemUrl) VALUES
('Vestidos', 'Looks perfeitos para momentos especiais', '/images/categorias/vestidos.jpg'),
('Blusas', 'Conforto e estilo para o dia a dia', '/images/categorias/blusas.jpg'),
('Calças', 'Modelos que valorizam seu corpo', '/images/categorias/calcas.jpg'),
('Saias', 'Elegância e movimento em cada passo', '/images/categorias/saias.jpg'),
('Conjuntos', 'Produções completas e práticas', '/images/categorias/conjuntos.jpg');

-- =============================================
-- DADOS - PRODUTOS (DESCRIÇÕES SIMPLES)
-- =============================================
INSERT INTO Produtos (Nome, Descricao, ImagemUrl, Preco, PrecoPromocional, CategoriaId, TamanhosDisponiveis, Material, Cor, Destaque, EmEstoque) VALUES
('Vestido Floral', 'Perfeito para eventos e ocasiões especiais', '/images/produtos/vestido-floral-1.jpg', 129.90, 99.90, 1, '44,46,48,50', 'Viscose', 'Floral', TRUE, TRUE),
('Blusa Básica', 'Essencial para compor looks do cotidiano', '/images/produtos/blusa-basica-1.jpg', 49.90, 39.90, 2, '44,46,48,50,52', 'Algodão', 'Preto', FALSE, TRUE),
('Calça Jeans', 'Conforto e estilo para o dia a dia', '/images/produtos/calca-jeans-1.jpg', 89.90, NULL, 3, '44,46,48,50', 'Jeans', 'Azul', TRUE, TRUE),
('Saia Plissada', 'Elegância e movimento para seus momentos', '/images/produtos/saia-plissada-1.jpg', 79.90, 69.90, 4, '44,46,48,50', 'Poliéster', 'Preto', FALSE, TRUE),
('Conjunto Verão', 'Praticidade e conforto para dias quentes', '/images/produtos/conjunto-casual-1.jpg', 119.90, 99.90, 5, '44,46,48,50,52', 'Algodão', 'Branco', TRUE, TRUE),
('Vestido Midi', 'Sofisticação para ocasiões especiais', '/images/produtos/vestido-midi-1.jpg', 139.90, 119.90, 1, '46,48,50,52', 'Cetim', 'Vermelho', TRUE, TRUE),
('Blusa Manga Longa', 'Conforto para os dias mais amenos', '/images/produtos/blusa-manga-longa-1.jpg', 59.90, 49.90, 2, '44,46,48,50', 'Malha', 'Cinza', FALSE, TRUE);

-- =============================================
-- DADOS - IMAGENS ADICIONAIS (PARA A COLEÇÃO)
-- =============================================
INSERT INTO ProdutoImagens (ProdutoId, ImagemUrl, ImagemPrincipal, Ordem) VALUES
-- Vestido Floral
(1, '/images/produtos/vestido-floral-1.jpg', TRUE, 1),
(1, '/images/produtos/vestido-floral-2.jpg', FALSE, 2),
(1, '/images/produtos/vestido-floral-3.jpg', FALSE, 3),

-- Blusa Básica
(2, '/images/produtos/blusa-basica-1.jpg', TRUE, 1),
(2, '/images/produtos/blusa-basica-2.jpg', FALSE, 2),

-- Calça Jeans
(3, '/images/produtos/calca-jeans-1.jpg', TRUE, 1),
(3, '/images/produtos/calca-jeans-2.jpg', FALSE, 2),
(3, '/images/produtos/calca-jeans-3.jpg', FALSE, 3),

-- Saia Plissada
(4, '/images/produtos/saia-plissada-1.jpg', TRUE, 1),
(4, '/images/produtos/saia-plissada-2.jpg', FALSE, 2),

-- Conjunto Verão
(5, '/images/produtos/conjunto-casual-1.jpg', TRUE, 1),
(5, '/images/produtos/conjunto-casual-2.jpg', FALSE, 2),
(5, '/images/produtos/conjunto-casual-3.jpg', FALSE, 3),

-- Vestido Midi
(6, '/images/produtos/vestido-midi-1.jpg', TRUE, 1),
(6, '/images/produtos/vestido-midi-2.jpg', FALSE, 2),

-- Blusa Manga Longa
(7, '/images/produtos/blusa-manga-longa-1.jpg', TRUE, 1),
(7, '/images/produtos/blusa-manga-longa-2.jpg', FALSE, 2);

-- =============================================
-- DADOS - ESTOQUE
-- =============================================
INSERT INTO Estoque (ProdutoId, Tamanho, Quantidade) VALUES
(1, '44', 15), (1, '46', 20), (1, '48', 18), (1, '50', 12),
(2, '44', 25), (2, '46', 30), (2, '48', 22), (2, '50', 18), (2, '52', 15),
(3, '44', 10), (3, '46', 15), (3, '48', 12), (3, '50', 8),
(4, '44', 20), (4, '46', 25), (4, '48', 18), (4, '50', 15),
(5, '44', 12), (5, '46', 16), (5, '48', 14), (5, '50', 10), (5, '52', 8),
(6, '46', 15), (6, '48', 18), (6, '50', 12), (6, '52', 10),
(7, '44', 20), (7, '46', 22), (7, '48', 18), (7, '50', 15);

-- =============================================
-- CONSULTA PARA PÁGINA COLEÇÃO (TODAS AS IMAGENS)
-- =============================================
SELECT '=== TODAS AS IMAGENS DA COLEÇÃO ===' AS '';
SELECT 
    pi.ImagemUrl,
    p.Nome,
    p.Descricao,
    p.Preco,
    p.PrecoPromocional,
    c.Nome as Categoria
FROM ProdutoImagens pi
JOIN Produtos p ON pi.ProdutoId = p.Id
JOIN Categorias c ON p.CategoriaId = c.Id
WHERE p.Ativo = TRUE
ORDER BY p.Id, pi.Ordem;

SELECT '✅ BACKUP EXECUTADO! PÁGINA COLEÇÃO PRONTA.' AS '';