<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.30.0-'s-Hertogenbosch" styleCategories="Symbology|Labeling|Fields|Forms">
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
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="short_name">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="title">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="description">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="true"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="responsible_person_id">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="status_code">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="start_date">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option type="bool" name="allow_null" value="true"/>
            <Option type="bool" name="calendar_popup" value="true"/>
            <Option type="QString" name="display_format" value="dd/MM/yyyy"/>
            <Option type="QString" name="field_format" value="yyyy-MM-dd"/>
            <Option type="bool" name="field_iso_format" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="end_date">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option type="bool" name="allow_null" value="true"/>
            <Option type="bool" name="calendar_popup" value="true"/>
            <Option type="QString" name="display_format" value="dd/MM/yyyy"/>
            <Option type="QString" name="field_format" value="yyyy-MM-dd"/>
            <Option type="bool" name="field_iso_format" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="project_type">
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
            <Option type="bool" name="IsMultiline" value="true"/>
            <Option type="bool" name="UseHtml" value="false"/>
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
    <alias field="fid" name="" index="0"/>
    <alias field="objectid" name="" index="1"/>
    <alias field="uuid" name="" index="2"/>
    <alias field="short_name" name="" index="3"/>
    <alias field="title" name="" index="4"/>
    <alias field="description" name="" index="5"/>
    <alias field="responsible_person_id" name="" index="6"/>
    <alias field="status_code" name="" index="7"/>
    <alias field="start_date" name="" index="8"/>
    <alias field="end_date" name="" index="9"/>
    <alias field="project_type" name="" index="10"/>
    <alias field="local_epsg" name="" index="11"/>
    <alias field="comment" name="" index="12"/>
    <alias field="user_entered" name="" index="13"/>
    <alias field="date_entered" name="" index="14"/>
    <alias field="user_updated" name="" index="15"/>
    <alias field="date_updated" name="" index="16"/>
  </aliases>
  <splitPolicies>
    <policy field="fid" policy="Duplicate"/>
    <policy field="objectid" policy="Duplicate"/>
    <policy field="uuid" policy="Duplicate"/>
    <policy field="short_name" policy="Duplicate"/>
    <policy field="title" policy="Duplicate"/>
    <policy field="description" policy="Duplicate"/>
    <policy field="responsible_person_id" policy="Duplicate"/>
    <policy field="status_code" policy="Duplicate"/>
    <policy field="start_date" policy="Duplicate"/>
    <policy field="end_date" policy="Duplicate"/>
    <policy field="project_type" policy="Duplicate"/>
    <policy field="local_epsg" policy="Duplicate"/>
    <policy field="comment" policy="Duplicate"/>
    <policy field="user_entered" policy="Duplicate"/>
    <policy field="date_entered" policy="Duplicate"/>
    <policy field="user_updated" policy="Duplicate"/>
    <policy field="date_updated" policy="Duplicate"/>
  </splitPolicies>
  <defaults>
    <default field="fid" applyOnUpdate="0" expression=""/>
    <default field="objectid" applyOnUpdate="0" expression=""/>
    <default field="uuid" applyOnUpdate="0" expression="uuid()"/>
    <default field="short_name" applyOnUpdate="0" expression=""/>
    <default field="title" applyOnUpdate="0" expression=""/>
    <default field="description" applyOnUpdate="0" expression=""/>
    <default field="responsible_person_id" applyOnUpdate="0" expression=""/>
    <default field="status_code" applyOnUpdate="0" expression=""/>
    <default field="start_date" applyOnUpdate="0" expression=""/>
    <default field="end_date" applyOnUpdate="0" expression=""/>
    <default field="project_type" applyOnUpdate="0" expression=""/>
    <default field="local_epsg" applyOnUpdate="0" expression=""/>
    <default field="comment" applyOnUpdate="0" expression=""/>
    <default field="user_entered" applyOnUpdate="0" expression="@user_account_name"/>
    <default field="date_entered" applyOnUpdate="0" expression="now()"/>
    <default field="user_updated" applyOnUpdate="1" expression="@user_account_name"/>
    <default field="date_updated" applyOnUpdate="1" expression="now()"/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" constraints="3" field="fid" unique_strength="1" notnull_strength="1"/>
    <constraint exp_strength="0" constraints="2" field="objectid" unique_strength="1" notnull_strength="0"/>
    <constraint exp_strength="0" constraints="3" field="uuid" unique_strength="1" notnull_strength="1"/>
    <constraint exp_strength="0" constraints="3" field="short_name" unique_strength="1" notnull_strength="1"/>
    <constraint exp_strength="0" constraints="0" field="title" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" constraints="0" field="description" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" constraints="0" field="responsible_person_id" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" constraints="0" field="status_code" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" constraints="0" field="start_date" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" constraints="0" field="end_date" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" constraints="1" field="project_type" unique_strength="0" notnull_strength="1"/>
    <constraint exp_strength="0" constraints="1" field="local_epsg" unique_strength="0" notnull_strength="1"/>
    <constraint exp_strength="0" constraints="0" field="comment" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" constraints="1" field="user_entered" unique_strength="0" notnull_strength="1"/>
    <constraint exp_strength="0" constraints="1" field="date_entered" unique_strength="0" notnull_strength="1"/>
    <constraint exp_strength="0" constraints="0" field="user_updated" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" constraints="0" field="date_updated" unique_strength="0" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="fid" desc="" exp=""/>
    <constraint field="objectid" desc="" exp=""/>
    <constraint field="uuid" desc="" exp=""/>
    <constraint field="short_name" desc="" exp=""/>
    <constraint field="title" desc="" exp=""/>
    <constraint field="description" desc="" exp=""/>
    <constraint field="responsible_person_id" desc="" exp=""/>
    <constraint field="status_code" desc="" exp=""/>
    <constraint field="start_date" desc="" exp=""/>
    <constraint field="end_date" desc="" exp=""/>
    <constraint field="project_type" desc="" exp=""/>
    <constraint field="local_epsg" desc="" exp=""/>
    <constraint field="comment" desc="" exp=""/>
    <constraint field="user_entered" desc="" exp=""/>
    <constraint field="date_entered" desc="" exp=""/>
    <constraint field="user_updated" desc="" exp=""/>
    <constraint field="date_updated" desc="" exp=""/>
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
  <editorlayout>generatedlayout</editorlayout>
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
