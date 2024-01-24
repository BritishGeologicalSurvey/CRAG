"""
Shared global variables used within the plugin.
"""

TABLES = {
    "features": [
        "locality_point",
        "bedrock_line",
        "superficial_line",
        "artificial_line",
        "mass_move_line",
        "terrain_line",
        # Views
        "view_structural_measurement",
        "view_lithology"
    ],
    "attributes": [
        # Dictionaries
        "dic_exposure_type",
        "dic_rock_all",
        "dic_field_project_type",
        "dic_line_type_artificial",
        "dic_line_type_bedrock",
        "dic_line_type_mass_move",
        "dic_line_type_superficial",
        "dic_line_type_terrain",
        "dic_manmade_code",
        "dic_media",
        "dic_rock_all",
        "dic_sample",
        "dic_structure_category",
        "dic_structure_code",
        "dic_superficial_category",
        "dic_superficial_code",
        # Attributes
        "lithology",
        "manmade_landform",
        "media",
        "photo",
        "sample",
        "structural_measurement",
        "superficial_landform",
        # Metadata
        "field_project",
        "view_next_locality_id",
    ]
}

VIEWS = {table for table in TABLES['features'] + TABLES['attributes']
         if table.startswith('view_')}
FEATURE_TABLES = {table for table in TABLES['features']}.difference(VIEWS)

FEATURE_TABLES_LINES = {table for table in FEATURE_TABLES
                        if table.endswith("_line")}

DICTIONARIES = {table for table in TABLES['attributes']
                if table.startswith('dic_')}
ATTRIBUTE_TABLES = {table for table in TABLES['attributes']
                    if not table.startswith("view")}.difference(DICTIONARIES)

TABLE_LIST = sorted(TABLES["features"] + TABLES["attributes"])

LOCALITY_POINT_CHILDREN = ATTRIBUTE_TABLES - {"field_project"}
