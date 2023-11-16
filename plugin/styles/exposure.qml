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
            <Option type="bool" value="false" name="AllowAddFeatures"/>
            <Option type="bool" value="false" name="AllowNULL"/>
            <Option type="bool" value="false" name="MapIdentification"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="ReadOnly"/>
            <Option type="QString" value="/home/leorud/personal/qgis_testing/fdc-plugin/field-data-capture.gpkg|layername=locality_point" name="ReferencedLayerDataSource"/>
            <Option type="QString" value="locality_point_0a424dd4_f60e_438b_8335_5bb1524d7ae7" name="ReferencedLayerId"/>
            <Option type="QString" value="locality_point" name="ReferencedLayerName"/>
            <Option type="QString" value="ogr" name="ReferencedLayerProviderKey"/>
            <Option type="QString" value="locality_point_exposure" name="Relation"/>
            <Option type="bool" value="false" name="ShowForm"/>
            <Option type="bool" value="true" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="exposure_type_code">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowAddFeatures"/>
            <Option type="bool" value="true" name="AllowNULL"/>
            <Option type="bool" value="false" name="MapIdentification"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="ReadOnly"/>
            <Option type="QString" value="/home/leorud/personal/qgis_testing/fdc-plugin/field-data-capture.gpkg|layername=dic_exposure_type" name="ReferencedLayerDataSource"/>
            <Option type="QString" value="dic_exposure_type_379c9546_9a57_4b0c_b00b_6f8638600eea" name="ReferencedLayerId"/>
            <Option type="QString" value="dic_exposure_type" name="ReferencedLayerName"/>
            <Option type="QString" value="ogr" name="ReferencedLayerProviderKey"/>
            <Option type="QString" value="dic_exposure_type_exposure_3" name="Relation"/>
            <Option type="bool" value="false" name="ShowForm"/>
            <Option type="bool" value="false" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="lithology_code">
      <editWidget type="RelationReference">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowAddFeatures"/>
            <Option type="bool" value="true" name="AllowNULL"/>
            <Option type="bool" value="false" name="ChainFilters"/>
            <Option type="QString" value="" name="FilterExpression"/>
            <Option type="StringList" name="FilterFields">
              <Option type="QString" value="rock_grouping"/>
            </Option>
            <Option type="bool" value="false" name="MapIdentification"/>
            <Option type="bool" value="true" name="OrderByValue"/>
            <Option type="bool" value="false" name="ReadOnly"/>
            <Option type="QString" value="/home/leorud/personal/qgis_testing/fdc-plugin/field-data-capture.gpkg|layername=dic_rock_all" name="ReferencedLayerDataSource"/>
            <Option type="QString" value="dic_rock_all_c3ccd553_ca00_4989_adda_3a04bcbab734" name="ReferencedLayerId"/>
            <Option type="QString" value="dic_rock_all" name="ReferencedLayerName"/>
            <Option type="QString" value="ogr" name="ReferencedLayerProviderKey"/>
            <Option type="QString" value="dic_rock_all_exposure_2" name="Relation"/>
            <Option type="bool" value="false" name="ShowForm"/>
            <Option type="bool" value="false" name="ShowOpenFormButton"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="description">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="true" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="comment">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="true" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
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
    <alias index="0" field="fid" name=""/>
    <alias index="1" field="objectid" name=""/>
    <alias index="2" field="uuid" name=""/>
    <alias index="3" field="locality_fuid" name=""/>
    <alias index="4" field="exposure_type_code" name=""/>
    <alias index="5" field="lithology_code" name=""/>
    <alias index="6" field="description" name=""/>
    <alias index="7" field="comment" name=""/>
    <alias index="8" field="user_entered" name=""/>
    <alias index="9" field="date_entered" name=""/>
    <alias index="10" field="user_updated" name=""/>
    <alias index="11" field="date_updated" name=""/>
  </aliases>
  <defaults>
    <default expression="" field="fid" applyOnUpdate="0"/>
    <default expression="" field="objectid" applyOnUpdate="0"/>
    <default expression="uuid()" field="uuid" applyOnUpdate="0"/>
    <default expression="" field="locality_fuid" applyOnUpdate="0"/>
    <default expression="" field="exposure_type_code" applyOnUpdate="0"/>
    <default expression="" field="lithology_code" applyOnUpdate="0"/>
    <default expression="" field="description" applyOnUpdate="0"/>
    <default expression="" field="comment" applyOnUpdate="0"/>
    <default expression="@user_account_name" field="user_entered" applyOnUpdate="0"/>
    <default expression="now()" field="date_entered" applyOnUpdate="0"/>
    <default expression="@user_account_name" field="user_updated" applyOnUpdate="1"/>
    <default expression="now()" field="date_updated" applyOnUpdate="1"/>
  </defaults>
  <constraints>
    <constraint field="fid" unique_strength="1" constraints="3" exp_strength="0" notnull_strength="1"/>
    <constraint field="objectid" unique_strength="1" constraints="2" exp_strength="0" notnull_strength="0"/>
    <constraint field="uuid" unique_strength="1" constraints="3" exp_strength="0" notnull_strength="1"/>
    <constraint field="locality_fuid" unique_strength="0" constraints="1" exp_strength="0" notnull_strength="1"/>
    <constraint field="exposure_type_code" unique_strength="0" constraints="1" exp_strength="0" notnull_strength="1"/>
    <constraint field="lithology_code" unique_strength="0" constraints="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="description" unique_strength="0" constraints="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="comment" unique_strength="0" constraints="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="user_entered" unique_strength="0" constraints="1" exp_strength="0" notnull_strength="1"/>
    <constraint field="date_entered" unique_strength="0" constraints="1" exp_strength="0" notnull_strength="1"/>
    <constraint field="user_updated" unique_strength="0" constraints="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="date_updated" unique_strength="0" constraints="0" exp_strength="0" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="fid" desc="" exp=""/>
    <constraint field="objectid" desc="" exp=""/>
    <constraint field="uuid" desc="" exp=""/>
    <constraint field="locality_fuid" desc="" exp=""/>
    <constraint field="exposure_type_code" desc="" exp=""/>
    <constraint field="lithology_code" desc="" exp=""/>
    <constraint field="description" desc="" exp=""/>
    <constraint field="comment" desc="" exp=""/>
    <constraint field="user_entered" desc="" exp=""/>
    <constraint field="date_entered" desc="" exp=""/>
    <constraint field="user_updated" desc="" exp=""/>
    <constraint field="date_updated" desc="" exp=""/>
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
    <field editable="1" name="comment"/>
    <field editable="1" name="date_entered"/>
    <field editable="1" name="date_updated"/>
    <field editable="1" name="description"/>
    <field editable="1" name="exposure_type_code"/>
    <field editable="1" name="fid"/>
    <field editable="1" name="lithology_code"/>
    <field editable="1" name="locality_fuid"/>
    <field editable="1" name="objectid"/>
    <field editable="1" name="user_entered"/>
    <field editable="1" name="user_updated"/>
    <field editable="1" name="uuid"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="comment"/>
    <field labelOnTop="0" name="date_entered"/>
    <field labelOnTop="0" name="date_updated"/>
    <field labelOnTop="0" name="description"/>
    <field labelOnTop="0" name="exposure_type_code"/>
    <field labelOnTop="0" name="fid"/>
    <field labelOnTop="0" name="lithology_code"/>
    <field labelOnTop="0" name="locality_fuid"/>
    <field labelOnTop="0" name="objectid"/>
    <field labelOnTop="0" name="user_entered"/>
    <field labelOnTop="0" name="user_updated"/>
    <field labelOnTop="0" name="uuid"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="comment"/>
    <field reuseLastValue="0" name="date_entered"/>
    <field reuseLastValue="0" name="date_updated"/>
    <field reuseLastValue="0" name="description"/>
    <field reuseLastValue="0" name="exposure_type_code"/>
    <field reuseLastValue="0" name="fid"/>
    <field reuseLastValue="0" name="lithology_code"/>
    <field reuseLastValue="0" name="locality_fuid"/>
    <field reuseLastValue="0" name="objectid"/>
    <field reuseLastValue="0" name="user_entered"/>
    <field reuseLastValue="0" name="user_updated"/>
    <field reuseLastValue="0" name="uuid"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <layerGeometryType>4</layerGeometryType>
</qgis>
