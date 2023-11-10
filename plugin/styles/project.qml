<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.28.11-Firenze" styleCategories="Symbology|Labeling|Fields|Forms">
  <fieldConfiguration>
    <field name="fid" configurationFlags="None">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="objectid" configurationFlags="None">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="uuid" configurationFlags="None">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="short_name" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="title" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="description" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="true"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="responsible_person_id" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="status_code" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="start_date" configurationFlags="None">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option type="bool" name="allow_null" value="true"/>
            <Option type="bool" name="calendar_popup" value="true"/>
            <Option type="QString" name="display_format" value="yyyy-MM-dd"/>
            <Option type="QString" name="field_format" value="yyyy-MM-dd"/>
            <Option type="bool" name="field_iso_format" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="end_date" configurationFlags="None">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option type="bool" name="allow_null" value="true"/>
            <Option type="bool" name="calendar_popup" value="true"/>
            <Option type="QString" name="display_format" value="yyyy-MM-dd"/>
            <Option type="QString" name="field_format" value="yyyy-MM-dd"/>
            <Option type="bool" name="field_iso_format" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="project_type" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" name="AllowAddFeatures" value="false"/>
            <Option type="bool" name="AllowNULL" value="false"/>
            <Option type="bool" name="MapIdentification" value="false"/>
            <Option type="bool" name="OrderByValue" value="false"/>
            <Option type="bool" name="ReadOnly" value="false"/>
            <Option type="QString" name="ReferencedLayerDataSource" value="C:/Users/jostev/mergin/data-model-v2.1/field-data-capture.gpkg|layername=dic_project_type"/>
            <Option type="QString" name="ReferencedLayerId" value="dic_project_type_c1a93252_0aca_461f_9aba_7ff3cf1e3400"/>
            <Option type="QString" name="ReferencedLayerName" value="dic_project_type"/>
            <Option type="QString" name="ReferencedLayerProviderKey" value="ogr"/>
            <Option type="QString" name="Relation" value="dic_project_type_project"/>
            <Option type="bool" name="ShowForm" value="false"/>
            <Option type="bool" name="ShowOpenFormButton" value="true"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="local_epsg" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="comment" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="true"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="user_entered" configurationFlags="None">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="date_entered" configurationFlags="None">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="user_updated" configurationFlags="None">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="date_updated" configurationFlags="None">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias name="" field="fid" index="0"/>
    <alias name="" field="objectid" index="1"/>
    <alias name="" field="uuid" index="2"/>
    <alias name="" field="short_name" index="3"/>
    <alias name="" field="title" index="4"/>
    <alias name="" field="description" index="5"/>
    <alias name="" field="responsible_person_id" index="6"/>
    <alias name="" field="status_code" index="7"/>
    <alias name="" field="start_date" index="8"/>
    <alias name="" field="end_date" index="9"/>
    <alias name="" field="project_type" index="10"/>
    <alias name="" field="local_epsg" index="11"/>
    <alias name="" field="comment" index="12"/>
    <alias name="" field="user_entered" index="13"/>
    <alias name="" field="date_entered" index="14"/>
    <alias name="" field="user_updated" index="15"/>
    <alias name="" field="date_updated" index="16"/>
  </aliases>
  <defaults>
    <default field="fid" expression="" applyOnUpdate="0"/>
    <default field="objectid" expression="" applyOnUpdate="0"/>
    <default field="uuid" expression="uuid()" applyOnUpdate="0"/>
    <default field="short_name" expression="" applyOnUpdate="0"/>
    <default field="title" expression="" applyOnUpdate="0"/>
    <default field="description" expression="" applyOnUpdate="0"/>
    <default field="responsible_person_id" expression="" applyOnUpdate="0"/>
    <default field="status_code" expression="" applyOnUpdate="0"/>
    <default field="start_date" expression="" applyOnUpdate="0"/>
    <default field="end_date" expression="" applyOnUpdate="0"/>
    <default field="project_type" expression="" applyOnUpdate="0"/>
    <default field="local_epsg" expression="" applyOnUpdate="0"/>
    <default field="comment" expression="" applyOnUpdate="0"/>
    <default field="user_entered" expression="@user_account_name" applyOnUpdate="0"/>
    <default field="date_entered" expression="now()" applyOnUpdate="0"/>
    <default field="user_updated" expression="@user_account_name" applyOnUpdate="1"/>
    <default field="date_updated" expression="now()" applyOnUpdate="1"/>
  </defaults>
  <constraints>
    <constraint constraints="3" field="fid" notnull_strength="1" exp_strength="0" unique_strength="1"/>
    <constraint constraints="2" field="objectid" notnull_strength="0" exp_strength="0" unique_strength="1"/>
    <constraint constraints="3" field="uuid" notnull_strength="1" exp_strength="0" unique_strength="1"/>
    <constraint constraints="3" field="short_name" notnull_strength="1" exp_strength="0" unique_strength="1"/>
    <constraint constraints="0" field="title" notnull_strength="0" exp_strength="0" unique_strength="0"/>
    <constraint constraints="0" field="description" notnull_strength="0" exp_strength="0" unique_strength="0"/>
    <constraint constraints="0" field="responsible_person_id" notnull_strength="0" exp_strength="0" unique_strength="0"/>
    <constraint constraints="0" field="status_code" notnull_strength="0" exp_strength="0" unique_strength="0"/>
    <constraint constraints="0" field="start_date" notnull_strength="0" exp_strength="0" unique_strength="0"/>
    <constraint constraints="0" field="end_date" notnull_strength="0" exp_strength="0" unique_strength="0"/>
    <constraint constraints="1" field="project_type" notnull_strength="1" exp_strength="0" unique_strength="0"/>
    <constraint constraints="1" field="local_epsg" notnull_strength="1" exp_strength="0" unique_strength="0"/>
    <constraint constraints="0" field="comment" notnull_strength="0" exp_strength="0" unique_strength="0"/>
    <constraint constraints="1" field="user_entered" notnull_strength="1" exp_strength="0" unique_strength="0"/>
    <constraint constraints="1" field="date_entered" notnull_strength="1" exp_strength="0" unique_strength="0"/>
    <constraint constraints="0" field="user_updated" notnull_strength="0" exp_strength="0" unique_strength="0"/>
    <constraint constraints="0" field="date_updated" notnull_strength="0" exp_strength="0" unique_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" field="fid" exp=""/>
    <constraint desc="" field="objectid" exp=""/>
    <constraint desc="" field="uuid" exp=""/>
    <constraint desc="" field="short_name" exp=""/>
    <constraint desc="" field="title" exp=""/>
    <constraint desc="" field="description" exp=""/>
    <constraint desc="" field="responsible_person_id" exp=""/>
    <constraint desc="" field="status_code" exp=""/>
    <constraint desc="" field="start_date" exp=""/>
    <constraint desc="" field="end_date" exp=""/>
    <constraint desc="" field="project_type" exp=""/>
    <constraint desc="" field="local_epsg" exp=""/>
    <constraint desc="" field="comment" exp=""/>
    <constraint desc="" field="user_entered" exp=""/>
    <constraint desc="" field="date_entered" exp=""/>
    <constraint desc="" field="user_updated" exp=""/>
    <constraint desc="" field="date_updated" exp=""/>
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
      <labelFont description="Sans Serif,9,-1,5,50,0,0,0,0,0" italic="0" style="" underline="0" strikethrough="0" bold="0"/>
    </labelStyle>
    <attributeEditorField showLabel="1" name="short_name" index="3">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" italic="0" style="" underline="0" strikethrough="0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" name="title" index="4">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" italic="0" style="" underline="0" strikethrough="0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" name="description" index="5">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" italic="0" style="" underline="0" strikethrough="0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" name="responsible_person_id" index="6">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" italic="0" style="" underline="0" strikethrough="0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" name="status_code" index="7">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" italic="0" style="" underline="0" strikethrough="0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" name="start_date" index="8">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" italic="0" style="" underline="0" strikethrough="0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" name="end_date" index="9">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" italic="0" style="" underline="0" strikethrough="0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" name="project_type" index="10">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" italic="0" style="" underline="0" strikethrough="0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" name="local_epsg" index="11">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" italic="0" style="" underline="0" strikethrough="0" bold="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField showLabel="1" name="comment" index="12">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" italic="0" style="" underline="0" strikethrough="0" bold="0"/>
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
    <field name="comment" labelOnTop="0"/>
    <field name="date_entered" labelOnTop="0"/>
    <field name="date_updated" labelOnTop="0"/>
    <field name="description" labelOnTop="0"/>
    <field name="end_date" labelOnTop="0"/>
    <field name="fid" labelOnTop="0"/>
    <field name="local_epsg" labelOnTop="0"/>
    <field name="objectid" labelOnTop="0"/>
    <field name="project_type" labelOnTop="0"/>
    <field name="responsible_person_id" labelOnTop="0"/>
    <field name="short_name" labelOnTop="0"/>
    <field name="start_date" labelOnTop="0"/>
    <field name="status_code" labelOnTop="0"/>
    <field name="title" labelOnTop="0"/>
    <field name="user_entered" labelOnTop="0"/>
    <field name="user_updated" labelOnTop="0"/>
    <field name="uuid" labelOnTop="0"/>
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
