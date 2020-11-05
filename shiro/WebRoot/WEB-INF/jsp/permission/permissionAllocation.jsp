<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="cxt" value="${pageContext.request.contextPath }"></c:set>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>权限分配</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
.checkbox{
height: 20;
margin-left: 20px;
}
#checkboxs{
  width: 400px;
  height: 350px;
  overflow: auto;
}
	</style>
<link rel="stylesheet" href="${cxt }/Context/layui/css/layui.css"
	type="text/css"></link>
<script type="text/javascript" src="${cxt }/Context/layui/layui.js"></script>
<script type="text/javascript"
	src="${cxt }/Context/js/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="${cxt}/Context/js/jquery.form.js"></script>
  </head>
  
  <body>
   <form class="layui-form" action="" >
		<div class="layui-form-item">
			<div class="layui-input-inline">
				<input type="text" name="info" placeholder="输入角色名称/ 角色类型" id="info"
					autocomplete="off" class="layui-input">
			</div>
			<button class="layui-btn" id="btn" type="button" onclick="futable()">查 询</button>
		</div>
	</form>
	<table id="infos" lay-filter="permisson"></table>
	<shiro:hasPermission name="permissionallocation:save">
		  <script type="text/html" id="barinfo">
          {{# if(d.id==1){ }}
                 --
            {{# } else { }}
               <a  lay-event="select"><i class="layui-icon" style="font-size: 16px; color: #1E9FFF;">&#xe630;</i>选择角色</a>
            {{# } }}  
          </script>
		</shiro:hasPermission>
		<shiro:lacksPermission name="permissionallocation:save">
		   <script type="text/html" id="barinfo">
                                           --
          </script>
		</shiro:lacksPermission>
		<div id="show" style="display: none;">
		<form class="layui-form layui-form-pane" action="${cxt}/permisson/savePerAllocation" id="saveRoleAllocation" method="post">
		    <input type="hidden" id="rid" name="rId">
		    <div id="checkboxs"></div>
			<hr>
			<div class="layui-form-item layui-form-text btnsave">
				<div class="layui-input-inline">
					<button class="layui-btn" lay-filter="btnsave" lay-submit
						type="button" onclick="">保 存</button>
					<button type="reset" class="layui-btn layui-btn-primary">重
						置</button>
					<input type="checkbox" name="" title="全 选" lay-filter="check">
				</div>
			</div>
		</form>
	</div>
	  <script language="javascript">
	    $(function(){
	      setTimeout(function(){
	           fulayui();//初始化layui
	       },100);//设置setTimeout防止页面刷新太快，没有重新渲染表单（下拉框还有遍历完）
	      futable();//表格初始化
	    })
	   //layui加载事件
	   function fulayui(){
		    layui.use([ 'form', 'layer'], function() {
				var form = layui.form, layer = layui.layer;
				form.render(); //更新全部	
				//监听表单提交
				form.on('submit(btnsave)', function(data){
				       var index = layer.load();
				       var checks=[];
				       var check = $("#checkboxs input[type=checkbox]:checked");
				       $.each(check,function(i){
				           checks.push(check[i].value);
				       })
				        $("#saveRoleAllocation").ajaxSubmit(function(data){
					       if(data.success){
						        layer.msg(data.msg,{icon: 6});
						        layer.closeAll('page');  
						         futable();//刷新表格
					       }else {
						        layer.msg(data.msg,{icon: 7}); 
						   }
					    })
				      layer.close(index);
					return false;
				});
				//监听全选开关
  				form.on('checkbox(check)', function(data){
  				   if(this.checked==true){
  				     $("#checkboxs input[type=checkbox]").attr("checked", true);;
  				   }else{
  				      $("#checkboxs input[type=checkbox]").attr("checked",false);
  				   }
  				   fulayui();//重新渲染表单
  				});
		  });
	    }
	    //加载表格数据
	     function futable(){
	          layui.use('table', function() {
				var table = layui.table;
			    var info=$("#info").val();
		        table.render({
					elem: '#infos'
					,width:886
					,height:473
					,url: '${cxt}/permisson/selectPerAllocation' //数据接口
					,page: true //开启分页
					,where: {info:info}//拼接参数
					,text: {none: '暂无相关数据'} //默认：无数据
					,id: 'infotext'
					,cols: [[ //表头
						{title: '序号', type:'numbers', width:70 ,fixed: 'left'}
						,{type:'checkbox',height:20}
						,{title: '角色名称', width:100,templet: function(d){
                           return d.name
                         }}
						,{title: '角色类型', width:180,sort: true,templet: function(d){
                           return d.type
                         }}
						,{title: '拥有的权限', width:330,sort: true,templet: function(d){
						   var str="";
						   $.each(d.permission,function(i){
						      if(i!=d.permission.length-1){
						        str+=d.permission[i].name+" , "
						      }else{
						        str+=d.permission[i].name
						      }
						   })
                           return str
                         }}
						,{fixed: 'right', title: '操作',width:150, align:'center', toolbar: '#barinfo'} //这里的toolbar值是模板元素的选择器
					]]
				});
				
				//监听工具条
				table.on('tool(permisson)', function(obj){ //注：tool是工具条事件名，info是table原始容器的属性 lay-filter="对应的值"
				    $("#rid").val(obj.data.id)
					var data = obj.data.permission; //获得当前行permission数据
					var ids=[];
					$.each(data,function(i){
					   ids.push(data[i].id);
					})
					var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
					    if(layEvent === 'select'){ //选择角色
							layer.open({
								type : 1,
								area : [ "400px", "500px" ],
								content : $('#show'),
								title : '选择权限',
								shade: [0.1, '#fff']
							});
							 $.post("${cxt}/permisson/selectPermissonList",function(d){ 
							    $("#checkboxs").empty();
					            d=d.data;
					            $.each(d,function(i){
					                 var id=d[i].id;
					                 $("#checkboxs").append('<div class="layui-form-item checkbox"><input type="checkbox" name="perIds"'+
					                       'id=checkbox'+id+' value='+d[i].id+' title='+d[i].name+' lay-skin="primary"  ></div>');
					                 if(ids.indexOf(id)>-1){
					                     $("#checkbox"+id).attr("checked",true);
					                 } 
					            })
					             fulayui();//重新渲染复选框
					        })
				       } 
			    });
		    })
	     }
	</script>
  </body>
</html>
