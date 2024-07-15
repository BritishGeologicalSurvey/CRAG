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
            <Option name="DocumentViewer" type="int" value="0"></Option>
            <Option name="DocumentViewerHeight" type="int" value="0"></Option>
            <Option name="DocumentViewerWidth" type="int" value="0"></Option>
            <Option name="FileWidget" type="bool" value="true"></Option>
            <Option name="FileWidgetButton" type="bool" value="true"></Option>
            <Option name="FileWidgetFilter" type="QString" value=""></Option>
            <Option name="PropertyCollection" type="Map">
              <Option name="name" type="QString" value=""></Option>
              <Option name="properties" type="Map">
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
    <alias field="media_type_code" index="4" name=""></alias>
    <alias field="media_link" index="5" name=""></alias>
    <alias field="media_description" index="6" name=""></alias>
    <alias field="user_entered" index="7" name=""></alias>
    <alias field="date_entered" index="8" name=""></alias>
    <alias field="user_updated" index="9" name=""></alias>
    <alias field="date_updated" index="10" name=""></alias>
  </aliases>
  <splitPolicies>
    <policy field="fid" policy="Duplicate"></policy>
    <policy field="uuid" policy="Duplicate"></policy>
    <policy field="locality_fuid" policy="DefaultValue"></policy>
    <policy field="media_type_code" policy="DefaultValue"></policy>
    <policy field="media_link" policy="DefaultValue"></policy>
    <policy field="media_description" policy="DefaultValue"></policy>
    <policy field="user_entered" policy="Duplicate"></policy>
    <policy field="date_entered" policy="Duplicate"></policy>
    <policy field="user_updated" policy="Duplicate"></policy>
    <policy field="date_updated" policy="Duplicate"></policy>
  </splitPolicies>
  <defaults>
    <default applyOnUpdate="0" expression="" field="fid"></default>
    <default applyOnUpdate="0" expression="uuid()" field="uuid"></default>
    <default applyOnUpdate="0" expression="" field="locality_fuid"></default>
    <default applyOnUpdate="0" expression="" field="media_type_code"></default>
    <default applyOnUpdate="0" expression="" field="media_link"></default>
    <default applyOnUpdate="0" expression="" field="media_description"></default>
    <default applyOnUpdate="0" expression="coalesce(nullif(@mergin_username, ''), @user_account_name)" field="user_entered"></default>
    <default applyOnUpdate="0" expression="now()" field="date_entered"></default>
    <default applyOnUpdate="1" expression="coalesce(nullif(@mergin_username, ''), @user_account_name)" field="user_updated"></default>
    <default applyOnUpdate="1" expression="now()" field="date_updated"></default>
  </defaults>
  <constraints>
    <constraint constraints="3" exp_strength="0" field="fid" notnull_strength="1" unique_strength="1"></constraint>
    <constraint constraints="3" exp_strength="0" field="uuid" notnull_strength="1" unique_strength="1"></constraint>
    <constraint constraints="1" exp_strength="0" field="locality_fuid" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="1" exp_strength="0" field="media_type_code" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="media_link" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="media_description" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="1" exp_strength="0" field="user_entered" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="1" exp_strength="0" field="date_entered" notnull_strength="1" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="user_updated" notnull_strength="0" unique_strength="0"></constraint>
    <constraint constraints="0" exp_strength="0" field="date_updated" notnull_strength="0" unique_strength="0"></constraint>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="fid"></constraint>
    <constraint desc="" exp="" field="uuid"></constraint>
    <constraint desc="" exp="" field="locality_fuid"></constraint>
    <constraint desc="" exp="" field="media_type_code"></constraint>
    <constraint desc="" exp="" field="media_link"></constraint>
    <constraint desc="" exp="" field="media_description"></constraint>
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
      <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
    </labelStyle>
    <attributeEditorField horizontalStretch="0" index="4" name="media_type_code" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="5" name="media_link" showLabel="1" verticalStretch="0">
      <labelStyle labelColor="0,0,0,255" overrideLabelColor="0" overrideLabelFont="0">
        <labelFont bold="0" description="MS Shell Dlg 2,8,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" style="" underline="0"></labelFont>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField horizontalStretch="0" index="6" name="media_description" showLabel="1" verticalStretch="0">
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
    <field editable="1" name="date_entered"></field>
    <field editable="1" name="date_updated"></field>
    <field editable="1" name="fid"></field>
    <field editable="1" name="locality_fuid"></field>
    <field editable="1" name="media_link"></field>
    <field editable="1" name="media_type_code"></field>
    <field editable="1" name="media_description"></field>
    <field editable="1" name="user_entered"></field>
    <field editable="1" name="user_updated"></field>
    <field editable="1" name="uuid"></field>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="date_entered"></field>
    <field labelOnTop="0" name="date_updated"></field>
    <field labelOnTop="0" name="fid"></field>
    <field labelOnTop="0" name="locality_fuid"></field>
    <field labelOnTop="0" name="media_link"></field>
    <field labelOnTop="0" name="media_type_code"></field>
    <field labelOnTop="0" name="media_description"></field>
    <field labelOnTop="0" name="user_entered"></field>
    <field labelOnTop="0" name="user_updated"></field>
    <field labelOnTop="0" name="uuid"></field>
  </labelOnTop>
  <reuseLastValue>
    <field name="date_entered" reuseLastValue="0"></field>
    <field name="date_updated" reuseLastValue="0"></field>
    <field name="fid" reuseLastValue="0"></field>
    <field name="locality_fuid" reuseLastValue="0"></field>
    <field name="media_link" reuseLastValue="0"></field>
    <field name="media_type_code" reuseLastValue="0"></field>
    <field name="media_description" reuseLastValue="0"></field>
    <field name="user_entered" reuseLastValue="0"></field>
    <field name="user_updated" reuseLastValue="0"></field>
    <field name="uuid" reuseLastValue="0"></field>
  </reuseLastValue>
  <dataDefinedFieldProperties></dataDefinedFieldProperties>
  <widgets></widgets>
  <mapTip enabled="1"></mapTip>
  <layerGeometryType>4</layerGeometryType>
</qgis>