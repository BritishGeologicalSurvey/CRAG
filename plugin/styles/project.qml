<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="Symbology|Labeling|Fields|Forms" version="3.30.0-'s-Hertogenbosch">
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
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="short_name">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="title">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="description">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="true" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="responsible_person_id">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="status_code">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="start_date">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option value="true" name="allow_null" type="bool"/>
            <Option value="true" name="calendar_popup" type="bool"/>
            <Option value="yyyy-MM-dd" name="display_format" type="QString"/>
            <Option value="yyyy-MM-dd" name="field_format" type="QString"/>
            <Option value="false" name="field_iso_format" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="end_date">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option value="true" name="allow_null" type="bool"/>
            <Option value="true" name="calendar_popup" type="bool"/>
            <Option value="yyyy-MM-dd" name="display_format" type="QString"/>
            <Option value="yyyy-MM-dd" name="field_format" type="QString"/>
            <Option value="false" name="field_iso_format" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="project_type">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/jostev/mergin/data-model-v2.1/field-data-capture.gpkg|layername=dic_project_type" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="dic_project_type_c1a93252_0aca_461f_9aba_7ff3cf1e3400" name="ReferencedLayerId" type="QString"/>
            <Option value="dic_project_type" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="dic_project_type_project" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="local_epsg">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="comment">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="true" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
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
    <alias index="0" name="" field="fid"/>
    <alias index="1" name="" field="objectid"/>
    <alias index="2" name="" field="uuid"/>
    <alias index="3" name="" field="short_name"/>
    <alias index="4" name="" field="title"/>
    <alias index="5" name="" field="description"/>
    <alias index="6" name="" field="responsible_person_id"/>
    <alias index="7" name="" field="status_code"/>
    <alias index="8" name="" field="start_date"/>
    <alias index="9" name="" field="end_date"/>
    <alias index="10" name="" field="project_type"/>
    <alias index="11" name="" field="local_epsg"/>
    <alias index="12" name="" field="comment"/>
    <alias index="13" name="" field="user_entered"/>
    <alias index="14" name="" field="date_entered"/>
    <alias index="15" name="" field="user_updated"/>
    <alias index="16" name="" field="date_updated"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="fid"/>
    <policy policy="Duplicate" field="objectid"/>
    <policy policy="Duplicate" field="uuid"/>
    <policy policy="Duplicate" field="short_name"/>
    <policy policy="Duplicate" field="title"/>
    <policy policy="Duplicate" field="description"/>
    <policy policy="Duplicate" field="responsible_person_id"/>
    <policy policy="Duplicate" field="status_code"/>
    <policy policy="Duplicate" field="start_date"/>
    <policy policy="Duplicate" field="end_date"/>
    <policy policy="Duplicate" field="project_type"/>
    <policy policy="Duplicate" field="local_epsg"/>
    <policy policy="Duplicate" field="comment"/>
    <policy policy="Duplicate" field="user_entered"/>
    <policy policy="Duplicate" field="date_entered"/>
    <policy policy="Duplicate" field="user_updated"/>
    <policy policy="Duplicate" field="date_updated"/>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="fid"/>
    <default applyOnUpdate="0" expression="" field="objectid"/>
    <default applyOnUpdate="0" expression="uuid()" field="uuid"/>
    <default applyOnUpdate="0" expression="" field="short_name"/>
    <default applyOnUpdate="0" expression="" field="title"/>
    <default applyOnUpdate="0" expression="" field="description"/>
    <default applyOnUpdate="0" expression="" field="responsible_person_id"/>
    <default applyOnUpdate="0" expression="" field="status_code"/>
    <default applyOnUpdate="0" expression="" field="start_date"/>
    <default applyOnUpdate="0" expression="" field="end_date"/>
    <default applyOnUpdate="0" expression="" field="project_type"/>
    <default applyOnUpdate="0" expression="" field="local_epsg"/>
    <default applyOnUpdate="0" expression="" field="comment"/>
    <default applyOnUpdate="0" expression="@user_account_name" field="user_entered"/>
    <default applyOnUpdate="0" expression="now()" field="date_entered"/>
    <default applyOnUpdate="1" expression="@user_account_name" field="user_updated"/>
    <default applyOnUpdate="1" expression="now()" field="date_updated"/>
  </defaults>
  <constraints>
    <constraint constraints="3" unique_strength="1" notnull_strength="1" field="fid" exp_strength="0"/>
    <constraint constraints="2" unique_strength="1" notnull_strength="0" field="objectid" exp_strength="0"/>
    <constraint constraints="3" unique_strength="1" notnull_strength="1" field="uuid" exp_strength="0"/>
    <constraint constraints="3" unique_strength="1" notnull_strength="1" field="short_name" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" field="title" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" field="description" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" field="responsible_person_id" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" field="status_code" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" field="start_date" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" field="end_date" exp_strength="0"/>
    <constraint constraints="1" unique_strength="0" notnull_strength="1" field="project_type" exp_strength="0"/>
    <constraint constraints="1" unique_strength="0" notnull_strength="1" field="local_epsg" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" field="comment" exp_strength="0"/>
    <constraint constraints="1" unique_strength="0" notnull_strength="1" field="user_entered" exp_strength="0"/>
    <constraint constraints="1" unique_strength="0" notnull_strength="1" field="date_entered" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" field="user_updated" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" field="date_updated" exp_strength="0"/>
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
      <labelFont italic="0" underline="0" bold="0" style="" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" strikethrough="0"/>
    </labelStyle>
    <attributeEditorField index="3" name="short_name" showLabel="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" underline="0" bold="0" style="" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="4" name="title" showLabel="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" underline="0" bold="0" style="" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="5" name="description" showLabel="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" underline="0" bold="0" style="" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="6" name="responsible_person_id" showLabel="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" underline="0" bold="0" style="" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="7" name="status_code" showLabel="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" underline="0" bold="0" style="" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="8" name="start_date" showLabel="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" underline="0" bold="0" style="" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="9" name="end_date" showLabel="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" underline="0" bold="0" style="" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="10" name="project_type" showLabel="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" underline="0" bold="0" style="" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="11" name="local_epsg" showLabel="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" underline="0" bold="0" style="" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="12" name="comment" showLabel="1">
      <labelStyle labelColor="0,0,0,255" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont italic="0" underline="0" bold="0" style="" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" strikethrough="0"/>
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
