from reportlab.lib.styles import ParagraphStyle as PS
from reportlab.lib import colors
from reportlab.platypus import Image, Paragraph, Table
from reportlab.platypus.doctemplate import PageTemplate, BaseDocTemplate
from reportlab.platypus.frames import Frame
from reportlab.platypus.flowables import KeepTogether, PageBreak
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

PHOTO_TABLE = {
    'photo_file': 'File name',
    'caption': 'Caption'
}

MEDIA_TABLE = {
    'media_link': 'File name',
    'media_description': 'Description'
}

TABLES = {
    'structural_measurement': STRUCTURAL_MEASUREMENT_TABLE,
    'lithology': LITHOLOGY_TABLE,
    'sample': SAMPLE_TABLE,
    'superficial_landform': SUPERFICIAL_TABLE,
    'manmade_landform': MANMADE_TABLE,
    'media': MEDIA_TABLE,
    'photo': PHOTO_TABLE
}

TABLE_SECTION_HEADINGS = {
    'structural_measurement': 'Structural measurements',
    'lithology': 'Lithologies',
    'sample': 'Samples',
    'superficial_landform': 'Superficial landforms',
    'manmade_landform': 'Manmade landforms',
    'photo': 'Photos',
    'media': 'Media Files'
}


class ReportTemplate(BaseDocTemplate):
    h1 = PS(name='Heading1', fontSize=18, spaceAfter=18)
    h2 = PS(name='Heading2', fontSize=16, spaceAfter=16)
    h3 = PS(name='Heading3', fontSize=14, spaceAfter=8)
    default_text = PS(name='DefaultText', fontSize=10,
                      spaceBefore=0, spaceAfter=0,
                      linkUnderline=1, underlineColor=colors.blue)
    error_text = PS(name='ErrorText', fontSize=14, textColor=colors.red)

    def __init__(self, filename, **kw):
        self.allowSplitting = 0
        BaseDocTemplate.__init__(self, filename, **kw)
        template = PageTemplate('normal', [Frame(2 * cm, 2.5 * cm, 20 * cm, 25 * cm, id='F1')])
        self.addPageTemplates(template)
        self.report = []

    def append_table(self, data, fields, header=None, photo=False, thumbnails_dir=None):
        """
        Build and return a table with data using fields as a template
        """
        table_data = []
        for field, title in fields.items():
            title_text = Paragraph(title, self.default_text)
            field_text = Paragraph('', self.default_text)
            if data[field] is not None:
                field_text = Paragraph(data[field], self.default_text)
            table_data.append([title_text, field_text])
        entered = [
            Paragraph('Entered', self.default_text),
            Paragraph(data['user_entered'] + ' at ' + data['date_entered'], self.default_text)
        ]
        table_data.append(entered)
        if data['user_updated'] is not None:
            updated = [
                Paragraph('Updated', self.default_text),
                Paragraph(data['user_updated'] + ' at ' + data['date_updated'], self.default_text)
            ]
            table_data.append(updated)

        # Define the table style
        rows = len(table_data)
        table_style = [('GRID', (0, 0), (2, rows), 0.5, colors.black),
                       ('VALIGN', (0, 0), (2, rows), 'TOP')]
        column_widths = [3.5 * cm, 13 * cm]

        # These parts are conditional on whether it is the photo table
        # The additional first column must be spanned over all rows
        # with the image being added to (0,0) and the first elements
        # of the remaining rows having an empty string value inserted.
        if photo:
            table_style.append(('SPAN', (0, 0), (0, rows - 1)))
            column_widths = [7.5 * cm, 2 * cm, 7 * cm]
            image_path = thumbnails_dir / data['photo_file']
            try:
                table_data[0].insert(0, Image(str(image_path)))
            except IOError:
                table_data[0].insert(0, Paragraph('Broken or missing thumbnail', self.error_text))
            for row in table_data[1:]:
                row.insert(0, '')

        table = Table(table_data,
                      colWidths=column_widths,
                      style=table_style,
                      hAlign='LEFT',
                      spaceBefore=6,
                      spaceAfter=12)

        # Use KeepTogether to prevent table splitting over pages
        if header:
            self.report.append(KeepTogether([header, table]))
        else:
            self.report.append(KeepTogether(table))

    def render(self, content, thumbnails_dir):
        """
        Build the full report
        """
        self.report.append(Paragraph('Field Report: ' + content['project']['title'], self.h1))
        self.report.append(Paragraph('Project information', self.h2))
        self.append_table(content['project'], PROJECT_TABLE)
        self.report.append(PageBreak())

        self.report.append(Paragraph('Locality Points', self.h2))
        for locality_point_key, locality_point in content['locality_points'].items():
            header = Paragraph('Locality point: ' + locality_point_key, self.h3)
            self.append_table(locality_point, LOCALITY_POINT_TABLE, header=header)
            for table_section in TABLES.keys():
                if locality_point['children'][table_section]:
                    # First table of a section needs a header
                    table = locality_point['children'][table_section][0]
                    header = Paragraph(TABLE_SECTION_HEADINGS[table_section], self.h3)
                    if table_section == 'photo':
                        self.append_table(table, TABLES[table_section], header=header,
                                          photo=True, thumbnails_dir=thumbnails_dir)
                    else:
                        self.append_table(table, TABLES[table_section], header=header)

                    # Remaining tables, if any
                    for table in locality_point['children'][table_section][1:]:
                        if table_section == 'photo':
                            self.append_table(table, TABLES[table_section], photo=True, thumbnails_dir=thumbnails_dir)
                        else:
                            self.append_table(table, TABLES[table_section])
            # Begin each set of locality point data on a new page...
            self.report.append(PageBreak())
        # ...but avoid a final empty page
        self.report.pop()
        self.multiBuild(self.report)
