import os
import sys

# Adiciona o diretório raiz do projeto ao sys.path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "../../")))

import streamlit as st

from src.services.identificacao_service import IdentificacaoService
from src.services.report_service import ReportService

# Configuração da página para melhor visualização em mobile
st.set_page_config(
    page_title="MicroBuddy - Identificação Microbiológica",
    page_icon="🔬",
    layout="wide",
    initial_sidebar_state="expanded",
)

# Estilização customizada para Dark Mode e Responsividade
st.markdown(
    """
    <style>
    .main {
        padding: 1rem;
    }
    .stSelectbox label {
        font-weight: bold;
    }
    /* Estilo para cards de resultado */
    .bacteria-card {
        padding: 1.5rem;
        border-radius: 10px;
        border-left: 5px solid #00d2ff;
        background-color: #262730;
        margin-bottom: 1rem;
    }
    </style>
    """,
    unsafe_allow_html=True,
)


def main():
    st.title("🔬 MicroBuddy")
    st.subheader("Sistema de Apoio à Identificação Bacteriana")

    service = IdentificacaoService()
    dados_iniciais = service.obter_dados_iniciais()

    # --- BARRA LATERAL (IDENTIFICAÇÃO DO ALUNO) ---
    with st.sidebar:
        st.header("📋 Identificação")
        nome_aluno = st.text_input("Nome do Aluno/Grupo", key="aluno_nome_input")
        disciplina = st.text_input("Disciplina", key="aluno_disciplina_input")
        amostra = st.text_input("Código da Amostra", key="aluno_amostra_input")

        st.divider()
        if st.button("🔄 Limpar Todos os Filtros", use_container_width=True):
            st.rerun()

        st.divider()
        st.info(
            "Preencha os resultados dos testes ao lado para identificar a bactéria."
        )

    # --- ÁREA PRINCIPAL ---
    col1, col2 = st.columns([1, 1])

    selecoes_meios = {}
    selecoes_testes = {}

    with col1:
        st.header("🧫 Morfologia e Meios")
        morfologia = st.selectbox(
            "Morfologia", ["Não selecionado", "coco", "bastonete"], key="sel_morfologia"
        )
        gram = st.selectbox(
            "Técnica de Gram",
            ["Não selecionado", "positivo", "negativo"],
            key="sel_gram",
        )

        st.write("---")
        for meio in dados_iniciais["meios"]:
            selecoes_meios[meio["id"]] = st.selectbox(
                f"Meio: {meio['nome']}", meio["opcoes"], key=f"meio_sel_{meio['id']}"
            )

    with col2:
        st.header("🧪 Testes Bioquímicos")
        for grupo in dados_iniciais["testes"]:
            with st.expander(f"Grupo: {grupo['grupo']}", expanded=True):
                for param in grupo["parametros"]:
                    selecoes_testes[param["id"]] = st.selectbox(
                        param["nome"], param["opcoes"], key=f"param_sel_{param['id']}"
                    )

    # --- RESULTADOS EM TEMPO REAL ---
    st.divider()
    st.header("Resultado da Identificação")

    candidatas = service.identificar_bacteria(
        morfologia, gram, selecoes_meios, selecoes_testes
    )

    if not candidatas:
        st.warning(
            "Nenhuma bactéria no banco de dados corresponde a todos os critérios selecionados."
        )
    elif len(candidatas) > 1:
        st.info(
            f"Foram encontradas {len(candidatas)} bactérias possíveis. Continue refinando os testes."
        )
        cols = st.columns(len(candidatas))
        for idx, cand in enumerate(candidatas):
            with cols[idx]:
                st.markdown(f"**{cand.genero} {cand.especie}**")
    else:
        bac = candidatas[0]
        st.success(f"Bactéria Identificada: **{bac.genero} {bac.especie}**")

        # Seção "Por que esta bactéria?"
        justificativa = service.gerar_justificativa(
            bac.id, selecoes_meios, selecoes_testes
        )
        if justificativa:
            with st.expander("Por que esta bactéria?", expanded=True):
                for item in justificativa:
                    st.markdown(item)

        # Preparação de dados para o PDF
        dados_aluno = {"nome": nome_aluno, "disciplina": disciplina, "amostra": amostra}

        morf_gram_data = {"morfologia": morfologia, "gram": gram}

        resultados_meios_pdf = []
        for m in dados_iniciais["meios"]:
            resultados_meios_pdf.append(
                {"nome": m["nome"], "valor": selecoes_meios[m["id"]]}
            )

        resultados_testes_pdf = []
        for g in dados_iniciais["testes"]:
            for p in g["parametros"]:
                resultados_testes_pdf.append(
                    {"nome": p["nome"], "valor": selecoes_testes[p["id"]]}
                )

        # Botão de Exportação
        pdf_buffer = ReportService.generate_pdf(
            dados_aluno,
            bac,
            morf_gram_data,
            resultados_meios_pdf,
            resultados_testes_pdf,
        )

        st.download_button(
            label="📄 Baixar Relatório PDF",
            data=pdf_buffer,
            file_name=f"relatorio_{amostra if amostra else 'identificacao'}.pdf",
            mime="application/pdf",
        )


if __name__ == "__main__":
    main()
