<%--
  Created by IntelliJ IDEA.
  User: NEU
  Date: 2018/1/2
  Time: 9:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.debugging.debug" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Nested Layout - jQuery EasyUI Demo</title>
  <link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.4/themes/default/easyui.css">
  <link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.4/themes/icon.css">
  <link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.4/demo/demo.css">
  <script type="text/javascript" src="jquery-easyui-1.5.4/jquery.min.js"></script>
  <script type="text/javascript" src="jquery-easyui-1.5.4/jquery.easyui.min.js"></script>
  <style>
    body{
      text-align: center;
    }
  </style>
  <script type="text/javascript">
    function showContent(obj) {
      $("#"+$(obj).text()).css("display","block").siblings().css("display","none");
    }
  </script>
</head>
<body>
<div style="margin:20px 0;"></div>
<div class="easyui-layout" style="width:1200px;height:700px;margin: auto">
  <div data-options="region:'north'" style="height:100px;text-align: center">
    <h2>Ontology Debugging System</h2>
    <p>The layout region panel contains another layout or other components.</p>
  </div>
  <div data-options="region:'south',split:true" style="height:50px;text-align: center">
    All rights reserved;
  </div>
  <div data-options="region:'east',split:true" title="Detail" style="width:180px;">
    <table id="tt" class="easyui-propertygrid" data-options="
                        url: 'propertygrid_data1.json',
                        method: 'get',
                        showGroup: true,
                        fit: true,
                        border: false
                    ">
    </table>
  </div>
  <div data-options="region:'west',split:true" title="Menu" style="width:150px;">
    <div class="easyui-accordion" data-options="fit:true,border:false">
      <div title="Ontology" data-options="selected:true" style="padding:10px;">
        <a class="easyui-linkbutton" style="margin-top:10px;" onclick="showContent(this)">Importing</a><br>
        <a class="easyui-linkbutton" style="margin-top:10px;" onclick="showContent(this)">Reasoning</a><br>
        <a class="easyui-linkbutton" style="margin-top:10px;" onclick="showContent(this)">Debugging</a>
      </div>
      <div title="About" style="padding:10px;">
        <a class="easyui-linkbutton" style="margin-top:10px;">Contact</a><br>
        <a class="easyui-linkbutton" style="margin-top:10px;">Help</a>
      </div>
    </div>
  </div>
  <div data-options="region:'center',iconCls:'icon-ok'" title="Center" style="padding:5px">
    <div id="Importing" class="easyui-layout" data-options="fit:true">
      Importing<br><input class="easyui-filebox" style="width: 200px"><br>
      upload pregress:      <div class="easyui-progressbar" data-options="value:80" style="width:50%;"></div>
    </div>
    <div id="Reasoning" class="easyui-layout" data-options="fit:true">
      Reasoning
    </div>
    <div id="Debugging" class="easyui-layout" data-options="fit:true">
      <div data-options="region:'north',split:true" style="height:50px;padding-top:5px;">
        subject:<input class="easyui-textbox" style="width: 120px;">
        predicate:<input class="easyui-textbox" style="width: 120px;">
        object:<input class="easyui-textbox" style="width: 120px;">
        <a class="easyui-linkbutton">Debug</a>
      </div>
      <!--<div data-options="region:'west',split:true" style="width:150px">-->
      <!---->
      <!--</div>-->
      <div data-options="region:'center'" style="padding-top: 5px;">
        Results:
        <select class="easyui-combobox">
          <option>Top 10</option>
          <option>Top 5</option>
          <option>Top 3</option>
        </select>
        <table class="easyui-datagrid" title="Basic DataGrid" style="width:auto;padding-top: 10px"
               data-options="pagination:true,singleSelect:true,collapsible:true,url:'datagrid_data1.json',method:'get'">
          <thead>
          <tr>
            <th data-options="field:'itemid',width:80">Item ID</th>
            <th data-options="field:'productid',width:100">Product</th>
            <th data-options="field:'listprice',width:80,align:'right'">List Price</th>
            <th data-options="field:'unitcost',width:80,align:'right'">Unit Cost</th>
            <th data-options="field:'attr1'">Attribute</th>
            <th data-options="field:'status',align:'center'">Status</th>
          </tr>
          </thead>
        </table>
      </div>
    </div>
  </div>
</div>

</body>
</html>
