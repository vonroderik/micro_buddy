-- Script para simplificar Urease e corrigir TSI

-- 1. Simplificar Urease (Tudo vira 'Positivo' ou 'Negativo')
UPDATE bacteria_teste_resultado 
SET opcao_dropdown = 'Positivo' 
WHERE parametro_id = 1 AND opcao_dropdown LIKE 'Positivo%';

-- 2. Corrigir TSI para as principais espécies
-- TSI Pico (Lactose/Sacarose) -> ID 2
-- TSI Base (Glicose) -> ID 3

-- E. coli: A/A (Ácido/Ácido)
UPDATE bacteria_teste_resultado SET opcao_dropdown = 'Ácido (A)' WHERE bacteria_id = 1 AND parametro_id IN (2, 3);

-- Klebsiella: A/A (Ácido/Ácido)
UPDATE bacteria_teste_resultado SET opcao_dropdown = 'Ácido (A)' WHERE bacteria_id = 2 AND parametro_id IN (2, 3);

-- Pseudomonas: K/K (Alcalino/Alcalino - Não fermentador)
UPDATE bacteria_teste_resultado SET opcao_dropdown = 'Alcalino (K)' WHERE bacteria_id = 3 AND parametro_id IN (2, 3);

-- Salmonella: K/A (Alcalino/Ácido - Fermenta apenas Glicose)
UPDATE bacteria_teste_resultado SET opcao_dropdown = 'Alcalino (K)' WHERE bacteria_id = 5 AND parametro_id = 2;
UPDATE bacteria_teste_resultado SET opcao_dropdown = 'Ácido (A)' WHERE bacteria_id = 5 AND parametro_id = 3;

-- Shigella: K/A (Alcalino/Ácido - Fermenta apenas Glicose)
UPDATE bacteria_teste_resultado SET opcao_dropdown = 'Alcalino (K)' WHERE bacteria_id = 6 AND parametro_id = 2;
UPDATE bacteria_teste_resultado SET opcao_dropdown = 'Ácido (A)' WHERE bacteria_id = 6 AND parametro_id = 3;

-- Proteus mirabilis (comum): K/A (Alcalino/Ácido)
UPDATE bacteria_teste_resultado SET opcao_dropdown = 'Alcalino (K)' WHERE bacteria_id = 9 AND parametro_id = 2;
UPDATE bacteria_teste_resultado SET opcao_dropdown = 'Ácido (A)' WHERE bacteria_id = 9 AND parametro_id = 3;

-- Enterobacter: A/A (Ácido/Ácido)
UPDATE bacteria_teste_resultado SET opcao_dropdown = 'Ácido (A)' WHERE bacteria_id = 7 AND parametro_id IN (2, 3);
