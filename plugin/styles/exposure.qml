<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.28.11-Firenze" styleCategories="Symbology|Labeling|Fields|Forms">
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
    <field name="exposure_type_code" configurationFlags="None">
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
    <field name="lithology_code" configurationFlags="None">
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
    <field name="description" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="true"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="comment" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="true"/>
            <Option type="bool" name="UseHtml" value="false"/>
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
  <defaults>
    <default field="fid" expression="" applyOnUpdate="0"/>
    <default field="objectid" expression="" applyOnUpdate="0"/>
    <default field="uuid" expression="uuid()" applyOnUpdate="0"/>
    <default field="locality_fuid" expression="" applyOnUpdate="0"/>
    <default field="exposure_type_code" expression="" applyOnUpdate="0"/>
    <default field="lithology_code" expression="" applyOnUpdate="0"/>
    <default field="description" expression="" applyOnUpdate="0"/>
    <default field="comment" expression="" applyOnUpdate="0"/>
    <default field="user_entered" expression="@user_account_name" applyOnUpdate="0"/>
    <default field="date_entered" expression="now()" applyOnUpdate="0"/>
    <default field="user_updated" expression="@user_account_name" applyOnUpdate="1"/>
    <default field="date_updated" expression="now()" applyOnUpdate="1"/>
  </defaults>
  <constraints>
    <constraint constraints="3" field="fid" notnull_strength="1" exp_strength="0" unique_strength="1"/>
    <constraint constraints="2" field="objectid" notnull_strength="0" exp_strength="0" unique_strength="1"/>
    <constraint constraints="3" field="uuid" notnull_strength="1" exp_strength="0" unique_strength="1"/>
    <constraint constraints="1" field="locality_fuid" notnull_strength="1" exp_strength="0" unique_strength="0"/>
    <constraint constraints="1" field="exposure_type_code" notnull_strength="1" exp_strength="0" unique_strength="0"/>
    <constraint constraints="0" field="lithology_code" notnull_strength="0" exp_strength="0" unique_strength="0"/>
    <constraint constraints="0" field="description" notnull_strength="0" exp_strength="0" unique_strength="0"/>
    <constraint constraints="0" field="comment" notnull_strength="0" exp_strength="0" unique_strength="0"/>
    <constraint constraints="1" field="user_entered" notnull_strength="1" exp_strength="0" unique_strength="0"/>
    <constraint constraints="1" field="date_entered" notnull_strength="1" exp_strength="0" unique_strength="0"/>
    <constraint constraints="0" field="user_updated" notnull_strength="0" exp_strength="0" unique_strength="0"/>
    <constraint constraints="0" field="date_updated" notnull_strength="0" exp_strength="0" unique_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" field="fid" exp=""/>
    <constraint desc="" field="objectid" exp=""/>
    <constraint desc="" field="uuid" exp=""/>
    <constraint desc="" field="locality_fuid" exp=""/>
    <constraint desc="" field="exposure_type_code" exp=""/>
    <constraint desc="" field="lithology_code" exp=""/>
    <constraint desc="" field="description" exp=""/>
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
