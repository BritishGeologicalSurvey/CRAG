<!--
Copyright 2026 British Geological Survey
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
            <Option name="ReferencedLayerId" type="QString" value="locality_point_ecb6cdf4_0fac_472b_a992_4fc1bfcc8807"></Option>
            <Option name="ReferencedLayerName" type="QString" value="locality_point"></Option>
            <Option name="ReferencedLayerProviderKey" type="QString" value="ogr"></Option>
            <Option name="Relation" type="QString" value="locality_point_photo"></Option>
            <Option name="ShowForm" type="bool" value="false"></Option>
            <Option name="ShowOpenFormButton" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="photo_file">
      <editWidget type="ExternalResource">
        <config>
          <Option type="Map">
            <Option name="DocumentViewer" type="int" value="1"></Option>
            <Option name="DocumentViewerHeight" type="int" value="0"></Option>
            <Option name="DocumentViewerWidth" type="int" value="0"></Option>
            <Option name="FileWidget" type="bool" value="true"></Option>
            <Option name="FileWidgetButton" type="bool" value="true"></Option>
            <Option name="FileWidgetFilter" type="invalid"></Option>
            <Option name="PropertyCollection" type="Map">
              <Option name="name" type="invalid"></Option>
              <Option name="properties" type="Map">
                <Option name="propertyRootPath" type="Map">
                  <Option name="active" type="bool" value="true"></Option>
                  <Option name="expression" type="QString" value="@project_folder + '/photos'"></Option>
                  <Option name="type" type="int" value="3"></Option>
                </Option>
              </Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
            <Option name="RelativeStorage" type="int" value="2"></Option>
            <Option name="StorageAuthConfigId" type="invalid"></Option>
            <Option name="StorageMode" type="int" value="0"></Option>
            <Option name="StorageType" type="invalid"></Option>
            <Option name="UseLink" type="bool" value="true"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="caption">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"></Option>
            <Option name="UseHtml" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="description">
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
    <alias field="photo_file" index="3" name=""></alias>
    <alias field="caption" index="4" name=""></alias>
    <alias field="description" index="5" name=""></alias>
    <alias field="recorded_by" index="6" name=""></alias>
    <alias field="recorded_on" index="7" name=""></alias>
  </aliases>
  <splitPolicies>
    <policy field="locality_fuid" policy="DefaultValue"></policy>
    <policy field="photo_file" policy="DefaultValue"></policy>
    <policy field="caption" policy="DefaultValue"></policy>
    <policy field="description" policy="DefaultValue"></policy>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="fid"></default>
    <default applyOnUpdate="0" expression="uuid()" field="uuid"></default>
    <default applyOnUpdate="0" expression="" field="locality_fuid"></default>
    <default applyOnUpdate="0" expression="if( @qgis_platform IS 'desktop', '../_field_data_capture/icons/BGS-placeholder.png', NULL )" field="photo_file"></default>
    <default applyOnUpdate="0" expression="" field="caption"></default>
    <default applyOnUpdate="0" expression="" field="description"></default>
    <default applyOnUpdate="0" expression="coalesce(nullif(@mergin_username, ''), @user_account_name)" field="recorded_by"></default>
    <default applyOnUpdate="0" expression="now()" field="recorded_on"></default>
  </defaults>
  <constraints>
    <constraint constraints="3" exp_strength="0" field="fid" notnull_strength="1" unique_strength="1"></constraint>
    <constraint constraints="7" exp_strength="1" field="uuid" notnull_strength="1" unique_strength="1"></constraint>
    <constraint constraints="5" exp_strength="1" field="locality_fuid" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="4" exp_strength="1" field="photo_file" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="4" exp_strength="1" field="caption" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="4" exp_strength="1" field="description" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="5" exp_strength="1" field="recorded_by" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="1" exp_strength="0" field="recorded_on" notnull_strength="1" unique_strength="0"></constraint>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="fid"></constraint>
    <constraint desc="Character limit: 38" exp="if(&quot;uuid&quot; is not null, length(&quot;uuid&quot;) &lt;= 38, true)" field="uuid"></constraint>
    <constraint desc="Character limit: 38" exp="if(&quot;locality_fuid&quot; is not null, length(&quot;locality_fuid&quot;) &lt;= 38, true)" field="locality_fuid"></constraint>
    <constraint desc="Photo file must be in the project folder and has a character limit of 4000" exp="if(&quot;photo_file&quot; is not null, length(&quot;photo_file&quot;) &lt;= 4000, true)&#xD;&#xA;and&#xD;&#xA;(&#xD;&#xA;&#x9;-- Photo is the placeholder image&#xD;&#xA;&#x9;&quot;photo_file&quot;='../_field_data_capture/icons/BGS-placeholder.png'&#xD;&#xA;&#x9;or&#xD;&#xA;&#x9;(&#xD;&#xA;&#x9;&#x9;-- Photos must be within project photos folder&#xD;&#xA;&#xD;&#xA;&#x9;&#x9;-- Don't match absolute windows paths (e.g. starting with &quot;C:/&quot;)&#xD;&#xA;&#x9;&#x9;not(regexp_match(lower(&quot;photo_file&quot;), '^[a-z]:/'))&#xD;&#xA;&#x9;&#x9;and&#xD;&#xA;&#x9;&#x9;-- Don't match absolute Linux paths (starting with &quot;/&quot;)&#xD;&#xA;&#x9;&#x9;not(regexp_match(&quot;photo_file&quot;, '^/'))&#xD;&#xA;&#x9;&#x9;and&#xD;&#xA;&#x9;&#x9;-- Don't match filepaths from parent directories (e.g. starting with &quot;../&quot;)&#xD;&#xA;&#x9;&#x9;not(regexp_match(&quot;photo_file&quot;, '^\\.\\./'))&#xD;&#xA;&#x9;&#x9;and&#xD;&#xA;&#x9;&#x9;-- Don't match files in the unlinked directory&#xD;&#xA;&#x9;&#x9;not(regexp_match(lower(&quot;photo_file&quot;), '^unlinked'))&#xD;&#xA;&#x9;)&#xD;&#xA;)" field="photo_file"></constraint>
    <constraint desc="Character limit: 250" exp="if(&quot;caption&quot; is not null, length(&quot;caption&quot;) &lt;= 250, true)" field="caption"></constraint>
    <constraint desc="Character limit: 4000" exp="if(&quot;description&quot; is not null, length(&quot;description&quot;) &lt;= 4000, true)" field="description"></constraint>
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
    <attributeEditorField horizontalStretch="0" index="3" name="photo_file" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,12,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="4" name="caption" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8.3,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="5" name="description" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8.3,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
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
    <field editable="1" name="caption"></field>
    <field editable="1" name="description"></field>
    <field editable="1" name="fid"></field>
    <field editable="1" name="locality_fuid"></field>
    <field editable="1" name="photo_file"></field>
    <field editable="1" name="recorded_by"></field>
    <field editable="1" name="recorded_on"></field>
    <field editable="1" name="uuid"></field>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="caption"></field>
    <field labelOnTop="0" name="description"></field>
    <field labelOnTop="0" name="fid"></field>
    <field labelOnTop="0" name="locality_fuid"></field>
    <field labelOnTop="0" name="photo_file"></field>
    <field labelOnTop="0" name="recorded_by"></field>
    <field labelOnTop="0" name="recorded_on"></field>
    <field labelOnTop="0" name="uuid"></field>
  </labelOnTop>
  <reuseLastValue>
    <field name="caption" reuseLastValue="0"></field>
    <field name="description" reuseLastValue="0"></field>
    <field name="fid" reuseLastValue="0"></field>
    <field name="locality_fuid" reuseLastValue="0"></field>
    <field name="photo_file" reuseLastValue="0"></field>
    <field name="recorded_by" reuseLastValue="0"></field>
    <field name="recorded_on" reuseLastValue="0"></field>
    <field name="uuid" reuseLastValue="0"></field>
  </reuseLastValue>
  <dataDefinedFieldProperties></dataDefinedFieldProperties>
  <widgets></widgets>
  <mapTip enabled="1"></mapTip>
  <layerGeometryType>4</layerGeometryType>
</qgis>