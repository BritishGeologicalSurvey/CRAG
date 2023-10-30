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
    <field configurationFlags="None" name="locality_fuid">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" name="AllowAddFeatures" value="false"/>
            <Option type="bool" name="AllowNULL" value="false"/>
            <Option type="bool" name="MapIdentification" value="false"/>
            <Option type="bool" name="OrderByValue" value="false"/>
            <Option type="bool" name="ReadOnly" value="false"/>
            <Option type="QString" name="ReferencedLayerDataSource" value="C:/Users/jostev/mergin/view-test/field-data-capture.gpkg|layername=locality_point"/>
            <Option type="QString" name="ReferencedLayerId" value="locality_point_b5d4a64c_6865_4086_866f_ff25c1aea696"/>
            <Option type="QString" name="ReferencedLayerName" value="locality_point"/>
            <Option type="QString" name="ReferencedLayerProviderKey" value="ogr"/>
            <Option type="QString" name="Relation" value="locality_point_exposure"/>
            <Option type="bool" name="ShowForm" value="false"/>
            <Option type="bool" name="ShowOpenFormButton" value="true"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="exposure_type_code">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" name="AllowAddFeatures" value="false"/>
            <Option type="bool" name="AllowNULL" value="false"/>
            <Option type="bool" name="MapIdentification" value="false"/>
            <Option type="bool" name="OrderByValue" value="false"/>
            <Option type="bool" name="ReadOnly" value="false"/>
            <Option type="QString" name="ReferencedLayerDataSource" value="C:/Users/jostev/mergin/view-test/field-data-capture.gpkg|layername=dic_exposure_type"/>
            <Option type="QString" name="ReferencedLayerId" value="dic_exposure_type_f5450c3c_9213_4960_b5d5_edecc60a8ca1"/>
            <Option type="QString" name="ReferencedLayerName" value="dic_exposure_type"/>
            <Option type="QString" name="ReferencedLayerProviderKey" value="ogr"/>
            <Option type="QString" name="Relation" value="dic_exposure_type_exposure_3"/>
            <Option type="bool" name="ShowForm" value="false"/>
            <Option type="bool" name="ShowOpenFormButton" value="true"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="lithology_code">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" name="AllowAddFeatures" value="false"/>
            <Option type="bool" name="AllowNULL" value="false"/>
            <Option type="bool" name="MapIdentification" value="false"/>
            <Option type="bool" name="OrderByValue" value="false"/>
            <Option type="bool" name="ReadOnly" value="false"/>
            <Option type="QString" name="ReferencedLayerDataSource" value="C:/Users/jostev/mergin/view-test/field-data-capture.gpkg|layername=dic_rock_all"/>
            <Option type="QString" name="ReferencedLayerId" value="dic_rock_all_1c6e4a7d_53c4_4eeb_8b0f_b5fe0955bb96"/>
            <Option type="QString" name="ReferencedLayerName" value="dic_rock_all"/>
            <Option type="QString" name="ReferencedLayerProviderKey" value="ogr"/>
            <Option type="QString" name="Relation" value="dic_rock_all_exposure_2"/>
            <Option type="bool" name="ShowForm" value="false"/>
            <Option type="bool" name="ShowOpenFormButton" value="true"/>
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
    <alias field="locality_fuid" name="" index="3"/>
    <alias field="exposure_type_code" name="" index="4"/>
    <alias field="lithology_code" name="" index="5"/>
    <alias field="description" name="" index="6"/>
    <alias field="comment" name="" index="7"/>
    <alias field="user_entered" name="" index="8"/>
    <alias field="date_entered" name="" index="9"/>
    <alias field="user_updated" name="" index="10"/>
    <alias field="date_updated" name="" index="11"/>
  </aliases>
  <splitPolicies>
    <policy field="fid" policy="Duplicate"/>
    <policy field="objectid" policy="Duplicate"/>
    <policy field="uuid" policy="Duplicate"/>
    <policy field="locality_fuid" policy="Duplicate"/>
    <policy field="exposure_type_code" policy="Duplicate"/>
    <policy field="lithology_code" policy="Duplicate"/>
    <policy field="description" policy="Duplicate"/>
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
    <default field="locality_fuid" applyOnUpdate="0" expression=""/>
    <default field="exposure_type_code" applyOnUpdate="0" expression=""/>
    <default field="lithology_code" applyOnUpdate="0" expression=""/>
    <default field="description" applyOnUpdate="0" expression=""/>
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
    <constraint exp_strength="0" constraints="1" field="locality_fuid" unique_strength="0" notnull_strength="1"/>
    <constraint exp_strength="0" constraints="1" field="exposure_type_code" unique_strength="0" notnull_strength="1"/>
    <constraint exp_strength="0" constraints="0" field="lithology_code" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" constraints="0" field="description" unique_strength="0" notnull_strength="0"/>
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
    <constraint field="locality_fuid" desc="" exp=""/>
    <constraint field="exposure_type_code" desc="" exp=""/>
    <constraint field="lithology_code" desc="" exp=""/>
    <constraint field="description" desc="" exp=""/>
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
    <field name="exposure_type_code" editable="1"/>
    <field name="fid" editable="1"/>
    <field name="lithology_code" editable="1"/>
    <field name="locality_fuid" editable="1"/>
    <field name="objectid" editable="1"/>
    <field name="user_entered" editable="1"/>
    <field name="user_updated" editable="1"/>
    <field name="uuid" editable="1"/>
  </editable>
  <labelOnTop>
    <field name="comment" labelOnTop="0"/>
    <field name="date_entered" labelOnTop="0"/>
    <field name="date_updated" labelOnTop="0"/>
    <field name="description" labelOnTop="0"/>
    <field name="exposure_type_code" labelOnTop="0"/>
    <field name="fid" labelOnTop="0"/>
    <field name="lithology_code" labelOnTop="0"/>
    <field name="locality_fuid" labelOnTop="0"/>
    <field name="objectid" labelOnTop="0"/>
    <field name="user_entered" labelOnTop="0"/>
    <field name="user_updated" labelOnTop="0"/>
    <field name="uuid" labelOnTop="0"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="comment" reuseLastValue="0"/>
    <field name="date_entered" reuseLastValue="0"/>
    <field name="date_updated" reuseLastValue="0"/>
    <field name="description" reuseLastValue="0"/>
    <field name="exposure_type_code" reuseLastValue="0"/>
    <field name="fid" reuseLastValue="0"/>
    <field name="lithology_code" reuseLastValue="0"/>
    <field name="locality_fuid" reuseLastValue="0"/>
    <field name="objectid" reuseLastValue="0"/>
    <field name="user_entered" reuseLastValue="0"/>
    <field name="user_updated" reuseLastValue="0"/>
    <field name="uuid" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <layerGeometryType>4</layerGeometryType>
</qgis>
