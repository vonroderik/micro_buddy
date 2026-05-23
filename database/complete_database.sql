-- Script para completar dados faltantes e evitar exclusões falsas

-- 1. Crescimento em Ágar Sangue (ID 7) para quem falta
INSERT OR IGNORE INTO bacteria_meio_cultura (bacteria_id, meio_id, opcao_dropdown, descricao_tecnica) VALUES
(4, 7, 'Cresce (Beta-hemólise)', 'Pequenas colônias cercadas por uma zona estreita de beta-hemólise'),
(5, 7, 'Cresce', 'Colônias médias, lisas e acinzentadas'),
(6, 7, 'Cresce', 'Colônias convexas, circulares e transparentes'),
(7, 7, 'Cresce', 'Colônias grandes, cinzas e às vezes mucoides'),
(8, 7, 'Cresce (Beta-hemólise)', 'Colônias grandes, foscas, com aspecto de vidro moído e forte hemólise');

-- 2. Crescimento em PCA (ID 5) - Todas as 12 crescem (meio para contagem total)
INSERT OR IGNORE INTO bacteria_meio_cultura (bacteria_id, meio_id, opcao_dropdown, descricao_tecnica) VALUES
(1, 5, 'Cresce', 'Crescimento para contagem padrão'),
(2, 5, 'Cresce', 'Crescimento para contagem padrão'),
(3, 5, 'Cresce', 'Crescimento para contagem padrão'),
(4, 5, 'Cresce', 'Crescimento para contagem padrão'),
(5, 5, 'Cresce', 'Crescimento para contagem padrão'),
(6, 5, 'Cresce', 'Crescimento para contagem padrão'),
(7, 5, 'Cresce', 'Crescimento para contagem padrão'),
(8, 5, 'Cresce', 'Crescimento para contagem padrão'),
(9, 5, 'Cresce', 'Crescimento para contagem padrão'),
(10, 5, 'Cresce', 'Crescimento para contagem padrão'),
(11, 5, 'Cresce', 'Crescimento para contagem padrão'),
(12, 5, 'Cresce', 'Crescimento para contagem padrão');

-- 3. Crescimento em CLED (ID 6) - Meio para urocultura
INSERT OR IGNORE INTO bacteria_meio_cultura (bacteria_id, meio_id, opcao_dropdown, descricao_tecnica) VALUES
(3, 6, 'Cresce (Lactose -)', 'Colônias esverdeadas ou azuladas, com superfície fosca'),
(5, 6, 'Cresce (Lactose -)', 'Colônias azuladas'),
(6, 6, 'Cresce (Lactose -)', 'Colônias azuladas pequenas'),
(7, 6, 'Cresce (Lactose +)', 'Colônias amarelas mucoides'),
(9, 6, 'Cresce (Lactose -)', 'Colônias azuladas, swarming é inibido'),
(11, 6, 'Cresce (Lactose +)', 'Colônias amarelas pequenas, profundas'),
(12, 6, 'Cresce (Lactose +)', 'Colônias amarelas muito pequenas');

-- 4. Testes Bioquímicos Essenciais Faltantes

-- Listeria monocytogenes (4)
INSERT OR IGNORE INTO bacteria_teste_resultado (bacteria_id, parametro_id, opcao_dropdown, descricao_tecnica) VALUES
(4, 2, 'Alcalino (K)', 'Não fermenta lactose/sacarose'),
(4, 3, 'Ácido (A)', 'Fermenta glicose'),
(4, 6, 'Negativo', 'H2S negativo'),
(4, 7, 'Negativo', 'Indol negativo'),
(4, 9, 'Negativo', 'Citrato negativo'),
(4, 11, 'Positivo', 'Fermentadora'),
(4, 12, 'Positivo', 'Fermentadora');

-- Bacillus cereus (8)
INSERT OR IGNORE INTO bacteria_teste_resultado (bacteria_id, parametro_id, opcao_dropdown, descricao_tecnica) VALUES
(8, 1, 'Negativo', 'Urease negativa'),
(8, 2, 'Ácido (A)', 'Fermenta sacarose'),
(8, 3, 'Ácido (A)', 'Fermenta glicose'),
(8, 4, 'Negativo', 'Sem gás'),
(8, 6, 'Negativo', 'H2S negativo'),
(8, 7, 'Negativo', 'Indol negativo'),
(8, 8, 'Positivo', 'Motilidade positiva'),
(8, 9, 'Positivo', 'Citrato positivo'),
(8, 11, 'Positivo', 'Fermentadora'),
(8, 12, 'Positivo', 'Fermentadora');

-- Staphylococcus aureus (11) - Completando
INSERT OR IGNORE INTO bacteria_teste_resultado (bacteria_id, parametro_id, opcao_dropdown, descricao_tecnica) VALUES
(11, 1, 'Positivo', 'Urease positiva'),
(11, 2, 'Ácido (A)', 'Fermenta lactose/sacarose'),
(11, 3, 'Ácido (A)', 'Fermenta glicose'),
(11, 6, 'Negativo', 'H2S negativo'),
(11, 7, 'Negativo', 'Indol negativo'),
(11, 8, 'Negativo', 'Imóvel'),
(11, 9, 'Positivo', 'Citrato positivo'),
(11, 11, 'Positivo', 'Fermentadora'),
(11, 12, 'Positivo', 'Fermentadora');

-- Streptococcus sp. (10)
INSERT OR IGNORE INTO bacteria_teste_resultado (bacteria_id, parametro_id, opcao_dropdown, descricao_tecnica) VALUES
(10, 1, 'Negativo', 'Urease negativa'),
(10, 2, 'Ácido (A)', 'Fermenta açúcares'),
(10, 3, 'Ácido (A)', 'Fermenta glicose'),
(10, 8, 'Negativo', 'Imóvel'),
(10, 11, 'Positivo', 'Fermentadora'),
(10, 12, 'Positivo', 'Fermentadora');

-- 5. Mueller Hinton (4) - Completando para todos (meio base)
INSERT OR IGNORE INTO bacteria_meio_cultura (bacteria_id, meio_id, opcao_dropdown, descricao_tecnica) VALUES
(4, 4, 'Cresce', 'Cresce bem'),
(5, 4, 'Cresce', 'Cresce bem'),
(6, 4, 'Cresce', 'Cresce bem'),
(7, 4, 'Cresce', 'Cresce bem'),
(8, 4, 'Cresce', 'Cresce bem'),
(9, 4, 'Cresce', 'Cresce bem'),
(10, 4, 'Cresce', 'Cresce bem'),
(12, 4, 'Cresce', 'Cresce bem');
