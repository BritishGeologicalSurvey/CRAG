<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.30.0-'s-Hertogenbosch" styleCategories="Symbology|Labeling|Forms|Relations">
  <referencedLayers>
    <relation referencedLayer="dic_manmade_code_3b585b27_c33e_466c_b634_cf86ba0823f2" dataSource="./field-data-capture.gpkg|layername=dic_manmade_code" name="dic_manmade_code_manmade_landform_2" referencingLayer="manmade_landform_1622cee9_24ac_43ae_b4ca_81ce62c6c37d" id="dic_manmade_code_manmade_landform_2" layerName="dic_manmade_code" providerKey="ogr" strength="Association" layerId="dic_manmade_code_3b585b27_c33e_466c_b634_cf86ba0823f2">
      <fieldRef referencedField="code" referencingField="manmade_type_code"/>
    </relation>
    <relation referencedLayer="locality_point_f54eb9eb_e369_431e_a1a8_73aa93286d97" dataSource="./field-data-capture.gpkg|layername=locality_point" name="locality_point_manmade_landform" referencingLayer="manmade_landform_1622cee9_24ac_43ae_b4ca_81ce62c6c37d" id="locality_point_manmade_landform" layerName="locality_point" providerKey="ogr" strength="Association" layerId="locality_point_f54eb9eb_e369_431e_a1a8_73aa93286d97">
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
            <Option name="Relation" value="locality_point_manmade_landform" type="QString"/>
            <Option name="ShowForm" value="false" type="bool"/>
            <Option name="ShowOpenFormButton" value="true" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="manmade_type_code">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" value="false" type="bool"/>
            <Option name="AllowNULL" value="false" type="bool"/>
            <Option name="MapIdentification" value="false" type="bool"/>
            <Option name="OrderByValue" value="false" type="bool"/>
            <Option name="ReadOnly" value="false" type="bool"/>
            <Option name="ReferencedLayerDataSource" value="C:/Users/jostev/mergin/data-model-v2.1/field-data-capture.gpkg|layername=dic_manmade_code" type="QString"/>
            <Option name="ReferencedLayerId" value="dic_manmade_code_3b585b27_c33e_466c_b634_cf86ba0823f2" type="QString"/>
            <Option name="ReferencedLayerName" value="dic_manmade_code" type="QString"/>
            <Option name="ReferencedLayerProviderKey" value="ogr" type="QString"/>
            <Option name="Relation" value="dic_manmade_code_manmade_landform_2" type="QString"/>
            <Option name="ShowForm" value="false" type="bool"/>
            <Option name="ShowOpenFormButton" value="true" type="bool"/>
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
    <field name="dip_dir">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="length">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="width">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="comment">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="true" type="bool"/>
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
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" value="false" type="bool"/>
            <Option name="UseHtml" value="false" type="bool"/>
          </Option>
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
    <field name="comment" editable="1"/>
    <field name="date_entered" editable="1"/>
    <field name="date_updated" editable="1"/>
    <field name="dip" editable="1"/>
    <field name="dip_dir" editable="1"/>
    <field name="fid" editable="1"/>
    <field name="length" editable="1"/>
    <field name="locality_fuid" editable="1"/>
    <field name="manmade_type_code" editable="1"/>
    <field name="objectid" editable="1"/>
    <field name="user_entered" editable="1"/>
    <field name="user_updated" editable="1"/>
    <field name="uuid" editable="1"/>
    <field name="width" editable="1"/>
  </editable>
  <labelOnTop>
    <field name="comment" labelOnTop="0"/>
    <field name="date_entered" labelOnTop="0"/>
    <field name="date_updated" labelOnTop="0"/>
    <field name="dip" labelOnTop="0"/>
    <field name="dip_dir" labelOnTop="0"/>
    <field name="fid" labelOnTop="0"/>
    <field name="length" labelOnTop="0"/>
    <field name="locality_fuid" labelOnTop="0"/>
    <field name="manmade_type_code" labelOnTop="0"/>
    <field name="objectid" labelOnTop="0"/>
    <field name="user_entered" labelOnTop="0"/>
    <field name="user_updated" labelOnTop="0"/>
    <field name="uuid" labelOnTop="0"/>
    <field name="width" labelOnTop="0"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="comment" reuseLastValue="0"/>
    <field name="date_entered" reuseLastValue="0"/>
    <field name="date_updated" reuseLastValue="0"/>
    <field name="dip" reuseLastValue="0"/>
    <field name="dip_dir" reuseLastValue="0"/>
    <field name="fid" reuseLastValue="0"/>
    <field name="length" reuseLastValue="0"/>
    <field name="locality_fuid" reuseLastValue="0"/>
    <field name="manmade_type_code" reuseLastValue="0"/>
    <field name="objectid" reuseLastValue="0"/>
    <field name="user_entered" reuseLastValue="0"/>
    <field name="user_updated" reuseLastValue="0"/>
    <field name="uuid" reuseLastValue="0"/>
    <field name="width" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <layerGeometryType>4</layerGeometryType>
</qgis>
