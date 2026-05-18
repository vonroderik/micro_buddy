from sqlalchemy import Column, Integer, String, Boolean, ForeignKey, CheckConstraint, UniqueConstraint
from sqlalchemy.orm import declarative_base, relationship

Base = declarative_base()

class Bacteria(Base):
    __tablename__ = 'bacteria'
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    genero = Column(String, nullable=False)
    especie = Column(String, nullable=False)
    morfologia = Column(String, nullable=False)
    gram = Column(String, nullable=False)
    
    __table_args__ = (
        CheckConstraint("morfologia IN ('coco', 'bastonete')"),
        CheckConstraint("gram IN ('positivo', 'negativo')"),
        UniqueConstraint('genero', 'especie', name='_genero_especie_uc'),
    )

    meios_cultura = relationship("BacteriaMeioCultura", back_populates="bacteria")
    testes_resultados = relationship("BacteriaTesteResultado", back_populates="bacteria")

    def __repr__(self):
        return f"<Bacteria(genero='{self.genero}', especie='{self.especie}')>"

class MeioCultura(Base):
    __tablename__ = 'meio_cultura'
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    nome = Column(String, nullable=False, unique=True)
    is_simples = Column(Boolean, nullable=False, default=False)
    is_seletivo = Column(Boolean, nullable=False, default=False)
    is_diferencial = Column(Boolean, nullable=False, default=False)

    bacterias = relationship("BacteriaMeioCultura", back_populates="meio")

class BacteriaMeioCultura(Base):
    __tablename__ = 'bacteria_meio_cultura'
    
    bacteria_id = Column(Integer, ForeignKey('bacteria.id', ondelete='CASCADE'), primary_key=True)
    meio_id = Column(Integer, ForeignKey('meio_cultura.id', ondelete='CASCADE'), primary_key=True)
    opcao_dropdown = Column(String, nullable=False)
    descricao_tecnica = Column(String, nullable=False)

    bacteria = relationship("Bacteria", back_populates="meios_cultura")
    meio = relationship("MeioCultura", back_populates="bacterias")

class TesteGrupo(Base):
    __tablename__ = 'teste_grupo'
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    nome = Column(String, nullable=False, unique=True)
    
    parametros = relationship("TesteParametro", back_populates="grupo")

class TesteParametro(Base):
    __tablename__ = 'teste_parametro'
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    grupo_id = Column(Integer, ForeignKey('teste_grupo.id', ondelete='CASCADE'), nullable=False)
    nome = Column(String, nullable=False)
    
    __table_args__ = (
        UniqueConstraint('grupo_id', 'nome', name='_grupo_parametro_uc'),
    )

    grupo = relationship("TesteGrupo", back_populates="parametros")
    resultados_bacterias = relationship("BacteriaTesteResultado", back_populates="parametro")

class BacteriaTesteResultado(Base):
    __tablename__ = 'bacteria_teste_resultado'
    
    bacteria_id = Column(Integer, ForeignKey('bacteria.id', ondelete='CASCADE'), primary_key=True)
    parametro_id = Column(Integer, ForeignKey('teste_parametro.id', ondelete='CASCADE'), primary_key=True)
    opcao_dropdown = Column(String, nullable=False)
    descricao_tecnica = Column(String, nullable=False)

    bacteria = relationship("Bacteria", back_populates="testes_resultados")
    parametro = relationship("TesteParametro", back_populates="resultados_bacterias")
