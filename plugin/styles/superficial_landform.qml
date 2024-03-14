<qgis styleCategories="Symbology|Labeling|Fields|Forms|MapTips" version="3.34.0-Prizren">
  <fieldConfiguration>
    <field configurationFlags="NoFlag" name="fid">
      <editWidget type="Hidden">
        <config>
          <Option></Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="objectid">
      <editWidget type="Hidden">
        <config>
          <Option></Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="uuid">
      <editWidget type="Hidden">
        <config>
          <Option></Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="locality_fuid">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" type="bool" value="false"></Option>
            <Option name="AllowNULL" type="bool" value="false"></Option>
            <Option name="FetchLimitActive" type="bool" value="true"></Option>
            <Option name="FetchLimitNumber" type="int" value="100"></Option>
            <Option name="MapIdentification" type="bool" value="false"></Option>
            <Option name="ReadOnly" type="bool" value="false"></Option>
            <Option name="ReferencedLayerDataSource" type="QString" value="C:\leorud_stuff\personal\qgis_testing\fdc-plugin\field-data-capture.gpkg|layername=locality_point"></Option>
            <Option name="ReferencedLayerId" type="QString" value="locality_point_acda2da5_77f6_43e1_ab7e_7ac409577fc7"></Option>
            <Option name="ReferencedLayerName" type="QString" value="locality_point"></Option>
            <Option name="ReferencedLayerProviderKey" type="QString" value="ogr"></Option>
            <Option name="Relation" type="QString" value="locality_point_superficial_landform"></Option>
            <Option name="ShowForm" type="bool" value="false"></Option>
            <Option name="ShowOpenFormButton" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="superficial_type_category">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"></Option>
            <Option name="UseHtml" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="superficial_type_code">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" type="bool" value="false"></Option>
            <Option name="AllowNULL" type="bool" value="true"></Option>
            <Option name="ChainFilters" type="bool" value="false"></Option>
            <Option name="FetchLimitActive" type="bool" value="true"></Option>
            <Option name="FetchLimitNumber" type="int" value="100"></Option>
            <Option name="FilterExpression" type="QString" value=""></Option>
            <Option name="FilterFields" type="List">
              <Option type="QString" value="category"></Option>
            </Option>
            <Option name="MapIdentification" type="bool" value="false"></Option>
            <Option name="ReadOnly" type="bool" value="false"></Option>
            <Option name="ReferencedLayerDataSource" type="QString" value="C:\leorud_stuff\personal\qgis_testing\fdc-plugin\field-data-capture.gpkg|layername=dic_superficial_landform"></Option>
            <Option name="ReferencedLayerId" type="QString" value="dic_superficial_landform_ea7aced7_9a5d_47c7_b890_765577064181"></Option>
            <Option name="ReferencedLayerName" type="QString" value="dic_superficial_landform"></Option>
            <Option name="ReferencedLayerProviderKey" type="QString" value="ogr"></Option>
            <Option name="Relation" type="QString" value="dic_superficial_landform_superficial_landform_2"></Option>
            <Option name="ShowForm" type="bool" value="false"></Option>
            <Option name="ShowOpenFormButton" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="dip">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"></Option>
            <Option name="UseHtml" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="azimuth">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"></Option>
            <Option name="UseHtml" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="length">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"></Option>
            <Option name="UseHtml" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="width">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"></Option>
            <Option name="UseHtml" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="height_depth">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"></Option>
            <Option name="UseHtml" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="notes">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="true"></Option>
            <Option name="UseHtml" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="user_entered">
      <editWidget type="Hidden">
        <config>
          <Option></Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="date_entered">
      <editWidget type="Hidden">
        <config>
          <Option></Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="user_updated">
      <editWidget type="Hidden">
        <config>
          <Option></Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="date_updated">
      <editWidget type="Hidden">
        <config>
          <Option></Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="fid" index="0" name=""></alias>
    <alias field="objectid" index="1" name=""></alias>
    <alias field="uuid" index="2" name=""></alias>
    <alias field="locality_fuid" index="3" name=""></alias>
    <alias field="superficial_type_category" index="4" name=""></alias>
    <alias field="superficial_type_code" index="5" name=""></alias>
    <alias field="dip" index="6" name=""></alias>
    <alias field="azimuth" index="7" name=""></alias>
    <alias field="length" index="8" name=""></alias>
    <alias field="width" index="9" name=""></alias>
    <alias field="height_depth" index="10" name=""></alias>
    <alias field="notes" index="11" name=""></alias>
    <alias field="user_entered" index="12" name=""></alias>
    <alias field="date_entered" index="13" name=""></alias>
    <alias field="user_updated" index="14" name=""></alias>
    <alias field="date_updated" index="15" name=""></alias>
  </aliases>
  <splitPolicies>
    <policy field="fid" policy="Duplicate"></policy>
    <policy field="objectid" policy="DefaultValue"></policy>
    <policy field="uuid" policy="DefaultValue"></policy>
    <policy field="locality_fuid" policy="DefaultValue"></policy>
    <policy field="superficial_type_category" policy="DefaultValue"></policy>
    <policy field="superficial_type_code" policy="DefaultValue"></policy>
    <policy field="dip" policy="DefaultValue"></policy>
    <policy field="azimuth" policy="DefaultValue"></policy>
    <policy field="length" policy="DefaultValue"></policy>
    <policy field="width" policy="DefaultValue"></policy>
    <policy field="height_depth" policy="DefaultValue"></policy>
    <policy field="notes" policy="DefaultValue"></policy>
    <policy field="user_entered" policy="Duplicate"></policy>
    <policy field="date_entered" policy="Duplicate"></policy>
    <policy field="user_updated" policy="Duplicate"></policy>
    <policy field="date_updated" policy="Duplicate"></policy>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="fid"></default>
    <default applyOnUpdate="0" expression="" field="objectid"></default>
    <default applyOnUpdate="0" expression="uuid()" field="uuid"></default>
    <default applyOnUpdate="0" expression="" field="locality_fuid"></default>
    <default applyOnUpdate="0" expression="" field="superficial_type_category"></default>
    <default applyOnUpdate="0" expression="" field="superficial_type_code"></default>
    <default applyOnUpdate="0" expression="" field="dip"></default>
    <default applyOnUpdate="0" expression="" field="azimuth"></default>
    <default applyOnUpdate="0" expression="" field="length"></default>
    <default applyOnUpdate="0" expression="" field="width"></default>
    <default applyOnUpdate="0" expression="" field="height_depth"></default>
    <default applyOnUpdate="0" expression="" field="notes"></default>
    <default applyOnUpdate="0" expression="@user_account_name" field="user_entered"></default>
    <default applyOnUpdate="0" expression="now()" field="date_entered"></default>
    <default applyOnUpdate="1" expression="@user_account_name" field="user_updated"></default>
    <default applyOnUpdate="1" expression="now()" field="date_updated"></default>
  </defaults>
  <constraints>
    <constraint constraints="3" exp_strength="0" field="fid" notnull_strength="1" unique_strength="1"></constraint>
    <constraint constraints="2" exp_strength="0" field="objectid" notnull_strength="0" unique_strength="1"></constraint>
    <constraint constraints="3" exp_strength="0" field="uuid" notnull_strength="1" unique_strength="1"></constraint>
    <constraint constraints="1" exp_strength="0" field="locality_fuid" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="1" exp_strength="0" field="superficial_type_category" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="1" exp_strength="0" field="superficial_type_code" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="4" exp_strength="1" field="dip" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="4" exp_strength="1" field="azimuth" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="length" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="width" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="height_depth" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="notes" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="1" exp_strength="0" field="user_entered" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="1" exp_strength="0" field="date_entered" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="user_updated" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="date_updated" notnull_strength="0" unique_strength="0"></constraint>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="fid"></constraint>
    <constraint desc="" exp="" field="objectid"></constraint>
    <constraint desc="" exp="" field="uuid"></constraint>
    <constraint desc="" exp="" field="locality_fuid"></constraint>
    <constraint desc="" exp="" field="superficial_type_category"></constraint>
    <constraint desc="" exp="" field="superficial_type_code"></constraint>
    <constraint desc="0 &lt;= dip &lt;= 90" exp="&quot;dip&quot; >= 0 and &quot;dip&quot; &lt;= 90" field="dip"></constraint>
    <constraint desc="0 &lt;= azimuth &lt; 360" exp="&quot;azimuth&quot; >= 0 and &quot;azimuth&quot; &lt; 360" field="azimuth"></constraint>
    <constraint desc="" exp="" field="length"></constraint>
    <constraint desc="" exp="" field="width"></constraint>
    <constraint desc="" exp="" field="height_depth"></constraint>
    <constraint desc="" exp="" field="notes"></constraint>
    <constraint desc="" exp="" field="user_entered"></constraint>
    <constraint desc="" exp="" field="date_entered"></constraint>
    <constraint desc="" exp="" field="user_updated"></constraint>
    <constraint desc="" exp="" field="date_updated"></constraint>
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
    <field editable="1" name="azimuth"></field>
    <field editable="1" name="date_entered"></field>
    <field editable="1" name="date_updated"></field>
    <field editable="1" name="dip"></field>
    <field editable="1" name="fid"></field>
    <field editable="1" name="height_depth"></field>
    <field editable="1" name="length"></field>
    <field editable="1" name="locality_fuid"></field>
    <field editable="1" name="notes"></field>
    <field editable="1" name="objectid"></field>
    <field editable="1" name="superficial_type_category"></field>
    <field editable="1" name="superficial_type_code"></field>
    <field editable="1" name="user_entered"></field>
    <field editable="1" name="user_updated"></field>
    <field editable="1" name="uuid"></field>
    <field editable="1" name="width"></field>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="azimuth"></field>
    <field labelOnTop="0" name="date_entered"></field>
    <field labelOnTop="0" name="date_updated"></field>
    <field labelOnTop="0" name="dip"></field>
    <field labelOnTop="0" name="fid"></field>
    <field labelOnTop="0" name="height_depth"></field>
    <field labelOnTop="0" name="length"></field>
    <field labelOnTop="0" name="locality_fuid"></field>
    <field labelOnTop="0" name="notes"></field>
    <field labelOnTop="0" name="objectid"></field>
    <field labelOnTop="0" name="superficial_type_category"></field>
    <field labelOnTop="0" name="superficial_type_code"></field>
    <field labelOnTop="0" name="user_entered"></field>
    <field labelOnTop="0" name="user_updated"></field>
    <field labelOnTop="0" name="uuid"></field>
    <field labelOnTop="0" name="width"></field>
  </labelOnTop>
  <reuseLastValue>
    <field name="azimuth" reuseLastValue="0"></field>
    <field name="date_entered" reuseLastValue="0"></field>
    <field name="date_updated" reuseLastValue="0"></field>
    <field name="dip" reuseLastValue="0"></field>
    <field name="fid" reuseLastValue="0"></field>
    <field name="height_depth" reuseLastValue="0"></field>
    <field name="length" reuseLastValue="0"></field>
    <field name="locality_fuid" reuseLastValue="0"></field>
    <field name="notes" reuseLastValue="0"></field>
    <field name="objectid" reuseLastValue="0"></field>
    <field name="superficial_type_category" reuseLastValue="0"></field>
    <field name="superficial_type_code" reuseLastValue="0"></field>
    <field name="user_entered" reuseLastValue="0"></field>
    <field name="user_updated" reuseLastValue="0"></field>
    <field name="uuid" reuseLastValue="0"></field>
    <field name="width" reuseLastValue="0"></field>
  </reuseLastValue>
  <dataDefinedFieldProperties></dataDefinedFieldProperties>
  <widgets></widgets>
  <mapTip enabled="1"></mapTip>
  <layerGeometryType>4</layerGeometryType>
</qgis>