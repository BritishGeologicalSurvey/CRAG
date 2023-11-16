<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="Symbology|Labeling|Fields|Forms" version="3.28.11-Firenze">
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
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="title" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="description" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="true" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="responsible_person_id" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="status_code" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="start_date" configurationFlags="None">
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
    <field name="end_date" configurationFlags="None">
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
    <field name="project_type" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/jostev/mergin/data-model-v2.1/field-data-capture.gpkg|layername=dic_project_type" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="dic_project_type_8b5b572b_6af3_4552_9910_f953dcd30a90" name="ReferencedLayerId" type="QString"/>
            <Option value="dic_project_type" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="dic_project_type_project" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="local_epsg" configurationFlags="None">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option name="map" type="List">
              <Option type="Map">
                <Option value="27700" name="British National Grid (EPSG:27700)" type="QString"/>
              </Option>
              <Option type="Map">
                <Option value="4326" name="WGS84 (EPSG:4326)" type="QString"/>
              </Option>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="comment" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="true" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
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
    <constraint exp_strength="0" unique_strength="1" notnull_strength="1" field="fid" constraints="3"/>
    <constraint exp_strength="0" unique_strength="1" notnull_strength="0" field="objectid" constraints="2"/>
    <constraint exp_strength="0" unique_strength="1" notnull_strength="1" field="uuid" constraints="3"/>
    <constraint exp_strength="0" unique_strength="1" notnull_strength="1" field="short_name" constraints="3"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="0" field="title" constraints="0"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="0" field="description" constraints="0"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="0" field="responsible_person_id" constraints="0"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="0" field="status_code" constraints="0"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="0" field="start_date" constraints="0"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="0" field="end_date" constraints="0"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="1" field="project_type" constraints="1"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="1" field="local_epsg" constraints="1"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="0" field="comment" constraints="0"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="1" field="user_entered" constraints="1"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="1" field="date_entered" constraints="1"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="0" field="user_updated" constraints="0"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="0" field="date_updated" constraints="0"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" field="fid" desc=""/>
    <constraint exp="" field="objectid" desc=""/>
    <constraint exp="" field="uuid" desc=""/>
    <constraint exp="" field="short_name" desc=""/>
    <constraint exp="" field="title" desc=""/>
    <constraint exp="" field="description" desc=""/>
    <constraint exp="" field="responsible_person_id" desc=""/>
    <constraint exp="" field="status_code" desc=""/>
    <constraint exp="" field="start_date" desc=""/>
    <constraint exp="" field="end_date" desc=""/>
    <constraint exp="" field="project_type" desc=""/>
    <constraint exp="" field="local_epsg" desc=""/>
    <constraint exp="" field="comment" desc=""/>
    <constraint exp="" field="user_entered" desc=""/>
    <constraint exp="" field="date_entered" desc=""/>
    <constraint exp="" field="user_updated" desc=""/>
    <constraint exp="" field="date_updated" desc=""/>
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
    <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
      <labelFont italic="0" underline="0" description="Sans Serif,9,-1,5,50,0,0,0,0,0" strikethrough="0" bold="0" style=""/>
    </labelStyle>
    <attributeEditorField name="short_name" index="3" showLabel="1">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" strikethrough="0" bold="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="title" index="4" showLabel="1">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" strikethrough="0" bold="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="description" index="5" showLabel="1">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" strikethrough="0" bold="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="responsible_person_id" index="6" showLabel="1">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" strikethrough="0" bold="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="status_code" index="7" showLabel="1">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" strikethrough="0" bold="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="start_date" index="8" showLabel="1">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" strikethrough="0" bold="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="end_date" index="9" showLabel="1">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" strikethrough="0" bold="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="project_type" index="10" showLabel="1">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" strikethrough="0" bold="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="local_epsg" index="11" showLabel="1">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" underline="0" description="DejaVu Sans,9,-1,5,50,0,0,0,0,0" strikethrough="0" bold="0" style=""/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="comment" index="12" showLabel="1">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" underline="0" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" strikethrough="0" bold="0" style=""/>
      </labelStyle>
    </attributeEditorField>
  </attributeEditorForm>
  <editable>
    <field name="comment" editable="1"/>
    <field name="date_entered" editable="1"/>
    <field name="date_updated" editable="1"/>
    <field name="description" editable="1"/>
    <field name="end_date" editable="1"/>
    <field name="fid" editable="1"/>
    <field name="local_epsg" editable="1"/>
    <field name="objectid" editable="1"/>
    <field name="project_type" editable="1"/>
    <field name="responsible_person_id" editable="1"/>
    <field name="short_name" editable="1"/>
    <field name="start_date" editable="1"/>
    <field name="status_code" editable="1"/>
    <field name="title" editable="1"/>
    <field name="user_entered" editable="1"/>
    <field name="user_updated" editable="1"/>
    <field name="uuid" editable="1"/>
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
