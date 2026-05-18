from sqlalchemy import create_engine
import os

# Caminho absoluto para o banco de dados baseado na localização deste arquivo
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DATABASE_PATH = os.path.join(BASE_DIR, "identificacao_microbiologica.db")
DATABASE_URL = f"sqlite:///{DATABASE_PATH}"

def get_engine():
    return create_engine(DATABASE_URL)
