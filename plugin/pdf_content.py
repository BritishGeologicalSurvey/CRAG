from reportlab.lib.styles import ParagraphStyle as PS
from reportlab.platypus import PageBreak
from reportlab.platypus.paragraph import Paragraph
from reportlab.platypus.doctemplate import PageTemplate, BaseDocTemplate
from reportlab.platypus.tableofcontents import TableOfContents
from reportlab.platypus.frames import Frame
from reportlab.lib.units import cm


class ReportTemplate(BaseDocTemplate):
    h1 = PS(name='Heading1', fontSize=18, leading=16)
    h2 = PS(name='Heading2', fontSize=16, leading=16)
    h3 = PS(name='Heading3', fontSize=14, leading=14)
    toc_entry = PS(name='TOCLocalityPoint', fontSize=12, leading=12)

    def __init__(self, filename, **kw):
        self.allowSplitting = 0
        BaseDocTemplate.__init__(self, filename, **kw)
        template = PageTemplate('normal', [Frame(2.5 * cm, 2.5 * cm, 15 * cm, 25 * cm, id='F1')])
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

    def render(self, content):

        report = []
        toc = TableOfContents()
        toc.levelStyles = [self.h2, self.toc_entry]

        report.append(toc)
        report.append(PageBreak())
        report.append(Paragraph('Field Report: ' + content['project']['title'], self.h1))
        report.append(Paragraph('Project information', self.h2))
        report.append(Paragraph('Locality Points', self.h2))
        for locality_point in content['locality_points'].keys():
            report.append(Paragraph('Locality point: ' + locality_point, self.h3))

        self.multiBuild(report)
