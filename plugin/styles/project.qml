<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.28.11-Firenze" styleCategories="Symbology|Labeling|Fields|Forms">
  <fieldConfiguration>
    <field configurationFlags="None" name="fid">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="objectid">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="uuid">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="short_name">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="title">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="description">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="true" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="responsible_person_id">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="status_code">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="start_date">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option type="bool" value="true" name="allow_null"/>
            <Option type="bool" value="true" name="calendar_popup"/>
            <Option type="QString" value="yyyy-MM-dd" name="display_format"/>
            <Option type="QString" value="yyyy-MM-dd" name="field_format"/>
            <Option type="bool" value="false" name="field_iso_format"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="end_date">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option type="bool" value="true" name="allow_null"/>
            <Option type="bool" value="true" name="calendar_popup"/>
            <Option type="QString" value="yyyy-MM-dd" name="display_format"/>
            <Option type="QString" value="yyyy-MM-dd" name="field_format"/>
            <Option type="bool" value="false" name="field_iso_format"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="project_type">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowAddFeatures"/>
            <Option type="bool" value="true" name="AllowNULL"/>
            <Option type="bool" value="false" name="MapIdentification"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="ReadOnly"/>
            <Option type="QString" value="/home/leorud/personal/qgis_testing/fdc-plugin/field-data-capture.gpkg|layername=dic_project_type" name="ReferencedLayerDataSource"/>
            <Option type="QString" value="dic_project_type_7eceea9f_ce95_438d_aa04_cd9f81cb20b8" name="ReferencedLayerId"/>
            <Option type="QString" value="dic_project_type" name="ReferencedLayerName"/>
            <Option type="QString" value="ogr" name="ReferencedLayerProviderKey"/>
            <Option type="QString" value="dic_project_type_project" name="Relation"/>
            <Option type="bool" value="false" name="ShowForm"/>
            <Option type="bool" value="true" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="local_epsg">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="List" name="map">
              <Option type="Map">
                <Option type="QString" value="27700" name="British National Grid (EPSG:27700)"/>
              </Option>
              <Option type="Map">
                <Option type="QString" value="4326" name="WGS84 (EPSG:4326)"/>
              </Option>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="comment">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="true" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="user_entered">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="date_entered">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="user_updated">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="date_updated">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias name="" index="0" field="fid"/>
    <alias name="" index="1" field="objectid"/>
    <alias name="" index="2" field="uuid"/>
    <alias name="" index="3" field="short_name"/>
    <alias name="" index="4" field="title"/>
    <alias name="" index="5" field="description"/>
    <alias name="" index="6" field="responsible_person_id"/>
    <alias name="" index="7" field="status_code"/>
    <alias name="" index="8" field="start_date"/>
    <alias name="" index="9" field="end_date"/>
    <alias name="" index="10" field="project_type"/>
    <alias name="" index="11" field="local_epsg"/>
    <alias name="" index="12" field="comment"/>
    <alias name="" index="13" field="user_entered"/>
    <alias name="" index="14" field="date_entered"/>
    <alias name="" index="15" field="user_updated"/>
    <alias name="" index="16" field="date_updated"/>
  </aliases>
  <defaults>
    <default expression="" field="fid" applyOnUpdate="0"/>
    <default expression="" field="objectid" applyOnUpdate="0"/>
    <default expression="uuid()" field="uuid" applyOnUpdate="0"/>
    <default expression="" field="short_name" applyOnUpdate="0"/>
    <default expression="" field="title" applyOnUpdate="0"/>
    <default expression="" field="description" applyOnUpdate="0"/>
    <default expression="" field="responsible_person_id" applyOnUpdate="0"/>
    <default expression="" field="status_code" applyOnUpdate="0"/>
    <default expression="" field="start_date" applyOnUpdate="0"/>
    <default expression="" field="end_date" applyOnUpdate="0"/>
    <default expression="" field="project_type" applyOnUpdate="0"/>
    <default expression="" field="local_epsg" applyOnUpdate="0"/>
    <default expression="" field="comment" applyOnUpdate="0"/>
    <default expression="@user_account_name" field="user_entered" applyOnUpdate="0"/>
    <default expression="now()" field="date_entered" applyOnUpdate="0"/>
    <default expression="@user_account_name" field="user_updated" applyOnUpdate="1"/>
    <default expression="now()" field="date_updated" applyOnUpdate="1"/>
  </defaults>
  <constraints>
    <constraint unique_strength="1" constraints="3" notnull_strength="1" exp_strength="0" field="fid"/>
    <constraint unique_strength="1" constraints="2" notnull_strength="0" exp_strength="0" field="objectid"/>
    <constraint unique_strength="1" constraints="3" notnull_strength="1" exp_strength="0" field="uuid"/>
    <constraint unique_strength="1" constraints="3" notnull_strength="1" exp_strength="0" field="short_name"/>
    <constraint unique_strength="0" constraints="0" notnull_strength="0" exp_strength="0" field="title"/>
    <constraint unique_strength="0" constraints="0" notnull_strength="0" exp_strength="0" field="description"/>
    <constraint unique_strength="0" constraints="0" notnull_strength="0" exp_strength="0" field="responsible_person_id"/>
    <constraint unique_strength="0" constraints="0" notnull_strength="0" exp_strength="0" field="status_code"/>
    <constraint unique_strength="0" constraints="0" notnull_strength="0" exp_strength="0" field="start_date"/>
    <constraint unique_strength="0" constraints="0" notnull_strength="0" exp_strength="0" field="end_date"/>
    <constraint unique_strength="0" constraints="1" notnull_strength="1" exp_strength="0" field="project_type"/>
    <constraint unique_strength="0" constraints="1" notnull_strength="1" exp_strength="0" field="local_epsg"/>
    <constraint unique_strength="0" constraints="0" notnull_strength="0" exp_strength="0" field="comment"/>
    <constraint unique_strength="0" constraints="1" notnull_strength="1" exp_strength="0" field="user_entered"/>
    <constraint unique_strength="0" constraints="1" notnull_strength="1" exp_strength="0" field="date_entered"/>
    <constraint unique_strength="0" constraints="0" notnull_strength="0" exp_strength="0" field="user_updated"/>
    <constraint unique_strength="0" constraints="0" notnull_strength="0" exp_strength="0" field="date_updated"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="fid"/>
    <constraint exp="" desc="" field="objectid"/>
    <constraint exp="" desc="" field="uuid"/>
    <constraint exp="" desc="" field="short_name"/>
    <constraint exp="" desc="" field="title"/>
    <constraint exp="" desc="" field="description"/>
    <constraint exp="" desc="" field="responsible_person_id"/>
    <constraint exp="" desc="" field="status_code"/>
    <constraint exp="" desc="" field="start_date"/>
    <constraint exp="" desc="" field="end_date"/>
    <constraint exp="" desc="" field="project_type"/>
    <constraint exp="" desc="" field="local_epsg"/>
    <constraint exp="" desc="" field="comment"/>
    <constraint exp="" desc="" field="user_entered"/>
    <constraint exp="" desc="" field="date_entered"/>
    <constraint exp="" desc="" field="user_updated"/>
    <constraint exp="" desc="" field="date_updated"/>
  </constraintExpressions>
  <expressionfields/>
  <editform tolerant="1"></editform>
  <editforminit/>
  <editforminitcodesource>0</editforminitcodesource>
  <editforminitfilepath></editforminitfilepath>
  <editforminitcode><![CDATA[# -*- coding: utf-8 -*-
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
]]></editforminitcode>
  <featformsuppress>0</featformsuppress>
  <editorlayout>tablayout</editorlayout>
  <attributeEditorForm>
    <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
      <labelFont strikethrough="0" italic="0" bold="0" description="Sans Serif,9,-1,5,50,0,0,0,0,0" style="" underline="0"/>
    </labelStyle>
    <attributeEditorField name="short_name" index="3" showLabel="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont strikethrough="0" italic="0" bold="0" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="title" index="4" showLabel="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont strikethrough="0" italic="0" bold="0" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="description" index="5" showLabel="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont strikethrough="0" italic="0" bold="0" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="responsible_person_id" index="6" showLabel="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont strikethrough="0" italic="0" bold="0" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="status_code" index="7" showLabel="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont strikethrough="0" italic="0" bold="0" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="start_date" index="8" showLabel="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont strikethrough="0" italic="0" bold="0" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="end_date" index="9" showLabel="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont strikethrough="0" italic="0" bold="0" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="project_type" index="10" showLabel="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont strikethrough="0" italic="0" bold="0" description="DejaVu Sans,9,-1,5,50,0,0,0,0,0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="local_epsg" index="11" showLabel="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont strikethrough="0" italic="0" bold="0" description="DejaVu Sans,9,-1,5,50,0,0,0,0,0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="comment" index="12" showLabel="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont strikethrough="0" italic="0" bold="0" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" style="" underline="0"/>
      </labelStyle>
    </attributeEditorField>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="comment"/>
    <field editable="1" name="date_entered"/>
    <field editable="1" name="date_updated"/>
    <field editable="1" name="description"/>
    <field editable="1" name="end_date"/>
    <field editable="1" name="fid"/>
    <field editable="1" name="local_epsg"/>
    <field editable="1" name="objectid"/>
    <field editable="1" name="project_type"/>
    <field editable="1" name="responsible_person_id"/>
    <field editable="1" name="short_name"/>
    <field editable="1" name="start_date"/>
    <field editable="1" name="status_code"/>
    <field editable="1" name="title"/>
    <field editable="1" name="user_entered"/>
    <field editable="1" name="user_updated"/>
    <field editable="1" name="uuid"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="comment"/>
    <field labelOnTop="0" name="date_entered"/>
    <field labelOnTop="0" name="date_updated"/>
    <field labelOnTop="0" name="description"/>
    <field labelOnTop="0" name="end_date"/>
    <field labelOnTop="0" name="fid"/>
    <field labelOnTop="0" name="local_epsg"/>
    <field labelOnTop="0" name="objectid"/>
    <field labelOnTop="0" name="project_type"/>
    <field labelOnTop="0" name="responsible_person_id"/>
    <field labelOnTop="0" name="short_name"/>
    <field labelOnTop="0" name="start_date"/>
    <field labelOnTop="0" name="status_code"/>
    <field labelOnTop="0" name="title"/>
    <field labelOnTop="0" name="user_entered"/>
    <field labelOnTop="0" name="user_updated"/>
    <field labelOnTop="0" name="uuid"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="comment" reuseLastValue="0"/>
    <field name="date_entered" reuseLastValue="0"/>
    <field name="date_updated" reuseLastValue="0"/>
    <field name="description" reuseLastValue="0"/>
    <field name="end_date" reuseLastValue="0"/>
    <field name="fid" reuseLastValue="0"/>
    <field name="local_epsg" reuseLastValue="0"/>
    <field name="objectid" reuseLastValue="0"/>
    <field name="project_type" reuseLastValue="0"/>
    <field name="responsible_person_id" reuseLastValue="0"/>
    <field name="short_name" reuseLastValue="0"/>
    <field name="start_date" reuseLastValue="0"/>
    <field name="status_code" reuseLastValue="0"/>
    <field name="title" reuseLastValue="0"/>
    <field name="user_entered" reuseLastValue="0"/>
    <field name="user_updated" reuseLastValue="0"/>
    <field name="uuid" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <layerGeometryType>4</layerGeometryType>
</qgis>
