from sqlalchemy.orm import sessionmaker, joinedload
from database.connection import get_engine
from src.models.entities import Bacteria, MeioCultura, TesteGrupo, TesteParametro, BacteriaMeioCultura, BacteriaTesteResultado

class MicrobiologiaRepository:
    def __init__(self):
        self.engine = get_engine()
        self.Session = sessionmaker(bind=self.engine)

    def get_all_bacterias(self):
        with self.Session() as session:
            return session.query(Bacteria).all()

    def get_all_meios_cultura(self):
        with self.Session() as session:
            return session.query(MeioCultura).all()

    def get_all_testes_grupos(self):
        with self.Session() as session:
            # Carrega grupos e seus parâmetros usando joinedload para evitar DetachedInstanceError
            return session.query(TesteGrupo).options(joinedload(TesteGrupo.parametros)).all()

    def get_bacteria_by_id(self, bacteria_id):
        with self.Session() as session:
            return session.query(Bacteria).filter(Bacteria.id == bacteria_id).first()

    def get_bacteria_details(self, bacteria_id):
        """Retorna detalhes completos da bactéria incluindo meios e testes."""
        with self.Session() as session:
            # Usando joinedload para trazer tudo em uma única consulta eficiente
            bacteria = session.query(Bacteria).options(
                joinedload(Bacteria.meios_cultura).joinedload(BacteriaMeioCultura.meio),
                joinedload(Bacteria.testes_resultados).joinedload(BacteriaTesteResultado.parametro)
            ).filter(Bacteria.id == bacteria_id).first()
            
            if not bacteria:
                return None
            
            return {
                "bacteria": bacteria,
                "meios": bacteria.meios_cultura,
                "testes": bacteria.testes_resultados
            }
    
    def get_distinct_meio_options(self, meio_id):
        """Retorna as opções únicas de dropdown para um meio específico."""
        with self.Session() as session:
            results = session.query(BacteriaMeioCultura.opcao_dropdown)\
                .filter(BacteriaMeioCultura.meio_id == meio_id)\
                .distinct().all()
            return [r[0] for r in results]

    def get_distinct_teste_options(self, parametro_id):
        """Retorna as opções únicas de dropdown para um parâmetro de teste."""
        with self.Session() as session:
            results = session.query(BacteriaTesteResultado.opcao_dropdown)\
                .filter(BacteriaTesteResultado.parametro_id == parametro_id)\
                .distinct().all()
            return [r[0] for r in results]
