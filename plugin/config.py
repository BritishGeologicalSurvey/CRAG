"""
Shared global variables used within the plugin.
"""

TABLES = {
    "features": [
        "locality_point",
    ],
    "attributes": [
        # Dictionaries
        "dic_exposure_type",
        "dic_rock_all",
        "dic_project_type",
        "dic_manmade_code",
        "dic_media",
        "dic_sample",
        "dic_structure_category",
        "dic_structure_code",
        "dic_superficial_category",
        "dic_superficial_code",
        # Attributes
        "exposure",
        "manmade_landform",
        "media",
        "photo",
        "sample",
        "structural_measurement",
        "superficial_landform",
        # Metadata
        "project",
    ]
}

FEATURE_TABLES = {table for table in TABLES['features']}
ATTRIBUTE_TABLES = {table for table in TABLES['attributes']
                    if not table.startswith('dic_')}
DICTIONARIES = {table for table in TABLES['attributes']
                if table.startswith('dic_')}