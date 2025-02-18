from reportlab.lib import colors
from reportlab.lib.styles import ParagraphStyle as PS
from reportlab.platypus import PageBreak, Paragraph, Table
from reportlab.platypus.doctemplate import PageTemplate, BaseDocTemplate
from reportlab.platypus.tableofcontents import TableOfContents
from reportlab.platypus.frames import Frame
from reportlab.lib.units import cm


class ReportTemplate(BaseDocTemplate):
    h1 = PS(name='Heading1', fontSize=18, spaceAfter=18)
    h2 = PS(name='Heading2', fontSize=16, spaceAfter=16)
    h3 = PS(name='Heading3', fontSize=14, spaceAfter=8)
    toc_entry = PS(name='TOCLocalityPoint', fontSize=12, spaceAfter=6)
    table_text = PS(name='TableTText', fontSize=12, spaceAfter=6)

    def __init__(self, filename, **kw):
        self.allowSplitting = 0
        BaseDocTemplate.__init__(self, filename, **kw)
        template = PageTemplate('normal', [Frame(2 * cm, 2.5 * cm, 20 * cm, 25 * cm, id='F1')])
        self.addPageTemplates(template)

    def afterFlowable(self, flowable):
        "Registers TOC entries."
        if flowable.__class__.__name__ == 'Paragraph':
            text = flowable.getPlainText()
            style = flowable.style.name
            if style == 'Heading2':
                self.notify('TOCEntry', (0, text, self.page))
            if style == 'Heading3':
                self.notify('TOCEntry', (1, text, self.page))

    def get_locality_point_table(self, locality_point):
        """
        Build and return table with locality point data
        """
        table_data = [
            ['Locality type',
                Paragraph(locality_point['locality_type_code'])],
            ['Location',
                Paragraph(locality_point['pdf_geometry'])],
            ['Locality description',
                Paragraph(locality_point['locality_description'])],
            ['Map face note',
                Paragraph(locality_point['map_face_note'])],
            ['Geology description',
                Paragraph(locality_point['geology_description'])],
            ['Entered',
                Paragraph(locality_point['user_entered'] + ' at ' + locality_point['date_entered'])],
        ]
        table_style = [('GRID', (0, 0), (2, 6), 1, colors.blue),
                       ('VALIGN', (0, 0), (2, 6), 'TOP')]
        table = Table(table_data,
                      colWidths=[5 * cm, 12 * cm],
                      style=table_style,
                      hAlign='LEFT',
                      spaceBefore=6,
                      spaceAfter=12)
        return table

    def render(self, content):
        """
        Build the full report
        """
        report = []
        toc = TableOfContents()
        toc.levelStyles = [self.h2, self.toc_entry]

        report.append(toc)
        report.append(PageBreak())
        report.append(Paragraph('Field Report: ' + content['project']['title'], self.h1))
        report.append(Paragraph('Project information', self.h2))

        report.append(Paragraph('Locality Points', self.h2))
        for locality_point_key, locality_point in content['locality_points'].items():
            report.append(Paragraph('Locality point: ' + locality_point_key, self.h3))
            table = self.get_locality_point_table(locality_point)
            report.append(table)

        self.multiBuild(report)
