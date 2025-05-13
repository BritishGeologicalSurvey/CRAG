<qgis styleCategories="Symbology|Labeling|Fields|Forms|MapTips" version="3.36.2-Maidenhead">
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
            <Option name="Relation" type="QString" value="locality_point_media"></Option>
            <Option name="ShowForm" type="bool" value="false"></Option>
            <Option name="ShowOpenFormButton" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="media_type_code">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option name="AllowAddFeatures" type="bool" value="false"></Option>
            <Option name="AllowNULL" type="bool" value="true"></Option>
            <Option name="FetchLimitActive" type="bool" value="true"></Option>
            <Option name="FetchLimitNumber" type="int" value="100"></Option>
            <Option name="MapIdentification" type="bool" value="false"></Option>
            <Option name="ReadOnly" type="bool" value="false"></Option>
            <Option name="ReferencedLayerDataSource" type="QString" value="C:\leorud_stuff\personal\qgis_testing\fdc-plugin\field-data-capture.gpkg|layername=dic_media"></Option>
            <Option name="ReferencedLayerId" type="QString" value="dic_media_88a8f46f_20f2_4b35_b0c2_6c463764d3af"></Option>
            <Option name="ReferencedLayerName" type="QString" value="dic_media"></Option>
            <Option name="ReferencedLayerProviderKey" type="QString" value="ogr"></Option>
            <Option name="Relation" type="QString" value="dic_media_media_2"></Option>
            <Option name="ShowForm" type="bool" value="false"></Option>
            <Option name="ShowOpenFormButton" type="bool" value="false"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="media_link">
      <editWidget type="ExternalResource">
        <config>
          <Option type="Map">
            <Option name="DefaultRoot" type="QString" value="@project_folder + '/media'"></Option>
            <Option name="DocumentViewer" type="int" value="1"></Option>
            <Option name="DocumentViewerHeight" type="int" value="0"></Option>
            <Option name="DocumentViewerWidth" type="int" value="600"></Option>
            <Option name="FileWidget" type="bool" value="true"></Option>
            <Option name="FileWidgetButton" type="bool" value="true"></Option>
            <Option name="FileWidgetFilter" type="QString" value=""></Option>
            <Option name="PropertyCollection" type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties" type="Map">
                <Option name="documentViewerContent" type="Map">
                  <Option name="active" type="bool" value="true"></Option>
                  <Option name="expression" type="QString" value="if(&quot;media_link&quot;='../icons/BGS-placeholder.png', 'Image', 'NoContent')"></Option>
                  <Option name="type" type="int" value="3"></Option>
                </Option>
                <Option name="propertyRootPath" type="Map">
                  <Option name="active" type="bool" value="true"></Option>
                  <Option name="expression" type="QString" value="@project_folder + '/media'"></Option>
                  <Option name="type" type="int" value="3"></Option>
                </Option>
              </Option>
              <Option name="type" type="QString" value="collection"></Option>
            </Option>
            <Option name="RelativeStorage" type="int" value="2"></Option>
            <Option name="StorageAuthConfigId" type="QString" value=""></Option>
            <Option name="StorageMode" type="int" value="0"></Option>
            <Option name="StorageType" type="QString" value=""></Option>
            <Option name="UseLink" type="bool" value="true"></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="media_description">
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
    <alias field="media_type_code" index="3" name=""></alias>
    <alias field="media_link" index="4" name=""></alias>
    <alias field="media_description" index="5" name=""></alias>
    <alias field="recorded_by" index="6" name=""></alias>
    <alias field="recorded_on" index="7" name=""></alias>
  </aliases>
  <splitPolicies>
    <policy field="fid" policy="Duplicate"></policy>
    <policy field="uuid" policy="Duplicate"></policy>
    <policy field="locality_fuid" policy="DefaultValue"></policy>
    <policy field="media_type_code" policy="DefaultValue"></policy>
    <policy field="media_link" policy="DefaultValue"></policy>
    <policy field="media_description" policy="DefaultValue"></policy>
    <policy field="recorded_by" policy="Duplicate"></policy>
    <policy field="recorded_on" policy="Duplicate"></policy>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="fid"></default>
    <default applyOnUpdate="0" expression="uuid()" field="uuid"></default>
    <default applyOnUpdate="0" expression="" field="locality_fuid"></default>
    <default applyOnUpdate="0" expression="" field="media_type_code"></default>
    <default applyOnUpdate="0" expression="'../icons/BGS-placeholder.png'" field="media_link"></default>
    <default applyOnUpdate="0" expression="" field="media_description"></default>
    <default applyOnUpdate="0" expression="coalesce(nullif(@mergin_username, ''), @user_account_name)" field="recorded_by"></default>
    <default applyOnUpdate="0" expression="now()" field="recorded_on"></default>
  </defaults>
  <constraints>
    <constraint constraints="3" exp_strength="0" field="fid" notnull_strength="1" unique_strength="1"></constraint>
    <constraint constraints="3" exp_strength="0" field="uuid" notnull_strength="1" unique_strength="1"></constraint>
    <constraint constraints="1" exp_strength="0" field="locality_fuid" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="1" exp_strength="0" field="media_type_code" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="4" exp_strength="1" field="media_link" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="media_description" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="1" exp_strength="0" field="recorded_by" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="1" exp_strength="0" field="recorded_on" notnull_strength="1" unique_strength="0"></constraint>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="fid"></constraint>
    <constraint desc="" exp="" field="uuid"></constraint>
    <constraint desc="" exp="" field="locality_fuid"></constraint>
    <constraint desc="" exp="" field="media_type_code"></constraint>
    <constraint desc="" exp="-- Media is the placeholder image&#xD;&#xA;&quot;media_link&quot;='../icons/BGS-placeholder.png'&#xD;&#xA;or&#xD;&#xA;(&#xD;&#xA;&#x9;-- Media must be within project media folder&#xD;&#xA;&#xD;&#xA;&#x9;-- Don't match absolute windows paths (e.g. starting with &quot;C:/&quot;)&#xD;&#xA;&#x9;not(regexp_match(lower(&quot;media_link&quot;), '^[a-z]:/'))&#xD;&#xA;&#x9;and&#xD;&#xA;&#x9;-- Don't match absolute Linux paths (starting with &quot;/&quot;)&#xD;&#xA;&#x9;not(regexp_match(&quot;media_link&quot;, '^/'))&#xD;&#xA;&#x9;and&#xD;&#xA;&#x9;-- Don't match filepaths from parent directories (e.g. starting with &quot;../&quot;)&#xD;&#xA;&#x9;not(regexp_match(&quot;media_link&quot;, '^\\.\\./'))&#xD;&#xA;)" field="media_link"></constraint>
    <constraint desc="" exp="" field="media_description"></constraint>
    <constraint desc="" exp="" field="recorded_by"></constraint>
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
    <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
      <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
    </labelStyle>
    <attributeEditorField horizontalStretch="0" index="3" name="media_type_code" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="4" name="media_link" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="5" name="media_description" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsed="1" collapsedExpression="" collapsedExpressionEnabled="0" columnCount="1" groupBox="1" horizontalStretch="0" name="Parent locality" showLabel="1" type="GroupBox" verticalStretch="0" visibilityExpression="" visibilityExpressionEnabled="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
      <attributeEditorField horizontalStretch="0" index="2" name="locality_fuid" showLabel="1" verticalStretch="0">
        <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
          <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
        </labelStyle>
      </attributeEditorField>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="recorded_on"></field>
    <field editable="1" name="fid"></field>
    <field editable="1" name="locality_fuid"></field>
    <field editable="1" name="media_description"></field>
    <field editable="1" name="media_link"></field>
    <field editable="1" name="media_type_code"></field>
    <field editable="1" name="recorded_by"></field>
    <field editable="1" name="uuid"></field>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="recorded_on"></field>
    <field labelOnTop="0" name="fid"></field>
    <field labelOnTop="0" name="locality_fuid"></field>
    <field labelOnTop="0" name="media_description"></field>
    <field labelOnTop="0" name="media_link"></field>
    <field labelOnTop="0" name="media_type_code"></field>
    <field labelOnTop="0" name="recorded_by"></field>
    <field labelOnTop="0" name="uuid"></field>
  </labelOnTop>
  <reuseLastValue>
    <field name="recorded_on" reuseLastValue="0"></field>
    <field name="fid" reuseLastValue="0"></field>
    <field name="locality_fuid" reuseLastValue="0"></field>
    <field name="media_description" reuseLastValue="0"></field>
    <field name="media_link" reuseLastValue="0"></field>
    <field name="media_type_code" reuseLastValue="0"></field>
    <field name="recorded_by" reuseLastValue="0"></field>
    <field name="uuid" reuseLastValue="0"></field>
  </reuseLastValue>
  <dataDefinedFieldProperties></dataDefinedFieldProperties>
  <widgets></widgets>
  <mapTip enabled="1"></mapTip>
  <layerGeometryType>4</layerGeometryType>
</qgis>