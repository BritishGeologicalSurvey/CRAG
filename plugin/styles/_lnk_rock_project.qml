<!--
Copyright 2026 British Geological Survey
Licensed under GPLv3 licence
SPDX-License-Identifier: GPL-3.0-or-later
-->
<qgis styleCategories="Symbology|Labeling|Fields|Forms|MapTips" version="3.40.7-Bratislava">
  <fieldConfiguration>
    <field configurationFlags="NoFlag" name="fid">
      <editWidget type="TextEdit">
        <config>
          <Option></Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="field_project_uuid">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" type="bool" value="false"></Option>
            <Option name="AllowNULL" type="bool" value="false"></Option>
            <Option name="FetchLimitActive" type="bool" value="false"></Option>
            <Option name="FetchLimitNumber" type="int" value="100"></Option>
            <Option name="MapIdentification" type="bool" value="false"></Option>
            <Option name="ReadOnly" type="bool" value="false"></Option>
            <Option name="ReferencedLayerDataSource" type="QString" value=""></Option>
            <Option name="ReferencedLayerId" type="QString" value="field_project_bf449975_8c64_4d2d_9b3f_01eb6769ebba"></Option>
            <Option name="ReferencedLayerName" type="QString" value="field_project"></Option>
            <Option name="ReferencedLayerProviderKey" type="QString" value="ogr"></Option>
            <Option name="Relation" type="QString" value="field_project__lnk_rock_project"></Option>
            <Option name="ShowForm" type="bool" value="false"></Option>
            <Option name="ShowOpenFormButton" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="rock_code">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" type="bool" value="false"></Option>
            <Option name="AllowNULL" type="bool" value="false"></Option>
            <Option name="FetchLimitActive" type="bool" value="false"></Option>
            <Option name="FetchLimitNumber" type="int" value="100"></Option>
            <Option name="MapIdentification" type="bool" value="false"></Option>
            <Option name="ReadOnly" type="bool" value="false"></Option>
            <Option name="ReferencedLayerDataSource" type="QString" value=""></Option>
            <Option name="ReferencedLayerId" type="QString" value="dic_rock_field_8c3352ee_b401_446c_8bab_bb1afdb353af"></Option>
            <Option name="ReferencedLayerName" type="QString" value="dic_rock_field"></Option>
            <Option name="ReferencedLayerProviderKey" type="QString" value="ogr"></Option>
            <Option name="Relation" type="QString" value="dic_rock_field__lnk_rock_project_2"></Option>
            <Option name="ShowForm" type="bool" value="false"></Option>
            <Option name="ShowOpenFormButton" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="category">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"></Option>
            <Option name="UseHtml" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="simple_lithology">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"></Option>
            <Option name="UseHtml" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="fid" index="0" name=""></alias>
    <alias field="field_project_uuid" index="1" name=""></alias>
    <alias field="rock_code" index="2" name=""></alias>
    <alias field="category" index="3" name=""></alias>
    <alias field="simple_lithology" index="4" name=""></alias>
  </aliases>
  <splitPolicies>
    <policy field="fid" policy="Duplicate"></policy>
    <policy field="field_project_uuid" policy="DefaultValue"></policy>
    <policy field="rock_code" policy="DefaultValue"></policy>
    <policy field="category" policy="DefaultValue"></policy>
    <policy field="simple_lithology" policy="DefaultValue"></policy>
  </splitPolicies>
  <duplicatePolicies>
    <policy field="fid" policy="Duplicate"></policy>
    <policy field="field_project_uuid" policy="Duplicate"></policy>
    <policy field="rock_code" policy="Duplicate"></policy>
    <policy field="category" policy="Duplicate"></policy>
    <policy field="simple_lithology" policy="Duplicate"></policy>
  </duplicatePolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="fid"></default>
    <default applyOnUpdate="0" expression="" field="field_project_uuid"></default>
    <default applyOnUpdate="0" expression="" field="rock_code"></default>
    <default applyOnUpdate="0" expression="" field="category"></default>
    <default applyOnUpdate="0" expression="" field="simple_lithology"></default>
  </defaults>
  <constraints>
    <constraint constraints="3" exp_strength="0" field="fid" notnull_strength="1" unique_strength="1"></constraint>
    <constraint constraints="1" exp_strength="0" field="field_project_uuid" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="1" exp_strength="0" field="rock_code" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="category" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="simple_lithology" notnull_strength="0" unique_strength="0"></constraint>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="fid"></constraint>
    <constraint desc="" exp="" field="field_project_uuid"></constraint>
    <constraint desc="" exp="" field="rock_code"></constraint>
    <constraint desc="" exp="" field="category"></constraint>
    <constraint desc="" exp="" field="simple_lithology"></constraint>
  </constraintExpressions>
  <expressionfields></expressionfields>
  <editform tolerant="1"></editform>
  <editforminit></editforminit>
  <editforminitcodesource>0</editforminitcodesource>
  <editforminitfilepath></editforminitfilepath>
  <editforminitcode># -*- coding: utf-8 -*-
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
</editforminitcode>
  <featformsuppress>0</featformsuppress>
  <editorlayout>generatedlayout</editorlayout>
  <editable>
    <field editable="0" name="category"></field>
    <field editable="1" name="fid"></field>
    <field editable="1" name="field_project_uuid"></field>
    <field editable="1" name="rock_code"></field>
    <field editable="0" name="simple_lithology"></field>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="category"></field>
    <field labelOnTop="0" name="fid"></field>
    <field labelOnTop="0" name="field_project_uuid"></field>
    <field labelOnTop="0" name="rock_code"></field>
    <field labelOnTop="0" name="simple_lithology"></field>
  </labelOnTop>
  <reuseLastValue>
    <field name="category" reuseLastValue="0"></field>
    <field name="fid" reuseLastValue="0"></field>
    <field name="field_project_uuid" reuseLastValue="0"></field>
    <field name="rock_code" reuseLastValue="0"></field>
    <field name="simple_lithology" reuseLastValue="0"></field>
  </reuseLastValue>
  <dataDefinedFieldProperties></dataDefinedFieldProperties>
  <widgets></widgets>
  <mapTip enabled="1"></mapTip>
  <layerGeometryType>4</layerGeometryType>
</qgis>