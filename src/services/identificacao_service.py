from src.repository.microbiologia_repository import MicrobiologiaRepository

class IdentificacaoService:
    def __init__(self):
        self.repo = MicrobiologiaRepository()

    def obter_dados_iniciais(self):
        """Prepara todos os dados necessários para popular os filtros da UI."""
        meios = self.repo.get_all_meios_cultura()
        grupos_testes = self.repo.get_all_testes_grupos()
        
        filtros_meios = []
        for m in meios:
            # Opções padrão para meios de cultura
            opcoes_padrao = ["Não selecionado", "Cresce", "Não Cresce"]
            # Adiciona opções específicas do banco se existirem
            opcoes_db = self.repo.get_distinct_meio_options(m.id)
            
            # Unifica e limpa opções
            opcoes_finais = list(opcoes_padrao)
            for opt in opcoes_db:
                if opt not in opcoes_finais:
                    opcoes_finais.append(opt)
                    
            filtros_meios.append({
                "id": m.id,
                "nome": m.nome,
                "opcoes": opcoes_finais
            })

        filtros_testes = []
        for g in grupos_testes:
            parametros = []
            for p in g.parametros:
                # Opções baseadas no tipo de teste
                if "TSI" in g.nome:
                    opcoes_padrao = ["Não selecionado", "Ácido (A)", "Alcalino (K)", "Positivo", "Negativo"]
                else:
                    opcoes_padrao = ["Não selecionado", "Positivo", "Negativo"]
                
                opcoes_db = self.repo.get_distinct_teste_options(p.id)
                
                opcoes_finais = list(opcoes_padrao)
                for opt in opcoes_db:
                    if opt not in opcoes_finais:
                        opcoes_finais.append(opt)

                parametros.append({
                    "id": p.id,
                    "nome": p.nome,
                    "opcoes": opcoes_finais
                })
            filtros_testes.append({
                "grupo": g.nome,
                "parametros": parametros
            })

        return {
            "meios": filtros_meios,
            "testes": filtros_testes
        }

    def identificar_bacteria(self, morfologia, gram, selecoes_meios, selecoes_testes):
        """
        Lógica de filtragem em tempo real.
        """
        bacterias = self.repo.get_all_bacterias()
        candidatas = []

        for b in bacterias:
            match = True
            
            # 1. Filtro Morfologia/Gram (Obrigatórios se selecionados)
            if morfologia != "Não selecionado" and b.morfologia != morfologia:
                match = False
            if gram != "Não selecionado" and b.gram != gram:
                match = False
            
            if not match: continue

            # Buscamos os detalhes uma vez por bactéria para eficiência
            detalhes = self.repo.get_bacteria_details(b.id)

            # 2. Filtro Meios de Cultura
            for m_id, opcao_selecionada in selecoes_meios.items():
                if opcao_selecionada == "Não selecionado":
                    continue
                
                # Procura o resultado da bactéria para este meio
                resultado_bac = next((m for m in detalhes['meios'] if m.meio_id == m_id), None)
                
                if resultado_bac:
                    # Se temos o dado, ele deve bater com a seleção
                    # Lógica flexível: "Cresce (Lactose +)" contém "Cresce"
                    if opcao_selecionada not in resultado_bac.opcao_dropdown and \
                       resultado_bac.opcao_dropdown not in opcao_selecionada:
                        match = False
                        break
                else:
                    # Se não temos o dado no banco para esta bactéria,
                    # por segurança pedagógica, assumimos que não dá match 
                    # com 'Cresce' ou 'Positivo' para evitar falsos positivos
                    if "Cresce" in opcao_selecionada or "Positivo" in opcao_selecionada:
                        match = False
                        break
            
            if not match: continue

            # 3. Filtro Testes Bioquímicos
            for p_id, opcao_selecionada in selecoes_testes.items():
                if opcao_selecionada == "Não selecionado":
                    continue
                
                resultado_bac = next((t for t in detalhes['testes'] if t.parametro_id == p_id), None)
                
                if resultado_bac:
                    # Match direto ou parcial (ex: 'Positivo' bate com 'Positivo Rápido')
                    if opcao_selecionada.lower() not in resultado_bac.opcao_dropdown.lower() and \
                       resultado_bac.opcao_dropdown.lower() not in opcao_selecionada.lower():
                        match = False
                        break
                else:
                    # Se o teste foi marcado mas a bactéria não tem esse teste mapeado
                    if "Positivo" in opcao_selecionada or "Ácido" in opcao_selecionada:
                        match = False
                        break
            
            if match:
                candidatas.append(b)

        return candidatas

    def gerar_justificativa(self, bacteria_id, selecoes_meios, selecoes_testes):
        """Gera o texto 'Por que esta bactéria?' baseado nos matches encontrados."""
        detalhes = self.repo.get_bacteria_details(bacteria_id)
        justificativa = []

        for m_id, opcao in selecoes_meios.items():
            if opcao != "Não selecionado":
                m_info = next((m for m in detalhes['meios'] if m.meio_id == m_id), None)
                if m_info:
                    justificativa.append(f"- **{m_info.meio.nome}**: {m_info.descricao_tecnica}")

        for p_id, opcao in selecoes_testes.items():
            if opcao != "Não selecionado":
                p_info = next((t for t in detalhes['testes'] if t.parametro_id == p_id), None)
                if p_info:
                    justificativa.append(f"- **{p_info.parametro.nome}**: {p_info.descricao_tecnica}")

        return justificativa
