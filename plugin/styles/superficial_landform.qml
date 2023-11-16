<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.28.11-Firenze" styleCategories="Symbology|Labeling|Fields|Forms">
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
      <editWidget type="Hidden">
        <config>
          <Option/>
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
            <Option type="QString" name="ReferencedLayerId" value="locality_point_09acf2b3_5030_4514_8ed2_1a8cbd935a84"/>
            <Option type="QString" name="ReferencedLayerName" value="locality_point"/>
            <Option type="QString" name="ReferencedLayerProviderKey" value="ogr"/>
            <Option type="QString" name="Relation" value="locality_point_superficial_landform"/>
            <Option type="bool" name="ShowForm" value="false"/>
            <Option type="bool" name="ShowOpenFormButton" value="true"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="superficial_type_category">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" name="AllowMulti" value="false"/>
            <Option type="bool" name="AllowNull" value="true"/>
            <Option type="QString" name="Description" value=""/>
            <Option type="QString" name="FilterExpression" value=""/>
            <Option type="QString" name="Key" value="code"/>
            <Option type="QString" name="Layer" value="dic_superficial_category_cb188d00_d38d_41bb_89af_d08d2abf2c24"/>
            <Option type="QString" name="LayerName" value="dic_superficial_category"/>
            <Option type="QString" name="LayerProviderName" value="ogr"/>
            <Option type="QString" name="LayerSource" value="/home/leorud/personal/qgis_testing/fdc-plugin/field-data-capture.gpkg|layername=dic_superficial_category"/>
            <Option type="int" name="NofColumns" value="1"/>
            <Option type="bool" name="OrderByValue" value="false"/>
            <Option type="bool" name="UseCompleter" value="false"/>
            <Option type="QString" name="Value" value="code"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="superficial_type_code">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" name="AllowMulti" value="false"/>
            <Option type="bool" name="AllowNull" value="true"/>
            <Option type="QString" name="Description" value=""/>
            <Option type="QString" name="FilterExpression" value="&quot;category&quot; = current_value('superficial_type_category')"/>
            <Option type="QString" name="Key" value="code"/>
            <Option type="QString" name="Layer" value="dic_superficial_code_ce01bb0e_008b_421b_96eb_f20ed661b244"/>
            <Option type="QString" name="LayerName" value="dic_superficial_code"/>
            <Option type="QString" name="LayerProviderName" value="ogr"/>
            <Option type="QString" name="LayerSource" value="/home/leorud/personal/qgis_testing/fdc-plugin/field-data-capture.gpkg|layername=dic_superficial_code"/>
            <Option type="int" name="NofColumns" value="1"/>
            <Option type="bool" name="OrderByValue" value="false"/>
            <Option type="bool" name="UseCompleter" value="false"/>
            <Option type="QString" name="Value" value="code"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="dip">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="length">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="width">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="height_depth">
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
  <defaults>
    <default applyOnUpdate="0" field="fid" expression=""/>
    <default applyOnUpdate="0" field="objectid" expression=""/>
    <default applyOnUpdate="0" field="uuid" expression="uuid()"/>
    <default applyOnUpdate="0" field="locality_fuid" expression=""/>
    <default applyOnUpdate="0" field="superficial_type_category" expression=""/>
    <default applyOnUpdate="0" field="superficial_type_code" expression=""/>
    <default applyOnUpdate="0" field="dip" expression=""/>
    <default applyOnUpdate="0" field="length" expression=""/>
    <default applyOnUpdate="0" field="width" expression=""/>
    <default applyOnUpdate="0" field="height_depth" expression=""/>
    <default applyOnUpdate="0" field="comment" expression=""/>
    <default applyOnUpdate="0" field="user_entered" expression="@user_account_name"/>
    <default applyOnUpdate="0" field="date_entered" expression="now()"/>
    <default applyOnUpdate="1" field="user_updated" expression="@user_account_name"/>
    <default applyOnUpdate="1" field="date_updated" expression="now()"/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" field="fid" constraints="3" unique_strength="1" notnull_strength="1"/>
    <constraint exp_strength="0" field="objectid" constraints="2" unique_strength="1" notnull_strength="0"/>
    <constraint exp_strength="0" field="uuid" constraints="3" unique_strength="1" notnull_strength="1"/>
    <constraint exp_strength="0" field="locality_fuid" constraints="1" unique_strength="0" notnull_strength="1"/>
    <constraint exp_strength="0" field="superficial_type_category" constraints="1" unique_strength="0" notnull_strength="1"/>
    <constraint exp_strength="0" field="superficial_type_code" constraints="1" unique_strength="0" notnull_strength="1"/>
    <constraint exp_strength="0" field="dip" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="length" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="width" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="height_depth" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="comment" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="user_entered" constraints="1" unique_strength="0" notnull_strength="1"/>
    <constraint exp_strength="0" field="date_entered" constraints="1" unique_strength="0" notnull_strength="1"/>
    <constraint exp_strength="0" field="user_updated" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="date_updated" constraints="0" unique_strength="0" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" field="fid" exp=""/>
    <constraint desc="" field="objectid" exp=""/>
    <constraint desc="" field="uuid" exp=""/>
    <constraint desc="" field="locality_fuid" exp=""/>
    <constraint desc="" field="superficial_type_category" exp=""/>
    <constraint desc="" field="superficial_type_code" exp=""/>
    <constraint desc="" field="dip" exp=""/>
    <constraint desc="" field="length" exp=""/>
    <constraint desc="" field="width" exp=""/>
    <constraint desc="" field="height_depth" exp=""/>
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
