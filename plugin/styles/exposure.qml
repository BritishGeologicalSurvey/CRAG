<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="Symbology|Labeling|Fields|Forms" version="3.30.0-'s-Hertogenbosch">
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
    <field name="locality_fuid" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:\Users\jostev\mergin\jostev-minimal\field-data-capture.gpkg|layername=locality_point" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="locality_point_b91cabcd_71e0_463b_8a04_1d9c31d08f87" name="ReferencedLayerId" type="QString"/>
            <Option value="locality_point" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="locality_point_exposure" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="exposure_type_code" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:\Users\jostev\mergin\jostev-minimal\field-data-capture.gpkg|layername=dic_exposure_type" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="dic_exposure_type_3bc9ab97_16c7_4a46_b67e_5265da38a506" name="ReferencedLayerId" type="QString"/>
            <Option value="dic_exposure_type" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="dic_exposure_type_exposure_3" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="false" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="lithology_code" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="false" name="ChainFilters" type="bool"/>
            <Option value="" name="FilterExpression" type="QString"/>
            <Option name="FilterFields" type="StringList">
              <Option value="rock_grouping" type="QString"/>
            </Option>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="true" name="OrderByValue" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:\Users\jostev\mergin\jostev-minimal\field-data-capture.gpkg|layername=dic_rock_all" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="dic_rock_all_bf9f0a19_a352_4fa7_8906_d86ce8e4876a" name="ReferencedLayerId" type="QString"/>
            <Option value="dic_rock_all" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="dic_rock_all_exposure_2" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="false" name="ShowOpenFormButton" type="bool"/>
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
    <alias name="" field="locality_fuid" index="3"/>
    <alias name="" field="exposure_type_code" index="4"/>
    <alias name="" field="lithology_code" index="5"/>
    <alias name="" field="description" index="6"/>
    <alias name="" field="comment" index="7"/>
    <alias name="" field="user_entered" index="8"/>
    <alias name="" field="date_entered" index="9"/>
    <alias name="" field="user_updated" index="10"/>
    <alias name="" field="date_updated" index="11"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="fid"/>
    <policy policy="Duplicate" field="objectid"/>
    <policy policy="Duplicate" field="uuid"/>
    <policy policy="Duplicate" field="locality_fuid"/>
    <policy policy="Duplicate" field="exposure_type_code"/>
    <policy policy="Duplicate" field="lithology_code"/>
    <policy policy="Duplicate" field="description"/>
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
    <default applyOnUpdate="0" expression="" field="locality_fuid"/>
    <default applyOnUpdate="0" expression="" field="exposure_type_code"/>
    <default applyOnUpdate="0" expression="" field="lithology_code"/>
    <default applyOnUpdate="0" expression="" field="description"/>
    <default applyOnUpdate="0" expression="" field="comment"/>
    <default applyOnUpdate="0" expression="@user_account_name" field="user_entered"/>
    <default applyOnUpdate="0" expression="now()" field="date_entered"/>
    <default applyOnUpdate="1" expression="@user_account_name" field="user_updated"/>
    <default applyOnUpdate="1" expression="now()" field="date_updated"/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" unique_strength="1" constraints="3" notnull_strength="1" field="fid"/>
    <constraint exp_strength="0" unique_strength="1" constraints="2" notnull_strength="0" field="objectid"/>
    <constraint exp_strength="0" unique_strength="1" constraints="3" notnull_strength="1" field="uuid"/>
    <constraint exp_strength="0" unique_strength="0" constraints="1" notnull_strength="1" field="locality_fuid"/>
    <constraint exp_strength="0" unique_strength="0" constraints="1" notnull_strength="1" field="exposure_type_code"/>
    <constraint exp_strength="0" unique_strength="0" constraints="0" notnull_strength="0" field="lithology_code"/>
    <constraint exp_strength="0" unique_strength="0" constraints="0" notnull_strength="0" field="description"/>
    <constraint exp_strength="0" unique_strength="0" constraints="0" notnull_strength="0" field="comment"/>
    <constraint exp_strength="0" unique_strength="0" constraints="1" notnull_strength="1" field="user_entered"/>
    <constraint exp_strength="0" unique_strength="0" constraints="1" notnull_strength="1" field="date_entered"/>
    <constraint exp_strength="0" unique_strength="0" constraints="0" notnull_strength="0" field="user_updated"/>
    <constraint exp_strength="0" unique_strength="0" constraints="0" notnull_strength="0" field="date_updated"/>
  </constraints>
  <constraintExpressions>
    <constraint field="fid" exp="" desc=""/>
    <constraint field="objectid" exp="" desc=""/>
    <constraint field="uuid" exp="" desc=""/>
    <constraint field="locality_fuid" exp="" desc=""/>
    <constraint field="exposure_type_code" exp="" desc=""/>
    <constraint field="lithology_code" exp="" desc=""/>
    <constraint field="description" exp="" desc=""/>
    <constraint field="comment" exp="" desc=""/>
    <constraint field="user_entered" exp="" desc=""/>
    <constraint field="date_entered" exp="" desc=""/>
    <constraint field="user_updated" exp="" desc=""/>
    <constraint field="date_updated" exp="" desc=""/>
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
    <field editable="1" name="comment"/>
    <field editable="1" name="date_entered"/>
    <field editable="1" name="date_updated"/>
    <field editable="1" name="description"/>
    <field editable="1" name="exposure_type_code"/>
    <field editable="1" name="fid"/>
    <field editable="1" name="lithology_code"/>
    <field editable="1" name="locality_fuid"/>
    <field editable="1" name="objectid"/>
    <field editable="1" name="user_entered"/>
    <field editable="1" name="user_updated"/>
    <field editable="1" name="uuid"/>
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
