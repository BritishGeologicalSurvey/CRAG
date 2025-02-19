from reportlab.lib.styles import ParagraphStyle as PS
from reportlab.lib import colors
from reportlab.platypus import Paragraph, Table
from reportlab.platypus.doctemplate import PageTemplate, BaseDocTemplate
from reportlab.platypus.frames import Frame
from reportlab.platypus.flowables import KeepTogether
from reportlab.lib.units import cm


PROJECT_TABLE = {
    'project_lead': 'Project lead',
    'start_date': 'Start date',
    'end_date': 'End date',
    'description': 'Description',
    'notes': 'Notes'
}

LOCALITY_POINT_TABLE = {
    'locality_type_code': 'Locality type',
    'pdf_geometry': 'Location',
    'locality_description': 'Locality description',
    'map_face_note': 'Map face note',
    'geology_description': 'Geology description'
}

STRUCTURAL_MEASUREMENT_TABLE = {
    'measurement_type': 'Structure type',
    'dip_azimuth': 'Dip / Azimuth',
    'notes': 'Notes'
}

LITHOLOGY_TABLE = {
    'lithology': 'Lithology',
    'notes': 'Notes'
}

SAMPLE_TABLE = {
    'sample_id': 'Sample ID',
    'description': 'Sample type',
    'sample_description': 'Sample description'
}

SUPERFICIAL_TABLE = {
    'description': 'Superficial landform type',
    'notes': 'Notes'
}

MANMADE_TABLE = {
    'description': 'Manmade landform type',
    'notes': 'Notes'
}

SIMPLE_TABLES = {
    'structural_measurement': STRUCTURAL_MEASUREMENT_TABLE,
    'lithology': LITHOLOGY_TABLE,
    'sample': SAMPLE_TABLE,
    'superficial_landform': SUPERFICIAL_TABLE,
    'manmade_landform': MANMADE_TABLE
}

TABLE_SECTION_HEADINGS = {
    'structural_measurement': 'Structural measurements',
    'lithology': 'Lithologies',
    'sample': 'Samples',
    'superficial_landform': 'Superficial landforms',
    'manmade_landform': 'Manmade landforms'
}


class ReportTemplate(BaseDocTemplate):
    h1 = PS(name='Heading1', fontSize=18, spaceAfter=18)
    h2 = PS(name='Heading2', fontSize=16, spaceAfter=16)
    h3 = PS(name='Heading3', fontSize=14, spaceAfter=8)
    table_text = PS(name='TableTText', fontSize=12, spaceAfter=6)
    report = []

    def __init__(self, filename, **kw):
        self.allowSplitting = 0
        BaseDocTemplate.__init__(self, filename, **kw)
        template = PageTemplate('normal', [Frame(2 * cm, 2.5 * cm, 20 * cm, 25 * cm, id='F1')])
        self.addPageTemplates(template)

    def append_table(self, data, fields):
        """
        Build and return table with data using fields as a template
        """
        table_data = []
        for field, title in fields.items():
            field_text = ''
            if data[field] is not None:
                field_text = Paragraph(data[field])
            table_data.append([title, field_text])
        entered = [
            'Entered',
            Paragraph(data['user_entered'] + ' at ' + data['date_entered'])
        ]
        table_data.append(entered)
        if data['user_updated'] is not None:
            updated = [
                'Updated',
                Paragraph(data['user_updated'] + ' at ' + data['date_updated'])
            ]
            table_data.append(updated)

        # Define and style the table
        rows = len(table_data)
        table_style = [('GRID', (0, 0), (2, rows), 0.5, colors.black),
                       ('VALIGN', (0, 0), (2, rows), 'TOP')]
        table = Table(table_data,
                      colWidths=[5 * cm, 12 * cm],
                      style=table_style,
                      hAlign='LEFT',
                      spaceBefore=6,
                      spaceAfter=12)
        # Use KeepTogether to prevent table splitting over pages
        self.report.append(KeepTogether(table))

    def render(self, content):
        """
        Build the full report
        """
        self.report.append(Paragraph('Field Report: ' + content['project']['title'], self.h1))

        self.report.append(Paragraph('Project information', self.h2))
        self.append_table(content['project'], PROJECT_TABLE)

        self.report.append(Paragraph('Locality Points', self.h2))
        for locality_point_key, locality_point in content['locality_points'].items():
            self.report.append(Paragraph('Locality point: ' + locality_point_key, self.h3))
            self.append_table(locality_point, LOCALITY_POINT_TABLE)
            for table_section in SIMPLE_TABLES.keys():
                self.report.append(Paragraph(TABLE_SECTION_HEADINGS[table_section], self.h3))
                for table in locality_point['children'][table_section]:
                    self.append_table(table, SIMPLE_TABLES[table_section])

        self.multiBuild(self.report)
