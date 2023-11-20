<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.28.11-Firenze" styleCategories="Symbology|Labeling|Fields|Forms">
  <fieldConfiguration>
    <field configurationFlags="None" name="fid">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="objectid">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="uuid">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="locality_fuid">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" name="AllowAddFeatures" value="false"/>
            <Option type="bool" name="AllowNULL" value="false"/>
            <Option type="bool" name="MapIdentification" value="false"/>
            <Option type="bool" name="OrderByValue" value="false"/>
            <Option type="bool" name="ReadOnly" value="false"/>
            <Option type="QString" name="ReferencedLayerDataSource" value="C:/Users/jostev/mergin/view-test/field-data-capture.gpkg|layername=locality_point"/>
            <Option type="QString" name="ReferencedLayerId" value="locality_point_09acf2b3_5030_4514_8ed2_1a8cbd935a84"/>
            <Option type="QString" name="ReferencedLayerName" value="locality_point"/>
            <Option type="QString" name="ReferencedLayerProviderKey" value="ogr"/>
            <Option type="QString" name="Relation" value="locality_point_media"/>
            <Option type="bool" name="ShowForm" value="false"/>
            <Option type="bool" name="ShowOpenFormButton" value="true"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="media_type_code">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" name="AllowAddFeatures" value="false"/>
            <Option type="bool" name="AllowNULL" value="true"/>
            <Option type="bool" name="MapIdentification" value="false"/>
            <Option type="bool" name="OrderByValue" value="false"/>
            <Option type="bool" name="ReadOnly" value="false"/>
            <Option type="QString" name="ReferencedLayerDataSource" value="/home/leorud/personal/qgis_testing/fdc-plugin/field-data-capture.gpkg|layername=dic_media"/>
            <Option type="QString" name="ReferencedLayerId" value="dic_media_1bc3cd66_e06b_4863_a3af_a9c2a783c764"/>
            <Option type="QString" name="ReferencedLayerName" value="dic_media"/>
            <Option type="QString" name="ReferencedLayerProviderKey" value="ogr"/>
            <Option type="QString" name="Relation" value="dic_media_media_2"/>
            <Option type="bool" name="ShowForm" value="false"/>
            <Option type="bool" name="ShowOpenFormButton" value="true"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="media_link">
      <editWidget type="ExternalResource">
        <config>
          <Option type="Map">
            <Option type="QString" name="DefaultRoot" value="@project_folder + '/media'"/>
            <Option type="int" name="DocumentViewer" value="0"/>
            <Option type="int" name="DocumentViewerHeight" value="0"/>
            <Option type="int" name="DocumentViewerWidth" value="0"/>
            <Option type="bool" name="FileWidget" value="true"/>
            <Option type="bool" name="FileWidgetButton" value="true"/>
            <Option type="QString" name="FileWidgetFilter" value=""/>
            <Option type="Map" name="PropertyCollection">
              <Option type="QString" name="name" value=""/>
              <Option type="Map" name="properties">
                <Option type="Map" name="propertyRootPath">
                  <Option type="bool" name="active" value="true"/>
                  <Option type="QString" name="expression" value="@project_folder + '/media'"/>
                  <Option type="int" name="type" value="3"/>
                </Option>
              </Option>
              <Option type="QString" name="type" value="collection"/>
            </Option>
            <Option type="int" name="RelativeStorage" value="2"/>
            <Option type="QString" name="StorageAuthConfigId" value=""/>
            <Option type="int" name="StorageMode" value="0"/>
            <Option type="QString" name="StorageType" value=""/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="comment">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="true"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="user_entered">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="date_entered">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="user_updated">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="date_updated">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias name="" field="fid" index="0"/>
    <alias name="" field="objectid" index="1"/>
    <alias name="" field="uuid" index="2"/>
    <alias name="" field="locality_fuid" index="3"/>
    <alias name="" field="media_type_code" index="4"/>
    <alias name="" field="media_link" index="5"/>
    <alias name="" field="comment" index="6"/>
    <alias name="" field="user_entered" index="7"/>
    <alias name="" field="date_entered" index="8"/>
    <alias name="" field="user_updated" index="9"/>
    <alias name="" field="date_updated" index="10"/>
  </aliases>
  <defaults>
    <default applyOnUpdate="0" field="fid" expression=""/>
    <default applyOnUpdate="0" field="objectid" expression=""/>
    <default applyOnUpdate="0" field="uuid" expression="uuid()"/>
    <default applyOnUpdate="0" field="locality_fuid" expression=""/>
    <default applyOnUpdate="0" field="media_type_code" expression=""/>
    <default applyOnUpdate="0" field="media_link" expression=""/>
    <default applyOnUpdate="0" field="comment" expression="mallard"/>
    <default applyOnUpdate="0" field="user_entered" expression="@user_account_name"/>
    <default applyOnUpdate="0" field="date_entered" expression="now()"/>
    <default applyOnUpdate="1" field="user_updated" expression="@user_account_name"/>
    <default applyOnUpdate="1" field="date_updated" expression="now()"/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" field="fid" constraints="3" unique_strength="1" notnull_strength="1"/>
    <constraint exp_strength="0" field="objectid" constraints="2" unique_strength="1" notnull_strength="0"/>
    <constraint exp_strength="0" field="uuid" constraints="3" unique_strength="1" notnull_strength="1"/>
    <constraint exp_strength="0" field="locality_fuid" constraints="1" unique_strength="0" notnull_strength="1"/>
    <constraint exp_strength="0" field="media_type_code" constraints="1" unique_strength="0" notnull_strength="1"/>
    <constraint exp_strength="0" field="media_link" constraints="1" unique_strength="0" notnull_strength="1"/>
    <constraint exp_strength="0" field="comment" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="user_entered" constraints="1" unique_strength="0" notnull_strength="1"/>
    <constraint exp_strength="0" field="date_entered" constraints="1" unique_strength="0" notnull_strength="1"/>
    <constraint exp_strength="0" field="user_updated" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="date_updated" constraints="0" unique_strength="0" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" field="fid" exp=""/>
    <constraint desc="" field="objectid" exp=""/>
    <constraint desc="" field="uuid" exp=""/>
    <constraint desc="" field="locality_fuid" exp=""/>
    <constraint desc="" field="media_type_code" exp=""/>
    <constraint desc="" field="media_link" exp=""/>
    <constraint desc="" field="comment" exp=""/>
    <constraint desc="" field="user_entered" exp=""/>
    <constraint desc="" field="date_entered" exp=""/>
    <constraint desc="" field="user_updated" exp=""/>
    <constraint desc="" field="date_updated" exp=""/>
  </constraintExpressions>
  <expressionfields/>
  <editform tolerant="1"></editform>
  <editforminit/>
  <editforminitcodesource>0</editforminitcodesource>
  <editforminitfilepath></editforminitfilepath>
  <editforminitcode><![CDATA[# -*- coding: utf-8 -*-
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
]]></editforminitcode>
  <featformsuppress>0</featformsuppress>
  <editorlayout>generatedlayout</editorlayout>
  <editable>
    <field name="comment" editable="1"/>
    <field name="date_entered" editable="1"/>
    <field name="date_updated" editable="1"/>
    <field name="fid" editable="1"/>
    <field name="locality_fuid" editable="1"/>
    <field name="media_link" editable="1"/>
    <field name="media_type_code" editable="1"/>
    <field name="objectid" editable="1"/>
    <field name="user_entered" editable="1"/>
    <field name="user_updated" editable="1"/>
    <field name="uuid" editable="1"/>
  </editable>
  <labelOnTop>
    <field name="comment" labelOnTop="0"/>
    <field name="date_entered" labelOnTop="0"/>
    <field name="date_updated" labelOnTop="0"/>
    <field name="fid" labelOnTop="0"/>
    <field name="locality_fuid" labelOnTop="0"/>
    <field name="media_link" labelOnTop="0"/>
    <field name="media_type_code" labelOnTop="0"/>
    <field name="objectid" labelOnTop="0"/>
    <field name="user_entered" labelOnTop="0"/>
    <field name="user_updated" labelOnTop="0"/>
    <field name="uuid" labelOnTop="0"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="comment" reuseLastValue="0"/>
    <field name="date_entered" reuseLastValue="0"/>
    <field name="date_updated" reuseLastValue="0"/>
    <field name="fid" reuseLastValue="0"/>
    <field name="locality_fuid" reuseLastValue="0"/>
    <field name="media_link" reuseLastValue="0"/>
    <field name="media_type_code" reuseLastValue="0"/>
    <field name="objectid" reuseLastValue="0"/>
    <field name="user_entered" reuseLastValue="0"/>
    <field name="user_updated" reuseLastValue="0"/>
    <field name="uuid" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <layerGeometryType>4</layerGeometryType>
</qgis>
