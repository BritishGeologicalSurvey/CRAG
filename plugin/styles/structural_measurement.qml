<qgis styleCategories="Symbology|Labeling|Fields|Forms|MapTips" version="3.34.5-Prizren">
  <fieldConfiguration>
    <field configurationFlags="NoFlag" name="fid">
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
            <Option name="Relation" type="QString" value="locality_point_structural_measurement_4"></Option>
            <Option name="ShowForm" type="bool" value="false"></Option>
            <Option name="ShowOpenFormButton" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="structure_type_code">
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
            <Option name="ReferencedLayerDataSource" type="QString" value="C:\leorud_stuff\personal\qgis_testing\fdc-plugin\field-data-capture.gpkg|layername=dic_structure"></Option>
            <Option name="ReferencedLayerId" type="QString" value="dic_structure_876f248d_223e_499e_843f_b14d86b7aa7b"></Option>
            <Option name="ReferencedLayerName" type="QString" value="dic_structure"></Option>
            <Option name="ReferencedLayerProviderKey" type="QString" value="ogr"></Option>
            <Option name="Relation" type="QString" value="dic_structure_structural_measurement_3"></Option>
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
    <field configurationFlags="NoFlag" name="secondary_attribute">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option name="AllowMulti" type="bool" value="false"></Option>
            <Option name="AllowNull" type="bool" value="true"></Option>
            <Option name="Description" type="QString" value="&quot;description&quot;"></Option>
            <Option name="FilterExpression" type="QString" value="&quot;category&quot; = attribute(&#xA;    get_feature(&#xA;        'dic_structure',&#xA;        'code',&#xA;&#x9;&#x9;current_value('structure_type_code')&#xA;       ),&#xA;    'secondary_attr_category'&#xA;)"></Option>
            <Option name="Key" type="QString" value="code"></Option>
            <Option name="Layer" type="QString" value="dic_structure_secondary_f29f71ac_0993_4adc_9364_86b15887801a"></Option>
            <Option name="LayerName" type="QString" value="dic_structure_secondary"></Option>
            <Option name="LayerProviderName" type="QString" value="ogr"></Option>
            <Option name="LayerSource" type="QString" value="C:\Users\jostev\mergin\jostev-dev\field-data-capture.gpkg|layername=dic_structure_secondary"></Option>
            <Option name="NofColumns" type="int" value="1"></Option>
            <Option name="OrderByValue" type="bool" value="false"></Option>
            <Option name="UseCompleter" type="bool" value="false"></Option>
            <Option name="Value" type="QString" value="description"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="third_attribute">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option name="AllowMulti" type="bool" value="false"></Option>
            <Option name="AllowNull" type="bool" value="true"></Option>
            <Option name="Description" type="QString" value="&quot;description&quot;"></Option>
            <Option name="FilterExpression" type="QString" value="&quot;category&quot; = attribute(&#xA;    get_feature(&#xA;        'dic_structure',&#xA;        'code',&#xA;&#x9;&#x9;current_value('structure_type_code')&#xA;       ),&#xA;    'third_attr_category'&#xA;)"></Option>
            <Option name="Key" type="QString" value="code"></Option>
            <Option name="Layer" type="QString" value="dic_structure_third_6a0cb1a0_81ae_4ff5_8d24_6d83c4d52422"></Option>
            <Option name="LayerName" type="QString" value="dic_structure_third"></Option>
            <Option name="LayerProviderName" type="QString" value="ogr"></Option>
            <Option name="LayerSource" type="QString" value="C:\Users\jostev\mergin\jostev-dev\field-data-capture.gpkg|layername=dic_structure_third"></Option>
            <Option name="NofColumns" type="int" value="1"></Option>
            <Option name="OrderByValue" type="bool" value="false"></Option>
            <Option name="UseCompleter" type="bool" value="false"></Option>
            <Option name="Value" type="QString" value="description"></Option>
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
    <alias field="uuid" index="2" name=""></alias>
    <alias field="locality_fuid" index="3" name=""></alias>
    <alias field="structure_type_code" index="4" name=""></alias>
    <alias field="dip" index="5" name=""></alias>
    <alias field="azimuth" index="6" name=""></alias>
    <alias field="secondary_attribute" index="7" name=""></alias>
    <alias field="third_attribute" index="8" name=""></alias>
    <alias field="notes" index="9" name=""></alias>
    <alias field="user_entered" index="10" name=""></alias>
    <alias field="date_entered" index="11" name=""></alias>
    <alias field="user_updated" index="12" name=""></alias>
    <alias field="date_updated" index="13" name=""></alias>
  </aliases>
  <splitPolicies>
    <policy field="fid" policy="Duplicate"></policy>
    <policy field="uuid" policy="Duplicate"></policy>
    <policy field="locality_fuid" policy="DefaultValue"></policy>
    <policy field="structure_type_code" policy="DefaultValue"></policy>
    <policy field="dip" policy="DefaultValue"></policy>
    <policy field="azimuth" policy="DefaultValue"></policy>
    <policy field="secondary_attribute" policy="DefaultValue"></policy>
    <policy field="third_attribute" policy="DefaultValue"></policy>
    <policy field="notes" policy="DefaultValue"></policy>
    <policy field="user_entered" policy="Duplicate"></policy>
    <policy field="date_entered" policy="Duplicate"></policy>
    <policy field="user_updated" policy="Duplicate"></policy>
    <policy field="date_updated" policy="Duplicate"></policy>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="fid"></default>
    <default applyOnUpdate="0" expression="uuid()" field="uuid"></default>
    <default applyOnUpdate="0" expression="" field="locality_fuid"></default>
    <default applyOnUpdate="0" expression="" field="structure_type_code"></default>
    <default applyOnUpdate="0" expression="" field="dip"></default>
    <default applyOnUpdate="0" expression="" field="azimuth"></default>
    <default applyOnUpdate="0" expression="" field="secondary_attribute"></default>
    <default applyOnUpdate="0" expression="" field="third_attribute"></default>
    <default applyOnUpdate="0" expression="" field="notes"></default>
    <default applyOnUpdate="0" expression="coalesce(nullif(@mergin_username, ''), @user_account_name)" field="user_entered"></default>
    <default applyOnUpdate="0" expression="now()" field="date_entered"></default>
    <default applyOnUpdate="1" expression="coalesce(nullif(@mergin_username, ''), @user_account_name)" field="user_updated"></default>
    <default applyOnUpdate="1" expression="now()" field="date_updated"></default>
  </defaults>
  <constraints>
    <constraint constraints="3" exp_strength="0" field="fid" notnull_strength="1" unique_strength="1"></constraint>
    <constraint constraints="3" exp_strength="0" field="uuid" notnull_strength="1" unique_strength="1"></constraint>
    <constraint constraints="1" exp_strength="0" field="locality_fuid" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="1" exp_strength="0" field="structure_type_code" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="5" exp_strength="1" field="dip" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="4" exp_strength="1" field="azimuth" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="secondary_attribute" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="third_attribute" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="notes" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="1" exp_strength="0" field="user_entered" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="1" exp_strength="0" field="date_entered" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="user_updated" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="date_updated" notnull_strength="0" unique_strength="0"></constraint>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="fid"></constraint>
    <constraint desc="" exp="" field="uuid"></constraint>
    <constraint desc="" exp="" field="locality_fuid"></constraint>
    <constraint desc="" exp="" field="structure_type_code"></constraint>
    <constraint desc="0 &lt;= dip &lt;= 90" exp="&quot;dip&quot; >= 0 and &quot;dip&quot; &lt;= 90" field="dip"></constraint>
    <constraint desc="0 &lt;= azimuth &lt; 360" exp="&quot;azimuth&quot; >= 0 and &quot;azimuth&quot; &lt; 360" field="azimuth"></constraint>
    <constraint desc="" exp="" field="secondary_attribute"></constraint>
    <constraint desc="" exp="" field="third_attribute"></constraint>
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
  <editorlayout>tablayout</editorlayout>
  <attributeEditorForm>
    <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
      <labelFont bold="0" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
    </labelStyle>
    <attributeEditorField horizontalStretch="0" index="4" name="structure_type_code" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="5" name="dip" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="6" name="azimuth" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="7" name="secondary_attribute" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="8" name="third_attribute" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="9" name="notes" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsed="1" collapsedExpression="" collapsedExpressionEnabled="0" columnCount="1" groupBox="1" horizontalStretch="0" name="Parent locality" showLabel="1" type="GroupBox" verticalStretch="0" visibilityExpression="" visibilityExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" index="3" name="locality_fuid" showLabel="1" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="azimuth"></field>
    <field editable="1" name="date_entered"></field>
    <field editable="1" name="date_updated"></field>
    <field editable="1" name="dip"></field>
    <field editable="0" name="fid"></field>
    <field editable="1" name="locality_fuid"></field>
    <field editable="1" name="notes"></field>
    <field editable="1" name="secondary_attribute"></field>
    <field editable="1" name="structure_type_category"></field>
    <field editable="1" name="structure_type_code"></field>
    <field editable="1" name="third_attribute"></field>
    <field editable="1" name="user_entered"></field>
    <field editable="1" name="user_updated"></field>
    <field editable="0" name="uuid"></field>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="azimuth"></field>
    <field labelOnTop="0" name="date_entered"></field>
    <field labelOnTop="0" name="date_updated"></field>
    <field labelOnTop="0" name="dip"></field>
    <field labelOnTop="0" name="fid"></field>
    <field labelOnTop="0" name="locality_fuid"></field>
    <field labelOnTop="0" name="notes"></field>
    <field labelOnTop="0" name="secondary_attribute"></field>
    <field labelOnTop="0" name="structure_type_category"></field>
    <field labelOnTop="0" name="structure_type_code"></field>
    <field labelOnTop="0" name="third_attribute"></field>
    <field labelOnTop="0" name="user_entered"></field>
    <field labelOnTop="0" name="user_updated"></field>
    <field labelOnTop="0" name="uuid"></field>
  </labelOnTop>
  <reuseLastValue>
    <field name="azimuth" reuseLastValue="0"></field>
    <field name="date_entered" reuseLastValue="0"></field>
    <field name="date_updated" reuseLastValue="0"></field>
    <field name="dip" reuseLastValue="0"></field>
    <field name="fid" reuseLastValue="0"></field>
    <field name="locality_fuid" reuseLastValue="0"></field>
    <field name="notes" reuseLastValue="0"></field>
    <field name="secondary_attribute" reuseLastValue="0"></field>
    <field name="structure_type_category" reuseLastValue="0"></field>
    <field name="structure_type_code" reuseLastValue="0"></field>
    <field name="third_attribute" reuseLastValue="0"></field>
    <field name="user_entered" reuseLastValue="0"></field>
    <field name="user_updated" reuseLastValue="0"></field>
    <field name="uuid" reuseLastValue="0"></field>
  </reuseLastValue>
  <dataDefinedFieldProperties></dataDefinedFieldProperties>
  <widgets></widgets>
  <mapTip enabled="1"></mapTip>
  <layerGeometryType>4</layerGeometryType>
</qgis>