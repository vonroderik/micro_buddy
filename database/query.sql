PRAGMA foreign_keys = ON;

-- TABELA: bactérias
CREATE TABLE bacteria (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    genero TEXT NOT NULL,
    especie TEXT NOT NULL,
    morfologia TEXT NOT NULL CHECK(morfologia IN ('coco', 'bastonete')),
    gram TEXT NOT NULL CHECK(gram IN ('positivo', 'negativo')),
    UNIQUE(genero, especie)
);

-- TABELA: meios de cultura
CREATE TABLE meio_cultura (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL UNIQUE,
    is_simples BOOLEAN NOT NULL DEFAULT 0,
    is_seletivo BOOLEAN NOT NULL DEFAULT 0,
    is_diferencial BOOLEAN NOT NULL DEFAULT 0
);

-- TABELA ASSOCIATIVA: bactéria <-> meio de cultura
CREATE TABLE bacteria_meio_cultura (
    bacteria_id INTEGER NOT NULL,
    meio_id INTEGER NOT NULL,
    opcao_dropdown TEXT NOT NULL, -- Ex: 'Cresce (Lactose +)', 'Cresce (Lactose -)', 'Não Cresce'
    descricao_tecnica TEXT NOT NULL,
    PRIMARY KEY (bacteria_id, meio_id),
    FOREIGN KEY (bacteria_id) REFERENCES bacteria(id) ON DELETE CASCADE,
    FOREIGN KEY (meio_id) REFERENCES meio_cultura(id) ON DELETE CASCADE
);

-- TABELA: Grupo de Testes
CREATE TABLE teste_grupo (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL UNIQUE
);

-- TABELA: Parâmetros do Teste
CREATE TABLE teste_parametro (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    grupo_id INTEGER NOT NULL,
    nome TEXT NOT NULL,
    FOREIGN KEY (grupo_id) REFERENCES teste_grupo(id) ON DELETE CASCADE,
    UNIQUE(grupo_id, nome)
);

-- TABELA ASSOCIATIVA: bactéria <-> parâmetro de teste
CREATE TABLE bacteria_teste_resultado (
    bacteria_id INTEGER NOT NULL,
    parametro_id INTEGER NOT NULL,
    opcao_dropdown TEXT NOT NULL, -- O valor exato para o menu do Streamlit (ex: 'Positivo', 'Ácido (A)')
    descricao_tecnica TEXT NOT NULL, -- Texto explicativo
    PRIMARY KEY (bacteria_id, parametro_id),
    FOREIGN KEY (bacteria_id) REFERENCES bacteria(id) ON DELETE CASCADE,
    FOREIGN KEY (parametro_id) REFERENCES teste_parametro(id) ON DELETE CASCADE
);

-- ==========================================
-- 1. CARGA INICIAL: BACTÉRIAS E MEIOS
-- ==========================================

INSERT INTO bacteria (genero, especie, morfologia, gram) VALUES 
('Escherichia', 'coli', 'bastonete', 'negativo'),         -- 1
('Klebsiella', 'pneumoniae', 'bastonete', 'negativo'),    -- 2
('Pseudomonas', 'aeruginosa', 'bastonete', 'negativo'),   -- 3
('Listeria', 'monocytogenes', 'bastonete', 'positivo'),   -- 4
('Salmonella', 'sp.', 'bastonete', 'negativo'),           -- 5
('Shigella', 'sp.', 'bastonete', 'negativo'),             -- 6
('Enterobacter', 'sp.', 'bastonete', 'negativo'),         -- 7
('Bacillus', 'cereus', 'bastonete', 'positivo'),          -- 8
('Proteus', 'sp.', 'bastonete', 'negativo'),              -- 9
('Streptococcus', 'sp.', 'coco', 'positivo'),             -- 10
('Staphylococcus', 'aureus', 'coco', 'positivo'),         -- 11
('Enterococcus', 'sp.', 'coco', 'positivo');              -- 12

INSERT INTO meio_cultura (nome, is_simples, is_seletivo, is_diferencial) VALUES 
('NA (Ágar Nutriente)', 1, 0, 0),    -- 1
('MacConkey', 0, 1, 1),              -- 2
('Baird Parker', 0, 1, 1),           -- 3
('Mueller Hinton', 1, 0, 0),         -- 4
('PCA', 1, 0, 0),                    -- 5
('Cled', 0, 0, 1),                   -- 6
('Ágar Sangue', 0, 0, 1);            -- 7

INSERT INTO teste_grupo (nome) VALUES 
('Ureia'), ('TSI'), ('SIM'), ('Citrato'), ('Bile Esculina'), ('OF'), ('Catalase');

INSERT INTO teste_parametro (grupo_id, nome) VALUES 
(1, 'Atividade Urease'),             -- 1
(2, 'Pico (Lactose/Sacarose)'),      -- 2
(2, 'Base (Glicose)'),               -- 3
(2, 'Produção de Gás'),              -- 4
(2, 'Produção de H2S'),              -- 5
(3, 'Produção de Sulfeto (H2S)'),    -- 6
(3, 'Produção de Indol'),            -- 7
(3, 'Motilidade'),                   -- 8
(4, 'Utilização de Citrato'),        -- 9
(5, 'Hidrólise de Esculina'),        -- 10
(6, 'Tubo Aberto (Aerobiose)'),      -- 11
(6, 'Tubo Fechado (Anaerobiose)'),   -- 12
(7, 'Produção de Bolhas');           -- 13


-- ==========================================
-- 2. CARGA INICIAL: CRESCIMENTO EM MEIOS
-- ==========================================

INSERT INTO bacteria_meio_cultura (bacteria_id, meio_id, opcao_dropdown, descricao_tecnica) VALUES
-- E. coli (1)
(1, 2, 'Cresce (Lactose +)', 'Colônias de coloração vermelho-púrpura, opacas, rodeadas por halo de precipitação de sais biliares.'),
(1, 6, 'Cresce (Lactose +)', 'Colônias amarelas, convexas e opacas.'),
(1, 7, 'Cresce', 'Colônias úmidas, acinzentadas, podendo apresentar beta-hemólise ou gama-hemólise dependendo da cepa.'),
-- K. pneumoniae (2)
(2, 2, 'Cresce (Lactose + Mucóide)', 'Colônias grandes, excessivamente mucóides (presença de cápsula polissacarídica) e de coloração rósea.'),
(2, 6, 'Cresce (Lactose +)', 'Colônias amarelas e mucóides.'),
-- P. aeruginosa (3)
(3, 2, 'Cresce (Lactose -)', 'Colônias pálidas ou incolores, bordas irregulares, frequentemente com pigmentação esverdeada difusível (piocianina).'),
(3, 7, 'Cresce (Beta-hemólise)', 'Colônias achatadas, com bordas espraiadas, brilho metálico, odor característico de uva e presença de beta-hemólise.'),
-- Proteus sp. (9)
(9, 2, 'Cresce (Lactose -)', 'Colônias pálidas e translúcidas. O fenômeno de swarming é inibido pelos sais biliares.'),
(9, 7, 'Cresce (Swarming)', 'Crescimento em véu contínuo (fenômeno de swarming) cobrindo toda a superfície do ágar.'),
-- S. aureus (11)
(11, 3, 'Cresce (Halo de Proteólise)', 'Colônias negras, brilhantes e convexas, circundadas por um halo claro de proteólise e um anel opaco de atividade lipolítica.'),
(11, 7, 'Cresce (Beta-hemólise)', 'Colônias circulares, lisas, de coloração branco-porcelana a amarelo-ouro, exibindo halo de beta-hemólise nítida.'),
-- Streptococcus sp. (10)
(10, 7, 'Cresce (Alfa ou Beta-hemólise)', 'Colônias puntiformes, translúcidas a opacas, apresentando halo de alfa-hemólise (esverdeamento) ou beta-hemólise (clareamento total).'),
-- Enterococcus sp. (12)
(12, 7, 'Cresce (Gama-hemólise)', 'Colônias pequenas, acinzentadas, geralmente apresentando gama-hemólise (ausência de hemólise).');


-- ==========================================
-- 3. CARGA INICIAL: RESULTADOS BIOQUÍMICOS
-- ==========================================

INSERT INTO bacteria_teste_resultado (bacteria_id, parametro_id, opcao_dropdown, descricao_tecnica) VALUES
-- =========================================
-- Escherichia coli (1)
-- =========================================
(1, 1, 'Negativo', 'Meio permanece com coloração amarelo-alaranjada'),
(1, 2, 'Ácido (A)', 'Coloração amarela'), 
(1, 3, 'Ácido (A)', 'Coloração amarela'), 
(1, 4, 'Positivo', 'Presença de bolhas ou rachaduras no ágar'), 
(1, 5, 'Negativo', 'Ausência de precipitado negro'), 
(1, 6, 'Negativo', 'Ausência de escurecimento'), 
(1, 7, 'Positivo', 'Formação de anel vermelho na superfície após adição do reativo de Kovac'), 
(1, 8, 'Positivo', 'Crescimento difuso a partir da linha de picada, turvando o meio'), 
(1, 9, 'Negativo', 'Meio permanece verde, sem alcalinização'), 
(1, 13, 'Positivo', 'Efervescência vigorosa após adição de H2O2'), 

-- =========================================
-- Klebsiella pneumoniae (2)
-- =========================================
(2, 1, 'Positivo Lento', 'Viragem parcial para coloração rosa-fúcsia'), 
(2, 2, 'Ácido (A)', 'Coloração amarela'), 
(2, 3, 'Ácido (A)', 'Coloração amarela'), 
(2, 4, 'Positivo', 'Abundante formação de gás rompendo o meio'), 
(2, 5, 'Negativo', 'Ausência de precipitado negro'), 
(2, 6, 'Negativo', 'Ausência de escurecimento'), 
(2, 7, 'Negativo', 'Anel permanece amarelo/pardo'), 
(2, 8, 'Negativo', 'Crescimento restrito à linha de picada'), 
(2, 9, 'Positivo', 'Viragem do indicador para coloração azul intensa'), 

-- =========================================
-- Pseudomonas aeruginosa (3)
-- =========================================
(3, 2, 'Alcalino (K)', 'Coloração vermelha'), 
(3, 3, 'Alcalino (K)', 'Coloração vermelha (Não fermentador)'), 
(3, 4, 'Negativo', 'Ausência de gás'), 
(3, 5, 'Negativo', 'Ausência de H2S'), 
(3, 8, 'Positivo', 'Alta motilidade'), 
(3, 9, 'Positivo', 'Viragem para azul'), 
(3, 11, 'Positivo', 'Produção de ácido, viragem para amarelo na porção superior do tubo aberto'), 
(3, 12, 'Negativo', 'Meio permanece verde no tubo selado com óleo mineral'), 
(3, 13, 'Positivo', 'Efervescência vigorosa'), 

-- =========================================
-- Salmonella sp. (5)
-- =========================================
(5, 1, 'Negativo', 'Meio permanece amarelo'), 
(5, 2, 'Alcalino (K)', 'Coloração vermelha'), 
(5, 3, 'Ácido (A)', 'Coloração amarela'), 
(5, 4, 'Positivo', 'Presença de gás'), 
(5, 5, 'Positivo', 'Intenso precipitado negro de sulfeto de ferro na base'), 
(5, 6, 'Positivo', 'Escurecimento do meio'), 
(5, 7, 'Negativo', 'Ausência de indol'), 
(5, 8, 'Positivo', 'Motilidade evidente'), 
(5, 9, 'Positivo', 'Viragem para azul, dependente da espécie'), 

-- =========================================
-- Proteus sp. (9)
-- =========================================
(9, 1, 'Positivo Rápido', 'Viragem intensa e rápida para rosa-fúcsia por alta atividade de urease'), 
(9, 2, 'Alcalino (K) ou Ácido (A)', 'Depende da espécie (P. vulgaris vs P. mirabilis)'), 
(9, 3, 'Ácido (A)', 'Coloração amarela na base'), 
(9, 5, 'Positivo', 'Intensa produção de H2S mascarando o fundo do tubo'), 
(9, 7, 'Variável', 'Positivo para P. vulgaris, Negativo para P. mirabilis'), 
(9, 8, 'Positivo', 'Extremamente móvel'), 

-- =========================================
-- Cocos Gram-Positivos
-- =========================================
(11, 13, 'Positivo', 'Clássica efervescência, diferenciando de Streptococcus'), 
(10, 13, 'Negativo', 'Ausência de bolhas, gênero não produz enzima'), 
(12, 13, 'Negativo', 'Pode apresentar pseudo-catalase fraca dependendo da cepa, mas classicamente negativo'), 
(12, 10, 'Positivo', 'Hidrólise da esculina gerando escurecimento enegrecido a marrom do ágar');