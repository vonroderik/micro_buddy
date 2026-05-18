-- Script para completar dados faltantes de testes bioquímicos

-- Escherichia coli (ID: 1)
-- OF: Fermentadora (Positivo/Positivo)
INSERT OR IGNORE INTO bacteria_teste_resultado (bacteria_id, parametro_id, opcao_dropdown, descricao_tecnica) VALUES
(1, 11, 'Positivo', 'Produção de ácido (amarelo) em aerobiose'),
(1, 12, 'Positivo', 'Produção de ácido (amarelo) em anaerobiose (fermentação)');

-- Klebsiella pneumoniae (ID: 2)
-- OF: Fermentadora (Positivo/Positivo)
-- Catalase: Positivo
-- SIM: Sulfeto -, Indol -, Motilidade -
INSERT OR IGNORE INTO bacteria_teste_resultado (bacteria_id, parametro_id, opcao_dropdown, descricao_tecnica) VALUES
(2, 6, 'Negativo', 'Sem H2S'),
(2, 11, 'Positivo', 'Produção de ácido (amarelo)'),
(2, 12, 'Positivo', 'Produção de ácido (amarelo)'),
(2, 13, 'Positivo', 'Efervescência vigorosa');

-- Pseudomonas aeruginosa (ID: 3)
-- Ureia: Negativo
-- TSI: K/K, Gás -, H2S -
-- SIM: H2S -, Indol -, Motilidade +
-- OF: Oxidadora (Positivo/Negativo)
INSERT OR IGNORE INTO bacteria_teste_resultado (bacteria_id, parametro_id, opcao_dropdown, descricao_tecnica) VALUES
(3, 1, 'Negativo', 'Sem viragem da ureia'),
(3, 6, 'Negativo', 'Sem H2S'),
(3, 7, 'Negativo', 'Indol negativo');

-- Listeria monocytogenes (ID: 4)
-- Gram +, Bastonete
-- Catalase: Positivo
-- Motilidade: Positivo (em guarda-chuva a 25°C)
-- Bile Esculina: Positivo
INSERT OR IGNORE INTO bacteria_teste_resultado (bacteria_id, parametro_id, opcao_dropdown, descricao_tecnica) VALUES
(4, 1, 'Negativo', 'Urease negativa'),
(4, 8, 'Positivo', 'Motilidade característica'),
(4, 10, 'Positivo', 'Hidrólise de esculina presente'),
(4, 13, 'Positivo', 'Catalase positiva');

-- Salmonella sp. (ID: 5)
-- OF: Fermentadora (Positivo/Positivo)
-- Catalase: Positivo
INSERT OR IGNORE INTO bacteria_teste_resultado (bacteria_id, parametro_id, opcao_dropdown, descricao_tecnica) VALUES
(5, 11, 'Positivo', 'Fermentadora'),
(5, 12, 'Positivo', 'Fermentadora'),
(5, 13, 'Positivo', 'Catalase positiva');

-- Shigella sp. (ID: 6)
-- Bastonete Gram -
-- TSI: K/A, Gás -, H2S -
-- SIM: H2S -, Indol (Variável), Motilidade -
-- Citrato: Negativo
-- OF: Fermentadora (Positivo/Positivo)
-- Catalase: Positivo
INSERT OR IGNORE INTO bacteria_teste_resultado (bacteria_id, parametro_id, opcao_dropdown, descricao_tecnica) VALUES
(6, 1, 'Negativo', 'Urease negativa'),
(6, 2, 'Alcalino (K)', 'Pico vermelho'),
(6, 3, 'Ácido (A)', 'Base amarela'),
(6, 4, 'Negativo', 'Sem gás'),
(6, 5, 'Negativo', 'Sem H2S'),
(6, 6, 'Negativo', 'Sem H2S'),
(6, 7, 'Negativo', 'Geralmente negativo'),
(6, 8, 'Negativo', 'Imóvel'),
(6, 9, 'Negativo', 'Citrato negativo'),
(6, 11, 'Positivo', 'Fermentadora'),
(6, 12, 'Positivo', 'Fermentadora'),
(6, 13, 'Positivo', 'Catalase positiva');

-- Enterobacter sp. (ID: 7)
-- Bastonete Gram -
-- TSI: A/A, Gás +, H2S -
-- SIM: H2S -, Indol -, Motilidade +
-- Citrato: Positivo
-- OF: Fermentadora (Positivo/Positivo)
-- Catalase: Positivo
INSERT OR IGNORE INTO bacteria_teste_resultado (bacteria_id, parametro_id, opcao_dropdown, descricao_tecnica) VALUES
(7, 1, 'Negativo', 'Urease negativa'),
(7, 2, 'Ácido (A)', 'Pico amarelo'),
(7, 3, 'Ácido (A)', 'Base amarela'),
(7, 4, 'Positivo', 'Produção de gás'),
(7, 5, 'Negativo', 'Sem H2S'),
(7, 6, 'Negativo', 'Sem H2S'),
(7, 7, 'Negativo', 'Indol negativo'),
(7, 8, 'Positivo', 'Móvel'),
(7, 9, 'Positivo', 'Citrato positivo'),
(7, 11, 'Positivo', 'Fermentadora'),
(7, 12, 'Positivo', 'Fermentadora'),
(7, 13, 'Positivo', 'Catalase positiva');

-- Bacillus cereus (ID: 8)
-- Bastonete Gram +
-- Catalase: Positivo
INSERT OR IGNORE INTO bacteria_teste_resultado (bacteria_id, parametro_id, opcao_dropdown, descricao_tecnica) VALUES
(8, 13, 'Positivo', 'Catalase positiva');

-- Proteus sp. (ID: 9)
-- OF: Fermentadora (Positivo/Positivo)
-- Catalase: Positivo
INSERT OR IGNORE INTO bacteria_teste_resultado (bacteria_id, parametro_id, opcao_dropdown, descricao_tecnica) VALUES
(9, 11, 'Positivo', 'Fermentadora'),
(9, 12, 'Positivo', 'Fermentadora'),
(9, 13, 'Positivo', 'Catalase positiva');

-- Streptococcus sp. (ID: 10)
-- Coco Gram +
-- Catalase: Negativo
INSERT OR IGNORE INTO bacteria_teste_resultado (bacteria_id, parametro_id, opcao_dropdown, descricao_tecnica) VALUES
(10, 10, 'Negativo', 'Bile Esculina negativa (exceto grupo D)');

-- Staphylococcus aureus (ID: 11)
-- Coco Gram +
-- Catalase: Positivo
-- OF: Fermentadora (Positivo/Positivo)
INSERT OR IGNORE INTO bacteria_teste_resultado (bacteria_id, parametro_id, opcao_dropdown, descricao_tecnica) VALUES
(11, 11, 'Positivo', 'Fermentadora'),
(11, 12, 'Positivo', 'Fermentadora');

-- Enterococcus sp. (ID: 12)
-- Coco Gram +
-- Catalase: Negativo (ou pseudo-catalase fraca)
-- Bile Esculina: Positivo
INSERT OR IGNORE INTO bacteria_teste_resultado (bacteria_id, parametro_id, opcao_dropdown, descricao_tecnica) VALUES
(12, 13, 'Negativo', 'Catalase negativa');
