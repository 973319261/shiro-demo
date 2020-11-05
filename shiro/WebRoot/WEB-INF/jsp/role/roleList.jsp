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
    
    <title>角色列表</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
.show{
  margin:10px 50px;
  padding:5px;
  border: 1px solid #eee;
}
#addListRole{
padding-left: 10px
}
</style>
  </head>
  <link rel="stylesheet" href="${cxt }/Context/layui/css/layui.css"
	type="text/css"></link>
<script type="text/javascript" src="${cxt }/Context/layui/layui.js"></script>
<script type="text/javascript"
	src="${cxt }/Context/js/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="${cxt}/Context/js/jquery.form.js"></script>
  <body>
     <form class="layui-form" action="" >
		<div class="layui-form-item">
			<div class="layui-input-inline">
				<input type="text" name="info" placeholder="输入角色类型 / 角色名称" id="info"
					autocomplete="off" class="layui-input">
			</div>
			<button class="layui-btn" id="btn" type="button" onclick="futable()">查 询</button>
			
			<shiro:hasPermission name="rolelist:delete">
			  <button class="layui-btn layui-btn-danger btnTable" type="button"  data-type="deleteInfo">删除</button>
			</shiro:hasPermission>
		    <shiro:hasPermission name="rolelist:export">
		      <button class="layui-btn layui-btn-warm" type="button" onclick="exportToExcel()">导 出</button>
		    </shiro:hasPermission>
		   <shiro:hasPermission name="rolelist:import">
		       <button type="button" class="layui-btn" id="importToExcel"><i class="layui-icon">&#xe67c;</i>导 入</button>
		   </shiro:hasPermission>
		</div>
	</form>
	<div>
	<div id="show" class="" style="float: left;">
	  <table id="infos" lay-filter="role"></table>
		<shiro:hasPermission name="rolelist:delete">
		  <script type="text/html" id="barinfo">
            {{# if(d.id==1){ }}
                 --
            {{# } else { }}
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            {{# } }}  
          </script>
		</shiro:hasPermission>
		<shiro:lacksPermission name="rolelist:delete">
		   <script type="text/html" id="barinfo">
                                           --
          </script>
		</shiro:lacksPermission>
	</div>
	<shiro:hasPermission name="rolelist:add">
			   <div id="show" class="show" style="float: left;">
      <fieldset class="layui-elem-field">
		<legend>增加角色</legend>
		<form class="layui-form layui-form-pane" action="${cxt }/role/addListRole" id="addListRole"
		  method="post">
		    <input type="hidden" name="id" value="0" > 
			<div class="layui-form-item">
				<label class="layui-form-label">角色名称</label>
				<div class="layui-input-inline">
					<input type="text" name="name" required lay-verify="required"
						placeholder="请输入角色名称" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">角色类型</label>
				<div class="layui-input-inline">
					<input type="text" name="type" required lay-verify="required"
						placeholder="请输入角色类型" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item layui-form-text" >
				<div class="layui-input-inline">
					<button class="layui-btn" lay-filter="btnsave" lay-submit
						type="button" onclick="">保 存</button>
					<button type="reset" id="reset" class="layui-btn layui-btn-primary">重
						置</button>
				</div>
			</div>
		</form>
		</fieldset>
	</div>
   </shiro:hasPermission>
	</div>
	
    <script language="javascript">
	    $(function(){
	      setTimeout(function(){
	           fulayui();//初始化layui
	       },100);//设置setTimeout防止页面刷新太快，没有重新渲染表单（下拉框还有遍历完）
	      futable();//表格初始化
	    })
	    layui.use('upload', function() {
	        var upload=layui.upload;
	        //导入Excel
			var uploadInst = upload.render({
				elem: '#d' //绑定元素
				,url: '${cxt}/role/importExcel' //上传接口
				,accept: 'file' //普通文件
                ,exts: 'xls' //只允许上传xls文件
                ,before: function(obj){ //obj参数包含的信息，跟 choose回调完全一致，可参见上文。
				 layer.load(); //上传loading
				}
				,done: function(data){
				var index = layer.load();
				if(data.success){
				  layer.msg(data.msg,{icon: 6});
				  futable();//重新加载表格
				}else{
				  layer.msg(data.msg,{icon: 7});
				}
				 layer.closeAll('loading'); //关闭loading
				}
				,error: function(res){
			   	 layer.closeAll('loading'); //关闭loading
				 //重新上传的方法
				 layer.confirm('上传失败，请检查模板格式或者尝试重新上传', {btn:['重新上传','取消'],icon: 3, title:'提示',shade: [0.1, '#fff']}, function(index){
					layer.close(index);
				    uploadInst.upload(); 
				});
			    }
			});
	    })
	   //layui加载事件
	   function fulayui(){
		    layui.use([ 'form', 'layer'], function() {
				var form = layui.form, layer = layui.layer;
				//监听表单提交
				form.on('submit(btnsave)', function(data){
				       var index = layer.load();
					   $("#addListRole").ajaxSubmit(function(data){
					       if(data.success){
						        layer.msg(data.msg,{icon: 6}); 
						           reset();//重置表单
						         futable();//刷新表格
					       }else {
						        layer.msg(data.msg,{icon: 7}); 
						   }
						   layer.close(index);
					   })
					return false;
				});
				//表单检验
				form.verify({
					number: [
					/^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$/
					,'只能输入数字'
				]
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
					,width:532
					,height:473
					,url: '${cxt}/role/selectRoleList' //数据接口
					,page: true //开启分页
					,where: {info:info,userId:${user.id}}//拼接参数
					,text: {none: '暂无相关数据'} //默认：无数据
					,id: 'infotext'
					,cols: [[ //表头
						{title: '序号', type:'numbers', width:70 ,fixed: 'left'}
						,{type:'checkbox',height:20}
						,{field: 'name', title: '名称', width:154,<shiro:hasPermission name="rolelist:add"> edit: 'text'</shiro:hasPermission>}
						,{field: 'type', title: '类型', width:154,<shiro:hasPermission name="rolelist:add"> edit: 'text',</shiro:hasPermission>sort: true}
						,{fixed: 'right', title: '操作',width:100, align:'center', toolbar: '#barinfo'} //这里的toolbar值是模板元素的选择器
					]]
				});
				//监听单元格编辑
				 table.on('edit(role)', function(obj){
				    var data = obj.data //得到所在行所有键值
				    $.ajax({
		                type: "POST",
		                url: "${cxt}/role/updateListRole",
		                data: data,
		                dataType: "json", //这里返回的类型为字符串类型
		               // contentType:"multipart/form-data",
		                success: function (data) {
		                    if(data.success){
		                     layer.msg(data.msg,{icon: 6}); 
		                    }else{
		                      layer.msg(data.msg,{icon: 7}); 
		                    }
						   
		                },
		                error: function (data) {
		                    layer.msg(data.msg,{icon: 7}); 
		                }
                    });
                });
				//监听工具条
				table.on('tool(role)', function(obj){ //注：tool是工具条事件名，info是table原始容器的属性 lay-filter="对应的值"
					var data = obj.data; //获得当前行数据
					var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
					var tr = obj.tr; //获得当前行 tr 的DOM对象
					var id=data.id;
					    if(layEvent === 'del'){ //删除
							layer.confirm('确定删除行吗?',{shade: 0}, function(index){
							//向服务端发送删除指令
							 $.post("${cxt}/role/deleteRoleListById?ids="+id,function(data){
							    if(data.success){
							       layer.msg(data.msg);
							        obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
							       futable();
							    }else{
							       layer.msg(data.msg);
							    }
							 })
							 layer.close(index);
						  });
						} 
			    });
			    //添加按钮事件
			      active = {
					  deleteInfo: function(){ //获取选中数据进行批量删除
					    var data = table.checkStatus('infotext').data;
					     var delId=[];
					    $.each(data,function(i){
					       delId.push(data[i].id);//把选择的id添加到数组中
					    });
					    if(delId.length > 0){
					       if(delId.indexOf(1)){
					            var index = layer.load();
					           layer.confirm('确定删除选择的行吗?',{shade: 0}, function(index){
								 $.ajax({
					                type: "POST",
					                url: "${cxt}/role/deleteRoleListById",
					                data: {ids:delId},
					                traditional:true,//阻止jquery对数组序列化
					                dataType: "json", 
					                success: function (data) {
					                     if(data.success){
					                        layer.msg(data.msg,{icon: 6}); 
					                        futable();
					                     }else{
					                        layer.msg(data.msg,{icon: 7}); 
					                     }
					                    
					                     layer.closeAll('loading'); //关闭loading
					                },
					                error: function (data) {
					                    layer.msg(data.msg,{icon: 7}); 
					                    layer.closeAll('loading'); //关闭loading
					               }
		                        });
								   layer.close(index);
							  });  
					       }else{
					          layer.msg("系统管理员不能删除！");
					       }
				      }else{
				         layer.msg("请选择要删除的数据！");
				      } 
				   }
				};
		    })
	     }
	    //导出到Excle表格
	    function exportToExcel(){
	     layer.confirm('确定导出当前数据到本地?',{shade: [0.1, '#fff']}, function(index){
			  window.open("${cxt}/role/exportExcel");//打开下载链接
			  layer.close(index);
		   });
	    }
		//重置表单
		function reset() {
		  $("#reset").click();//重置表单
		}
		 //注册按钮事件
	    $('.btnTable').on('click', function(){
		  var type = $(this).data('type');
		  active[type] ? active[type].call(this) : '';
		});
	</script>
  </body>
</html>
