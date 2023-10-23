<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="Symbology|Labeling|Fields|Forms" version="3.30.0-'s-Hertogenbosch">
  <fieldConfiguration>
    <field name="fid" configurationFlags="None">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="objectid" configurationFlags="None">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="uuid" configurationFlags="None">
      <editWidget type="UuidGenerator">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="locality_fuid" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/jostev/mergin/view-test/field-data-capture.gpkg|layername=locality_point" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="locality_point_b5d4a64c_6865_4086_866f_ff25c1aea696" name="ReferencedLayerId" type="QString"/>
            <Option value="locality_point" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="locality_point_media" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="media_type_code" configurationFlags="None">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option value="false" name="AllowAddFeatures" type="bool"/>
            <Option value="false" name="AllowNULL" type="bool"/>
            <Option value="false" name="MapIdentification" type="bool"/>
            <Option value="false" name="OrderByValue" type="bool"/>
            <Option value="false" name="ReadOnly" type="bool"/>
            <Option value="C:/Users/jostev/mergin/view-test/field-data-capture.gpkg|layername=dic_media" name="ReferencedLayerDataSource" type="QString"/>
            <Option value="dic_media_22c702cd_a5fd_4124_8a34_dafe4ed58e7c" name="ReferencedLayerId" type="QString"/>
            <Option value="dic_media" name="ReferencedLayerName" type="QString"/>
            <Option value="ogr" name="ReferencedLayerProviderKey" type="QString"/>
            <Option value="dic_media_media_2" name="Relation" type="QString"/>
            <Option value="false" name="ShowForm" type="bool"/>
            <Option value="true" name="ShowOpenFormButton" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="media_link" configurationFlags="None">
      <editWidget type="ExternalResource">
        <config>
          <Option type="Map">
            <Option value="0" name="DocumentViewer" type="int"/>
            <Option value="0" name="DocumentViewerHeight" type="int"/>
            <Option value="0" name="DocumentViewerWidth" type="int"/>
            <Option value="true" name="FileWidget" type="bool"/>
            <Option value="true" name="FileWidgetButton" type="bool"/>
            <Option value="" name="FileWidgetFilter" type="QString"/>
            <Option name="PropertyCollection" type="Map">
              <Option value="" name="name" type="QString"/>
              <Option name="properties"/>
              <Option value="collection" name="type" type="QString"/>
            </Option>
            <Option value="0" name="RelativeStorage" type="int"/>
            <Option value="" name="StorageAuthConfigId" type="QString"/>
            <Option value="0" name="StorageMode" type="int"/>
            <Option value="" name="StorageType" type="QString"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="comment" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option value="true" name="IsMultiline" type="bool"/>
            <Option value="false" name="UseHtml" type="bool"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="user_entered" configurationFlags="None">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="date_entered" configurationFlags="None">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="user_updated" configurationFlags="None">
      <editWidget type="Hidden">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="date_updated" configurationFlags="None">
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
  <splitPolicies>
    <policy field="fid" policy="Duplicate"/>
    <policy field="objectid" policy="Duplicate"/>
    <policy field="uuid" policy="Duplicate"/>
    <policy field="locality_fuid" policy="Duplicate"/>
    <policy field="media_type_code" policy="Duplicate"/>
    <policy field="media_link" policy="Duplicate"/>
    <policy field="comment" policy="DefaultValue"/>
    <policy field="user_entered" policy="Duplicate"/>
    <policy field="date_entered" policy="Duplicate"/>
    <policy field="user_updated" policy="Duplicate"/>
    <policy field="date_updated" policy="Duplicate"/>
  </splitPolicies>
  <defaults>
    <default expression="" applyOnUpdate="0" field="fid"/>
    <default expression="" applyOnUpdate="0" field="objectid"/>
    <default expression="" applyOnUpdate="0" field="uuid"/>
    <default expression="" applyOnUpdate="0" field="locality_fuid"/>
    <default expression="" applyOnUpdate="0" field="media_type_code"/>
    <default expression="" applyOnUpdate="0" field="media_link"/>
    <default expression="mallard" applyOnUpdate="0" field="comment"/>
    <default expression="@user_account_name" applyOnUpdate="0" field="user_entered"/>
    <default expression="now()" applyOnUpdate="0" field="date_entered"/>
    <default expression="@user_account_name" applyOnUpdate="1" field="user_updated"/>
    <default expression="now()" applyOnUpdate="1" field="date_updated"/>
  </defaults>
  <constraints>
    <constraint unique_strength="1" notnull_strength="1" field="fid" constraints="3" exp_strength="0"/>
    <constraint unique_strength="1" notnull_strength="0" field="objectid" constraints="2" exp_strength="0"/>
    <constraint unique_strength="1" notnull_strength="1" field="uuid" constraints="3" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="1" field="locality_fuid" constraints="1" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="1" field="media_type_code" constraints="1" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="1" field="media_link" constraints="1" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="0" field="comment" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="1" field="user_entered" constraints="1" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="1" field="date_entered" constraints="1" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="0" field="user_updated" constraints="0" exp_strength="0"/>
    <constraint unique_strength="0" notnull_strength="0" field="date_updated" constraints="0" exp_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" field="fid" desc=""/>
    <constraint exp="" field="objectid" desc=""/>
    <constraint exp="" field="uuid" desc=""/>
    <constraint exp="" field="locality_fuid" desc=""/>
    <constraint exp="" field="media_type_code" desc=""/>
    <constraint exp="" field="media_link" desc=""/>
    <constraint exp="" field="comment" desc=""/>
    <constraint exp="" field="user_entered" desc=""/>
    <constraint exp="" field="date_entered" desc=""/>
    <constraint exp="" field="user_updated" desc=""/>
    <constraint exp="" field="date_updated" desc=""/>
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
