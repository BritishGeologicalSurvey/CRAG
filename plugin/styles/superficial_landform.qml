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
      <editWidget type="UuidGenerator">
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
            <Option value="C:/Users/jostev/mergin/view-test/field-data-capture.gpkg|layername=locality_point" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="locality_point_b5d4a64c_6865_4086_866f_ff25c1aea696" name="ReferencedLayerId" type="QString"/>
            <Option value="locality_point" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="locality_point_superficial_landform" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="superficial_type_category" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="false" name="AllowNull" type="bool"/>
            <Option value="" name="Description" type="QString"/>
            <Option value="" name="FilterExpression" type="QString"/>
            <Option value="code" name="Key" type="QString"/>
            <Option value="dic_superficial_category_76c3b143_4b39_488e_8475_09dc0971900d" name="Layer" type="QString"/>
            <Option value="dic_superficial_category" name="LayerName" type="QString"/>
            <Option value="ogr" name="LayerProviderName" type="QString"/>
            <Option value="C:/Users/jostev/mergin/view-test/field-data-capture.gpkg|layername=dic_superficial_category" name="LayerSource" type="QString"/>
            <Option value="1" name="NofColumns" type="int"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="UseCompleter" type="bool"/>
            <Option value="code" name="Value" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="superficial_type_code" configurationFlags="None">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowMulti" type="bool"/>
            <Option value="false" name="AllowNull" type="bool"/>
            <Option value="" name="Description" type="QString"/>
            <Option value="&quot;category&quot; = current_value('superficial_type_category')" name="FilterExpression" type="QString"/>
            <Option value="code" name="Key" type="QString"/>
            <Option value="dic_superficial_code_bf7ab3f3_04f9_4c36_9bc0_9ebdecfb3b34" name="Layer" type="QString"/>
            <Option value="dic_superficial_code" name="LayerName" type="QString"/>
            <Option value="ogr" name="LayerProviderName" type="QString"/>
            <Option value="C:/Users/jostev/mergin/view-test/field-data-capture.gpkg|layername=dic_superficial_code" name="LayerSource" type="QString"/>
            <Option value="1" name="NofColumns" type="int"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="UseCompleter" type="bool"/>
            <Option value="code" name="Value" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="dip" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="false" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="length" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="width" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="height_depth" configurationFlags="None">
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
    <alias name="" field="superficial_type_category" index="4"/>
    <alias name="" field="superficial_type_code" index="5"/>
    <alias name="" field="dip" index="6"/>
    <alias name="" field="length" index="7"/>
    <alias name="" field="width" index="8"/>
    <alias name="" field="height_depth" index="9"/>
    <alias name="" field="comment" index="10"/>
    <alias name="" field="user_entered" index="11"/>
    <alias name="" field="date_entered" index="12"/>
    <alias name="" field="user_updated" index="13"/>
    <alias name="" field="date_updated" index="14"/>
  </aliases>
  <splitPolicies>
    <policy field="fid" policy="Duplicate"/>
    <policy field="objectid" policy="Duplicate"/>
    <policy field="uuid" policy="Duplicate"/>
    <policy field="locality_fuid" policy="Duplicate"/>
    <policy field="superficial_type_category" policy="Duplicate"/>
    <policy field="superficial_type_code" policy="Duplicate"/>
    <policy field="dip" policy="Duplicate"/>
    <policy field="length" policy="Duplicate"/>
    <policy field="width" policy="Duplicate"/>
    <policy field="height_depth" policy="Duplicate"/>
    <policy field="comment" policy="Duplicate"/>
    <policy field="user_entered" policy="Duplicate"/>
    <policy field="date_entered" policy="Duplicate"/>
    <policy field="user_updated" policy="Duplicate"/>
    <policy field="date_updated" policy="Duplicate"/>
  </splitPolicies>
  <defaults>
    <default expression="" applyOnUpdate="0" field="fid"/>
    <default expression="" applyOnUpdate="0" field="objectid"/>
    <default expression="" applyOnUpdate="0" field="uuid"/>
    <default expression="" applyOnUpdate="0" field="locality_fuid"/>
    <default expression="" applyOnUpdate="0" field="superficial_type_category"/>
    <default expression="" applyOnUpdate="0" field="superficial_type_code"/>
    <default expression="" applyOnUpdate="0" field="dip"/>
    <default expression="" applyOnUpdate="0" field="length"/>
    <default expression="" applyOnUpdate="0" field="width"/>
    <default expression="" applyOnUpdate="0" field="height_depth"/>
    <default expression="" applyOnUpdate="0" field="comment"/>
    <default expression="@user_account_name" applyOnUpdate="0" field="user_entered"/>
    <default expression="now()" applyOnUpdate="0" field="date_entered"/>
    <default expression="@user_account_name" applyOnUpdate="1" field="user_updated"/>
    <default expression="now()" applyOnUpdate="1" field="date_updated"/>
  </defaults>
  <constraints>
    <constraint unique_strength="1" notnull_strength="1" field="fid" constraints="3" exp_strength="0"/>
    <constraint unique_strength="1" notnull_strength="0" field="objectid" constraints="2" exp_strength="0"/>
    <constraint unique_strength="1" notnull_strength="1" field="uuid" constraints="3" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="1" field="locality_fuid" constraints="1" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="1" field="superficial_type_category" constraints="1" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="1" field="superficial_type_code" constraints="1" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="0" field="dip" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="0" field="length" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="0" field="width" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="0" field="height_depth" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="0" field="comment" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="1" field="user_entered" constraints="1" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="1" field="date_entered" constraints="1" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="0" field="user_updated" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="0" field="date_updated" constraints="0" exp_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" field="fid" desc=""/>
    <constraint exp="" field="objectid" desc=""/>
    <constraint exp="" field="uuid" desc=""/>
    <constraint exp="" field="locality_fuid" desc=""/>
    <constraint exp="" field="superficial_type_category" desc=""/>
    <constraint exp="" field="superficial_type_code" desc=""/>
    <constraint exp="" field="dip" desc=""/>
    <constraint exp="" field="length" desc=""/>
    <constraint exp="" field="width" desc=""/>
    <constraint exp="" field="height_depth" desc=""/>
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
  <editorlayout>generatedlayout</editorlayout>
  <editable>
    <field name="comment" editable="1"/>
    <field name="date_entered" editable="1"/>
    <field name="date_updated" editable="1"/>
    <field name="dip" editable="1"/>
    <field name="fid" editable="1"/>
    <field name="height_depth" editable="1"/>
    <field name="length" editable="1"/>
    <field name="locality_fuid" editable="1"/>
    <field name="objectid" editable="1"/>
    <field name="superficial_type_category" editable="1"/>
    <field name="superficial_type_code" editable="1"/>
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
    <field name="fid" labelOnTop="0"/>
    <field name="height_depth" labelOnTop="0"/>
    <field name="length" labelOnTop="0"/>
    <field name="locality_fuid" labelOnTop="0"/>
    <field name="objectid" labelOnTop="0"/>
    <field name="superficial_type_category" labelOnTop="0"/>
    <field name="superficial_type_code" labelOnTop="0"/>
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
    <field name="fid" reuseLastValue="0"/>
    <field name="height_depth" reuseLastValue="0"/>
    <field name="length" reuseLastValue="0"/>
    <field name="locality_fuid" reuseLastValue="0"/>
    <field name="objectid" reuseLastValue="0"/>
    <field name="superficial_type_category" reuseLastValue="0"/>
    <field name="superficial_type_code" reuseLastValue="0"/>
    <field name="user_entered" reuseLastValue="0"/>
    <field name="user_updated" reuseLastValue="0"/>
    <field name="uuid" reuseLastValue="0"/>
    <field name="width" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <layerGeometryType>4</layerGeometryType>
</qgis>
