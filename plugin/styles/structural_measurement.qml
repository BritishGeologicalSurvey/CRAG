<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.30.0-'s-Hertogenbosch" styleCategories="Symbology|Labeling|Forms|Relations">
  <referencedLayers>
    <relation referencedLayer="dic_structure_code_474f4a6e_da0d_4a0a_aa64_5aec270f2d27" dataSource="./field-data-capture.gpkg|layername=dic_structure_code" name="dic_structure_code_structural_measurement_2" referencingLayer="structural_measurement_719a6ddc_1e31_481b_97ca_d04e4a53d7d4" id="dic_structure_code_structural_measurement_2" layerName="dic_structure_code" providerKey="ogr" strength="Association" layerId="dic_structure_code_474f4a6e_da0d_4a0a_aa64_5aec270f2d27">
      <fieldRef referencedField="category" referencingField="structure_type_category"/>
    </relation>
    <relation referencedLayer="dic_structure_code_474f4a6e_da0d_4a0a_aa64_5aec270f2d27" dataSource="./field-data-capture.gpkg|layername=dic_structure_code" name="dic_structure_code_structural_measurement_3" referencingLayer="structural_measurement_719a6ddc_1e31_481b_97ca_d04e4a53d7d4" id="dic_structure_code_structural_measurement_3" layerName="dic_structure_code" providerKey="ogr" strength="Association" layerId="dic_structure_code_474f4a6e_da0d_4a0a_aa64_5aec270f2d27">
      <fieldRef referencedField="code" referencingField="structure_type_code"/>
    </relation>
    <relation referencedLayer="locality_point_f54eb9eb_e369_431e_a1a8_73aa93286d97" dataSource="./field-data-capture.gpkg|layername=locality_point" name="locality_point_structural_measurement" referencingLayer="structural_measurement_719a6ddc_1e31_481b_97ca_d04e4a53d7d4" id="locality_point_structural_measurement" layerName="locality_point" providerKey="ogr" strength="Association" layerId="locality_point_f54eb9eb_e369_431e_a1a8_73aa93286d97">
      <fieldRef referencedField="uuid" referencingField="locality_fuid"/>
    </relation>
  </referencedLayers>
  <fieldConfiguration>
    <field name="fid">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="objectid">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="uuid">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="locality_fuid">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" value="false" type="bool"/>
            <Option name="AllowNULL" value="false" type="bool"/>
            <Option name="MapIdentification" value="false" type="bool"/>
            <Option name="OrderByValue" value="false" type="bool"/>
            <Option name="ReadOnly" value="false" type="bool"/>
            <Option name="ReferencedLayerDataSource" value="C:/Users/jostev/mergin/data-model-v2.1/field-data-capture.gpkg|layername=locality_point" type="QString"/>
            <Option name="ReferencedLayerId" value="locality_point_f54eb9eb_e369_431e_a1a8_73aa93286d97" type="QString"/>
            <Option name="ReferencedLayerName" value="locality_point" type="QString"/>
            <Option name="ReferencedLayerProviderKey" value="ogr" type="QString"/>
            <Option name="Relation" value="locality_point_structural_measurement" type="QString"/>
            <Option name="ShowForm" value="false" type="bool"/>
            <Option name="ShowOpenFormButton" value="true" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="structure_type_category">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" value="false" type="bool"/>
            <Option name="AllowNULL" value="false" type="bool"/>
            <Option name="MapIdentification" value="false" type="bool"/>
            <Option name="OrderByValue" value="false" type="bool"/>
            <Option name="ReadOnly" value="false" type="bool"/>
            <Option name="ReferencedLayerDataSource" value="C:/Users/jostev/mergin/data-model-v2.1/field-data-capture.gpkg|layername=dic_structure_code" type="QString"/>
            <Option name="ReferencedLayerId" value="dic_structure_code_474f4a6e_da0d_4a0a_aa64_5aec270f2d27" type="QString"/>
            <Option name="ReferencedLayerName" value="dic_structure_code" type="QString"/>
            <Option name="ReferencedLayerProviderKey" value="ogr" type="QString"/>
            <Option name="Relation" value="dic_structure_code_structural_measurement_2" type="QString"/>
            <Option name="ShowForm" value="false" type="bool"/>
            <Option name="ShowOpenFormButton" value="true" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="structure_type_code">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option name="AllowMulti" value="false" type="bool"/>
            <Option name="AllowNull" value="false" type="bool"/>
            <Option name="Description" value="" type="QString"/>
            <Option name="FilterExpression" value="&quot;category&quot; = current_value(&quot;structure_type_category&quot;)" type="QString"/>
            <Option name="Key" value="code" type="QString"/>
            <Option name="Layer" value="dic_structure_code_474f4a6e_da0d_4a0a_aa64_5aec270f2d27" type="QString"/>
            <Option name="LayerName" value="dic_structure_code" type="QString"/>
            <Option name="LayerProviderName" value="ogr" type="QString"/>
            <Option name="LayerSource" value="C:/Users/jostev/mergin/data-model-v2.1/field-data-capture.gpkg|layername=dic_structure_code" type="QString"/>
            <Option name="NofColumns" value="1" type="int"/>
            <Option name="OrderByValue" value="false" type="bool"/>
            <Option name="UseCompleter" value="true" type="bool"/>
            <Option name="Value" value="description" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="dip">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="dip_direction">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="user_entered">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="date_entered">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="user_updated">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="date_updated">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
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
    <field name="date_entered" editable="1"/>
    <field name="date_updated" editable="1"/>
    <field name="dip" editable="1"/>
    <field name="dip_direction" editable="1"/>
    <field name="fid" editable="1"/>
    <field name="locality_fuid" editable="1"/>
    <field name="objectid" editable="1"/>
    <field name="structure_type_category" editable="1"/>
    <field name="structure_type_code" editable="1"/>
    <field name="user_entered" editable="1"/>
    <field name="user_updated" editable="1"/>
    <field name="uuid" editable="1"/>
  </editable>
  <labelOnTop>
    <field name="date_entered" labelOnTop="0"/>
    <field name="date_updated" labelOnTop="0"/>
    <field name="dip" labelOnTop="0"/>
    <field name="dip_direction" labelOnTop="0"/>
    <field name="fid" labelOnTop="0"/>
    <field name="locality_fuid" labelOnTop="0"/>
    <field name="objectid" labelOnTop="0"/>
    <field name="structure_type_category" labelOnTop="0"/>
    <field name="structure_type_code" labelOnTop="0"/>
    <field name="user_entered" labelOnTop="0"/>
    <field name="user_updated" labelOnTop="0"/>
    <field name="uuid" labelOnTop="0"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="date_entered" reuseLastValue="0"/>
    <field name="date_updated" reuseLastValue="0"/>
    <field name="dip" reuseLastValue="0"/>
    <field name="dip_direction" reuseLastValue="0"/>
    <field name="fid" reuseLastValue="0"/>
    <field name="locality_fuid" reuseLastValue="0"/>
    <field name="objectid" reuseLastValue="0"/>
    <field name="structure_type_category" reuseLastValue="0"/>
    <field name="structure_type_code" reuseLastValue="0"/>
    <field name="user_entered" reuseLastValue="0"/>
    <field name="user_updated" reuseLastValue="0"/>
    <field name="uuid" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <layerGeometryType>4</layerGeometryType>
</qgis>
