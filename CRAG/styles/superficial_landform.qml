<!--
Copyright 2026 UKRI / British Geological Survey
Licensed under GPLv3 licence
SPDX-License-Identifier: GPL-3.0-or-later
-->
<qgis styleCategories="Symbology|Labeling|Fields|Forms|MapTips" version="3.44.10-Solothurn">
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
            <Option name="ReferencedLayerDataSource" type="invalid"></Option>
            <Option name="ReferencedLayerId" type="QString" value="locality_point_a0ef48c5_a49f_4555_a5fa_800ff598e8f8"></Option>
            <Option name="ReferencedLayerName" type="QString" value="locality_point"></Option>
            <Option name="ReferencedLayerProviderKey" type="QString" value="ogr"></Option>
            <Option name="Relation" type="QString" value="locality_point_superficial_landform"></Option>
            <Option name="ShowForm" type="bool" value="false"></Option>
            <Option name="ShowOpenFormButton" type="bool" value="false"></Option>
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
            <Option name="FilterExpression" type="invalid"></Option>
            <Option name="FilterFields" type="List">
              <Option type="QString" value="category"></Option>
            </Option>
            <Option name="MapIdentification" type="bool" value="false"></Option>
            <Option name="ReadOnly" type="bool" value="false"></Option>
            <Option name="ReferencedLayerDataSource" type="invalid"></Option>
            <Option name="ReferencedLayerId" type="QString" value="dic_superficial_landform_7e5e5fa2_894e_4174_b8bb_7d8c6a175c88"></Option>
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
    <alias field="superficial_type_code" index="3" name=""></alias>
    <alias field="dip" index="4" name="dip (°)"></alias>
    <alias field="azimuth" index="5" name="azimuth (°)"></alias>
    <alias field="length" index="6" name="length (m)"></alias>
    <alias field="width" index="7" name="width (m)"></alias>
    <alias field="height_depth" index="8" name="height_depth (m)"></alias>
    <alias field="notes" index="9" name=""></alias>
    <alias field="recorded_by" index="10" name=""></alias>
    <alias field="recorded_on" index="11" name=""></alias>
  </aliases>
  <splitPolicies>
    <policy field="uuid" policy="DefaultValue"></policy>
    <policy field="locality_fuid" policy="DefaultValue"></policy>
    <policy field="superficial_type_code" policy="DefaultValue"></policy>
    <policy field="dip" policy="DefaultValue"></policy>
    <policy field="azimuth" policy="DefaultValue"></policy>
    <policy field="length" policy="DefaultValue"></policy>
    <policy field="width" policy="DefaultValue"></policy>
    <policy field="height_depth" policy="DefaultValue"></policy>
    <policy field="notes" policy="DefaultValue"></policy>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="fid"></default>
    <default applyOnUpdate="0" expression="uuid()" field="uuid"></default>
    <default applyOnUpdate="0" expression="" field="locality_fuid"></default>
    <default applyOnUpdate="0" expression="" field="superficial_type_code"></default>
    <default applyOnUpdate="0" expression="" field="dip"></default>
    <default applyOnUpdate="0" expression="" field="azimuth"></default>
    <default applyOnUpdate="0" expression="" field="length"></default>
    <default applyOnUpdate="0" expression="" field="width"></default>
    <default applyOnUpdate="0" expression="" field="height_depth"></default>
    <default applyOnUpdate="0" expression="" field="notes"></default>
    <default applyOnUpdate="0" expression="coalesce(nullif(@mergin_username, ''), @user_account_name)" field="recorded_by"></default>
    <default applyOnUpdate="0" expression="now()" field="recorded_on"></default>
  </defaults>
  <constraints>
    <constraint constraints="3" exp_strength="0" field="fid" notnull_strength="1" unique_strength="1"></constraint>
    <constraint constraints="7" exp_strength="1" field="uuid" notnull_strength="1" unique_strength="1"></constraint>
    <constraint constraints="5" exp_strength="1" field="locality_fuid" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="5" exp_strength="1" field="superficial_type_code" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="4" exp_strength="1" field="dip" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="4" exp_strength="1" field="azimuth" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="length" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="width" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="height_depth" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="4" exp_strength="1" field="notes" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="5" exp_strength="1" field="recorded_by" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="1" exp_strength="0" field="recorded_on" notnull_strength="1" unique_strength="0"></constraint>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="fid"></constraint>
    <constraint desc="Character limit: 38" exp="if(&quot;uuid&quot; is not null, length(&quot;uuid&quot;) &lt;= 38, true)" field="uuid"></constraint>
    <constraint desc="Character limit: 38" exp="if(&quot;locality_fuid&quot; is not null, length(&quot;locality_fuid&quot;) &lt;= 38, true)" field="locality_fuid"></constraint>
    <constraint desc="Character limit: 50" exp="if(&quot;superficial_type_code&quot; is not null, length(&quot;superficial_type_code&quot;) &lt;= 50, true)" field="superficial_type_code"></constraint>
    <constraint desc="0 &lt;= dip &lt;= 90" exp="(&quot;dip&quot; >= 0 and &quot;dip&quot; &lt;= 90) OR (&quot;dip&quot; IS NULL)" field="dip"></constraint>
    <constraint desc="0 &lt;= azimuth &lt; 360" exp=" (&quot;azimuth&quot; >= 0 and &quot;azimuth&quot; &lt; 360) OR (&quot;azimuth&quot; IS NULL)" field="azimuth"></constraint>
    <constraint desc="" exp="" field="length"></constraint>
    <constraint desc="" exp="" field="width"></constraint>
    <constraint desc="" exp="" field="height_depth"></constraint>
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
      <labelFont bold="0" description="MS Shell Dlg 2,9.8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
    </labelStyle>
    <attributeEditorField horizontalStretch="0" index="3" name="superficial_type_code" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsed="0" collapsedExpression="" collapsedExpressionEnabled="0" columnCount="1" groupBox="0" horizontalStretch="0" name="azimuth" showLabel="0" type="Row" verticalStretch="0" visibilityExpression="attribute(&#xD;&#xA;&#x9;get_feature(&#xD;&#xA;&#x9;&#x9;'dic_superficial_landform',&#xD;&#xA;&#x9;&#x9;'code',&#xD;&#xA;&#x9;&#x9;&quot;superficial_type_code&quot;&#xD;&#xA;&#x9;),&#xD;&#xA;&#x9;'has_azimuth'&#xD;&#xA;)" visibilityExpressionEnabled="1">
      <labelStyle labelColor="" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" index="5" name="azimuth" showLabel="1" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorContainer collapsed="0" collapsedExpression="" collapsedExpressionEnabled="0" columnCount="1" groupBox="0" horizontalStretch="0" name="dip" showLabel="0" type="Row" verticalStretch="0" visibilityExpression="attribute(&#xD;&#xA;&#x9;get_feature(&#xD;&#xA;&#x9;&#x9;'dic_superficial_landform',&#xD;&#xA;&#x9;&#x9;'code',&#xD;&#xA;&#x9;&#x9;&quot;superficial_type_code&quot;&#xD;&#xA;&#x9;),&#xD;&#xA;&#x9;'has_dip'&#xD;&#xA;)" visibilityExpressionEnabled="1">
      <labelStyle labelColor="" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" index="4" name="dip" showLabel="1" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
    <attributeEditorField horizontalStretch="0" index="6" name="length" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="7" name="width" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="8" name="height_depth" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="9" name="notes" showLabel="1" verticalStretch="0">
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
    <field editable="1" name="azimuth"></field>
    <field editable="1" name="dip"></field>
    <field editable="1" name="fid"></field>
    <field editable="1" name="height_depth"></field>
    <field editable="1" name="length"></field>
    <field editable="1" name="locality_fuid"></field>
    <field editable="1" name="notes"></field>
    <field editable="1" name="recorded_by"></field>
    <field editable="1" name="recorded_on"></field>
    <field editable="1" name="superficial_type_category"></field>
    <field editable="1" name="superficial_type_code"></field>
    <field editable="1" name="uuid"></field>
    <field editable="1" name="width"></field>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="azimuth"></field>
    <field labelOnTop="0" name="dip"></field>
    <field labelOnTop="0" name="fid"></field>
    <field labelOnTop="0" name="height_depth"></field>
    <field labelOnTop="0" name="length"></field>
    <field labelOnTop="0" name="locality_fuid"></field>
    <field labelOnTop="0" name="notes"></field>
    <field labelOnTop="0" name="recorded_by"></field>
    <field labelOnTop="0" name="recorded_on"></field>
    <field labelOnTop="0" name="superficial_type_category"></field>
    <field labelOnTop="0" name="superficial_type_code"></field>
    <field labelOnTop="0" name="uuid"></field>
    <field labelOnTop="0" name="width"></field>
  </labelOnTop>
  <reuseLastValue>
    <field name="azimuth" reuseLastValue="0"></field>
    <field name="dip" reuseLastValue="0"></field>
    <field name="fid" reuseLastValue="0"></field>
    <field name="height_depth" reuseLastValue="0"></field>
    <field name="length" reuseLastValue="0"></field>
    <field name="locality_fuid" reuseLastValue="0"></field>
    <field name="notes" reuseLastValue="0"></field>
    <field name="recorded_by" reuseLastValue="0"></field>
    <field name="recorded_on" reuseLastValue="0"></field>
    <field name="superficial_type_category" reuseLastValue="0"></field>
    <field name="superficial_type_code" reuseLastValue="1"></field>
    <field name="uuid" reuseLastValue="0"></field>
    <field name="width" reuseLastValue="0"></field>
  </reuseLastValue>
  <dataDefinedFieldProperties></dataDefinedFieldProperties>
  <widgets></widgets>
  <mapTip enabled="1"></mapTip>
  <layerGeometryType>4</layerGeometryType>
</qgis>