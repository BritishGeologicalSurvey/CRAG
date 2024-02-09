<qgis styleCategories="Symbology|Labeling|Fields|Forms" version="3.34.0-Prizren">
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
            <Option name="MapIdentification" type="bool" value="false"></Option>
            <Option name="OrderByValue" type="bool" value="false"></Option>
            <Option name="ReadOnly" type="bool" value="false"></Option>
            <Option name="ReferencedLayerDataSource" type="QString" value="C:/Users/jostev/mergin/view-test/field-data-capture.gpkg|layername=locality_point"></Option>
            <Option name="ReferencedLayerId" type="QString" value="locality_point_66e0db7d_f7ea_40aa_8aa0_c83f2e1b88a2"></Option>
            <Option name="ReferencedLayerName" type="QString" value="locality_point"></Option>
            <Option name="ReferencedLayerProviderKey" type="QString" value="ogr"></Option>
            <Option name="Relation" type="QString" value="locality_point_photo"></Option>
            <Option name="ShowForm" type="bool" value="false"></Option>
            <Option name="ShowOpenFormButton" type="bool" value="true"></Option>
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
            <Option name="DocumentViewerWidth" type="int" value="600"></Option>
            <Option name="FileWidget" type="bool" value="true"></Option>
            <Option name="FileWidgetButton" type="bool" value="true"></Option>
            <Option name="FileWidgetFilter" type="QString" value=""></Option>
            <Option name="PropertyCollection" type="Map">
              <Option name="name" type="QString" value=""></Option>
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
            <Option name="StorageAuthConfigId" type="QString" value=""></Option>
            <Option name="StorageMode" type="int" value="0"></Option>
            <Option name="StorageType" type="QString" value=""></Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="NoFlag" name="comment">
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
    <alias field="photo_file" index="4" name=""></alias>
    <alias field="comment" index="5" name=""></alias>
    <alias field="user_entered" index="6" name=""></alias>
    <alias field="date_entered" index="7" name=""></alias>
    <alias field="user_updated" index="8" name=""></alias>
    <alias field="date_updated" index="9" name=""></alias>
  </aliases>
  <splitPolicies>
    <policy field="fid" policy="Duplicate"></policy>
    <policy field="objectid" policy="Duplicate"></policy>
    <policy field="uuid" policy="Duplicate"></policy>
    <policy field="locality_fuid" policy="Duplicate"></policy>
    <policy field="photo_file" policy="Duplicate"></policy>
    <policy field="comment" policy="Duplicate"></policy>
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
    <default applyOnUpdate="0" expression="" field="photo_file"></default>
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
    <constraint constraints="0" exp_strength="0" field="photo_file" notnull_strength="0" unique_strength="0"></constraint>
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
    <constraint desc="" exp="" field="photo_file"></constraint>
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
    <field editable="1" name="fid"></field>
    <field editable="1" name="locality_fuid"></field>
    <field editable="1" name="objectid"></field>
    <field editable="1" name="photo_file"></field>
    <field editable="1" name="user_entered"></field>
    <field editable="1" name="user_updated"></field>
    <field editable="1" name="uuid"></field>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="comment"></field>
    <field labelOnTop="0" name="date_entered"></field>
    <field labelOnTop="0" name="date_updated"></field>
    <field labelOnTop="0" name="fid"></field>
    <field labelOnTop="0" name="locality_fuid"></field>
    <field labelOnTop="0" name="objectid"></field>
    <field labelOnTop="0" name="photo_file"></field>
    <field labelOnTop="0" name="user_entered"></field>
    <field labelOnTop="0" name="user_updated"></field>
    <field labelOnTop="0" name="uuid"></field>
  </labelOnTop>
  <reuseLastValue>
    <field name="comment" reuseLastValue="0"></field>
    <field name="date_entered" reuseLastValue="0"></field>
    <field name="date_updated" reuseLastValue="0"></field>
    <field name="fid" reuseLastValue="0"></field>
    <field name="locality_fuid" reuseLastValue="0"></field>
    <field name="objectid" reuseLastValue="0"></field>
    <field name="photo_file" reuseLastValue="0"></field>
    <field name="user_entered" reuseLastValue="0"></field>
    <field name="user_updated" reuseLastValue="0"></field>
    <field name="uuid" reuseLastValue="0"></field>
  </reuseLastValue>
  <dataDefinedFieldProperties></dataDefinedFieldProperties>
  <widgets></widgets>
  <layerGeometryType>4</layerGeometryType>
</qgis>