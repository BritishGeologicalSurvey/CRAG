<qgis styleCategories="Symbology|Labeling|Fields|Forms" version="3.28.11-Firenze">
  <fieldConfiguration>
    <field configurationFlags="None" name="fid">
      <editWidget type="Hidden">
        <config>
          <Option></Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="objectid">
      <editWidget type="Hidden">
        <config>
          <Option></Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="uuid">
      <editWidget type="Hidden">
        <config>
          <Option></Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="locality_fuid">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" type="bool" value="false"></Option>
            <Option name="AllowNULL" type="bool" value="false"></Option>
            <Option name="MapIdentification" type="bool" value="false"></Option>
            <Option name="OrderByValue" type="bool" value="false"></Option>
            <Option name="ReadOnly" type="bool" value="false"></Option>
            <Option name="ReferencedLayerDataSource" type="QString" value="C:/Users/jostev/mergin/view-test/field-data-capture.gpkg|layername=locality_point"></Option>
            <Option name="ReferencedLayerId" type="QString" value="locality_point_d722a305_c34e_4ced_9262_1e7f6ccc3598"></Option>
            <Option name="ReferencedLayerName" type="QString" value="locality_point"></Option>
            <Option name="ReferencedLayerProviderKey" type="QString" value="ogr"></Option>
            <Option name="Relation" type="QString" value="locality_point_superficial_landform"></Option>
            <Option name="ShowForm" type="bool" value="false"></Option>
            <Option name="ShowOpenFormButton" type="bool" value="true"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="superficial_type_category">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option name="AllowMulti" type="bool" value="false"></Option>
            <Option name="AllowNull" type="bool" value="true"></Option>
            <Option name="Description" type="QString" value=""></Option>
            <Option name="FilterExpression" type="QString" value=""></Option>
            <Option name="Key" type="QString" value="code"></Option>
            <Option name="Layer" type="QString" value="dic_superficial_category_cb188d00_d38d_41bb_89af_d08d2abf2c24"></Option>
            <Option name="LayerName" type="QString" value="dic_superficial_category"></Option>
            <Option name="LayerProviderName" type="QString" value="ogr"></Option>
            <Option name="LayerSource" type="QString" value="/home/leorud/personal/qgis_testing/fdc-plugin/field-data-capture.gpkg|layername=dic_superficial_category"></Option>
            <Option name="NofColumns" type="int" value="1"></Option>
            <Option name="OrderByValue" type="bool" value="false"></Option>
            <Option name="UseCompleter" type="bool" value="false"></Option>
            <Option name="Value" type="QString" value="code"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="superficial_type_code">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option name="AllowMulti" type="bool" value="false"></Option>
            <Option name="AllowNull" type="bool" value="true"></Option>
            <Option name="Description" type="QString" value=""></Option>
            <Option name="FilterExpression" type="QString" value="&quot;category&quot; = current_value('superficial_type_category')"></Option>
            <Option name="Key" type="QString" value="code"></Option>
            <Option name="Layer" type="QString" value="dic_superficial_code_ce01bb0e_008b_421b_96eb_f20ed661b244"></Option>
            <Option name="LayerName" type="QString" value="dic_superficial_code"></Option>
            <Option name="LayerProviderName" type="QString" value="ogr"></Option>
            <Option name="LayerSource" type="QString" value="/home/leorud/personal/qgis_testing/fdc-plugin/field-data-capture.gpkg|layername=dic_superficial_code"></Option>
            <Option name="NofColumns" type="int" value="1"></Option>
            <Option name="OrderByValue" type="bool" value="false"></Option>
            <Option name="UseCompleter" type="bool" value="false"></Option>
            <Option name="Value" type="QString" value="code"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="dip">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"></Option>
            <Option name="UseHtml" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="length">
      <editWidget type="TextEdit">
        <config>
          <Option></Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="width">
      <editWidget type="TextEdit">
        <config>
          <Option></Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="height_depth">
      <editWidget type="TextEdit">
        <config>
          <Option></Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="comment">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="true"></Option>
            <Option name="UseHtml" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="user_entered">
      <editWidget type="Hidden">
        <config>
          <Option></Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="date_entered">
      <editWidget type="Hidden">
        <config>
          <Option></Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="user_updated">
      <editWidget type="Hidden">
        <config>
          <Option></Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="date_updated">
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
    <alias field="length" index="7" name=""></alias>
    <alias field="width" index="8" name=""></alias>
    <alias field="height_depth" index="9" name=""></alias>
    <alias field="comment" index="10" name=""></alias>
    <alias field="user_entered" index="11" name=""></alias>
    <alias field="date_entered" index="12" name=""></alias>
    <alias field="user_updated" index="13" name=""></alias>
    <alias field="date_updated" index="14" name=""></alias>
  </aliases>
  <defaults>
    <default applyOnUpdate="0" expression="" field="fid"></default>
    <default applyOnUpdate="0" expression="" field="objectid"></default>
    <default applyOnUpdate="0" expression="uuid()" field="uuid"></default>
    <default applyOnUpdate="0" expression="" field="locality_fuid"></default>
    <default applyOnUpdate="0" expression="" field="superficial_type_category"></default>
    <default applyOnUpdate="0" expression="" field="superficial_type_code"></default>
    <default applyOnUpdate="0" expression="" field="dip"></default>
    <default applyOnUpdate="0" expression="" field="length"></default>
    <default applyOnUpdate="0" expression="" field="width"></default>
    <default applyOnUpdate="0" expression="" field="height_depth"></default>
    <default applyOnUpdate="0" expression="" field="comment"></default>
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
    <constraint constraints="0" exp_strength="0" field="dip" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="length" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="width" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="height_depth" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="comment" notnull_strength="0" unique_strength="0"></constraint>
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
    <constraint desc="" exp="" field="dip"></constraint>
    <constraint desc="" exp="" field="length"></constraint>
    <constraint desc="" exp="" field="width"></constraint>
    <constraint desc="" exp="" field="height_depth"></constraint>
    <constraint desc="" exp="" field="comment"></constraint>
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
    <field editable="1" name="comment"></field>
    <field editable="1" name="date_entered"></field>
    <field editable="1" name="date_updated"></field>
    <field editable="1" name="dip"></field>
    <field editable="1" name="fid"></field>
    <field editable="1" name="height_depth"></field>
    <field editable="1" name="length"></field>
    <field editable="1" name="locality_fuid"></field>
    <field editable="1" name="objectid"></field>
    <field editable="1" name="superficial_type_category"></field>
    <field editable="1" name="superficial_type_code"></field>
    <field editable="1" name="user_entered"></field>
    <field editable="1" name="user_updated"></field>
    <field editable="1" name="uuid"></field>
    <field editable="1" name="width"></field>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="comment"></field>
    <field labelOnTop="0" name="date_entered"></field>
    <field labelOnTop="0" name="date_updated"></field>
    <field labelOnTop="0" name="dip"></field>
    <field labelOnTop="0" name="fid"></field>
    <field labelOnTop="0" name="height_depth"></field>
    <field labelOnTop="0" name="length"></field>
    <field labelOnTop="0" name="locality_fuid"></field>
    <field labelOnTop="0" name="objectid"></field>
    <field labelOnTop="0" name="superficial_type_category"></field>
    <field labelOnTop="0" name="superficial_type_code"></field>
    <field labelOnTop="0" name="user_entered"></field>
    <field labelOnTop="0" name="user_updated"></field>
    <field labelOnTop="0" name="uuid"></field>
    <field labelOnTop="0" name="width"></field>
  </labelOnTop>
  <reuseLastValue>
    <field name="comment" reuseLastValue="0"></field>
    <field name="date_entered" reuseLastValue="0"></field>
    <field name="date_updated" reuseLastValue="0"></field>
    <field name="dip" reuseLastValue="0"></field>
    <field name="fid" reuseLastValue="0"></field>
    <field name="height_depth" reuseLastValue="0"></field>
    <field name="length" reuseLastValue="0"></field>
    <field name="locality_fuid" reuseLastValue="0"></field>
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
  <layerGeometryType>4</layerGeometryType>
</qgis>