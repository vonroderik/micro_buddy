from reportlab.lib.pagesizes import A4
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle
from io import BytesIO
from datetime import datetime

class ReportService:
    @staticmethod
    def generate_pdf(dados_aluno, identificacao, morfologia_gram, resultados_meios, resultados_testes):
        buffer = BytesIO()
        doc = SimpleDocTemplate(buffer, pagesize=A4)
        styles = getSampleStyleSheet()
        
        # Estilos Customizados
        title_style = ParagraphStyle(
            'TitleStyle',
            parent=styles['Heading1'],
            fontSize=18,
            alignment=1,
            spaceAfter=20
        )
        
        content = []
        
        # Cabeçalho
        content.append(Paragraph("Relatório de Identificação Microbiológica - MicroBuddy", title_style))
        content.append(Spacer(1, 12))
        
        # Informações do Aluno
        info_data = [
            ["Aluno/Grupo:", dados_aluno.get('nome', '')],
            ["Disciplina:", dados_aluno.get('disciplina', '')],
            ["Amostra:", dados_aluno.get('amostra', '')],
            ["Data:", datetime.now().strftime("%d/%m/%Y %H:%M")]
        ]
        t_info = Table(info_data, colWidths=[100, 350])
        t_info.setStyle(TableStyle([
            ('FONTNAME', (0,0), (0,-1), 'Helvetica-Bold'),
            ('BOTTOMPADDING', (0,0), (-1,-1), 6),
        ]))
        content.append(t_info)
        content.append(Spacer(1, 20))
        
        # Resultado Principal
        content.append(Paragraph("<b>Identificação Final:</b>", styles['Heading2']))
        res_text = f"<i>{identificacao.genero} {identificacao.especie}</i>" if identificacao else "Não identificada"
        content.append(Paragraph(res_text, styles['Normal']))
        content.append(Spacer(1, 15))
        
        # Morfologia e Gram
        content.append(Paragraph("<b>Morfologia e Gram:</b>", styles['Heading3']))
        m_data = [
            ["Morfologia:", morfologia_gram.get('morfologia', '')],
            ["Gram:", morfologia_gram.get('gram', '')]
        ]
        t_m = Table(m_data, colWidths=[100, 350])
        content.append(t_m)
        content.append(Spacer(1, 15))
        
        # Tabela de Meios
        content.append(Paragraph("<b>Meios de Cultura:</b>", styles['Heading3']))
        meio_data = [["Meio", "Resultado"]]
        for m in resultados_meios:
            meio_data.append([m['nome'], m['valor']])
        
        t_meio = Table(meio_data, colWidths=[200, 250])
        t_meio.setStyle(TableStyle([
            ('BACKGROUND', (0,0), (-1,0), colors.grey),
            ('TEXTCOLOR', (0,0), (-1,0), colors.whitesmoke),
            ('ALIGN', (0,0), (-1,-1), 'LEFT'),
            ('GRID', (0,0), (-1,-1), 0.5, colors.black),
            ('FONTNAME', (0,0), (-1,0), 'Helvetica-Bold'),
        ]))
        content.append(t_meio)
        content.append(Spacer(1, 15))
        
        # Tabela de Testes Bioquímicos
        content.append(Paragraph("<b>Testes Bioquímicos:</b>", styles['Heading3']))
        teste_data = [["Teste", "Resultado"]]
        for t in resultados_testes:
            teste_data.append([t['nome'], t['valor']])
            
        t_teste = Table(teste_data, colWidths=[200, 250])
        t_teste.setStyle(TableStyle([
            ('BACKGROUND', (0,0), (-1,0), colors.darkblue),
            ('TEXTCOLOR', (0,0), (-1,0), colors.whitesmoke),
            ('GRID', (0,0), (-1,-1), 0.5, colors.black),
            ('FONTNAME', (0,0), (-1,0), 'Helvetica-Bold'),
        ]))
        content.append(t_teste)
        
        doc.build(content)
        buffer.seek(0)
        return buffer
