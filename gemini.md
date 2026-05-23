# MicroBuddy

## Descrição do projeto

Um software para identificação de bactérias, através do cruzamento de dados de crescimento em meios de cultura, morfologia e testes bioquímicos.
Este software tem objetivo educacional, e será utilizado por alunos de graduação em Biomedicina, nas disciplinas de microbiologia.

O objetivo é que o aluno possa selecionar os resultados de crescimento, morfologia e testes bioquímicos, e receber a identificação da bactéria.

O software será acessado via website Streamlit.
Os dados para identificação estão armazenados em um arquivo chamado 'identificacao_microbiologica.db' em '/database'.

Os usuários apenas farão a leitura do banco, e não precisarão realizar UPDATE, DELETE ou CREATE.

É importante que exista a opção de exportar o relatório final, com a identificação da bactéria.

## Stack
- UV
- Python
- SQLAlchemy
- Streamlit
- reportlab
- ruff

## Principios de programação

- O software deverá utilizar OOP ou programação funcional, conforme necessário.
- Deve-se aplicar técnicas de DRY. Se necessário, funções repetitivas devem ser transformadas em funções ou classes que possam ser chamadas quando necessário. Estas devem ficar em /src/utils
- Todos arquivos envolvendo o banco de dados/sqlalchemy devem ficar em /database
- O programa deve utilizar principios de sepração de responsabilidade:
  - '/src/models': é onde ficam localizados os modelos de classes das entidades necessárias para o código
  - '/src/repository': onde ficam localizados os arquivos que irão fazer a conexão com o banco de dados. Apenas estes arquivos devem ter contato com o banco de dados. Todas outras classes, fora desta pasta, que devem interagir com o banco de dados, devem o fazer via 'repository'.
  - '/src/services': onde ficam as lógicas de negócio, e validações necessárias.
  - '/src/ui': nesta pasta e subpastas devem ficar todos os componentes respectivos à UI/Streamlit.

## Exportação

É necessário que os alunos possam exportar seus resultados:
- Nome do aluno/grupo
- Data
- Disciplina
- Amostra
- Gênero e espécie da bactéria identificada
- Resultados da técnica de Gram/Morfologia
- Resultado dos meios de cultivo
- Resultados dos testes bioquímicos

---

Exploração Inicial do Projeto: Pesquisando a estrutura atual da interface e lógica de negócio para sugerir melhorias de UI/UX e arquitetura.

  ✓  ReadFolder  src/ui/pages → Found 1 item(s).
  ✓  ReadFolder  src/ui/components → Found 1 item(s).
  ✓  ReadFile  src\ui\app.py
  ✓  ReadFile  src\...\identificacao_service.py
  ✓  ReadFile  src\...\microbiologia_repository.py
  ✓  ReadFile  src\models\entities.py
  ✓  ReadFile  src\services\report_service.py

✦ Com base na análise do código atual e no contexto educacional (graduação em Biomedicina), aqui estão minhas sugestões de refatoração focadas em UI/UX e Arquitetura, utilizando o que há de mais moderno no
  Streamlit para transformar o software em uma ferramenta didática mais envolvente e profissional.

  ---

  1. Refatoração da Arquitetura de UI (Componentização)

  O arquivo app.py está começando a acumular muita lógica de interface. Sugiro mover os componentes para a pasta src/ui/components para facilitar a manutenção e reutilização.

  Sugestão de estrutura:
   - src/ui/components/sidebar.py: Gestão dos dados do aluno.
   - src/ui/components/filters.py: Lógica dos selectboxes de meios e testes.
   - src/ui/components/results.py: Cards de exibição das bactérias identificadas.

  2. Melhoria Visual e Didática (UX/UI)

  Para alunos de microbiologia, o reconhecimento visual é fundamental. Podemos substituir ou complementar os textos por elementos visuais:

   * Identificação de Gram Visual: Em vez de apenas um selectbox, use cores para reforçar o aprendizado.
       * Gram Positivo -> Roxo/Violeta.
       * Gram Negativo -> Rosa/Vermelho.
   * Uso de Tabs para Fluxo de Trabalho: Organize o processo laboratorial em etapas lógicas:

   1     tab1, tab2, tab3 = st.tabs(["🧫 Triagem Primária", "🧪 Meios e Cultivo", "🔬 Bioquímica Avançada"])
   * Métricas de Progresso: Use st.metric para mostrar quantas bactérias "sobreviveram" aos filtros em tempo real na barra lateral. Isso dá um feedback imediato do impacto de cada teste selecionado.

  3. Implementação de "Tooltips" Didáticos

  Muitos alunos podem esquecer o que cada teste avalia. Podemos injetar conhecimento no componente:

   1 st.selectbox(
   2     "Catalase", 
   3     options=["Não selecionado", "Positivo", "Negativo"],
   4     help="O teste da catalase detecta a presença da enzima que quebra o H2O2 em água e oxigênio. Diferencia Staphylococcus (+) de Streptococcus (-)."
   5 )

  4. Gestão de Estado (Session State)

  Atualmente, o botão de "Limpar Filtros" usa st.rerun(). Para uma UX mais suave, recomendo gerenciar os filtros via st.session_state. Isso permite que o aluno "desfaça" uma seleção sem recarregar toda a
  página e possibilita futuras funcionalidades como "Salvar Progresso".

  5. Feedback de Processamento (Simulation)

  Para dar uma sensação de "análise laboratorial", podemos usar o st.status (disponível nas versões recentes do Streamlit) ao realizar a identificação:

   1 with st.status("Analisando padrões bioquímicos...", expanded=False) as status:
   2     candidatas = service.identificar_bacteria(...)
   3     status.update(label=f"Análise concluída: {len(candidatas)} encontrada(s)", state="complete")

  ---

  Exemplo de Refatoração do app.py (Conceitual)

  Abaixo, um esboço de como o app.py ficaria mais limpo e profissional:

    1 import streamlit as st
    2 from src.ui.components import sidebar, filters, results
    3 from src.services.identificacao_service import IdentificacaoService
    4
    5 # Configuração e CSS Customizado
    6 st.set_page_config(page_title="MicroBuddy", layout="wide")
    7
    8 def main():
    9     # Estilização para cores de Gram
   10     st.markdown("""
   11         <style>
   12         .gram-pos { color: #6f42c1; font-weight: bold; }
   13         .gram-neg { color: #d63384; font-weight: bold; }
   14         </style>
   15     """, unsafe_allow_html=True)
   16
   17     service = IdentificacaoService()
   18     
   19     # 1. Sidebar com Metas de Identificação
   20     dados_aluno = sidebar.render()
   21     
   22     st.title("🔬 MicroBuddy")
   23     
   24     # 2. Tabs seguindo o fluxo real de bancada
   25     tab_triagem, tab_meios, tab_bioquimica = st.tabs([
   26         "🧫 1. Morfologia e Gram", 
   27         "🧪 2. Meios de Cultura", 
   28         "🧬 3. Testes Bioquímicos"
   29     ])
   30
   31     with tab_triagem:
   32         # Componente visual para Gram e Morfologia
   33         morf_gram = filters.render_triagem()
   34
   35     with tab_meios:
   36         selecoes_meios = filters.render_meios(service.obter_dados_iniciais()["meios"])
   37
   38     with tab_bioquimica:
   39         selecoes_testes = filters.render_testes(service.obter_dados_iniciais()["testes"])
   40
   41     # 3. Lógica de Identificação com Feedback Visual
   42     with st.container():
   43         st.divider()
   44         candidatas = service.identificar_bacteria(morf_gram, selecoes_meios, selecoes_testes)
   45         results.render_identification_area(candidatas, dados_aluno, service)
   46
   47 if __name__ == "__main__":
   48     main()

  6. Melhoria no Relatório (PDF)
  No ReportService, sugiro adicionar um campo de "Conclusão Clínica/Observações" onde o aluno pode digitar uma breve interpretação dos resultados antes de exportar, reforçando o caráter avaliativo da
  ferramenta.

  Próximos Passos Sugeridos:
   1. Criar o src/ui/components e mover a lógica de renderização para lá.
   2. Implementar o help nos selectboxes com as descrições técnicas dos testes.
   3. Melhorar a visualização das candidatas: Se houver mais de uma, mostrar uma tabela comparativa evidenciando qual teste falta para diferenciá-las.

  Você gostaria que eu prosseguisse com a implementação de alguma dessas refatorações específicas?