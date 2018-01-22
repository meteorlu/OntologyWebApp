<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            } else {
                return false;
            }
        }
        function onClickCell(index, field){
            if (endEditing()){
                $('#dg').datagrid('selectRow', index)
                    .datagrid('editCell', {index:index,field:field});
                editIndex = index;
            }
        }
    </script>
</head>
<body>
<table id="dg" class="easyui-datagrid" title="Justifications" style="width:auto;padding-top: 10px"
       data-options="pagination:true,
                   singleSelect:true,
                   collapsible:true,
                   url:'datas/justifications.json',
                   method:'get',
                   onClickCell: onClickCell
        ">
    <thead>
    <tr>
        <th data-options="field:'Number',width:80">Number</th>
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
<table id="dg_triples" class="easyui-datagrid" title="triples" style="width:auto;padding-top: 10px"
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
</body>
</html>