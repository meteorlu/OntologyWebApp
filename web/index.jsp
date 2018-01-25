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
      $("#center").panel({"title":$(obj).text()});
    }
  </script>
  <script type="text/javascript">
    $.extend($.fn.datagrid.methods, {
      editCell: function(jq,param){
        return jq.each(function(){
          var opts = $(this).datagrid('options');
          var fields = $(this).datagrid('getColumnFields',true).concat($(this).datagrid('getColumnFields'));
          for(var i=0; i<fields.length; i++){
            var col = $(this).datagrid('getColumnOption', fields[i]);
            col.editor1 = col.editor;
            if (fields[i] != param.field){
              col.editor = null;
            }
          }
          $(this).datagrid('beginEdit', param.index);
          for(var i=0; i<fields.length; i++){
            var col = $(this).datagrid('getColumnOption', fields[i]);
            col.editor = col.editor1;
          }
        });
      }
    });

    var editIndex = undefined;
    function endEditing(){
      if (editIndex == undefined){return true}
      if ($('#dg').datagrid('validateRow', editIndex)){
        $('#dg').datagrid('endEdit', editIndex);
        editIndex = undefined;
        return true;
      } else if ($('#dg_score').datagrid('validateRow', editIndex)){
        $('#dg').datagrid('endEdit', editIndex);
        editIndex = undefined;
        return true;
      }  else {
        return false;
      }
    }
    function onClickCell(index, field){
      if (endEditing()){
        $('#dg').datagrid('selectRow', index)
                .datagrid('editCell', {index:index,field:field});
        $('#dg_score').datagrid('selectRow', index)
                .datagrid('editCell', {index:index,field:field});
        editIndex = index;
      }
    }
  </script>
</head>
<body>
<div style="margin:20px 0;"></div>
<div class="easyui-layout" style="width:1200px;height:700px;margin: auto">
  <div data-options="region:'north'" style="text-align: center">
    <h2 style="padding: 5px;">Ontology Debugging System</h2>
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
        <a class="easyui-linkbutton" style="margin-top:10px;" onclick="showContent(this)">Debugging</a><br>
        <a class="easyui-linkbutton" style="margin-top:10px;" onclick="showContent(this)">Scoring</a><br>
        <a class="easyui-linkbutton" style="margin-top:10px;" onclick="showContent(this)">Training</a>
      </div>
      <div title="About" style="padding:10px;">
        <a class="easyui-linkbutton" style="margin-top:10px;">Contact</a><br>
        <a class="easyui-linkbutton" style="margin-top:10px;">Help</a>
      </div>
    </div>
  </div>
  <div id="center" data-options="region:'center',iconCls:'icon-ok'" title="Center" style="padding:5px">
    <div id="Importing" class="easyui-layout" data-options="fit:true">
      Importing<br><input class="easyui-filebox" style="width: 200px"><br>
      upload pregress:      <div class="easyui-progressbar" data-options="value:80" style="width:50%;"></div>
    </div>
    <div id="Reasoning" class="easyui-layout" data-options="fit:true">
      Reasoning
    </div>
    <div id="Scoring" class="easyui-layout" data-options="fit:true">
      Numbers:
      <select class="easyui-combobox" style="width: 100px">
        <option>100</option>
        <option>300</option>
        <option>500</option>
      </select>
      <table id="dg_score" class="easyui-datagrid" title="Justifications" style="width:auto;padding-top: 10px"
             data-options="pagination:true,
                   singleSelect:true,
                   collapsible:true,
                   url:'datas/justifications.json',
                   method:'get',
                   onClickCell: onClickCell
        ">
        <thead>
        <tr>
          <th data-options="field:'Number',width:80">Index</th>
          <th data-options="field:'tripleNumber',width:80">tripleNumber</th>
          <th data-options="field:'Score',width:50,editor:{
							type:'numberbox',
							options:{
								precision:0,
								min:0,
								max:100
							}
						}">Score</th>
        </tr>
        </thead>
      </table>
      <table id="dg_score_triples" class="easyui-datagrid" title="Justification Detail" style="width:auto;padding-top: 10px"
             data-options="pagination:true,
                   singleSelect:true,
                   collapsible:true,
                   url:'datas/triples.json',
                   method:'get',
                   onClickCell: onClickCell
        ">
        <thead>
        <tr>
          <th data-options="field:'Number',width:80">Number</th>
          <th data-options="field:'Subject'">Subject</th>
          <th data-options="field:'Predicate'">Predicate</th>
          <th data-options="field:'Object'">Object</th>
        </tr>
        </thead>
      </table>
    </div>
    <div id="Training" class="easyui-layout" data-options="fit:true">
      Numbers:
      <select class="easyui-combobox" style="width: 100px">
        <option>100</option>
        <option>300</option>
        <option>500</option>
      </select>
      <a onclick="$('#dlg').dialog('open')" class="easyui-linkbutton" iconCls="icon-add" style="margin: 5px;">Training</a>
      <table id="dg_train" class="easyui-datagrid" title="Justifications" style="width:auto;padding-top: 10px"
             data-options="pagination:true,
                   singleSelect:true,
                   collapsible:true,
                   url:'datas/justifications_training.json',
                   method:'get',
                   onClickCell: onClickCell
        ">
        <thead>
        <tr>
          <th data-options="field:'Number',width:80">Index</th>
          <th data-options="field:'tripleNumber',width:80">tripleNumber</th>
          <th data-options="field:'Score',width:50,editor:{
							type:'numberbox',
							options:{
								precision:0,
								min:0,
								max:100
							}
						}">Score</th>
        </tr>
        </thead>
      </table>
      <table id="dg_train_triples" class="easyui-datagrid" title="Justification Detail" style="width:auto;padding-top: 10px"
             data-options="pagination:true,
                   singleSelect:true,
                   collapsible:true,
                   url:'datas/triples.json',
                   method:'get',
                   onClickCell: onClickCell
        ">
        <thead>
        <tr>
          <th data-options="field:'Number',width:80">Number</th>
          <th data-options="field:'Subject'">Subject</th>
          <th data-options="field:'Predicate'">Predicate</th>
          <th data-options="field:'Object'">Object</th>
        </tr>
        </thead>
      </table>
    </div>
    <div id="Debugging" class="easyui-layout" data-options="fit:true">
      <div data-options="region:'north',split:true" style="height:50px;padding-top:5px;">
        subject:<input class="easyui-textbox" style="width: 300px;" value="Department1.University0.edu/AssistantProfessor0">
        predicate:<input class="easyui-textbox" style="width: 120px;" value="type">
        object:<input class="easyui-textbox" style="width: 120px;" value="Employee">
        <a class="easyui-linkbutton">Debug</a>
      </div>
      <!--<div data-options="region:'west',split:true" style="width:150px">-->
      <!---->
      <!--</div>-->
      <div data-options="region:'center'" style="padding-top: 5px;">
        <%--<a onclick="$('#dlg').dialog('open')" class="easyui-linkbutton" iconCls="icon-add" style="margin: 5px;">Training</a>--%>
        <%--<a href="#" class="easyui-linkbutton" iconCls="icon-filter" style="margin: 5px;">Sorting</a>--%>
        <%--Numbers:--%>
        <%--<select class="easyui-combobox">--%>
          <%--<option>Top 10</option>--%>
          <%--<option>Top 5</option>--%>
          <%--<option>Top 3</option>--%>
        <%--</select>--%>
        <table id="dg" class="easyui-datagrid" title="Justifications" style="width:auto;padding-top: 10px"
               data-options="pagination:true,
                   singleSelect:true,
                   collapsible:true,
                   url:'datas/justifications_debugging.json',
                   method:'get',
                   onClickCell: onClickCell
        ">
          <thead>
          <tr>
            <th data-options="field:'Number',width:80">Index</th>
            <th data-options="field:'tripleNumber',width:80">tripleNumber</th>
            <th data-options="field:'Score',width:50,editor:{
							type:'numberbox',
							options:{
								precision:0,
								min:0,
								max:100
							}
						}">Score</th>
          </tr>
          </thead>
        </table>
        <table id="dg_triples" class="easyui-datagrid" title="Justification Detail" style="width:auto;padding-top: 10px"
               data-options="pagination:true,
                   singleSelect:true,
                   collapsible:true,
                   url:'datas/triples.json',
                   method:'get',
                   onClickCell: onClickCell
        ">
          <thead>
          <tr>
            <th data-options="field:'Number',width:80">Number</th>
            <th data-options="field:'Subject'">Subject</th>
            <th data-options="field:'Predicate'">Predicate</th>
            <th data-options="field:'Object'">Object</th>
          </tr>
          </thead>
        </table>
      </div>
    </div>
    <div id="Sorting" class="easyui-layout" data-options="fit:true">
      Reasoning
    </div>
  </div>
</div>
  <div id="dlg" class="easyui-dialog" title="Set Learning Rate" style="width:400px;padding:10px"
       data-options="
                  iconCls: 'icon-save',
                  closed:true,
                  vcenter:true,
                  top:200,
                  moadl:true,
                  buttons: [{
                      text:'Ok',
                      iconCls:'icon-ok',
                      handler:function(){
                        $('#dlg').dialog('close')
                      }
                  },{
                      text:'Cancel',
                      iconCls:'icon-undo',
                      handler:function(){
                      $('#dlg').dialog('close')
                      }
                  }]
              ">
      <div style="text-align: center">
        Learning Rate:<input class="easyui-numberbox" style="width:30px ">%
      </div>
  </div>
</body>
</html>
