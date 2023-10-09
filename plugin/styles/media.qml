<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.30.0-'s-Hertogenbosch" styleCategories="Symbology|Labeling|Forms|Relations">
  <referencedLayers>
    <relation referencedLayer="dic_media_9ba63437_21ba_41dd_9497_0f70e56412db" dataSource="./field-data-capture.gpkg|layername=dic_media" name="dic_media_media_2" referencingLayer="media_a010cbc2_133d_4d97_a60c_a318dcaef14e" id="dic_media_media_2" layerName="dic_media" providerKey="ogr" strength="Association" layerId="dic_media_9ba63437_21ba_41dd_9497_0f70e56412db">
      <fieldRef referencedField="code" referencingField="media_type_code"/>
    </relation>
    <relation referencedLayer="locality_point_f54eb9eb_e369_431e_a1a8_73aa93286d97" dataSource="./field-data-capture.gpkg|layername=locality_point" name="locality_point_media" referencingLayer="media_a010cbc2_133d_4d97_a60c_a318dcaef14e" id="locality_point_media" layerName="locality_point" providerKey="ogr" strength="Association" layerId="locality_point_f54eb9eb_e369_431e_a1a8_73aa93286d97">
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
            <Option name="Relation" value="locality_point_media" type="QString"/>
            <Option name="ShowForm" value="false" type="bool"/>
            <Option name="ShowOpenFormButton" value="true" type="bool"/>
          </Option>
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
    <field name="media_type_code">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" value="false" type="bool"/>
            <Option name="AllowNULL" value="false" type="bool"/>
            <Option name="MapIdentification" value="false" type="bool"/>
            <Option name="OrderByValue" value="false" type="bool"/>
            <Option name="ReadOnly" value="false" type="bool"/>
            <Option name="ReferencedLayerDataSource" value="C:/Users/jostev/mergin/data-model-v2.1/field-data-capture.gpkg|layername=dic_media" type="QString"/>
            <Option name="ReferencedLayerId" value="dic_media_9ba63437_21ba_41dd_9497_0f70e56412db" type="QString"/>
            <Option name="ReferencedLayerName" value="dic_media" type="QString"/>
            <Option name="ReferencedLayerProviderKey" value="ogr" type="QString"/>
            <Option name="Relation" value="dic_media_media_2" type="QString"/>
            <Option name="ShowForm" value="false" type="bool"/>
            <Option name="ShowOpenFormButton" value="true" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="media_link">
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
    <field name="comment" editable="1"/>
    <field name="date_entered" editable="1"/>
    <field name="date_updated" editable="1"/>
    <field name="fid" editable="1"/>
    <field name="locality_fuid" editable="1"/>
    <field name="media_link" editable="1"/>
    <field name="media_type_code" editable="1"/>
    <field name="objectid" editable="1"/>
    <field name="user_entered" editable="1"/>
    <field name="user_updated" editable="1"/>
    <field name="uuid" editable="1"/>
  </editable>
  <labelOnTop>
    <field name="comment" labelOnTop="0"/>
    <field name="date_entered" labelOnTop="0"/>
    <field name="date_updated" labelOnTop="0"/>
    <field name="fid" labelOnTop="0"/>
    <field name="locality_fuid" labelOnTop="0"/>
    <field name="media_link" labelOnTop="0"/>
    <field name="media_type_code" labelOnTop="0"/>
    <field name="objectid" labelOnTop="0"/>
    <field name="user_entered" labelOnTop="0"/>
    <field name="user_updated" labelOnTop="0"/>
    <field name="uuid" labelOnTop="0"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="comment" reuseLastValue="0"/>
    <field name="date_entered" reuseLastValue="0"/>
    <field name="date_updated" reuseLastValue="0"/>
    <field name="fid" reuseLastValue="0"/>
    <field name="locality_fuid" reuseLastValue="0"/>
    <field name="media_link" reuseLastValue="0"/>
    <field name="media_type_code" reuseLastValue="0"/>
    <field name="objectid" reuseLastValue="0"/>
    <field name="user_entered" reuseLastValue="0"/>
    <field name="user_updated" reuseLastValue="0"/>
    <field name="uuid" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <layerGeometryType>4</layerGeometryType>
</qgis>
