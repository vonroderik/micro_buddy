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

