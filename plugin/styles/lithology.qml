<qgis styleCategories="Symbology|Labeling|Fields|Forms|MapTips" version="3.40.7-Bratislava">
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
            <Option name="ReferencedLayerDataSource" type="QString" value=""></Option>
            <Option name="ReferencedLayerId" type="QString" value="locality_point_4bb76b3f_42c7_4fd0_a75a_9419ceaf18b6"></Option>
            <Option name="ReferencedLayerName" type="QString" value="locality_point"></Option>
            <Option name="ReferencedLayerProviderKey" type="QString" value="ogr"></Option>
            <Option name="Relation" type="QString" value="locality_point_lithology"></Option>
            <Option name="ShowForm" type="bool" value="false"></Option>
            <Option name="ShowOpenFormButton" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="lithology_code">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" type="bool" value="false"></Option>
            <Option name="AllowNULL" type="bool" value="true"></Option>
            <Option name="ChainFilters" type="bool" value="false"></Option>
            <Option name="FetchLimitActive" type="bool" value="false"></Option>
            <Option name="FetchLimitNumber" type="int" value="100"></Option>
            <Option name="FilterExpression" type="QString" value="array_contains(&#xA;&#x9;string_to_array(&#xA;&#x9;&#x9;aggregate(&#xA;&#x9;&#x9;&#x9;'_lnk_rock_project',&#xA;&#x9;&#x9;&#x9;aggregate:='concatenate',&#xA;&#x9;&#x9;&#x9;expression:=&quot;rock_code&quot;,&#xA;&#x9;&#x9;&#x9;concatenator:=','&#xA;&#x9;&#x9;)&#xA;&#x9;),&#xA;&#x9;&quot;code&quot;&#xA;)"></Option>
            <Option name="FilterFields" type="invalid"></Option>
            <Option name="MapIdentification" type="bool" value="false"></Option>
            <Option name="ReadOnly" type="bool" value="false"></Option>
            <Option name="ReferencedLayerDataSource" type="QString" value=""></Option>
            <Option name="ReferencedLayerId" type="QString" value="dic_rock_field_8c3352ee_b401_446c_8bab_bb1afdb353af"></Option>
            <Option name="ReferencedLayerName" type="QString" value="dic_rock_field"></Option>
            <Option name="ReferencedLayerProviderKey" type="QString" value="ogr"></Option>
            <Option name="Relation" type="QString" value="dic_rock_field_lithology_2"></Option>
            <Option name="ShowForm" type="bool" value="false"></Option>
            <Option name="ShowOpenFormButton" type="bool" value="false"></Option>
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
    <field configurationFlags="NoFlag" name="recorded_by">
      <editWidget type="Hidden">
        <config>
          <Option></Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="recorded_on">
      <editWidget type="Hidden">
        <config>
          <Option></Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="fid" index="0" name=""></alias>
    <alias field="uuid" index="1" name=""></alias>
    <alias field="locality_fuid" index="2" name=""></alias>
    <alias field="lithology_code" index="3" name=""></alias>
    <alias field="notes" index="4" name=""></alias>
    <alias field="recorded_by" index="5" name=""></alias>
    <alias field="recorded_on" index="6" name=""></alias>
  </aliases>
  <splitPolicies>
    <policy field="fid" policy="DefaultValue"></policy>
    <policy field="uuid" policy="DefaultValue"></policy>
    <policy field="locality_fuid" policy="DefaultValue"></policy>
    <policy field="lithology_code" policy="DefaultValue"></policy>
    <policy field="notes" policy="DefaultValue"></policy>
    <policy field="recorded_by" policy="DefaultValue"></policy>
    <policy field="recorded_on" policy="DefaultValue"></policy>
  </splitPolicies>
  <duplicatePolicies>
    <policy field="fid" policy="Duplicate"></policy>
    <policy field="uuid" policy="Duplicate"></policy>
    <policy field="locality_fuid" policy="Duplicate"></policy>
    <policy field="lithology_code" policy="Duplicate"></policy>
    <policy field="notes" policy="Duplicate"></policy>
    <policy field="recorded_by" policy="Duplicate"></policy>
    <policy field="recorded_on" policy="Duplicate"></policy>
  </duplicatePolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="fid"></default>
    <default applyOnUpdate="0" expression="uuid()" field="uuid"></default>
    <default applyOnUpdate="0" expression="" field="locality_fuid"></default>
    <default applyOnUpdate="0" expression="" field="lithology_code"></default>
    <default applyOnUpdate="0" expression="" field="notes"></default>
    <default applyOnUpdate="0" expression="coalesce(nullif(@mergin_username, ''), @user_account_name)" field="recorded_by"></default>
    <default applyOnUpdate="0" expression="now()" field="recorded_on"></default>
  </defaults>
  <constraints>
    <constraint constraints="3" exp_strength="0" field="fid" notnull_strength="1" unique_strength="1"></constraint>
    <constraint constraints="7" exp_strength="1" field="uuid" notnull_strength="1" unique_strength="1"></constraint>
    <constraint constraints="5" exp_strength="1" field="locality_fuid" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="5" exp_strength="1" field="lithology_code" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="4" exp_strength="1" field="notes" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="5" exp_strength="1" field="recorded_by" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="1" exp_strength="0" field="recorded_on" notnull_strength="1" unique_strength="0"></constraint>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="fid"></constraint>
    <constraint desc="Character limit: 38" exp="if(&quot;uuid&quot; is not null, length(&quot;uuid&quot;) &lt;= 38, true)" field="uuid"></constraint>
    <constraint desc="Character limit: 38" exp="if(&quot;locality_fuid&quot; is not null, length(&quot;locality_fuid&quot;) &lt;= 38, true)" field="locality_fuid"></constraint>
    <constraint desc="Character limit: 50" exp="if(&quot;lithology_code&quot; is not null, length(&quot;lithology_code&quot;) &lt;= 50, true)" field="lithology_code"></constraint>
    <constraint desc="Character limit: 4000" exp="if(&quot;notes&quot; is not null, length(&quot;notes&quot;) &lt;= 4000, true)" field="notes"></constraint>
    <constraint desc="Character limit: 50" exp="if(&quot;recorded_by&quot; is not null, length(&quot;recorded_by&quot;) &lt;= 50, true)" field="recorded_by"></constraint>
    <constraint desc="" exp="" field="recorded_on"></constraint>
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
    <labelStyle labelColor="" overrideLabelColor="0" overrideLabelFont="0">
      <labelFont bold="0" description="MS Shell Dlg 2,12,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
    </labelStyle>
    <attributeEditorField horizontalStretch="0" index="3" name="lithology_code" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorTextElement horizontalStretch="0" name="Simple Lithology" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>[% attribute(get_feature('dic_rock_field', 'code', current_value('lithology_code')), 'simple_lithology') %]</attributeEditorTextElement>
    <attributeEditorField horizontalStretch="0" index="4" name="notes" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsed="1" collapsedExpression="" collapsedExpressionEnabled="0" columnCount="1" groupBox="1" horizontalStretch="0" name="Parent locality" showLabel="1" type="GroupBox" verticalStretch="0" visibilityExpression="" visibilityExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" index="2" name="locality_fuid" showLabel="1" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="fid"></field>
    <field editable="1" name="lithology_code"></field>
    <field editable="1" name="locality_fuid"></field>
    <field editable="1" name="notes"></field>
    <field editable="1" name="recorded_by"></field>
    <field editable="1" name="recorded_on"></field>
    <field editable="1" name="uuid"></field>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="fid"></field>
    <field labelOnTop="0" name="lithology_code"></field>
    <field labelOnTop="0" name="locality_fuid"></field>
    <field labelOnTop="0" name="notes"></field>
    <field labelOnTop="0" name="recorded_by"></field>
    <field labelOnTop="0" name="recorded_on"></field>
    <field labelOnTop="0" name="uuid"></field>
  </labelOnTop>
  <reuseLastValue>
    <field name="fid" reuseLastValue="0"></field>
    <field name="lithology_code" reuseLastValue="0"></field>
    <field name="locality_fuid" reuseLastValue="0"></field>
    <field name="notes" reuseLastValue="0"></field>
    <field name="recorded_by" reuseLastValue="0"></field>
    <field name="recorded_on" reuseLastValue="0"></field>
    <field name="uuid" reuseLastValue="0"></field>
  </reuseLastValue>
  <dataDefinedFieldProperties></dataDefinedFieldProperties>
  <widgets></widgets>
  <mapTip enabled="1"></mapTip>
  <layerGeometryType>4</layerGeometryType>
</qgis>