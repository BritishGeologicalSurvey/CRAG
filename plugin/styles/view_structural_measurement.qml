<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis labelsEnabled="0" styleCategories="Symbology|Labeling|Fields|Forms" version="3.30.0-'s-Hertogenbosch">
  <renderer-v2 referencescale="-1" symbollevels="0" enableorderby="0" forceraster="0" attr="" type="categorizedSymbol">
    <source-symbol>
      <symbol is_animated="0" name="0" alpha="1" clip_to_extent="1" frame_rate="10" force_rhr="0" type="marker">
        <data_defined_properties>
          <Option type="Map">
            <Option value="" name="name" type="QString"/>
            <Option name="properties"/>
            <Option value="collection" name="type" type="QString"/>
          </Option>
        </data_defined_properties>
        <layer enabled="1" class="SimpleMarker" locked="0" pass="0" id="{c0db3176-1e3f-41d2-b8ae-917cb455a9e3}">
          <Option type="Map">
            <Option value="0" name="angle" type="QString"/>
            <Option value="square" name="cap_style" type="QString"/>
            <Option value="152,125,183,255" name="color" type="QString"/>
            <Option value="1" name="horizontal_anchor_point" type="QString"/>
            <Option value="bevel" name="joinstyle" type="QString"/>
            <Option value="arrow" name="name" type="QString"/>
            <Option value="0,0" name="offset" type="QString"/>
            <Option value="3x:0,0,0,0,0,0" name="offset_map_unit_scale" type="QString"/>
            <Option value="MM" name="offset_unit" type="QString"/>
            <Option value="35,35,35,255" name="outline_color" type="QString"/>
            <Option value="solid" name="outline_style" type="QString"/>
            <Option value="0" name="outline_width" type="QString"/>
            <Option value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale" type="QString"/>
            <Option value="MM" name="outline_width_unit" type="QString"/>
            <Option value="diameter" name="scale_method" type="QString"/>
            <Option value="2" name="size" type="QString"/>
            <Option value="3x:0,0,0,0,0,0" name="size_map_unit_scale" type="QString"/>
            <Option value="MM" name="size_unit" type="QString"/>
            <Option value="1" name="vertical_anchor_point" type="QString"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" name="name" type="QString"/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option value="true" name="active" type="bool"/>
                  <Option value="dip_direction" name="field" type="QString"/>
                  <Option name="transformer" type="Map">
                    <Option name="d" type="Map">
                      <Option value="1" name="exponent" type="double"/>
                      <Option value="360" name="maxOutput" type="double"/>
                      <Option value="0" name="maxValue" type="double"/>
                      <Option value="0" name="minOutput" type="double"/>
                      <Option value="0" name="minValue" type="double"/>
                      <Option value="0" name="nullOutput" type="double"/>
                    </Option>
                    <Option value="0" name="t" type="int"/>
                  </Option>
                  <Option value="2" name="type" type="int"/>
                </Option>
              </Option>
              <Option value="collection" name="type" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </source-symbol>
    <colorramp name="[source]" type="randomcolors">
      <Option/>
    </colorramp>
    <rotation/>
    <sizescale/>
  </renderer-v2>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <fieldConfiguration>
    <field name="project" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="locality_point" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="x" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="y" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
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
    <field name="structure_category" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="structure_type" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="dip" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="dip_direction" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="comment" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="structure_uuid" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="locality_uuid" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias name="" field="project" index="0"/>
    <alias name="" field="locality_point" index="1"/>
    <alias name="" field="x" index="2"/>
    <alias name="" field="y" index="3"/>
    <alias name="" field="local_epsg" index="4"/>
    <alias name="" field="structure_category" index="5"/>
    <alias name="" field="structure_type" index="6"/>
    <alias name="" field="dip" index="7"/>
    <alias name="" field="dip_direction" index="8"/>
    <alias name="" field="comment" index="9"/>
    <alias name="" field="structure_uuid" index="10"/>
    <alias name="" field="locality_uuid" index="11"/>
  </aliases>
  <splitPolicies>
    <policy field="project" policy="Duplicate"/>
    <policy field="locality_point" policy="Duplicate"/>
    <policy field="x" policy="Duplicate"/>
    <policy field="y" policy="Duplicate"/>
    <policy field="local_epsg" policy="Duplicate"/>
    <policy field="structure_category" policy="Duplicate"/>
    <policy field="structure_type" policy="Duplicate"/>
    <policy field="dip" policy="Duplicate"/>
    <policy field="dip_direction" policy="Duplicate"/>
    <policy field="comment" policy="Duplicate"/>
    <policy field="structure_uuid" policy="Duplicate"/>
    <policy field="locality_uuid" policy="Duplicate"/>
  </splitPolicies>
  <defaults>
    <default expression="" applyOnUpdate="0" field="project"/>
    <default expression="" applyOnUpdate="0" field="locality_point"/>
    <default expression="" applyOnUpdate="0" field="x"/>
    <default expression="" applyOnUpdate="0" field="y"/>
    <default expression="" applyOnUpdate="0" field="local_epsg"/>
    <default expression="" applyOnUpdate="0" field="structure_category"/>
    <default expression="" applyOnUpdate="0" field="structure_type"/>
    <default expression="" applyOnUpdate="0" field="dip"/>
    <default expression="" applyOnUpdate="0" field="dip_direction"/>
    <default expression="" applyOnUpdate="0" field="comment"/>
    <default expression="" applyOnUpdate="0" field="structure_uuid"/>
    <default expression="" applyOnUpdate="0" field="locality_uuid"/>
  </defaults>
  <constraints>
    <constraint unique_strength="0" notnull_strength="0" field="project" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="0" field="locality_point" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="0" field="x" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="0" field="y" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="0" field="local_epsg" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="0" field="structure_category" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="0" field="structure_type" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="0" field="dip" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="0" field="dip_direction" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="0" field="comment" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="0" field="structure_uuid" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="0" field="locality_uuid" constraints="0" exp_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" field="project" desc=""/>
    <constraint exp="" field="locality_point" desc=""/>
    <constraint exp="" field="x" desc=""/>
    <constraint exp="" field="y" desc=""/>
    <constraint exp="" field="local_epsg" desc=""/>
    <constraint exp="" field="structure_category" desc=""/>
    <constraint exp="" field="structure_type" desc=""/>
    <constraint exp="" field="dip" desc=""/>
    <constraint exp="" field="dip_direction" desc=""/>
    <constraint exp="" field="comment" desc=""/>
    <constraint exp="" field="structure_uuid" desc=""/>
    <constraint exp="" field="locality_uuid" desc=""/>
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
    <field name="dip" editable="1"/>
    <field name="dip_direction" editable="1"/>
    <field name="local_epsg" editable="1"/>
    <field name="locality_point" editable="1"/>
    <field name="locality_uuid" editable="1"/>
    <field name="project" editable="1"/>
    <field name="structure_category" editable="1"/>
    <field name="structure_type" editable="1"/>
    <field name="structure_uuid" editable="1"/>
    <field name="x" editable="1"/>
    <field name="y" editable="1"/>
  </editable>
  <labelOnTop>
    <field name="comment" labelOnTop="0"/>
    <field name="dip" labelOnTop="0"/>
    <field name="dip_direction" labelOnTop="0"/>
    <field name="local_epsg" labelOnTop="0"/>
    <field name="locality_point" labelOnTop="0"/>
    <field name="locality_uuid" labelOnTop="0"/>
    <field name="project" labelOnTop="0"/>
    <field name="structure_category" labelOnTop="0"/>
    <field name="structure_type" labelOnTop="0"/>
    <field name="structure_uuid" labelOnTop="0"/>
    <field name="x" labelOnTop="0"/>
    <field name="y" labelOnTop="0"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="comment" reuseLastValue="0"/>
    <field name="dip" reuseLastValue="0"/>
    <field name="dip_direction" reuseLastValue="0"/>
    <field name="local_epsg" reuseLastValue="0"/>
    <field name="locality_point" reuseLastValue="0"/>
    <field name="locality_uuid" reuseLastValue="0"/>
    <field name="project" reuseLastValue="0"/>
    <field name="structure_category" reuseLastValue="0"/>
    <field name="structure_type" reuseLastValue="0"/>
    <field name="structure_uuid" reuseLastValue="0"/>
    <field name="x" reuseLastValue="0"/>
    <field name="y" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <layerGeometryType>0</layerGeometryType>
</qgis>
