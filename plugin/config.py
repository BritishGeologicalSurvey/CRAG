"""
Shared global variables used within the plugin.
"""

TABLES = {
    "features": [
        "field_project",
        "locality_point",
        "bedrock_line",
        "superficial_line",
        "artificial_line",
        "mass_move_line",
        "terrain_line",
        # Views
        "view_structural_measurement",
        "view_lithology",
        "view_superficial_landform",
        "view_manmade_landform",
        "view_photo",
        "view_media",
        "view_sample",
    ],
    "attributes": [
        # Dictionaries
        "dic_line_type_artificial",
        "dic_line_type_bedrock",
        "dic_line_type_mass_move",
        "dic_line_type_superficial",
        "dic_line_type_terrain",
        "dic_locality_type",
        "dic_manmade_landform",
        "dic_media",
        "dic_rock_field",
        "dic_sample_material",
        "dic_structure",
        "dic_structure_secondary",
        "dic_structure_third",
        "dic_superficial_landform",
        # Attributes
        "lithology",
        "manmade_landform",
        "media",
        "photo",
        "sample",
        "structural_measurement",
        "superficial_landform",
        # Internal
        "_lnk_rock_project",
        "_view_next_locality_id",
    ]
}

VIEWS = {table for table in TABLES['features'] + TABLES['attributes']
         if table.startswith('view_')}
FEATURE_TABLES = {table for table in TABLES['features']}.difference(VIEWS)

FEATURE_TABLES_LINES = {table for table in FEATURE_TABLES
                        if table.endswith("_line")}

DICTIONARIES = {table for table in TABLES['attributes']
                if table.startswith('dic_')}

LINE_DICTIONARIES = {table for table in DICTIONARIES
                     if table.startswith("dic_line_")}

LOCALITY_DICTIONARIES = DICTIONARIES.difference(LINE_DICTIONARIES)

INTERNAL_TABLES = {table for table in TABLES['attributes']
                   if table.startswith('_')}

ATTRIBUTE_TABLES = {table for table in TABLES['attributes']
                    if not table.startswith("view")}.difference(DICTIONARIES, INTERNAL_TABLES)

TABLE_LIST = sorted(TABLES["features"] + TABLES["attributes"])

FEATURE_STR_IDENTIFIERS = {
    **{
        "locality_point": "name",
        "lithology": "lithology_code",
        "manmade_landform": "manmade_type_code",
        "media": "media_link",
        "photo": "photo_file",
        "sample": "sample_id",
        "structural_measurement": "structure_type_code",
        "superficial_landform": "superficial_type_code",
    },
    **{
        line_table: "line_type_code"
        for line_table in sorted(FEATURE_TABLES_LINES)
    },
}

LAYER_TREE_STRUCTURE = [
    {
        "group": None,
        "tables": ["locality_point"],
    },
    {
        "group": "lines",
        "tables": sorted(list(FEATURE_TABLES_LINES)),
    },
    {
        "group": "views",
        "tables": [
            "view_structural_measurement",
            "view_superficial_landform",
            "view_manmade_landform",
            "view_photo",
            "view_media",
            "view_sample",
            "view_lithology",
        ],
    },
    {
        "group": None,
        "tables": ["field_project"],
    },
    {
        "group": "locality_data",
        "tables": sorted(list(ATTRIBUTE_TABLES)),
    },
    {
        "group": "metadata",
        "tables": sorted(list(DICTIONARIES.union(INTERNAL_TABLES))),
    },
]

LAYER_TREE_STRUCTURE_INDEXED = {
    # First create a dictionary with all groups where the group is not None
    **{
        dict_item["group"]: dict_item["tables"]
        for dict_item in LAYER_TREE_STRUCTURE
        # Ignore items with no group as we need to combine them first
        if dict_item["group"] is not None
    },
    # Second, create an isolated dictionary where the only key is None
    # And it's value is the list of all tables with no group combined
    **{
        None: [
            table
            for dict_item in LAYER_TREE_STRUCTURE
            for table in dict_item["tables"]
            # Combine all items with no group
            if dict_item["group"] is None
        ]
    },
}

THUMBNAIL_SIZE = 500
PDF_THUMBNAIL_SCALE = 200 / THUMBNAIL_SIZE
