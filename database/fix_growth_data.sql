-- Script para preencher dados de crescimento básicos para Agar Nutriente e MacConkey

-- 1. Ágar Nutriente (ID 1) - Todas as bactérias do banco crescem em Ágar Nutriente (é um meio básico)
INSERT OR IGNORE INTO bacteria_meio_cultura (bacteria_id, meio_id, opcao_dropdown, descricao_tecnica) VALUES
(1, 1, 'Cresce', 'Crescimento abundante em meio simples'),
(2, 1, 'Cresce', 'Crescimento abundante em meio simples'),
(3, 1, 'Cresce', 'Crescimento abundante em meio simples'),
(4, 1, 'Cresce', 'Crescimento abundante em meio simples'),
(5, 1, 'Cresce', 'Crescimento abundante em meio simples'),
(6, 1, 'Cresce', 'Crescimento abundante em meio simples'),
(7, 1, 'Cresce', 'Crescimento abundante em meio simples'),
(8, 1, 'Cresce', 'Crescimento abundante em meio simples'),
(9, 1, 'Cresce', 'Crescimento abundante em meio simples'),
(10, 1, 'Cresce', 'Crescimento abundante em meio simples'),
(11, 1, 'Cresce', 'Crescimento abundante em meio simples'),
(12, 1, 'Cresce', 'Crescimento abundante em meio simples');

-- 2. MacConkey (ID 2) - Completando Gram-negativas faltantes
INSERT OR IGNORE INTO bacteria_meio_cultura (bacteria_id, meio_id, opcao_dropdown, descricao_tecnica) VALUES
(5, 2, 'Cresce (Lactose -)', 'Colônias incolores ou levemente amareladas (não fermenta lactose)'),
(6, 2, 'Cresce (Lactose -)', 'Colônias incolores e pequenas (não fermenta lactose)'),
(7, 2, 'Cresce (Lactose +)', 'Colônias cor-de-rosa (fermenta lactose)');

-- 3. Mueller Hinton (ID 4) - Meio base para antibiograma, a maioria cresce
INSERT OR IGNORE INTO bacteria_meio_cultura (bacteria_id, meio_id, opcao_dropdown, descricao_tecnica) VALUES
(1, 4, 'Cresce', 'Crescimento satisfatório para teste de sensibilidade'),
(2, 4, 'Cresce', 'Crescimento satisfatório para teste de sensibilidade'),
(3, 4, 'Cresce', 'Crescimento satisfatório para teste de sensibilidade'),
(11, 4, 'Cresce', 'Crescimento satisfatório para teste de sensibilidade');
