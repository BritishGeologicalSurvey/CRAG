<!--
Copyright 2026 UKRI / British Geological Survey
Licensed under GPLv3 licence
SPDX-License-Identifier: GPL-3.0-or-later
-->
<qgis labelsEnabled="1" styleCategories="Symbology|Labeling|Fields|Forms|MapTips" version="3.44.10-Solothurn">
  <renderer-v2 attr="line_type_code" enableorderby="0" forceraster="0" referencescale="-1" symbollevels="0" type="categorizedSymbol">
    <categories>
      <category label="air_photo_lineament" render="true" symbol="0" type="string" uuid="{69d4e521-88b5-43ac-b979-eadf0cfacbbd}" value="air_photo_lineament"></category>
      <category label="concave_break_of_slope" render="true" symbol="1" type="string" uuid="{e6e66333-7bac-4231-836d-0ea890018bd8}" value="concave_break_of_slope"></category>
      <category label="convex_break_of_slope" render="true" symbol="2" type="string" uuid="{6c8f48f9-bddb-4726-939d-e8016700bb84}" value="convex_break_of_slope"></category>
      <category label="dtm_lineament" render="true" symbol="3" type="string" uuid="{b4b78b60-6c5a-4340-8f09-5dbb2e1859c5}" value="dtm_lineament"></category>
      <category label="form_line" render="true" symbol="4" type="string" uuid="{ebcf69e9-04e1-41af-aad8-d90ef54c2f72}" value="form_line"></category>
      <category label="form_line_indicating_slope" render="true" symbol="5" type="string" uuid="{e5afb3a1-34d5-4502-90be-ec94bc9e15ae}" value="form_line_indicating_slope"></category>
      <category label="hollow_margin" render="true" symbol="6" type="string" uuid="{0cf3ee26-1fa2-4171-af4b-0c16ae0c92b5}" value="hollow_margin"></category>
      <category label="linear_negative_feature" render="true" symbol="7" type="string" uuid="{f1ea5753-2c1b-43fe-b321-19495da0bf0c}" value="linear_negative_feature"></category>
      <category label="linear_positive_feature_crestline" render="true" symbol="8" type="string" uuid="{5ac8cba5-0c1d-4ac5-ab45-995d3fab4281}" value="linear_positive_feature_crestline"></category>
    </categories>
    <symbols>
      <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="0" type="line">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" type="QString" value=""></Option>
            <Option name="properties"></Option>
            <Option name="type" type="QString" value="collection"></Option>
          </Option>
        </data_defined_properties>
        <layer class="SimpleLine" enabled="1" id="{fe168e0b-7535-4933-b7b6-c4196c87ee02}" locked="0" pass="0">
          <Option type="Map">
            <Option name="align_dash_pattern" type="QString" value="0"></Option>
            <Option name="capstyle" type="QString" value="flat"></Option>
            <Option name="customdash" type="QString" value="20;6"></Option>
            <Option name="customdash_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="customdash_unit" type="QString" value="Point"></Option>
            <Option name="dash_pattern_offset" type="QString" value="0"></Option>
            <Option name="dash_pattern_offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="dash_pattern_offset_unit" type="QString" value="MM"></Option>
            <Option name="draw_inside_polygon" type="QString" value="0"></Option>
            <Option name="joinstyle" type="QString" value="miter"></Option>
            <Option name="line_color" type="QString" value="230,152,0,255,rgb:0.9019608,0.5960784,0,1"></Option>
            <Option name="line_style" type="QString" value="solid"></Option>
            <Option name="line_width" type="QString" value="1"></Option>
            <Option name="line_width_unit" type="QString" value="Point"></Option>
            <Option name="offset" type="QString" value="0"></Option>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_unit" type="QString" value="MM"></Option>
            <Option name="ring_filter" type="QString" value="0"></Option>
            <Option name="trim_distance_end" type="QString" value="0"></Option>
            <Option name="trim_distance_end_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="trim_distance_end_unit" type="QString" value="MM"></Option>
            <Option name="trim_distance_start" type="QString" value="0"></Option>
            <Option name="trim_distance_start_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="trim_distance_start_unit" type="QString" value="MM"></Option>
            <Option name="tweak_dash_pattern_on_corners" type="QString" value="0"></Option>
            <Option name="use_custom_dash" type="QString" value="1"></Option>
            <Option name="width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties"></Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
          </data_defined_properties>
        </layer>
        <layer class="MarkerLine" enabled="1" id="{44172db2-8c5e-4998-ba76-bbbcf9a032ae}" locked="0" pass="0">
          <Option type="Map">
            <Option name="average_angle_length" type="QString" value="4"></Option>
            <Option name="average_angle_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="average_angle_unit" type="QString" value="MM"></Option>
            <Option name="interval" type="QString" value="26"></Option>
            <Option name="interval_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="interval_unit" type="QString" value="Point"></Option>
            <Option name="offset" type="QString" value="0"></Option>
            <Option name="offset_along_line" type="QString" value="23"></Option>
            <Option name="offset_along_line_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_along_line_unit" type="QString" value="Point"></Option>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_unit" type="QString" value="Point"></Option>
            <Option name="place_on_every_part" type="bool" value="true"></Option>
            <Option name="placements" type="QString" value="Interval"></Option>
            <Option name="ring_filter" type="QString" value="0"></Option>
            <Option name="rotate" type="QString" value="1"></Option>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties"></Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
          </data_defined_properties>
          <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="@0@1" type="marker">
            <data_defined_properties>
              <Option type="Map">
                <Option name="name" type="QString" value=""></Option>
                <Option name="properties"></Option>
                <Option name="type" type="QString" value="collection"></Option>
              </Option>
            </data_defined_properties>
            <layer class="SvgMarker" enabled="1" id="{4dad4f28-0d5e-476c-9314-ccb5d3883292}" locked="1" pass="0">
              <Option type="Map">
                <Option name="angle" type="QString" value="0"></Option>
                <Option name="color" type="QString" value="230,152,0,255,rgb:0.9019608,0.5960784,0,1"></Option>
                <Option name="fixedAspectRatio" type="QString" value="0"></Option>
                <Option name="horizontal_anchor_point" type="QString" value="1"></Option>
                <Option name="name" type="QString" value="base64:PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+Cjxzdmcgdmlld0JveD0iMC4yODkwNjMgLTQuMjQyMTkgMy44MjAzMSA0LjMzNTk0IgogeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgIHZlcnNpb249IjEuMiIgYmFzZVByb2ZpbGU9InRpbnkiPgo8dGl0bGU+UXQgU1ZHIERvY3VtZW50PC90aXRsZT4KPGRlc2M+R2VuZXJhdGVkIHdpdGggUXQ8L2Rlc2M+CjxkZWZzPgo8L2RlZnM+CjxnIGZpbGw9Im5vbmUiIHN0cm9rZT0iYmxhY2siIHN0cm9rZS13aWR0aD0iMSIgZmlsbC1ydWxlPSJldmVub2RkIiBzdHJva2UtbGluZWNhcD0ic3F1YXJlIiBzdHJva2UtbGluZWpvaW49ImJldmVsIiA+Cgo8ZyBmaWxsPSJwYXJhbShmaWxsKSIgZmlsbC1vcGFjaXR5PSJwYXJhbShmaWxsLW9wYWNpdHkpIiBzdHJva2U9InBhcmFtKG91dGxpbmUpIiBzdHJva2Utb3BhY2l0eT0icGFyYW0ob3V0bGluZS1vcGFjaXR5KSAxIiBzdHJva2Utd2lkdGg9InBhcmFtKG91dGxpbmUtd2lkdGgpIDAiIHRyYW5zZm9ybT0ibWF0cml4KDEsMCwwLDEsMCwwKSIKZm9udC1mYW1pbHk9Ik1TIFNoZWxsIERsZyAyIiBmb250LXNpemU9IjkuOCIgZm9udC13ZWlnaHQ9IjQwMCIgZm9udC1zdHlsZT0ibm9ybWFsIiAKPgo8cGF0aCB2ZWN0b3ItZWZmZWN0PSJub25lIiBmaWxsLXJ1bGU9Im5vbnplcm8iIGQ9Ik0zLjIzNDM4LC0wLjUxMTcxOSBDMi45NzM5NiwtMC4yOTAzNjUgMi43MjMzMSwtMC4xMzQxMTUgMi40ODI0MiwtMC4wNDI5Njg4IEMyLjI0MTU0LDAuMDQ4MTc3MSAxLjk4MzA3LDAuMDkzNzUgMS43MDcwMywwLjA5Mzc1IEMxLjI1MTMsMC4wOTM3NSAwLjkwMTA0MiwtMC4wMTc1NzgxIDAuNjU2MjUsLTAuMjQwMjM0IEMwLjQxMTQ1OCwtMC40NjI4OTEgMC4yODkwNjMsLTAuNzQ3Mzk2IDAuMjg5MDYzLC0xLjA5Mzc1IEMwLjI4OTA2MywtMS4yOTY4OCAwLjMzNTI4NiwtMS40ODI0MiAwLjQyNzczNCwtMS42NTAzOSBDMC41MjAxODIsLTEuODE4MzYgMC42NDEyNzYsLTEuOTUzMTMgMC43OTEwMTYsLTIuMDU0NjkgQzAuOTQwNzU1LC0yLjE1NjI1IDEuMTA5MzgsLTIuMjMzMDcgMS4yOTY4OCwtMi4yODUxNiBDMS40MzQ5LC0yLjMyMTYxIDEuNjQzMjMsLTIuMzU2NzcgMS45MjE4OCwtMi4zOTA2MyBDMi40ODk1OCwtMi40NTgzMyAyLjkwNzU1LC0yLjUzOTA2IDMuMTc1NzgsLTIuNjMyODEgQzMuMTc4MzksLTIuNzI5MTcgMy4xNzk2OSwtMi43OTAzNiAzLjE3OTY5LC0yLjgxNjQxIEMzLjE3OTY5LC0zLjEwMjg2IDMuMTEzMjgsLTMuMzA0NjkgMi45ODA0NywtMy40MjE4OCBDMi44MDA3OCwtMy41ODA3MyAyLjUzMzg1LC0zLjY2MDE2IDIuMTc5NjksLTMuNjYwMTYgQzEuODQ4OTYsLTMuNjYwMTYgMS42MDQ4MiwtMy42MDIyMSAxLjQ0NzI3LC0zLjQ4NjMzIEMxLjI4OTcxLC0zLjM3MDQ0IDEuMTczMTgsLTMuMTY1MzYgMS4wOTc2NiwtMi44NzEwOSBMMC40MTAxNTYsLTIuOTY0ODQgQzAuNDcyNjU2LC0zLjI1OTExIDAuNTc1NTIxLC0zLjQ5Njc0IDAuNzE4NzUsLTMuNjc3NzMgQzAuODYxOTc5LC0zLjg1ODcyIDEuMDY5MDEsLTMuOTk4MDUgMS4zMzk4NCwtNC4wOTU3IEMxLjYxMDY4LC00LjE5MzM2IDEuOTI0NDgsLTQuMjQyMTkgMi4yODEyNSwtNC4yNDIxOSBDMi42MzU0MiwtNC4yNDIxOSAyLjkyMzE4LC00LjIwMDUyIDMuMTQ0NTMsLTQuMTE3MTkgQzMuMzY1ODksLTQuMDMzODUgMy41Mjg2NSwtMy45MjkwNCAzLjYzMjgxLC0zLjgwMjczIEMzLjczNjk4LC0zLjY3NjQzIDMuODA5OSwtMy41MTY5MyAzLjg1MTU2LC0zLjMyNDIyIEMzLjg3NSwtMy4yMDQ0MyAzLjg4NjcyLC0yLjk4ODI4IDMuODg2NzIsLTIuNjc1NzggTDMuODg2NzIsLTEuNzM4MjggQzMuODg2NzIsLTEuMDg0NjQgMy45MDE2OSwtMC42NzEyMjQgMy45MzE2NCwtMC40OTgwNDcgQzMuOTYxNTksLTAuMzI0ODcgNC4wMjA4MywtMC4xNTg4NTQgNC4xMDkzOCwwIEwzLjM3NSwwIEMzLjMwMjA4LC0wLjE0NTgzMyAzLjI1NTIxLC0wLjMxNjQwNiAzLjIzNDM4LC0wLjUxMTcxOSBNMy4xNzU3OCwtMi4wODIwMyBDMi45MjA1NywtMS45Nzc4NiAyLjUzNzc2LC0xLjg4OTMyIDIuMDI3MzQsLTEuODE2NDEgQzEuNzM4MjgsLTEuNzc0NzQgMS41MzM4NSwtMS43Mjc4NiAxLjQxNDA2LC0xLjY3NTc4IEMxLjI5NDI3LC0xLjYyMzcgMS4yMDE4MiwtMS41NDc1MyAxLjEzNjcyLC0xLjQ0NzI3IEMxLjA3MTYxLC0xLjM0NzAxIDEuMDM5MDYsLTEuMjM1NjggMS4wMzkwNiwtMS4xMTMyOCBDMS4wMzkwNiwtMC45MjU3ODEgMS4xMTAwMywtMC43Njk1MzEgMS4yNTE5NSwtMC42NDQ1MzEgQzEuMzkzODgsLTAuNTE5NTMxIDEuNjAxNTYsLTAuNDU3MDMxIDEuODc1LC0wLjQ1NzAzMSBDMi4xNDU4MywtMC40NTcwMzEgMi4zODY3MiwtMC41MTYyNzYgMi41OTc2NiwtMC42MzQ3NjYgQzIuODA4NTksLTAuNzUzMjU1IDIuOTYzNTQsLTAuOTE1MzY1IDMuMDYyNSwtMS4xMjEwOSBDMy4xMzgwMiwtMS4yNzk5NSAzLjE3NTc4LC0xLjUxNDMyIDMuMTc1NzgsLTEuODI0MjIgTDMuMTc1NzgsLTIuMDgyMDMiLz4KPC9nPgo8L2c+Cjwvc3ZnPgo="></Option>
                <Option name="offset" type="QString" value="0,0"></Option>
                <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="offset_unit" type="QString" value="Point"></Option>
                <Option name="outline_color" type="QString" value="230,152,0,255,rgb:0.9019608,0.5960784,0,1"></Option>
                <Option name="outline_width" type="QString" value="0"></Option>
                <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="outline_width_unit" type="QString" value="Point"></Option>
                <Option name="parameters"></Option>
                <Option name="scale_method" type="QString" value="diameter"></Option>
                <Option name="size" type="QString" value="2.68454"></Option>
                <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="size_unit" type="QString" value="Point"></Option>
                <Option name="vertical_anchor_point" type="QString" value="1"></Option>
              </Option>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" type="QString" value=""></Option>
                  <Option name="properties"></Option>
                  <Option name="type" type="QString" value="collection"></Option>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="1" type="line">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" type="QString" value=""></Option>
            <Option name="properties"></Option>
            <Option name="type" type="QString" value="collection"></Option>
          </Option>
        </data_defined_properties>
        <layer class="SimpleLine" enabled="1" id="{652775fe-ee6a-40ee-873a-81026eaa4b38}" locked="0" pass="0">
          <Option type="Map">
            <Option name="align_dash_pattern" type="QString" value="0"></Option>
            <Option name="capstyle" type="QString" value="flat"></Option>
            <Option name="customdash" type="QString" value="10;4"></Option>
            <Option name="customdash_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="customdash_unit" type="QString" value="Point"></Option>
            <Option name="dash_pattern_offset" type="QString" value="0"></Option>
            <Option name="dash_pattern_offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="dash_pattern_offset_unit" type="QString" value="MM"></Option>
            <Option name="draw_inside_polygon" type="QString" value="0"></Option>
            <Option name="joinstyle" type="QString" value="miter"></Option>
            <Option name="line_color" type="QString" value="230,152,0,255,rgb:0.9019608,0.5960784,0,1"></Option>
            <Option name="line_style" type="QString" value="solid"></Option>
            <Option name="line_width" type="QString" value="1"></Option>
            <Option name="line_width_unit" type="QString" value="Point"></Option>
            <Option name="offset" type="QString" value="0"></Option>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_unit" type="QString" value="MM"></Option>
            <Option name="ring_filter" type="QString" value="0"></Option>
            <Option name="trim_distance_end" type="QString" value="0"></Option>
            <Option name="trim_distance_end_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="trim_distance_end_unit" type="QString" value="MM"></Option>
            <Option name="trim_distance_start" type="QString" value="0"></Option>
            <Option name="trim_distance_start_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="trim_distance_start_unit" type="QString" value="MM"></Option>
            <Option name="tweak_dash_pattern_on_corners" type="QString" value="0"></Option>
            <Option name="use_custom_dash" type="QString" value="1"></Option>
            <Option name="width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties"></Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
          </data_defined_properties>
        </layer>
        <layer class="MarkerLine" enabled="1" id="{fe1acb6b-f70b-4690-a795-3a179a701e96}" locked="0" pass="0">
          <Option type="Map">
            <Option name="average_angle_length" type="QString" value="4"></Option>
            <Option name="average_angle_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="average_angle_unit" type="QString" value="MM"></Option>
            <Option name="interval" type="QString" value="28"></Option>
            <Option name="interval_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="interval_unit" type="QString" value="Point"></Option>
            <Option name="offset" type="QString" value="-1.8"></Option>
            <Option name="offset_along_line" type="QString" value="5"></Option>
            <Option name="offset_along_line_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_along_line_unit" type="QString" value="Point"></Option>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_unit" type="QString" value="Point"></Option>
            <Option name="place_on_every_part" type="bool" value="true"></Option>
            <Option name="placements" type="QString" value="Interval"></Option>
            <Option name="ring_filter" type="QString" value="0"></Option>
            <Option name="rotate" type="QString" value="1"></Option>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties"></Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
          </data_defined_properties>
          <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="@1@1" type="marker">
            <data_defined_properties>
              <Option type="Map">
                <Option name="name" type="QString" value=""></Option>
                <Option name="properties"></Option>
                <Option name="type" type="QString" value="collection"></Option>
              </Option>
            </data_defined_properties>
            <layer class="SvgMarker" enabled="1" id="{c1c1cf22-ec5b-463e-9228-46b16013f8b0}" locked="1" pass="0">
              <Option type="Map">
                <Option name="angle" type="QString" value="0"></Option>
                <Option name="color" type="QString" value="230,152,0,255,rgb:0.9019608,0.5960784,0,1"></Option>
                <Option name="fixedAspectRatio" type="QString" value="0"></Option>
                <Option name="horizontal_anchor_point" type="QString" value="1"></Option>
                <Option name="name" type="QString" value="base64:PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+Cjxzdmcgdmlld0JveD0iMC4wMzA3NjE3IC01LjAxMDc0IDQuNTgzNSA1LjAxMDc0IgogeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgIHZlcnNpb249IjEuMiIgYmFzZVByb2ZpbGU9InRpbnkiPgo8dGl0bGU+UXQgU1ZHIERvY3VtZW50PC90aXRsZT4KPGRlc2M+R2VuZXJhdGVkIHdpdGggUXQ8L2Rlc2M+CjxkZWZzPgo8L2RlZnM+CjxnIGZpbGw9Im5vbmUiIHN0cm9rZT0iYmxhY2siIHN0cm9rZS13aWR0aD0iMSIgZmlsbC1ydWxlPSJldmVub2RkIiBzdHJva2UtbGluZWNhcD0ic3F1YXJlIiBzdHJva2UtbGluZWpvaW49ImJldmVsIiA+Cgo8ZyBmaWxsPSJwYXJhbShmaWxsKSIgZmlsbC1vcGFjaXR5PSJwYXJhbShmaWxsLW9wYWNpdHkpIiBzdHJva2U9InBhcmFtKG91dGxpbmUpIiBzdHJva2Utb3BhY2l0eT0icGFyYW0ob3V0bGluZS1vcGFjaXR5KSAxIiBzdHJva2Utd2lkdGg9InBhcmFtKG91dGxpbmUtd2lkdGgpIDAiIHRyYW5zZm9ybT0ibWF0cml4KDEsMCwwLDEsMCwwKSIKZm9udC1mYW1pbHk9Ik1TIFNoZWxsIERsZyAyIiBmb250LXNpemU9IjkuOCIgZm9udC13ZWlnaHQ9IjQwMCIgZm9udC1zdHlsZT0ibm9ybWFsIiAKPgo8cGF0aCB2ZWN0b3ItZWZmZWN0PSJub25lIiBmaWxsLXJ1bGU9Im5vbnplcm8iIGQ9Ik0xLjk3MjE3LDAgTDAuMDMwNzYxNywtNS4wMTA3NCBMMC43NDg1MzUsLTUuMDEwNzQgTDIuMDUwNzgsLTEuMzcwNjEgQzIuMTU1NiwtMS4wNzg5NCAyLjI0MzMzLC0wLjgwNTUwMSAyLjMxMzk2LC0wLjU1MDI5MyBDMi4zOTE0NCwtMC44MjM3MyAyLjQ4MTQ1LC0xLjA5NzE3IDIuNTgzOTgsLTEuMzcwNjEgTDMuOTM3NSwtNS4wMTA3NCBMNC42MTQyNiwtNS4wMTA3NCBMMi42NTIzNCwwIEwxLjk3MjE3LDAiLz4KPC9nPgo8L2c+Cjwvc3ZnPgo="></Option>
                <Option name="offset" type="QString" value="0,0"></Option>
                <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="offset_unit" type="QString" value="Point"></Option>
                <Option name="outline_color" type="QString" value="0,0,0,0,rgb:0,0,0,0"></Option>
                <Option name="outline_width" type="QString" value="0"></Option>
                <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="outline_width_unit" type="QString" value="Point"></Option>
                <Option name="parameters"></Option>
                <Option name="scale_method" type="QString" value="diameter"></Option>
                <Option name="size" type="QString" value="3.22084"></Option>
                <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="size_unit" type="QString" value="Point"></Option>
                <Option name="vertical_anchor_point" type="QString" value="1"></Option>
              </Option>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" type="QString" value=""></Option>
                  <Option name="properties"></Option>
                  <Option name="type" type="QString" value="collection"></Option>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="2" type="line">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" type="QString" value=""></Option>
            <Option name="properties"></Option>
            <Option name="type" type="QString" value="collection"></Option>
          </Option>
        </data_defined_properties>
        <layer class="SimpleLine" enabled="1" id="{4f032119-e890-4639-b1d1-1c48ac727501}" locked="0" pass="0">
          <Option type="Map">
            <Option name="align_dash_pattern" type="QString" value="0"></Option>
            <Option name="capstyle" type="QString" value="flat"></Option>
            <Option name="customdash" type="QString" value="10;4"></Option>
            <Option name="customdash_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="customdash_unit" type="QString" value="Point"></Option>
            <Option name="dash_pattern_offset" type="QString" value="0"></Option>
            <Option name="dash_pattern_offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="dash_pattern_offset_unit" type="QString" value="MM"></Option>
            <Option name="draw_inside_polygon" type="QString" value="0"></Option>
            <Option name="joinstyle" type="QString" value="miter"></Option>
            <Option name="line_color" type="QString" value="230,152,0,255,rgb:0.9019608,0.5960784,0,1"></Option>
            <Option name="line_style" type="QString" value="solid"></Option>
            <Option name="line_width" type="QString" value="1"></Option>
            <Option name="line_width_unit" type="QString" value="Point"></Option>
            <Option name="offset" type="QString" value="0"></Option>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_unit" type="QString" value="MM"></Option>
            <Option name="ring_filter" type="QString" value="0"></Option>
            <Option name="trim_distance_end" type="QString" value="0"></Option>
            <Option name="trim_distance_end_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="trim_distance_end_unit" type="QString" value="MM"></Option>
            <Option name="trim_distance_start" type="QString" value="0"></Option>
            <Option name="trim_distance_start_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="trim_distance_start_unit" type="QString" value="MM"></Option>
            <Option name="tweak_dash_pattern_on_corners" type="QString" value="0"></Option>
            <Option name="use_custom_dash" type="QString" value="1"></Option>
            <Option name="width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties"></Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
          </data_defined_properties>
        </layer>
        <layer class="MarkerLine" enabled="1" id="{f5a4a50b-39a6-4c88-8a13-d90a8d1e59a3}" locked="0" pass="0">
          <Option type="Map">
            <Option name="average_angle_length" type="QString" value="4"></Option>
            <Option name="average_angle_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="average_angle_unit" type="QString" value="MM"></Option>
            <Option name="interval" type="QString" value="28"></Option>
            <Option name="interval_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="interval_unit" type="QString" value="Point"></Option>
            <Option name="offset" type="QString" value="-1.8"></Option>
            <Option name="offset_along_line" type="QString" value="5"></Option>
            <Option name="offset_along_line_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_along_line_unit" type="QString" value="Point"></Option>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_unit" type="QString" value="Point"></Option>
            <Option name="place_on_every_part" type="bool" value="true"></Option>
            <Option name="placements" type="QString" value="Interval"></Option>
            <Option name="ring_filter" type="QString" value="0"></Option>
            <Option name="rotate" type="QString" value="1"></Option>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties"></Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
          </data_defined_properties>
          <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="@2@1" type="marker">
            <data_defined_properties>
              <Option type="Map">
                <Option name="name" type="QString" value=""></Option>
                <Option name="properties"></Option>
                <Option name="type" type="QString" value="collection"></Option>
              </Option>
            </data_defined_properties>
            <layer class="SvgMarker" enabled="1" id="{0200c499-0f54-4080-8d73-faadfcb2400b}" locked="1" pass="0">
              <Option type="Map">
                <Option name="angle" type="QString" value="-180"></Option>
                <Option name="color" type="QString" value="230,152,0,255,rgb:0.9019608,0.5960784,0,1"></Option>
                <Option name="fixedAspectRatio" type="QString" value="0"></Option>
                <Option name="horizontal_anchor_point" type="QString" value="1"></Option>
                <Option name="name" type="QString" value="base64:PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+Cjxzdmcgdmlld0JveD0iMC4wMzA3NjE3IC01LjAxMDc0IDQuNTgzNSA1LjAxMDc0IgogeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgIHZlcnNpb249IjEuMiIgYmFzZVByb2ZpbGU9InRpbnkiPgo8dGl0bGU+UXQgU1ZHIERvY3VtZW50PC90aXRsZT4KPGRlc2M+R2VuZXJhdGVkIHdpdGggUXQ8L2Rlc2M+CjxkZWZzPgo8L2RlZnM+CjxnIGZpbGw9Im5vbmUiIHN0cm9rZT0iYmxhY2siIHN0cm9rZS13aWR0aD0iMSIgZmlsbC1ydWxlPSJldmVub2RkIiBzdHJva2UtbGluZWNhcD0ic3F1YXJlIiBzdHJva2UtbGluZWpvaW49ImJldmVsIiA+Cgo8ZyBmaWxsPSJwYXJhbShmaWxsKSIgZmlsbC1vcGFjaXR5PSJwYXJhbShmaWxsLW9wYWNpdHkpIiBzdHJva2U9InBhcmFtKG91dGxpbmUpIiBzdHJva2Utb3BhY2l0eT0icGFyYW0ob3V0bGluZS1vcGFjaXR5KSAxIiBzdHJva2Utd2lkdGg9InBhcmFtKG91dGxpbmUtd2lkdGgpIDAiIHRyYW5zZm9ybT0ibWF0cml4KDEsMCwwLDEsMCwwKSIKZm9udC1mYW1pbHk9Ik1TIFNoZWxsIERsZyAyIiBmb250LXNpemU9IjkuOCIgZm9udC13ZWlnaHQ9IjQwMCIgZm9udC1zdHlsZT0ibm9ybWFsIiAKPgo8cGF0aCB2ZWN0b3ItZWZmZWN0PSJub25lIiBmaWxsLXJ1bGU9Im5vbnplcm8iIGQ9Ik0xLjk3MjE3LDAgTDAuMDMwNzYxNywtNS4wMTA3NCBMMC43NDg1MzUsLTUuMDEwNzQgTDIuMDUwNzgsLTEuMzcwNjEgQzIuMTU1NiwtMS4wNzg5NCAyLjI0MzMzLC0wLjgwNTUwMSAyLjMxMzk2LC0wLjU1MDI5MyBDMi4zOTE0NCwtMC44MjM3MyAyLjQ4MTQ1LC0xLjA5NzE3IDIuNTgzOTgsLTEuMzcwNjEgTDMuOTM3NSwtNS4wMTA3NCBMNC42MTQyNiwtNS4wMTA3NCBMMi42NTIzNCwwIEwxLjk3MjE3LDAiLz4KPC9nPgo8L2c+Cjwvc3ZnPgo="></Option>
                <Option name="offset" type="QString" value="0,0"></Option>
                <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="offset_unit" type="QString" value="Point"></Option>
                <Option name="outline_color" type="QString" value="0,0,0,0,rgb:0,0,0,0"></Option>
                <Option name="outline_width" type="QString" value="0"></Option>
                <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="outline_width_unit" type="QString" value="Point"></Option>
                <Option name="parameters"></Option>
                <Option name="scale_method" type="QString" value="diameter"></Option>
                <Option name="size" type="QString" value="3.22084"></Option>
                <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="size_unit" type="QString" value="Point"></Option>
                <Option name="vertical_anchor_point" type="QString" value="1"></Option>
              </Option>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" type="QString" value=""></Option>
                  <Option name="properties"></Option>
                  <Option name="type" type="QString" value="collection"></Option>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="3" type="line">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" type="QString" value=""></Option>
            <Option name="properties"></Option>
            <Option name="type" type="QString" value="collection"></Option>
          </Option>
        </data_defined_properties>
        <layer class="SimpleLine" enabled="1" id="{9bd61755-b84d-4be1-8306-e8559b5ac8d8}" locked="0" pass="0">
          <Option type="Map">
            <Option name="align_dash_pattern" type="QString" value="0"></Option>
            <Option name="capstyle" type="QString" value="flat"></Option>
            <Option name="customdash" type="QString" value="16;4;16;13"></Option>
            <Option name="customdash_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="customdash_unit" type="QString" value="Point"></Option>
            <Option name="dash_pattern_offset" type="QString" value="0"></Option>
            <Option name="dash_pattern_offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="dash_pattern_offset_unit" type="QString" value="MM"></Option>
            <Option name="draw_inside_polygon" type="QString" value="0"></Option>
            <Option name="joinstyle" type="QString" value="miter"></Option>
            <Option name="line_color" type="QString" value="230,152,0,255,rgb:0.9019608,0.5960784,0,1"></Option>
            <Option name="line_style" type="QString" value="solid"></Option>
            <Option name="line_width" type="QString" value="1"></Option>
            <Option name="line_width_unit" type="QString" value="Point"></Option>
            <Option name="offset" type="QString" value="0"></Option>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_unit" type="QString" value="MM"></Option>
            <Option name="ring_filter" type="QString" value="0"></Option>
            <Option name="trim_distance_end" type="QString" value="0"></Option>
            <Option name="trim_distance_end_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="trim_distance_end_unit" type="QString" value="MM"></Option>
            <Option name="trim_distance_start" type="QString" value="0"></Option>
            <Option name="trim_distance_start_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="trim_distance_start_unit" type="QString" value="MM"></Option>
            <Option name="tweak_dash_pattern_on_corners" type="QString" value="0"></Option>
            <Option name="use_custom_dash" type="QString" value="1"></Option>
            <Option name="width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties"></Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
          </data_defined_properties>
        </layer>
        <layer class="MarkerLine" enabled="1" id="{a8a2f48e-e4b4-4f24-a0cd-30a97f53f5ce}" locked="0" pass="0">
          <Option type="Map">
            <Option name="average_angle_length" type="QString" value="4"></Option>
            <Option name="average_angle_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="average_angle_unit" type="QString" value="MM"></Option>
            <Option name="interval" type="QString" value="49"></Option>
            <Option name="interval_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="interval_unit" type="QString" value="Point"></Option>
            <Option name="offset" type="QString" value="0.5"></Option>
            <Option name="offset_along_line" type="QString" value="45.6"></Option>
            <Option name="offset_along_line_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_along_line_unit" type="QString" value="Point"></Option>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_unit" type="QString" value="Point"></Option>
            <Option name="place_on_every_part" type="bool" value="true"></Option>
            <Option name="placements" type="QString" value="Interval"></Option>
            <Option name="ring_filter" type="QString" value="0"></Option>
            <Option name="rotate" type="QString" value="1"></Option>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties"></Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
          </data_defined_properties>
          <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="@3@1" type="marker">
            <data_defined_properties>
              <Option type="Map">
                <Option name="name" type="QString" value=""></Option>
                <Option name="properties"></Option>
                <Option name="type" type="QString" value="collection"></Option>
              </Option>
            </data_defined_properties>
            <layer class="SvgMarker" enabled="1" id="{e12f959e-b4ba-42b5-bbc9-f2cee3394c64}" locked="1" pass="0">
              <Option type="Map">
                <Option name="angle" type="QString" value="0"></Option>
                <Option name="color" type="QString" value="230,152,0,255,rgb:0.9019608,0.5960784,0,1"></Option>
                <Option name="fixedAspectRatio" type="QString" value="0"></Option>
                <Option name="horizontal_anchor_point" type="QString" value="1"></Option>
                <Option name="name" type="QString" value="base64:PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+Cjxzdmcgdmlld0JveD0iMC41MjczNDQgLTQuMjQyMTkgNS42MjEwOSA0LjI0MjE5IgogeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgIHZlcnNpb249IjEuMiIgYmFzZVByb2ZpbGU9InRpbnkiPgo8dGl0bGU+UXQgU1ZHIERvY3VtZW50PC90aXRsZT4KPGRlc2M+R2VuZXJhdGVkIHdpdGggUXQ8L2Rlc2M+CjxkZWZzPgo8L2RlZnM+CjxnIGZpbGw9Im5vbmUiIHN0cm9rZT0iYmxhY2siIHN0cm9rZS13aWR0aD0iMSIgZmlsbC1ydWxlPSJldmVub2RkIiBzdHJva2UtbGluZWNhcD0ic3F1YXJlIiBzdHJva2UtbGluZWpvaW49ImJldmVsIiA+Cgo8ZyBmaWxsPSJwYXJhbShmaWxsKSIgZmlsbC1vcGFjaXR5PSJwYXJhbShmaWxsLW9wYWNpdHkpIiBzdHJva2U9InBhcmFtKG91dGxpbmUpIiBzdHJva2Utb3BhY2l0eT0icGFyYW0ob3V0bGluZS1vcGFjaXR5KSAxIiBzdHJva2Utd2lkdGg9InBhcmFtKG91dGxpbmUtd2lkdGgpIDAiIHRyYW5zZm9ybT0ibWF0cml4KDEsMCwwLDEsMCwwKSIKZm9udC1mYW1pbHk9Ik1TIFNoZWxsIERsZyAyIiBmb250LXNpemU9IjkuOCIgZm9udC13ZWlnaHQ9IjQwMCIgZm9udC1zdHlsZT0ibm9ybWFsIiAKPgo8cGF0aCB2ZWN0b3ItZWZmZWN0PSJub25lIiBmaWxsLXJ1bGU9Im5vbnplcm8iIGQ9Ik0wLjUyNzM0NCwwIEwwLjUyNzM0NCwtNC4xNDg0NCBMMS4xNTYyNSwtNC4xNDg0NCBMMS4xNTYyNSwtMy41NjY0MSBDMS4yODY0NiwtMy43Njk1MyAxLjQ1OTY0LC0zLjkzMjk0IDEuNjc1NzgsLTQuMDU2NjQgQzEuODkxOTMsLTQuMTgwMzQgMi4xMzgwMiwtNC4yNDIxOSAyLjQxNDA2LC00LjI0MjE5IEMyLjcyMTM1LC00LjI0MjE5IDIuOTczMzEsLTQuMTc4MzkgMy4xNjk5MiwtNC4wNTA3OCBDMy4zNjY1NCwtMy45MjMxOCAzLjUwNTIxLC0zLjc0NDc5IDMuNTg1OTQsLTMuNTE1NjMgQzMuOTE0MDYsLTQgNC4zNDExNSwtNC4yNDIxOSA0Ljg2NzE5LC00LjI0MjE5IEM1LjI3ODY1LC00LjI0MjE5IDUuNTk1MDUsLTQuMTI4MjUgNS44MTY0MSwtMy45MDAzOSBDNi4wMzc3NiwtMy42NzI1MyA2LjE0ODQ0LC0zLjMyMTYxIDYuMTQ4NDQsLTIuODQ3NjYgTDYuMTQ4NDQsMCBMNS40NDkyMiwwIEw1LjQ0OTIyLC0yLjYxMzI4IEM1LjQ0OTIyLC0yLjg5NDUzIDUuNDI2NDMsLTMuMDk3IDUuMzgwODYsLTMuMjIwNyBDNS4zMzUyOSwtMy4zNDQ0IDUuMjUyNiwtMy40NDQwMSA1LjEzMjgxLC0zLjUxOTUzIEM1LjAxMzAyLC0zLjU5NTA1IDQuODcyNCwtMy42MzI4MSA0LjcxMDk0LC0zLjYzMjgxIEM0LjQxOTI3LC0zLjYzMjgxIDQuMTc3MDgsLTMuNTM1ODEgMy45ODQzOCwtMy4zNDE4IEMzLjc5MTY3LC0zLjE0Nzc5IDMuNjk1MzEsLTIuODM3MjQgMy42OTUzMSwtMi40MTAxNiBMMy42OTUzMSwwIEwyLjk5MjE5LDAgTDIuOTkyMTksLTIuNjk1MzEgQzIuOTkyMTksLTMuMDA3ODEgMi45MzQ5LC0zLjI0MjE5IDIuODIwMzEsLTMuMzk4NDQgQzIuNzA1NzMsLTMuNTU0NjkgMi41MTgyMywtMy42MzI4MSAyLjI1NzgxLC0zLjYzMjgxIEMyLjA1OTksLTMuNjMyODEgMS44NzY5NSwtMy41ODA3MyAxLjcwODk4LC0zLjQ3NjU2IEMxLjU0MTAyLC0zLjM3MjQgMS40MTkyNywtMy4yMjAwNSAxLjM0Mzc1LC0zLjAxOTUzIEMxLjI2ODIzLC0yLjgxOTAxIDEuMjMwNDcsLTIuNTI5OTUgMS4yMzA0NywtMi4xNTIzNCBMMS4yMzA0NywwIEwwLjUyNzM0NCwwIi8+CjwvZz4KPC9nPgo8L3N2Zz4K"></Option>
                <Option name="offset" type="QString" value="0,0"></Option>
                <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="offset_unit" type="QString" value="Point"></Option>
                <Option name="outline_color" type="QString" value="0,127,127,255,cmyk:1,0.50000762951094835,0.50000762951094835,0,1"></Option>
                <Option name="outline_width" type="QString" value="0"></Option>
                <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="outline_width_unit" type="QString" value="Point"></Option>
                <Option name="parameters"></Option>
                <Option name="scale_method" type="QString" value="diameter"></Option>
                <Option name="size" type="QString" value="3.94996"></Option>
                <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="size_unit" type="QString" value="Point"></Option>
                <Option name="vertical_anchor_point" type="QString" value="1"></Option>
              </Option>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" type="QString" value=""></Option>
                  <Option name="properties"></Option>
                  <Option name="type" type="QString" value="collection"></Option>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
        <layer class="MarkerLine" enabled="1" id="{381d9f5e-6d94-4f48-a7b9-c9650f248e41}" locked="0" pass="0">
          <Option type="Map">
            <Option name="average_angle_length" type="QString" value="4"></Option>
            <Option name="average_angle_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="average_angle_unit" type="QString" value="MM"></Option>
            <Option name="interval" type="QString" value="49"></Option>
            <Option name="interval_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="interval_unit" type="QString" value="Point"></Option>
            <Option name="offset" type="QString" value="0"></Option>
            <Option name="offset_along_line" type="QString" value="41.8"></Option>
            <Option name="offset_along_line_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_along_line_unit" type="QString" value="Point"></Option>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_unit" type="QString" value="Point"></Option>
            <Option name="place_on_every_part" type="bool" value="true"></Option>
            <Option name="placements" type="QString" value="Interval"></Option>
            <Option name="ring_filter" type="QString" value="0"></Option>
            <Option name="rotate" type="QString" value="1"></Option>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties"></Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
          </data_defined_properties>
          <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="@3@2" type="marker">
            <data_defined_properties>
              <Option type="Map">
                <Option name="name" type="QString" value=""></Option>
                <Option name="properties"></Option>
                <Option name="type" type="QString" value="collection"></Option>
              </Option>
            </data_defined_properties>
            <layer class="SvgMarker" enabled="1" id="{4776e22c-b323-4f69-a995-a800459af8a5}" locked="1" pass="0">
              <Option type="Map">
                <Option name="angle" type="QString" value="0"></Option>
                <Option name="color" type="QString" value="230,152,0,255,rgb:0.9019608,0.5960784,0,1"></Option>
                <Option name="fixedAspectRatio" type="QString" value="0"></Option>
                <Option name="horizontal_anchor_point" type="QString" value="1"></Option>
                <Option name="name" type="QString" value="base64:PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+Cjxzdmcgdmlld0JveD0iMC4xNDA2MjUgLTUuNTk3NjYgMi4wMjM0NCA1LjY1MjM0IgogeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgIHZlcnNpb249IjEuMiIgYmFzZVByb2ZpbGU9InRpbnkiPgo8dGl0bGU+UXQgU1ZHIERvY3VtZW50PC90aXRsZT4KPGRlc2M+R2VuZXJhdGVkIHdpdGggUXQ8L2Rlc2M+CjxkZWZzPgo8L2RlZnM+CjxnIGZpbGw9Im5vbmUiIHN0cm9rZT0iYmxhY2siIHN0cm9rZS13aWR0aD0iMSIgZmlsbC1ydWxlPSJldmVub2RkIiBzdHJva2UtbGluZWNhcD0ic3F1YXJlIiBzdHJva2UtbGluZWpvaW49ImJldmVsIiA+Cgo8ZyBmaWxsPSJwYXJhbShmaWxsKSIgZmlsbC1vcGFjaXR5PSJwYXJhbShmaWxsLW9wYWNpdHkpIiBzdHJva2U9InBhcmFtKG91dGxpbmUpIiBzdHJva2Utb3BhY2l0eT0icGFyYW0ob3V0bGluZS1vcGFjaXR5KSAxIiBzdHJva2Utd2lkdGg9InBhcmFtKG91dGxpbmUtd2lkdGgpIDAiIHRyYW5zZm9ybT0ibWF0cml4KDEsMCwwLDEsMCwwKSIKZm9udC1mYW1pbHk9Ik1TIFNoZWxsIERsZyAyIiBmb250LXNpemU9IjkuOCIgZm9udC13ZWlnaHQ9IjQwMCIgZm9udC1zdHlsZT0ibm9ybWFsIiAKPgo8cGF0aCB2ZWN0b3ItZWZmZWN0PSJub25lIiBmaWxsLXJ1bGU9Im5vbnplcm8iIGQ9Ik0yLjA2MjUsLTAuNjI4OTA2IEwyLjE2NDA2LC0wLjAwNzgxMjUgQzEuOTY2MTUsMC4wMzM4NTQyIDEuNzg5MDYsMC4wNTQ2ODc1IDEuNjMyODEsMC4wNTQ2ODc1IEMxLjM3NzYsMC4wNTQ2ODc1IDEuMTc5NjksMC4wMTQzMjI5IDEuMDM5MDYsLTAuMDY2NDA2MyBDMC44OTg0MzgsLTAuMTQ3MTM1IDAuNzk5NDc5LC0wLjI1MzI1NSAwLjc0MjE4OCwtMC4zODQ3NjYgQzAuNjg0ODk2LC0wLjUxNjI3NiAwLjY1NjI1LC0wLjc5Mjk2OSAwLjY1NjI1LC0xLjIxNDg0IEwwLjY1NjI1LC0zLjYwMTU2IEwwLjE0MDYyNSwtMy42MDE1NiBMMC4xNDA2MjUsLTQuMTQ4NDQgTDAuNjU2MjUsLTQuMTQ4NDQgTDAuNjU2MjUsLTUuMTc1NzggTDEuMzU1NDcsLTUuNTk3NjYgTDEuMzU1NDcsLTQuMTQ4NDQgTDIuMDYyNSwtNC4xNDg0NCBMMi4wNjI1LC0zLjYwMTU2IEwxLjM1NTQ3LC0zLjYwMTU2IEwxLjM1NTQ3LC0xLjE3NTc4IEMxLjM1NTQ3LC0wLjk3NTI2IDEuMzY3ODQsLTAuODQ2MzU0IDEuMzkyNTgsLTAuNzg5MDYzIEMxLjQxNzMyLC0wLjczMTc3MSAxLjQ1NzY4LC0wLjY4NjE5OCAxLjUxMzY3LC0wLjY1MjM0NCBDMS41Njk2NiwtMC42MTg0OSAxLjY0OTc0LC0wLjYwMTU2MyAxLjc1MzkxLC0wLjYwMTU2MyBDMS44MzIwMywtMC42MDE1NjMgMS45MzQ5LC0wLjYxMDY3NyAyLjA2MjUsLTAuNjI4OTA2ICIvPgo8L2c+CjwvZz4KPC9zdmc+Cg=="></Option>
                <Option name="offset" type="QString" value="0,0"></Option>
                <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="offset_unit" type="QString" value="Point"></Option>
                <Option name="outline_color" type="QString" value="0,127,127,255,cmyk:1,0.50000762951094835,0.50000762951094835,0,1"></Option>
                <Option name="outline_width" type="QString" value="0"></Option>
                <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="outline_width_unit" type="QString" value="Point"></Option>
                <Option name="parameters"></Option>
                <Option name="scale_method" type="QString" value="diameter"></Option>
                <Option name="size" type="QString" value="1.42188"></Option>
                <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="size_unit" type="QString" value="Point"></Option>
                <Option name="vertical_anchor_point" type="QString" value="1"></Option>
              </Option>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" type="QString" value=""></Option>
                  <Option name="properties"></Option>
                  <Option name="type" type="QString" value="collection"></Option>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
        <layer class="MarkerLine" enabled="1" id="{9aac7de0-c0cf-4203-8bf2-6dcd8d5d767b}" locked="0" pass="0">
          <Option type="Map">
            <Option name="average_angle_length" type="QString" value="4"></Option>
            <Option name="average_angle_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="average_angle_unit" type="QString" value="MM"></Option>
            <Option name="interval" type="QString" value="49"></Option>
            <Option name="interval_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="interval_unit" type="QString" value="Point"></Option>
            <Option name="offset" type="QString" value="0"></Option>
            <Option name="offset_along_line" type="QString" value="38.7"></Option>
            <Option name="offset_along_line_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_along_line_unit" type="QString" value="Point"></Option>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_unit" type="QString" value="Point"></Option>
            <Option name="place_on_every_part" type="bool" value="true"></Option>
            <Option name="placements" type="QString" value="Interval"></Option>
            <Option name="ring_filter" type="QString" value="0"></Option>
            <Option name="rotate" type="QString" value="1"></Option>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties"></Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
          </data_defined_properties>
          <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="@3@3" type="marker">
            <data_defined_properties>
              <Option type="Map">
                <Option name="name" type="QString" value=""></Option>
                <Option name="properties"></Option>
                <Option name="type" type="QString" value="collection"></Option>
              </Option>
            </data_defined_properties>
            <layer class="SvgMarker" enabled="1" id="{f153774e-4fc9-4515-ab8d-280e9916ac35}" locked="1" pass="0">
              <Option type="Map">
                <Option name="angle" type="QString" value="0"></Option>
                <Option name="color" type="QString" value="230,152,0,255,rgb:0.9019608,0.5960784,0,1"></Option>
                <Option name="fixedAspectRatio" type="QString" value="0"></Option>
                <Option name="horizontal_anchor_point" type="QString" value="1"></Option>
                <Option name="name" type="QString" value="base64:PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+Cjxzdmcgdmlld0JveD0iMC4yNzM0MzggLTUuNzI2NTYgMy41OTc2NiA1LjgyMDMxIgogeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgIHZlcnNpb249IjEuMiIgYmFzZVByb2ZpbGU9InRpbnkiPgo8dGl0bGU+UXQgU1ZHIERvY3VtZW50PC90aXRsZT4KPGRlc2M+R2VuZXJhdGVkIHdpdGggUXQ8L2Rlc2M+CjxkZWZzPgo8L2RlZnM+CjxnIGZpbGw9Im5vbmUiIHN0cm9rZT0iYmxhY2siIHN0cm9rZS13aWR0aD0iMSIgZmlsbC1ydWxlPSJldmVub2RkIiBzdHJva2UtbGluZWNhcD0ic3F1YXJlIiBzdHJva2UtbGluZWpvaW49ImJldmVsIiA+Cgo8ZyBmaWxsPSJwYXJhbShmaWxsKSIgZmlsbC1vcGFjaXR5PSJwYXJhbShmaWxsLW9wYWNpdHkpIiBzdHJva2U9InBhcmFtKG91dGxpbmUpIiBzdHJva2Utb3BhY2l0eT0icGFyYW0ob3V0bGluZS1vcGFjaXR5KSAxIiBzdHJva2Utd2lkdGg9InBhcmFtKG91dGxpbmUtd2lkdGgpIDAiIHRyYW5zZm9ybT0ibWF0cml4KDEsMCwwLDEsMCwwKSIKZm9udC1mYW1pbHk9Ik1TIFNoZWxsIERsZyAyIiBmb250LXNpemU9IjkuOCIgZm9udC13ZWlnaHQ9IjQwMCIgZm9udC1zdHlsZT0ibm9ybWFsIiAKPgo8cGF0aCB2ZWN0b3ItZWZmZWN0PSJub25lIiBmaWxsLXJ1bGU9Im5vbnplcm8iIGQ9Ik0zLjIxODc1LDAgTDMuMjE4NzUsLTAuNTIzNDM4IEMyLjk1NTczLC0wLjExMTk3OSAyLjU2OTAxLDAuMDkzNzUgMi4wNTg1OSwwLjA5Mzc1IEMxLjcyNzg2LDAuMDkzNzUgMS40MjM4MywwLjAwMjYwNDE2IDEuMTQ2NDgsLTAuMTc5Njg4IEMwLjg2OTE0MSwtMC4zNjE5NzkgMC42NTQyOTcsLTAuNjE2NTM2IDAuNTAxOTUzLC0wLjk0MzM1OSBDMC4zNDk2MDksLTEuMjcwMTggMC4yNzM0MzgsLTEuNjQ1ODMgMC4yNzM0MzgsLTIuMDcwMzEgQzAuMjczNDM4LC0yLjQ4NDM4IDAuMzQyNDQ4LC0yLjg2MDAzIDAuNDgwNDY5LC0zLjE5NzI3IEMwLjYxODQ5LC0zLjUzNDUgMC44MjU1MjEsLTMuNzkyOTcgMS4xMDE1NiwtMy45NzI2NiBDMS4zNzc2LC00LjE1MjM0IDEuNjg2MiwtNC4yNDIxOSAyLjAyNzM0LC00LjI0MjE5IEMyLjI3NzM0LC00LjI0MjE5IDIuNSwtNC4xODk0NSAyLjY5NTMxLC00LjA4Mzk4IEMyLjg5MDYzLC0zLjk3ODUyIDMuMDQ5NDgsLTMuODQxMTUgMy4xNzE4OCwtMy42NzE4OCBMMy4xNzE4OCwtNS43MjY1NiBMMy44NzEwOSwtNS43MjY1NiBMMy44NzEwOSwwIEwzLjIxODc1LDAgTTAuOTk2MDk0LC0yLjA3MDMxIEMwLjk5NjA5NCwtMS41MzkwNiAxLjEwODA3LC0xLjE0MTkzIDEuMzMyMDMsLTAuODc4OTA2IEMxLjU1NTk5LC0wLjYxNTg4NSAxLjgyMDMxLC0wLjQ4NDM3NSAyLjEyNSwtMC40ODQzNzUgQzIuNDMyMjksLTAuNDg0Mzc1IDIuNjkzMzYsLTAuNjEwMDI2IDIuOTA4MiwtMC44NjEzMjggQzMuMTIzMDUsLTEuMTEyNjMgMy4yMzA0NywtMS40OTYwOSAzLjIzMDQ3LC0yLjAxMTcyIEMzLjIzMDQ3LC0yLjU3OTQzIDMuMTIxMDksLTIuOTk2MDkgMi45MDIzNCwtMy4yNjE3MiBDMi42ODM1OSwtMy41MjczNCAyLjQxNDA2LC0zLjY2MDE2IDIuMDkzNzUsLTMuNjYwMTYgQzEuNzgxMjUsLTMuNjYwMTYgMS41MjAxOCwtMy41MzI1NSAxLjMxMDU1LC0zLjI3NzM0IEMxLjEwMDkxLC0zLjAyMjE0IDAuOTk2MDk0LC0yLjYxOTc5IDAuOTk2MDk0LC0yLjA3MDMxICIvPgo8L2c+CjwvZz4KPC9zdmc+Cg=="></Option>
                <Option name="offset" type="QString" value="0,0"></Option>
                <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="offset_unit" type="QString" value="Point"></Option>
                <Option name="outline_color" type="QString" value="0,127,127,255,cmyk:1,0.50000762951094835,0.50000762951094835,0,1"></Option>
                <Option name="outline_width" type="QString" value="0"></Option>
                <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="outline_width_unit" type="QString" value="Point"></Option>
                <Option name="parameters"></Option>
                <Option name="scale_method" type="QString" value="diameter"></Option>
                <Option name="size" type="QString" value="2.52808"></Option>
                <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="size_unit" type="QString" value="Point"></Option>
                <Option name="vertical_anchor_point" type="QString" value="1"></Option>
              </Option>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" type="QString" value=""></Option>
                  <Option name="properties"></Option>
                  <Option name="type" type="QString" value="collection"></Option>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="4" type="line">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" type="QString" value=""></Option>
            <Option name="properties"></Option>
            <Option name="type" type="QString" value="collection"></Option>
          </Option>
        </data_defined_properties>
        <layer class="SimpleLine" enabled="1" id="{d59f960e-96aa-48c5-8274-28c3df3dfdc6}" locked="0" pass="0">
          <Option type="Map">
            <Option name="align_dash_pattern" type="QString" value="0"></Option>
            <Option name="capstyle" type="QString" value="flat"></Option>
            <Option name="customdash" type="QString" value="18;6"></Option>
            <Option name="customdash_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="customdash_unit" type="QString" value="Point"></Option>
            <Option name="dash_pattern_offset" type="QString" value="0"></Option>
            <Option name="dash_pattern_offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="dash_pattern_offset_unit" type="QString" value="MM"></Option>
            <Option name="draw_inside_polygon" type="QString" value="0"></Option>
            <Option name="joinstyle" type="QString" value="miter"></Option>
            <Option name="line_color" type="QString" value="230,152,0,255,rgb:0.9019608,0.5960784,0,1"></Option>
            <Option name="line_style" type="QString" value="solid"></Option>
            <Option name="line_width" type="QString" value="1"></Option>
            <Option name="line_width_unit" type="QString" value="Point"></Option>
            <Option name="offset" type="QString" value="0"></Option>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_unit" type="QString" value="MM"></Option>
            <Option name="ring_filter" type="QString" value="0"></Option>
            <Option name="trim_distance_end" type="QString" value="0"></Option>
            <Option name="trim_distance_end_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="trim_distance_end_unit" type="QString" value="MM"></Option>
            <Option name="trim_distance_start" type="QString" value="0"></Option>
            <Option name="trim_distance_start_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="trim_distance_start_unit" type="QString" value="MM"></Option>
            <Option name="tweak_dash_pattern_on_corners" type="QString" value="0"></Option>
            <Option name="use_custom_dash" type="QString" value="1"></Option>
            <Option name="width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties"></Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
          </data_defined_properties>
        </layer>
        <layer class="MarkerLine" enabled="1" id="{6ffe3658-dbd1-498c-a771-875c675851f8}" locked="0" pass="0">
          <Option type="Map">
            <Option name="average_angle_length" type="QString" value="4"></Option>
            <Option name="average_angle_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="average_angle_unit" type="QString" value="MM"></Option>
            <Option name="interval" type="QString" value="24"></Option>
            <Option name="interval_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="interval_unit" type="QString" value="Point"></Option>
            <Option name="offset" type="QString" value="0"></Option>
            <Option name="offset_along_line" type="QString" value="21"></Option>
            <Option name="offset_along_line_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_along_line_unit" type="QString" value="Point"></Option>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_unit" type="QString" value="Point"></Option>
            <Option name="place_on_every_part" type="bool" value="true"></Option>
            <Option name="placements" type="QString" value="Interval"></Option>
            <Option name="ring_filter" type="QString" value="0"></Option>
            <Option name="rotate" type="QString" value="1"></Option>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties"></Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
          </data_defined_properties>
          <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="@4@1" type="marker">
            <data_defined_properties>
              <Option type="Map">
                <Option name="name" type="QString" value=""></Option>
                <Option name="properties"></Option>
                <Option name="type" type="QString" value="collection"></Option>
              </Option>
            </data_defined_properties>
            <layer class="SimpleMarker" enabled="1" id="{3767826a-d4ec-402b-89ff-749f71df33d6}" locked="1" pass="0">
              <Option type="Map">
                <Option name="angle" type="QString" value="0"></Option>
                <Option name="cap_style" type="QString" value="round"></Option>
                <Option name="color" type="QString" value="230,152,0,255,rgb:0.9019608,0.5960784,0,1"></Option>
                <Option name="horizontal_anchor_point" type="QString" value="1"></Option>
                <Option name="joinstyle" type="QString" value="round"></Option>
                <Option name="name" type="QString" value="circle"></Option>
                <Option name="offset" type="QString" value="0,0"></Option>
                <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="offset_unit" type="QString" value="Point"></Option>
                <Option name="outline_color" type="QString" value="0,0,0,0,rgb:0,0,0,0"></Option>
                <Option name="outline_style" type="QString" value="no"></Option>
                <Option name="outline_width" type="QString" value="0"></Option>
                <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="outline_width_unit" type="QString" value="Point"></Option>
                <Option name="scale_method" type="QString" value="diameter"></Option>
                <Option name="size" type="QString" value="1.8"></Option>
                <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="size_unit" type="QString" value="Point"></Option>
                <Option name="vertical_anchor_point" type="QString" value="1"></Option>
              </Option>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" type="QString" value=""></Option>
                  <Option name="properties"></Option>
                  <Option name="type" type="QString" value="collection"></Option>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="5" type="line">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" type="QString" value=""></Option>
            <Option name="properties"></Option>
            <Option name="type" type="QString" value="collection"></Option>
          </Option>
        </data_defined_properties>
        <layer class="SimpleLine" enabled="1" id="{45f25f5f-53f1-4d28-8fe9-be854ab80d95}" locked="0" pass="0">
          <Option type="Map">
            <Option name="align_dash_pattern" type="QString" value="0"></Option>
            <Option name="capstyle" type="QString" value="flat"></Option>
            <Option name="customdash" type="QString" value="18;6"></Option>
            <Option name="customdash_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="customdash_unit" type="QString" value="Point"></Option>
            <Option name="dash_pattern_offset" type="QString" value="0"></Option>
            <Option name="dash_pattern_offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="dash_pattern_offset_unit" type="QString" value="MM"></Option>
            <Option name="draw_inside_polygon" type="QString" value="0"></Option>
            <Option name="joinstyle" type="QString" value="miter"></Option>
            <Option name="line_color" type="QString" value="230,152,0,255,rgb:0.9019608,0.5960784,0,1"></Option>
            <Option name="line_style" type="QString" value="solid"></Option>
            <Option name="line_width" type="QString" value="1"></Option>
            <Option name="line_width_unit" type="QString" value="Point"></Option>
            <Option name="offset" type="QString" value="0"></Option>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_unit" type="QString" value="MM"></Option>
            <Option name="ring_filter" type="QString" value="0"></Option>
            <Option name="trim_distance_end" type="QString" value="0"></Option>
            <Option name="trim_distance_end_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="trim_distance_end_unit" type="QString" value="MM"></Option>
            <Option name="trim_distance_start" type="QString" value="0"></Option>
            <Option name="trim_distance_start_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="trim_distance_start_unit" type="QString" value="MM"></Option>
            <Option name="tweak_dash_pattern_on_corners" type="QString" value="0"></Option>
            <Option name="use_custom_dash" type="QString" value="1"></Option>
            <Option name="width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties"></Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
          </data_defined_properties>
        </layer>
        <layer class="MarkerLine" enabled="1" id="{8c122846-3925-4d56-b8fb-f3f5b6b60fa4}" locked="0" pass="0">
          <Option type="Map">
            <Option name="average_angle_length" type="QString" value="4"></Option>
            <Option name="average_angle_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="average_angle_unit" type="QString" value="MM"></Option>
            <Option name="interval" type="QString" value="24"></Option>
            <Option name="interval_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="interval_unit" type="QString" value="Point"></Option>
            <Option name="offset" type="QString" value="-1.4"></Option>
            <Option name="offset_along_line" type="QString" value="9"></Option>
            <Option name="offset_along_line_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_along_line_unit" type="QString" value="Point"></Option>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_unit" type="QString" value="Point"></Option>
            <Option name="place_on_every_part" type="bool" value="true"></Option>
            <Option name="placements" type="QString" value="Interval"></Option>
            <Option name="ring_filter" type="QString" value="0"></Option>
            <Option name="rotate" type="QString" value="1"></Option>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties"></Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
          </data_defined_properties>
          <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="@5@1" type="marker">
            <data_defined_properties>
              <Option type="Map">
                <Option name="name" type="QString" value=""></Option>
                <Option name="properties"></Option>
                <Option name="type" type="QString" value="collection"></Option>
              </Option>
            </data_defined_properties>
            <layer class="SvgMarker" enabled="1" id="{ca9e4225-d5ba-49ec-818a-83c8f4efe8d3}" locked="1" pass="0">
              <Option type="Map">
                <Option name="angle" type="QString" value="-90"></Option>
                <Option name="color" type="QString" value="255,255,255,0,rgb:1,1,1,0"></Option>
                <Option name="fixedAspectRatio" type="QString" value="0"></Option>
                <Option name="horizontal_anchor_point" type="QString" value="1"></Option>
                <Option name="name" type="QString" value="base64:PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+Cjxzdmcgdmlld0JveD0iLTAuNCAtMC40IDMuOCAzLjgiCiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiAgdmVyc2lvbj0iMS4yIiBiYXNlUHJvZmlsZT0idGlueSI+Cjx0aXRsZT5RdCBTVkcgRG9jdW1lbnQ8L3RpdGxlPgo8ZGVzYz5HZW5lcmF0ZWQgd2l0aCBRdDwvZGVzYz4KPGRlZnM+CjwvZGVmcz4KPGcgZmlsbD0ibm9uZSIgc3Ryb2tlPSJibGFjayIgc3Ryb2tlLXdpZHRoPSIxIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiIHN0cm9rZS1saW5lY2FwPSJzcXVhcmUiIHN0cm9rZS1saW5lam9pbj0iYmV2ZWwiID4KCjxnIGZpbGw9InBhcmFtKGZpbGwpIiBmaWxsLW9wYWNpdHk9InBhcmFtKGZpbGwtb3BhY2l0eSkiIHN0cm9rZT0icGFyYW0ob3V0bGluZSkiIHN0cm9rZS1vcGFjaXR5PSJwYXJhbShvdXRsaW5lLW9wYWNpdHkpIDEiIHN0cm9rZS13aWR0aD0icGFyYW0ob3V0bGluZS13aWR0aCkiIHN0cm9rZS1saW5lY2FwPSJidXR0IiBzdHJva2UtbGluZWpvaW49Im1pdGVyIiB0cmFuc2Zvcm09Im1hdHJpeCgxLDAsMCwxLDAsMCkiCmZvbnQtZmFtaWx5PSJNUyBTaGVsbCBEbGcgMiIgZm9udC1zaXplPSI5LjgiIGZvbnQtd2VpZ2h0PSI0MDAiIGZvbnQtc3R5bGU9Im5vcm1hbCIgCj4KPHBvbHlsaW5lIGZpbGw9Im5vbmUiIHZlY3Rvci1lZmZlY3Q9Im5vbmUiIHBvaW50cz0iMywxLjUgMCwxLjUgIiAvPgo8L2c+CjwvZz4KPC9zdmc+Cg=="></Option>
                <Option name="offset" type="QString" value="0,0"></Option>
                <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="offset_unit" type="QString" value="Point"></Option>
                <Option name="outline_color" type="QString" value="230,152,0,255,rgb:0.9019608,0.5960784,0,1"></Option>
                <Option name="outline_width" type="QString" value="0.8"></Option>
                <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="outline_width_unit" type="QString" value="Point"></Option>
                <Option name="parameters"></Option>
                <Option name="scale_method" type="QString" value="diameter"></Option>
                <Option name="size" type="QString" value="3"></Option>
                <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="size_unit" type="QString" value="Point"></Option>
                <Option name="vertical_anchor_point" type="QString" value="1"></Option>
              </Option>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" type="QString" value=""></Option>
                  <Option name="properties"></Option>
                  <Option name="type" type="QString" value="collection"></Option>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
        <layer class="MarkerLine" enabled="1" id="{2e6e831b-5ad5-43ab-8aac-6363297eec4e}" locked="0" pass="0">
          <Option type="Map">
            <Option name="average_angle_length" type="QString" value="4"></Option>
            <Option name="average_angle_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="average_angle_unit" type="QString" value="MM"></Option>
            <Option name="interval" type="QString" value="24"></Option>
            <Option name="interval_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="interval_unit" type="QString" value="Point"></Option>
            <Option name="offset" type="QString" value="0"></Option>
            <Option name="offset_along_line" type="QString" value="21"></Option>
            <Option name="offset_along_line_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_along_line_unit" type="QString" value="Point"></Option>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_unit" type="QString" value="Point"></Option>
            <Option name="place_on_every_part" type="bool" value="true"></Option>
            <Option name="placements" type="QString" value="Interval"></Option>
            <Option name="ring_filter" type="QString" value="0"></Option>
            <Option name="rotate" type="QString" value="1"></Option>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties"></Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
          </data_defined_properties>
          <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="@5@2" type="marker">
            <data_defined_properties>
              <Option type="Map">
                <Option name="name" type="QString" value=""></Option>
                <Option name="properties"></Option>
                <Option name="type" type="QString" value="collection"></Option>
              </Option>
            </data_defined_properties>
            <layer class="SimpleMarker" enabled="1" id="{23773feb-4243-4f3e-96de-37a145b6ccd9}" locked="0" pass="0">
              <Option type="Map">
                <Option name="angle" type="QString" value="0"></Option>
                <Option name="cap_style" type="QString" value="square"></Option>
                <Option name="color" type="QString" value="230,152,0,255,rgb:0.9019608,0.5960784,0,1"></Option>
                <Option name="horizontal_anchor_point" type="QString" value="1"></Option>
                <Option name="joinstyle" type="QString" value="bevel"></Option>
                <Option name="name" type="QString" value="circle"></Option>
                <Option name="offset" type="QString" value="0,0"></Option>
                <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="offset_unit" type="QString" value="Point"></Option>
                <Option name="outline_color" type="QString" value="35,35,35,255,rgb:0.1372549,0.1372549,0.1372549,1"></Option>
                <Option name="outline_style" type="QString" value="no"></Option>
                <Option name="outline_width" type="QString" value="0"></Option>
                <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="outline_width_unit" type="QString" value="MM"></Option>
                <Option name="scale_method" type="QString" value="diameter"></Option>
                <Option name="size" type="QString" value="1.6"></Option>
                <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="size_unit" type="QString" value="Point"></Option>
                <Option name="vertical_anchor_point" type="QString" value="1"></Option>
              </Option>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" type="QString" value=""></Option>
                  <Option name="properties"></Option>
                  <Option name="type" type="QString" value="collection"></Option>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="6" type="line">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" type="QString" value=""></Option>
            <Option name="properties"></Option>
            <Option name="type" type="QString" value="collection"></Option>
          </Option>
        </data_defined_properties>
        <layer class="SimpleLine" enabled="1" id="{994c57ec-9a01-499b-818a-d50ed6c9a8fc}" locked="0" pass="0">
          <Option type="Map">
            <Option name="align_dash_pattern" type="QString" value="0"></Option>
            <Option name="capstyle" type="QString" value="flat"></Option>
            <Option name="customdash" type="QString" value="16;4"></Option>
            <Option name="customdash_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="customdash_unit" type="QString" value="Point"></Option>
            <Option name="dash_pattern_offset" type="QString" value="0"></Option>
            <Option name="dash_pattern_offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="dash_pattern_offset_unit" type="QString" value="MM"></Option>
            <Option name="draw_inside_polygon" type="QString" value="0"></Option>
            <Option name="joinstyle" type="QString" value="miter"></Option>
            <Option name="line_color" type="QString" value="230,152,0,255,rgb:0.9019608,0.5960784,0,1"></Option>
            <Option name="line_style" type="QString" value="solid"></Option>
            <Option name="line_width" type="QString" value="1"></Option>
            <Option name="line_width_unit" type="QString" value="Point"></Option>
            <Option name="offset" type="QString" value="0"></Option>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_unit" type="QString" value="MM"></Option>
            <Option name="ring_filter" type="QString" value="0"></Option>
            <Option name="trim_distance_end" type="QString" value="0"></Option>
            <Option name="trim_distance_end_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="trim_distance_end_unit" type="QString" value="MM"></Option>
            <Option name="trim_distance_start" type="QString" value="0"></Option>
            <Option name="trim_distance_start_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="trim_distance_start_unit" type="QString" value="MM"></Option>
            <Option name="tweak_dash_pattern_on_corners" type="QString" value="0"></Option>
            <Option name="use_custom_dash" type="QString" value="1"></Option>
            <Option name="width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties"></Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
          </data_defined_properties>
        </layer>
        <layer class="MarkerLine" enabled="1" id="{39a84a99-55c3-4828-ae4f-428a982b9f0f}" locked="0" pass="0">
          <Option type="Map">
            <Option name="average_angle_length" type="QString" value="4"></Option>
            <Option name="average_angle_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="average_angle_unit" type="QString" value="MM"></Option>
            <Option name="interval" type="QString" value="40"></Option>
            <Option name="interval_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="interval_unit" type="QString" value="Point"></Option>
            <Option name="offset" type="QString" value="-2"></Option>
            <Option name="offset_along_line" type="QString" value="25"></Option>
            <Option name="offset_along_line_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_along_line_unit" type="QString" value="Point"></Option>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_unit" type="QString" value="Point"></Option>
            <Option name="place_on_every_part" type="bool" value="true"></Option>
            <Option name="placements" type="QString" value="Interval"></Option>
            <Option name="ring_filter" type="QString" value="0"></Option>
            <Option name="rotate" type="QString" value="1"></Option>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties"></Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
          </data_defined_properties>
          <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="@6@1" type="marker">
            <data_defined_properties>
              <Option type="Map">
                <Option name="name" type="QString" value=""></Option>
                <Option name="properties"></Option>
                <Option name="type" type="QString" value="collection"></Option>
              </Option>
            </data_defined_properties>
            <layer class="SvgMarker" enabled="1" id="{a2d00678-c40d-4d95-b7e5-110fd1316d13}" locked="1" pass="0">
              <Option type="Map">
                <Option name="angle" type="QString" value="-90"></Option>
                <Option name="color" type="QString" value="255,255,255,0,rgb:1,1,1,0"></Option>
                <Option name="fixedAspectRatio" type="QString" value="0"></Option>
                <Option name="horizontal_anchor_point" type="QString" value="1"></Option>
                <Option name="name" type="QString" value="base64:PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+Cjxzdmcgdmlld0JveD0iLTAuNSAtMC41IDUgNSIKIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiICB2ZXJzaW9uPSIxLjIiIGJhc2VQcm9maWxlPSJ0aW55Ij4KPHRpdGxlPlF0IFNWRyBEb2N1bWVudDwvdGl0bGU+CjxkZXNjPkdlbmVyYXRlZCB3aXRoIFF0PC9kZXNjPgo8ZGVmcz4KPC9kZWZzPgo8ZyBmaWxsPSJub25lIiBzdHJva2U9ImJsYWNrIiBzdHJva2Utd2lkdGg9IjEiIGZpbGwtcnVsZT0iZXZlbm9kZCIgc3Ryb2tlLWxpbmVjYXA9InNxdWFyZSIgc3Ryb2tlLWxpbmVqb2luPSJiZXZlbCIgPgoKPGcgZmlsbD0icGFyYW0oZmlsbCkiIGZpbGwtb3BhY2l0eT0icGFyYW0oZmlsbC1vcGFjaXR5KSIgc3Ryb2tlPSJwYXJhbShvdXRsaW5lKSIgc3Ryb2tlLW9wYWNpdHk9InBhcmFtKG91dGxpbmUtb3BhY2l0eSkgMSIgc3Ryb2tlLXdpZHRoPSJwYXJhbShvdXRsaW5lLXdpZHRoKSIgc3Ryb2tlLWxpbmVjYXA9ImJ1dHQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHRyYW5zZm9ybT0ibWF0cml4KDEsMCwwLDEsMCwwKSIKZm9udC1mYW1pbHk9Ik1TIFNoZWxsIERsZyAyIiBmb250LXNpemU9IjkuOCIgZm9udC13ZWlnaHQ9IjQwMCIgZm9udC1zdHlsZT0ibm9ybWFsIiAKPgo8cG9seWxpbmUgZmlsbD0ibm9uZSIgdmVjdG9yLWVmZmVjdD0ibm9uZSIgcG9pbnRzPSI0LDIgMCwyICIgLz4KPC9nPgo8L2c+Cjwvc3ZnPgo="></Option>
                <Option name="offset" type="QString" value="0,0"></Option>
                <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="offset_unit" type="QString" value="Point"></Option>
                <Option name="outline_color" type="QString" value="230,152,0,255,rgb:0.9019608,0.5960784,0,1"></Option>
                <Option name="outline_width" type="QString" value="0.75"></Option>
                <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="outline_width_unit" type="QString" value="Point"></Option>
                <Option name="parameters"></Option>
                <Option name="scale_method" type="QString" value="diameter"></Option>
                <Option name="size" type="QString" value="3"></Option>
                <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="size_unit" type="QString" value="Point"></Option>
                <Option name="vertical_anchor_point" type="QString" value="1"></Option>
              </Option>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" type="QString" value=""></Option>
                  <Option name="properties"></Option>
                  <Option name="type" type="QString" value="collection"></Option>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
        <layer class="MarkerLine" enabled="1" id="{726613c3-b44d-494f-9d84-aabdb38d7bd0}" locked="0" pass="0">
          <Option type="Map">
            <Option name="average_angle_length" type="QString" value="4"></Option>
            <Option name="average_angle_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="average_angle_unit" type="QString" value="MM"></Option>
            <Option name="interval" type="QString" value="40"></Option>
            <Option name="interval_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="interval_unit" type="QString" value="Point"></Option>
            <Option name="offset" type="QString" value="-2"></Option>
            <Option name="offset_along_line" type="QString" value="-31"></Option>
            <Option name="offset_along_line_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_along_line_unit" type="QString" value="Point"></Option>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_unit" type="QString" value="Point"></Option>
            <Option name="place_on_every_part" type="bool" value="true"></Option>
            <Option name="placements" type="QString" value="Interval"></Option>
            <Option name="ring_filter" type="QString" value="0"></Option>
            <Option name="rotate" type="QString" value="1"></Option>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties"></Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
          </data_defined_properties>
          <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="@6@2" type="marker">
            <data_defined_properties>
              <Option type="Map">
                <Option name="name" type="QString" value=""></Option>
                <Option name="properties"></Option>
                <Option name="type" type="QString" value="collection"></Option>
              </Option>
            </data_defined_properties>
            <layer class="SvgMarker" enabled="1" id="{05b1de64-2efa-46ac-b9a5-a50b5a305ae1}" locked="1" pass="0">
              <Option type="Map">
                <Option name="angle" type="QString" value="-90"></Option>
                <Option name="color" type="QString" value="255,255,255,0,rgb:1,1,1,0"></Option>
                <Option name="fixedAspectRatio" type="QString" value="0"></Option>
                <Option name="horizontal_anchor_point" type="QString" value="1"></Option>
                <Option name="name" type="QString" value="base64:PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+Cjxzdmcgdmlld0JveD0iLTAuNSAtMC41IDUgNSIKIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiICB2ZXJzaW9uPSIxLjIiIGJhc2VQcm9maWxlPSJ0aW55Ij4KPHRpdGxlPlF0IFNWRyBEb2N1bWVudDwvdGl0bGU+CjxkZXNjPkdlbmVyYXRlZCB3aXRoIFF0PC9kZXNjPgo8ZGVmcz4KPC9kZWZzPgo8ZyBmaWxsPSJub25lIiBzdHJva2U9ImJsYWNrIiBzdHJva2Utd2lkdGg9IjEiIGZpbGwtcnVsZT0iZXZlbm9kZCIgc3Ryb2tlLWxpbmVjYXA9InNxdWFyZSIgc3Ryb2tlLWxpbmVqb2luPSJiZXZlbCIgPgoKPGcgZmlsbD0icGFyYW0oZmlsbCkiIGZpbGwtb3BhY2l0eT0icGFyYW0oZmlsbC1vcGFjaXR5KSIgc3Ryb2tlPSJwYXJhbShvdXRsaW5lKSIgc3Ryb2tlLW9wYWNpdHk9InBhcmFtKG91dGxpbmUtb3BhY2l0eSkgMSIgc3Ryb2tlLXdpZHRoPSJwYXJhbShvdXRsaW5lLXdpZHRoKSIgc3Ryb2tlLWxpbmVjYXA9ImJ1dHQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHRyYW5zZm9ybT0ibWF0cml4KDEsMCwwLDEsMCwwKSIKZm9udC1mYW1pbHk9Ik1TIFNoZWxsIERsZyAyIiBmb250LXNpemU9IjkuOCIgZm9udC13ZWlnaHQ9IjQwMCIgZm9udC1zdHlsZT0ibm9ybWFsIiAKPgo8cG9seWxpbmUgZmlsbD0ibm9uZSIgdmVjdG9yLWVmZmVjdD0ibm9uZSIgcG9pbnRzPSI0LDIgMCwyICIgLz4KPC9nPgo8L2c+Cjwvc3ZnPgo="></Option>
                <Option name="offset" type="QString" value="0,0"></Option>
                <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="offset_unit" type="QString" value="Point"></Option>
                <Option name="outline_color" type="QString" value="230,152,0,255,rgb:0.9019608,0.5960784,0,1"></Option>
                <Option name="outline_width" type="QString" value="0.75"></Option>
                <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="outline_width_unit" type="QString" value="Point"></Option>
                <Option name="parameters"></Option>
                <Option name="scale_method" type="QString" value="diameter"></Option>
                <Option name="size" type="QString" value="3"></Option>
                <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="size_unit" type="QString" value="Point"></Option>
                <Option name="vertical_anchor_point" type="QString" value="1"></Option>
              </Option>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" type="QString" value=""></Option>
                  <Option name="properties"></Option>
                  <Option name="type" type="QString" value="collection"></Option>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="7" type="line">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" type="QString" value=""></Option>
            <Option name="properties"></Option>
            <Option name="type" type="QString" value="collection"></Option>
          </Option>
        </data_defined_properties>
        <layer class="SimpleLine" enabled="1" id="{11b7ab62-c1f3-4f72-a0ae-346ed48ce4fc}" locked="0" pass="0">
          <Option type="Map">
            <Option name="align_dash_pattern" type="QString" value="0"></Option>
            <Option name="capstyle" type="QString" value="flat"></Option>
            <Option name="customdash" type="QString" value="5;2"></Option>
            <Option name="customdash_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="customdash_unit" type="QString" value="MM"></Option>
            <Option name="dash_pattern_offset" type="QString" value="0"></Option>
            <Option name="dash_pattern_offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="dash_pattern_offset_unit" type="QString" value="MM"></Option>
            <Option name="draw_inside_polygon" type="QString" value="0"></Option>
            <Option name="joinstyle" type="QString" value="miter"></Option>
            <Option name="line_color" type="QString" value="230,152,0,255,rgb:0.9019608,0.5960784,0,1"></Option>
            <Option name="line_style" type="QString" value="solid"></Option>
            <Option name="line_width" type="QString" value="1"></Option>
            <Option name="line_width_unit" type="QString" value="Point"></Option>
            <Option name="offset" type="QString" value="0"></Option>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_unit" type="QString" value="MM"></Option>
            <Option name="ring_filter" type="QString" value="0"></Option>
            <Option name="trim_distance_end" type="QString" value="0"></Option>
            <Option name="trim_distance_end_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="trim_distance_end_unit" type="QString" value="MM"></Option>
            <Option name="trim_distance_start" type="QString" value="0"></Option>
            <Option name="trim_distance_start_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="trim_distance_start_unit" type="QString" value="MM"></Option>
            <Option name="tweak_dash_pattern_on_corners" type="QString" value="0"></Option>
            <Option name="use_custom_dash" type="QString" value="0"></Option>
            <Option name="width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties"></Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
          </data_defined_properties>
        </layer>
        <layer class="MarkerLine" enabled="1" id="{7d47ffb6-1066-449b-9002-0f1a0f3d96e8}" locked="0" pass="0">
          <Option type="Map">
            <Option name="average_angle_length" type="QString" value="4"></Option>
            <Option name="average_angle_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="average_angle_unit" type="QString" value="MM"></Option>
            <Option name="interval" type="QString" value="26"></Option>
            <Option name="interval_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="interval_unit" type="QString" value="Point"></Option>
            <Option name="offset" type="QString" value="0"></Option>
            <Option name="offset_along_line" type="QString" value="29.5"></Option>
            <Option name="offset_along_line_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_along_line_unit" type="QString" value="Point"></Option>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_unit" type="QString" value="Point"></Option>
            <Option name="place_on_every_part" type="bool" value="true"></Option>
            <Option name="placements" type="QString" value="Interval"></Option>
            <Option name="ring_filter" type="QString" value="0"></Option>
            <Option name="rotate" type="QString" value="1"></Option>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties"></Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
          </data_defined_properties>
          <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="@7@1" type="marker">
            <data_defined_properties>
              <Option type="Map">
                <Option name="name" type="QString" value=""></Option>
                <Option name="properties"></Option>
                <Option name="type" type="QString" value="collection"></Option>
              </Option>
            </data_defined_properties>
            <layer class="SimpleMarker" enabled="1" id="{c0165e97-2c8a-44a3-8905-9a2ca4dacbb6}" locked="1" pass="0">
              <Option type="Map">
                <Option name="angle" type="QString" value="0"></Option>
                <Option name="cap_style" type="QString" value="square"></Option>
                <Option name="color" type="QString" value="255,0,0,255,rgb:1,0,0,1"></Option>
                <Option name="horizontal_anchor_point" type="QString" value="1"></Option>
                <Option name="joinstyle" type="QString" value="miter"></Option>
                <Option name="name" type="QString" value="cross2"></Option>
                <Option name="offset" type="QString" value="0,0"></Option>
                <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="offset_unit" type="QString" value="Point"></Option>
                <Option name="outline_color" type="QString" value="230,152,0,255,rgb:0.9019608,0.5960784,0,1"></Option>
                <Option name="outline_style" type="QString" value="solid"></Option>
                <Option name="outline_width" type="QString" value="0.373104"></Option>
                <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="outline_width_unit" type="QString" value="Point"></Option>
                <Option name="scale_method" type="QString" value="diameter"></Option>
                <Option name="size" type="QString" value="3.00514"></Option>
                <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="size_unit" type="QString" value="Point"></Option>
                <Option name="vertical_anchor_point" type="QString" value="1"></Option>
              </Option>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" type="QString" value=""></Option>
                  <Option name="properties"></Option>
                  <Option name="type" type="QString" value="collection"></Option>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="8" type="line">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" type="QString" value=""></Option>
            <Option name="properties"></Option>
            <Option name="type" type="QString" value="collection"></Option>
          </Option>
        </data_defined_properties>
        <layer class="SimpleLine" enabled="1" id="{5ba31f10-b9ec-4998-a789-091021b6814a}" locked="0" pass="0">
          <Option type="Map">
            <Option name="align_dash_pattern" type="QString" value="0"></Option>
            <Option name="capstyle" type="QString" value="flat"></Option>
            <Option name="customdash" type="QString" value="20;6"></Option>
            <Option name="customdash_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="customdash_unit" type="QString" value="Point"></Option>
            <Option name="dash_pattern_offset" type="QString" value="0"></Option>
            <Option name="dash_pattern_offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="dash_pattern_offset_unit" type="QString" value="MM"></Option>
            <Option name="draw_inside_polygon" type="QString" value="0"></Option>
            <Option name="joinstyle" type="QString" value="miter"></Option>
            <Option name="line_color" type="QString" value="230,152,0,255,rgb:0.9019608,0.5960784,0,1"></Option>
            <Option name="line_style" type="QString" value="solid"></Option>
            <Option name="line_width" type="QString" value="1"></Option>
            <Option name="line_width_unit" type="QString" value="Point"></Option>
            <Option name="offset" type="QString" value="0"></Option>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_unit" type="QString" value="MM"></Option>
            <Option name="ring_filter" type="QString" value="0"></Option>
            <Option name="trim_distance_end" type="QString" value="0"></Option>
            <Option name="trim_distance_end_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="trim_distance_end_unit" type="QString" value="MM"></Option>
            <Option name="trim_distance_start" type="QString" value="0"></Option>
            <Option name="trim_distance_start_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="trim_distance_start_unit" type="QString" value="MM"></Option>
            <Option name="tweak_dash_pattern_on_corners" type="QString" value="0"></Option>
            <Option name="use_custom_dash" type="QString" value="1"></Option>
            <Option name="width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties"></Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
          </data_defined_properties>
        </layer>
        <layer class="MarkerLine" enabled="1" id="{081652a8-eb09-42d4-b08e-b5a76ae2f866}" locked="0" pass="0">
          <Option type="Map">
            <Option name="average_angle_length" type="QString" value="4"></Option>
            <Option name="average_angle_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="average_angle_unit" type="QString" value="MM"></Option>
            <Option name="interval" type="QString" value="26"></Option>
            <Option name="interval_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="interval_unit" type="QString" value="Point"></Option>
            <Option name="offset" type="QString" value="0"></Option>
            <Option name="offset_along_line" type="QString" value="23"></Option>
            <Option name="offset_along_line_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_along_line_unit" type="QString" value="Point"></Option>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_unit" type="QString" value="Point"></Option>
            <Option name="place_on_every_part" type="bool" value="true"></Option>
            <Option name="placements" type="QString" value="Interval"></Option>
            <Option name="ring_filter" type="QString" value="0"></Option>
            <Option name="rotate" type="QString" value="1"></Option>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties"></Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
          </data_defined_properties>
          <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="@8@1" type="marker">
            <data_defined_properties>
              <Option type="Map">
                <Option name="name" type="QString" value=""></Option>
                <Option name="properties"></Option>
                <Option name="type" type="QString" value="collection"></Option>
              </Option>
            </data_defined_properties>
            <layer class="SimpleMarker" enabled="1" id="{014b2e8e-6f21-4b6c-b573-c8762f496c9e}" locked="1" pass="0">
              <Option type="Map">
                <Option name="angle" type="QString" value="0"></Option>
                <Option name="cap_style" type="QString" value="round"></Option>
                <Option name="color" type="QString" value="230,152,0,255,rgb:0.9019608,0.5960784,0,1"></Option>
                <Option name="horizontal_anchor_point" type="QString" value="1"></Option>
                <Option name="joinstyle" type="QString" value="round"></Option>
                <Option name="name" type="QString" value="circle"></Option>
                <Option name="offset" type="QString" value="0,0"></Option>
                <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="offset_unit" type="QString" value="Point"></Option>
                <Option name="outline_color" type="QString" value="230,152,0,255,rgb:0.9019608,0.5960784,0,1"></Option>
                <Option name="outline_style" type="QString" value="no"></Option>
                <Option name="outline_width" type="QString" value="0"></Option>
                <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="outline_width_unit" type="QString" value="Point"></Option>
                <Option name="scale_method" type="QString" value="diameter"></Option>
                <Option name="size" type="QString" value="2"></Option>
                <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="size_unit" type="QString" value="Point"></Option>
                <Option name="vertical_anchor_point" type="QString" value="1"></Option>
              </Option>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" type="QString" value=""></Option>
                  <Option name="properties"></Option>
                  <Option name="type" type="QString" value="collection"></Option>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
      </symbol>
    </symbols>
    <source-symbol>
      <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="0" type="line">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" type="QString" value=""></Option>
            <Option name="properties"></Option>
            <Option name="type" type="QString" value="collection"></Option>
          </Option>
        </data_defined_properties>
        <layer class="SimpleLine" enabled="1" id="{94f7f6cf-f3d7-448f-804e-91ee6637f42c}" locked="0" pass="0">
          <Option type="Map">
            <Option name="align_dash_pattern" type="QString" value="0"></Option>
            <Option name="capstyle" type="QString" value="square"></Option>
            <Option name="customdash" type="QString" value="5;2"></Option>
            <Option name="customdash_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="customdash_unit" type="QString" value="MM"></Option>
            <Option name="dash_pattern_offset" type="QString" value="0"></Option>
            <Option name="dash_pattern_offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="dash_pattern_offset_unit" type="QString" value="MM"></Option>
            <Option name="draw_inside_polygon" type="QString" value="0"></Option>
            <Option name="joinstyle" type="QString" value="bevel"></Option>
            <Option name="line_color" type="QString" value="114,155,111,255,rgb:0.4470588,0.6078431,0.4352941,1"></Option>
            <Option name="line_style" type="QString" value="solid"></Option>
            <Option name="line_width" type="QString" value="0.26"></Option>
            <Option name="line_width_unit" type="QString" value="MM"></Option>
            <Option name="offset" type="QString" value="0"></Option>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="offset_unit" type="QString" value="MM"></Option>
            <Option name="ring_filter" type="QString" value="0"></Option>
            <Option name="trim_distance_end" type="QString" value="0"></Option>
            <Option name="trim_distance_end_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="trim_distance_end_unit" type="QString" value="MM"></Option>
            <Option name="trim_distance_start" type="QString" value="0"></Option>
            <Option name="trim_distance_start_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
            <Option name="trim_distance_start_unit" type="QString" value="MM"></Option>
            <Option name="tweak_dash_pattern_on_corners" type="QString" value="0"></Option>
            <Option name="use_custom_dash" type="QString" value="0"></Option>
            <Option name="width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties"></Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </source-symbol>
    <rotation></rotation>
    <sizescale></sizescale>
    <data-defined-properties>
      <Option type="Map">
        <Option name="name" type="QString" value=""></Option>
        <Option name="properties"></Option>
        <Option name="type" type="QString" value="collection"></Option>
      </Option>
    </data-defined-properties>
  </renderer-v2>
  <selection mode="Default">
    <selectionColor invalid="1"></selectionColor>
  </selection>
  <labeling type="simple">
    <settings calloutType="simple">
      <text-style allowHtml="0" blendMode="0" capitalization="0" fieldName="line_label" fontFamily="Sans Serif" fontItalic="0" fontKerning="1" fontLetterSpacing="0" fontSize="10" fontSizeMapUnitScale="3x:0,0,0,0,0,0" fontSizeUnit="Point" fontStrikeout="0" fontUnderline="0" fontWeight="50" fontWordSpacing="0" forcedBold="0" forcedItalic="0" isExpression="1" legendString="Aa" multilineHeight="1" multilineHeightUnit="Percentage" namedStyle="" previewBkgrdColor="255,255,255,255,rgb:1,1,1,1" stretchFactor="100" tabStopDistance="80" tabStopDistanceMapUnitScale="3x:0,0,0,0,0,0" tabStopDistanceUnit="Point" textColor="50,50,50,255,rgb:0.1960784,0.1960784,0.1960784,1" textOpacity="1" textOrientation="horizontal" useSubstitutions="0">
        <families></families>
        <text-buffer bufferBlendMode="0" bufferColor="250,250,250,255,rgb:0.9803922,0.9803922,0.9803922,1" bufferDraw="0" bufferJoinStyle="128" bufferNoFill="1" bufferOpacity="1" bufferSize="1" bufferSizeMapUnitScale="3x:0,0,0,0,0,0" bufferSizeUnits="MM"></text-buffer>
        <text-mask maskEnabled="0" maskJoinStyle="128" maskOpacity="1" maskSize="1.5" maskSize2="1.5" maskSizeMapUnitScale="3x:0,0,0,0,0,0" maskSizeUnits="MM" maskType="0" maskedSymbolLayers=""></text-mask>
        <background shapeBlendMode="0" shapeBorderColor="128,128,128,255,rgb:0.5019608,0.5019608,0.5019608,1" shapeBorderWidth="0" shapeBorderWidthMapUnitScale="3x:0,0,0,0,0,0" shapeBorderWidthUnit="Point" shapeDraw="1" shapeFillColor="181,171,98,255,rgb:0.7098039,0.6705882,0.3843137,1" shapeJoinStyle="64" shapeOffsetMapUnitScale="3x:0,0,0,0,0,0" shapeOffsetUnit="Point" shapeOffsetX="0" shapeOffsetY="0" shapeOpacity="1" shapeRadiiMapUnitScale="3x:0,0,0,0,0,0" shapeRadiiUnit="Point" shapeRadiiX="0" shapeRadiiY="0" shapeRotation="0" shapeRotationType="0" shapeSVGFile="" shapeSizeMapUnitScale="3x:0,0,0,0,0,0" shapeSizeType="0" shapeSizeUnit="Point" shapeSizeX="5" shapeSizeY="0" shapeType="0">
          <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="markerSymbol" type="marker">
            <data_defined_properties>
              <Option type="Map">
                <Option name="name" type="QString" value=""></Option>
                <Option name="properties"></Option>
                <Option name="type" type="QString" value="collection"></Option>
              </Option>
            </data_defined_properties>
            <layer class="SimpleMarker" enabled="1" id="" locked="0" pass="0">
              <Option type="Map">
                <Option name="angle" type="QString" value="0"></Option>
                <Option name="cap_style" type="QString" value="square"></Option>
                <Option name="color" type="QString" value="225,89,137,255,rgb:0.8823529,0.3490196,0.5372549,1"></Option>
                <Option name="horizontal_anchor_point" type="QString" value="1"></Option>
                <Option name="joinstyle" type="QString" value="bevel"></Option>
                <Option name="name" type="QString" value="circle"></Option>
                <Option name="offset" type="QString" value="0,0"></Option>
                <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="offset_unit" type="QString" value="MM"></Option>
                <Option name="outline_color" type="QString" value="35,35,35,255,rgb:0.1372549,0.1372549,0.1372549,1"></Option>
                <Option name="outline_style" type="QString" value="solid"></Option>
                <Option name="outline_width" type="QString" value="0"></Option>
                <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="outline_width_unit" type="QString" value="MM"></Option>
                <Option name="scale_method" type="QString" value="diameter"></Option>
                <Option name="size" type="QString" value="2"></Option>
                <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="size_unit" type="QString" value="MM"></Option>
                <Option name="vertical_anchor_point" type="QString" value="1"></Option>
              </Option>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" type="QString" value=""></Option>
                  <Option name="properties"></Option>
                  <Option name="type" type="QString" value="collection"></Option>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
          <symbol alpha="1" clip_to_extent="1" force_rhr="0" frame_rate="10" is_animated="0" name="fillSymbol" type="fill">
            <data_defined_properties>
              <Option type="Map">
                <Option name="name" type="QString" value=""></Option>
                <Option name="properties"></Option>
                <Option name="type" type="QString" value="collection"></Option>
              </Option>
            </data_defined_properties>
            <layer class="SimpleFill" enabled="1" id="" locked="0" pass="0">
              <Option type="Map">
                <Option name="border_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="color" type="QString" value="241,239,227,255,rgb:0.945098,0.9372549,0.8901961,1"></Option>
                <Option name="joinstyle" type="QString" value="bevel"></Option>
                <Option name="offset" type="QString" value="0,0"></Option>
                <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"></Option>
                <Option name="offset_unit" type="QString" value="MM"></Option>
                <Option name="outline_color" type="QString" value="128,128,128,255,rgb:0.5019608,0.5019608,0.5019608,1"></Option>
                <Option name="outline_style" type="QString" value="no"></Option>
                <Option name="outline_width" type="QString" value="0"></Option>
                <Option name="outline_width_unit" type="QString" value="Point"></Option>
                <Option name="style" type="QString" value="solid"></Option>
              </Option>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" type="QString" value=""></Option>
                  <Option name="properties"></Option>
                  <Option name="type" type="QString" value="collection"></Option>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </background>
        <shadow shadowBlendMode="6" shadowColor="0,0,0,255,rgb:0,0,0,1" shadowDraw="0" shadowOffsetAngle="135" shadowOffsetDist="1" shadowOffsetGlobal="1" shadowOffsetMapUnitScale="3x:0,0,0,0,0,0" shadowOffsetUnit="MM" shadowOpacity="0.69999999999999996" shadowRadius="1.5" shadowRadiusAlphaOnly="0" shadowRadiusMapUnitScale="3x:0,0,0,0,0,0" shadowRadiusUnit="MM" shadowScale="100" shadowUnder="0"></shadow>
        <dd_properties>
          <Option type="Map">
            <Option name="name" type="QString" value=""></Option>
            <Option name="properties"></Option>
            <Option name="type" type="QString" value="collection"></Option>
          </Option>
        </dd_properties>
        <substitutions></substitutions>
      </text-style>
      <text-format addDirectionSymbol="0" autoWrapLength="0" decimals="3" formatNumbers="0" leftDirectionSymbol="&lt;" multilineAlign="0" placeDirectionSymbol="0" plussign="0" reverseDirectionSymbol="0" rightDirectionSymbol=">" useMaxLineLengthForAutoWrap="1" wrapChar=""></text-format>
      <placement allowDegraded="0" centroidInside="0" centroidWhole="0" dist="0" distMapUnitScale="3x:0,0,0,0,0,0" distUnits="MM" fitInPolygonOnly="0" geometryGenerator="" geometryGeneratorEnabled="0" geometryGeneratorType="PointGeometry" labelOffsetMapUnitScale="3x:0,0,0,0,0,0" layerType="LineGeometry" lineAnchorClipping="0" lineAnchorPercent="0.5" lineAnchorTextPoint="FollowPlacement" lineAnchorType="0" maxCurvedCharAngleIn="25" maxCurvedCharAngleOut="-25" maximumDistance="0" maximumDistanceMapUnitScale="3x:0,0,0,0,0,0" maximumDistanceUnit="MM" offsetType="0" offsetUnits="MM" overlapHandling="PreventOverlap" overrunDistance="0" overrunDistanceMapUnitScale="3x:0,0,0,0,0,0" overrunDistanceUnit="MM" placement="2" placementFlags="9" polygonPlacementFlags="2" predefinedPositionOrder="TR,TL,BR,BL,R,L,TSR,BSR" preserveRotation="1" prioritization="PreferCloser" priority="5" quadOffset="4" repeatDistance="0" repeatDistanceMapUnitScale="3x:0,0,0,0,0,0" repeatDistanceUnits="MM" rotationAngle="0" rotationUnit="AngleDegrees" xOffset="0" yOffset="0"></placement>
      <rendering drawLabels="1" fontLimitPixelSize="0" fontMaxPixelSize="10000" fontMinPixelSize="3" labelPerPart="0" limitNumLabels="0" maxNumLabels="2000" mergeLines="0" minFeatureSize="0" obstacle="1" obstacleFactor="1" obstacleType="1" scaleMax="0" scaleMin="0" scaleVisibility="0" unplacedVisibility="0" upsidedownLabels="0" zIndex="0"></rendering>
      <dd_properties>
        <Option type="Map">
          <Option name="name" type="QString" value=""></Option>
          <Option name="properties"></Option>
          <Option name="type" type="QString" value="collection"></Option>
        </Option>
      </dd_properties>
      <callout type="simple">
        <Option type="Map">
          <Option name="anchorPoint" type="QString" value="pole_of_inaccessibility"></Option>
          <Option name="blendMode" type="int" value="0"></Option>
          <Option name="ddProperties" type="Map">
            <Option name="name" type="QString" value=""></Option>
            <Option name="properties"></Option>
            <Option name="type" type="QString" value="collection"></Option>
          </Option>
          <Option name="drawToAllParts" type="bool" value="false"></Option>
          <Option name="enabled" type="QString" value="0"></Option>
          <Option name="labelAnchorPoint" type="QString" value="point_on_exterior"></Option>
          <Option name="lineSymbol" type="QString" value="&lt;symbol clip_to_extent=&quot;1&quot; is_animated=&quot;0&quot; force_rhr=&quot;0&quot; frame_rate=&quot;10&quot; name=&quot;symbol&quot; alpha=&quot;1&quot; type=&quot;line&quot;>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option value=&quot;&quot; name=&quot;name&quot; type=&quot;QString&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option value=&quot;collection&quot; name=&quot;type&quot; type=&quot;QString&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;layer id=&quot;{d2f015f1-d2e3-4eb0-b33c-fbcbf587eb26}&quot; class=&quot;SimpleLine&quot; enabled=&quot;1&quot; locked=&quot;0&quot; pass=&quot;0&quot;>&lt;Option type=&quot;Map&quot;>&lt;Option value=&quot;0&quot; name=&quot;align_dash_pattern&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;square&quot; name=&quot;capstyle&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;5;2&quot; name=&quot;customdash&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;3x:0,0,0,0,0,0&quot; name=&quot;customdash_map_unit_scale&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;MM&quot; name=&quot;customdash_unit&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;0&quot; name=&quot;dash_pattern_offset&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;3x:0,0,0,0,0,0&quot; name=&quot;dash_pattern_offset_map_unit_scale&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;MM&quot; name=&quot;dash_pattern_offset_unit&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;0&quot; name=&quot;draw_inside_polygon&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;bevel&quot; name=&quot;joinstyle&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;60,60,60,255,rgb:0.2352941,0.2352941,0.2352941,1&quot; name=&quot;line_color&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;solid&quot; name=&quot;line_style&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;0.3&quot; name=&quot;line_width&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;MM&quot; name=&quot;line_width_unit&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;0&quot; name=&quot;offset&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;3x:0,0,0,0,0,0&quot; name=&quot;offset_map_unit_scale&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;MM&quot; name=&quot;offset_unit&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;0&quot; name=&quot;ring_filter&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;0&quot; name=&quot;trim_distance_end&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;3x:0,0,0,0,0,0&quot; name=&quot;trim_distance_end_map_unit_scale&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;MM&quot; name=&quot;trim_distance_end_unit&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;0&quot; name=&quot;trim_distance_start&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;3x:0,0,0,0,0,0&quot; name=&quot;trim_distance_start_map_unit_scale&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;MM&quot; name=&quot;trim_distance_start_unit&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;0&quot; name=&quot;tweak_dash_pattern_on_corners&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;0&quot; name=&quot;use_custom_dash&quot; type=&quot;QString&quot;/>&lt;Option value=&quot;3x:0,0,0,0,0,0&quot; name=&quot;width_map_unit_scale&quot; type=&quot;QString&quot;/>&lt;/Option>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option value=&quot;&quot; name=&quot;name&quot; type=&quot;QString&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option value=&quot;collection&quot; name=&quot;type&quot; type=&quot;QString&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;/layer>&lt;/symbol>"></Option>
          <Option name="minLength" type="double" value="0"></Option>
          <Option name="minLengthMapUnitScale" type="QString" value="3x:0,0,0,0,0,0"></Option>
          <Option name="minLengthUnit" type="QString" value="MM"></Option>
          <Option name="offsetFromAnchor" type="double" value="0"></Option>
          <Option name="offsetFromAnchorMapUnitScale" type="QString" value="3x:0,0,0,0,0,0"></Option>
          <Option name="offsetFromAnchorUnit" type="QString" value="MM"></Option>
          <Option name="offsetFromLabel" type="double" value="0"></Option>
          <Option name="offsetFromLabelMapUnitScale" type="QString" value="3x:0,0,0,0,0,0"></Option>
          <Option name="offsetFromLabelUnit" type="QString" value="MM"></Option>
        </Option>
      </callout>
    </settings>
  </labeling>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <fieldConfiguration>
    <field configurationFlags="NoFlag" name="fid">
      <editWidget type="TextEdit">
        <config>
          <Option></Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="uuid">
      <editWidget type="TextEdit">
        <config>
          <Option></Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="field_project_fuid">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" type="bool" value="false"></Option>
            <Option name="AllowNULL" type="bool" value="false"></Option>
            <Option name="FetchLimitActive" type="bool" value="true"></Option>
            <Option name="FetchLimitNumber" type="int" value="100"></Option>
            <Option name="MapIdentification" type="bool" value="false"></Option>
            <Option name="ReadOnly" type="bool" value="false"></Option>
            <Option name="ReferencedLayerDataSource" type="invalid"></Option>
            <Option name="ReferencedLayerId" type="QString" value="field_project_ee419ac9_c97e_4567_b40d_d8964e4188d1"></Option>
            <Option name="ReferencedLayerName" type="QString" value="field_project"></Option>
            <Option name="ReferencedLayerProviderKey" type="QString" value="ogr"></Option>
            <Option name="Relation" type="QString" value="field_project_terrain_line_2"></Option>
            <Option name="ShowForm" type="bool" value="false"></Option>
            <Option name="ShowOpenFormButton" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="line_type_code">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" type="bool" value="false"></Option>
            <Option name="AllowNULL" type="bool" value="false"></Option>
            <Option name="FetchLimitActive" type="bool" value="false"></Option>
            <Option name="FetchLimitNumber" type="int" value="100"></Option>
            <Option name="MapIdentification" type="bool" value="false"></Option>
            <Option name="ReadOnly" type="bool" value="false"></Option>
            <Option name="ReferencedLayerDataSource" type="invalid"></Option>
            <Option name="ReferencedLayerId" type="QString" value="dic_line_type_terrain_ae90b7df_f875_4323_a219_9f086019a416"></Option>
            <Option name="ReferencedLayerName" type="QString" value="dic_line_type_terrain"></Option>
            <Option name="ReferencedLayerProviderKey" type="QString" value="ogr"></Option>
            <Option name="Relation" type="QString" value="dic_line_type_terrain_terrain_line"></Option>
            <Option name="ShowForm" type="bool" value="false"></Option>
            <Option name="ShowOpenFormButton" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="line_label">
      <editWidget type="TextEdit">
        <config>
          <Option></Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="notes">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="true"></Option>
            <Option name="UseHtml" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="mapped_scale">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"></Option>
            <Option name="UseHtml" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="recorded_by">
      <editWidget type="TextEdit">
        <config>
          <Option></Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="recorded_on">
      <editWidget type="DateTime">
        <config>
          <Option></Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="fid" index="0" name=""></alias>
    <alias field="uuid" index="1" name=""></alias>
    <alias field="field_project_fuid" index="2" name=""></alias>
    <alias field="line_type_code" index="3" name=""></alias>
    <alias field="line_label" index="4" name=""></alias>
    <alias field="notes" index="5" name=""></alias>
    <alias field="mapped_scale" index="6" name=""></alias>
    <alias field="recorded_by" index="7" name=""></alias>
    <alias field="recorded_on" index="8" name=""></alias>
  </aliases>
  <defaults>
    <default applyOnUpdate="0" expression="" field="fid"></default>
    <default applyOnUpdate="0" expression="uuid()" field="uuid"></default>
    <default applyOnUpdate="0" expression="attribute(&#xD;&#xA;&#x9;get_feature(&#xD;&#xA;&#x9;&#x9;'field_project',&#xD;&#xA;&#x9;&#x9;'fid',&#xD;&#xA;&#x9;&#x9;-- Get the list of field_project fid values&#xD;&#xA;&#x9;&#x9;-- Then take the first one&#xD;&#xA;&#x9;&#x9;-- There should only be one, but this means&#xD;&#xA;&#x9;&#x9;-- that if the fid changes, this expression&#xD;&#xA;&#x9;&#x9;-- still works as expected&#xD;&#xA;&#x9;&#x9;aggregate(&#xD;&#xA;&#x9;&#x9;&#x9;'field_project',&#xD;&#xA;&#x9;&#x9;&#x9;'array_agg',&#xD;&#xA;&#x9;&#x9;&#x9;&quot;fid&quot;&#xD;&#xA;&#x9;&#x9;)[0]&#xD;&#xA;&#x9;),&#xD;&#xA;&#x9;'uuid'&#xD;&#xA;)" field="field_project_fuid"></default>
    <default applyOnUpdate="0" expression="" field="line_type_code"></default>
    <default applyOnUpdate="0" expression="" field="line_label"></default>
    <default applyOnUpdate="0" expression="" field="notes"></default>
    <default applyOnUpdate="1" expression="attribute(get_feature('field_project', 'uuid', attribute(@feature, 'field_project_fuid')), 'mapped_scale')" field="mapped_scale"></default>
    <default applyOnUpdate="0" expression="coalesce(nullif(@mergin_username, ''), @user_account_name)" field="recorded_by"></default>
    <default applyOnUpdate="0" expression="now()" field="recorded_on"></default>
  </defaults>
  <constraints>
    <constraint constraints="3" exp_strength="0" field="fid" notnull_strength="1" unique_strength="1"></constraint>
    <constraint constraints="7" exp_strength="1" field="uuid" notnull_strength="1" unique_strength="1"></constraint>
    <constraint constraints="5" exp_strength="1" field="field_project_fuid" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="5" exp_strength="1" field="line_type_code" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="4" exp_strength="1" field="line_label" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="4" exp_strength="1" field="notes" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="1" exp_strength="0" field="mapped_scale" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="5" exp_strength="1" field="recorded_by" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="1" exp_strength="0" field="recorded_on" notnull_strength="1" unique_strength="0"></constraint>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="fid"></constraint>
    <constraint desc="Character limit: 38" exp="if(&quot;uuid&quot; is not null, length(&quot;uuid&quot;) &lt;= 38, true)" field="uuid"></constraint>
    <constraint desc="Character limit: 38" exp="if(&quot;field_project_fuid&quot; is not null, length(&quot;field_project_fuid&quot;) &lt;= 38, true)" field="field_project_fuid"></constraint>
    <constraint desc="Character limit: 50" exp="if(&quot;line_type_code&quot; is not null, length(&quot;line_type_code&quot;) &lt;= 50, true)" field="line_type_code"></constraint>
    <constraint desc="Character limit: 255" exp="if(&quot;line_label&quot; is not null, length(&quot;line_label&quot;) &lt;= 255, true)" field="line_label"></constraint>
    <constraint desc="Character limit: 4000" exp="if(&quot;notes&quot; is not null, length(&quot;notes&quot;) &lt;= 4000, true)" field="notes"></constraint>
    <constraint desc="" exp="" field="mapped_scale"></constraint>
    <constraint desc="Character limit: 50" exp="if(&quot;recorded_by&quot; is not null, length(&quot;recorded_by&quot;) &lt;= 50, true)" field="recorded_by"></constraint>
    <constraint desc="" exp="" field="recorded_on"></constraint>
  </constraintExpressions>
  <expressionfields></expressionfields>
  <editform tolerant="1"></editform>
  <editforminit></editforminit>
  <editforminitcodesource>0</editforminitcodesource>
  <editforminitfilepath></editforminitfilepath>
  <editforminitcode># -*- coding: utf-8 -*-
"""
QGIS forms can have a Python function that is called when the form is
opened.

Use this function to add extra logic to your forms.

Enter the name of the function in the "Python Init function"
field.
An example follows:
"""
from qgis.PyQt.QtWidgets import QWidget

def my_form_open(dialog, layer, feature):
    geom = feature.geometry()
    control = dialog.findChild(QWidget, "MyLineEdit")
</editforminitcode>
  <featformsuppress>0</featformsuppress>
  <editorlayout>tablayout</editorlayout>
  <attributeEditorForm>
    <labelStyle labelColor="" overrideLabelColor="0" overrideLabelFont="0">
      <labelFont bold="0" description="MS Shell Dlg 2,9.8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
    </labelStyle>
    <attributeEditorContainer collapsed="1" collapsedExpression="" collapsedExpressionEnabled="0" columnCount="1" groupBox="1" horizontalStretch="0" name="Metadata" showLabel="1" type="GroupBox" verticalStretch="0" visibilityExpression="" visibilityExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
      <attributeEditorTextElement horizontalStretch="0" name="created" showLabel="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
        </labelStyle>Created by [% "recorded_by" %] on: [%  format_date("recorded_on", 'ddd dd MMM yyyy, hh:mm') %]</attributeEditorTextElement>
      <attributeEditorTextElement horizontalStretch="0" name="line stats" showLabel="0" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
        </labelStyle>length: [% format_number($length, 2) + 'm' %]&#xD;
azimuth: [% format_number(&#xD;
	degrees(&#xD;
		azimuth(&#xD;
			start_point(@geometry),&#xD;
			end_point(@geometry)&#xD;
		)&#xD;
	),&#xD;
	2&#xD;
) + '°' %]</attributeEditorTextElement>
    </attributeEditorContainer>
    <attributeEditorField horizontalStretch="0" index="3" name="line_type_code" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="Noto Sans,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="4" name="line_label" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorTextElement horizontalStretch="0" name="suggested_attributes" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>[% attribute(get_feature('dic_line_type_terrain', 'code', current_value('line_type_code') ), 'sec_attrib_list') %]</attributeEditorTextElement>
    <attributeEditorField horizontalStretch="0" index="5" name="notes" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="6" name="mapped_scale" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
    </attributeEditorField>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="fid"></field>
    <field editable="1" name="field_project_fuid"></field>
    <field editable="1" name="line_label"></field>
    <field editable="1" name="line_type_code"></field>
    <field editable="1" name="mapped_scale"></field>
    <field editable="1" name="notes"></field>
    <field editable="1" name="recorded_by"></field>
    <field editable="1" name="recorded_on"></field>
    <field editable="1" name="uuid"></field>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="fid"></field>
    <field labelOnTop="0" name="field_project_fuid"></field>
    <field labelOnTop="0" name="line_label"></field>
    <field labelOnTop="0" name="line_type_code"></field>
    <field labelOnTop="0" name="mapped_scale"></field>
    <field labelOnTop="0" name="notes"></field>
    <field labelOnTop="0" name="recorded_by"></field>
    <field labelOnTop="0" name="recorded_on"></field>
    <field labelOnTop="0" name="uuid"></field>
  </labelOnTop>
  <reuseLastValue>
    <field name="fid" reuseLastValue="0"></field>
    <field name="field_project_fuid" reuseLastValue="1"></field>
    <field name="line_label" reuseLastValue="0"></field>
    <field name="line_type_code" reuseLastValue="1"></field>
    <field name="mapped_scale" reuseLastValue="0"></field>
    <field name="notes" reuseLastValue="0"></field>
    <field name="recorded_by" reuseLastValue="0"></field>
    <field name="recorded_on" reuseLastValue="0"></field>
    <field name="uuid" reuseLastValue="0"></field>
  </reuseLastValue>
  <dataDefinedFieldProperties></dataDefinedFieldProperties>
  <widgets></widgets>
  <mapTip enabled="1"></mapTip>
  <layerGeometryType>1</layerGeometryType>
</qgis>