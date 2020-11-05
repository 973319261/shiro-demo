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
    
    <title>My JSP 'roleAllocation.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
.checkbox{
height: 20;
margin-left: 20px;
}
#checkboxs{
  width: 400px;
  height: 133px;
  overflow: auto;
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
				<input type="text" name="info" placeholder="输入用户昵称/ 用户账号" id="info"
					autocomplete="off" class="layui-input">
			</div>
			<button class="layui-btn" id="btn" type="button" onclick="futable()">查 询</button>
			<shiro:hasPermission name="roleallocation:clear">
			  <button class="layui-btn layui-btn-danger btnTable" type="button"  data-type="clearRoleAllocation">清空用户角色</button>
			</shiro:hasPermission>
		</div>
	</form>
	<div>
	  <table id="infos" lay-filter="role"></table>
		<shiro:hasPermission name="roleallocation:add">
		  <script type="text/html" id="barinfo">
          {{# if(d.role.length>0){}}
        	{{# layui.each(d.role, function(index, item){ }}
            {{# if(item.id==1){ }}
                 --
            {{# } else { }}
               <a  lay-event="select"><i class="layui-icon" style="font-size: 16px; color: #1E9FFF;">&#xe630;</i>选择角色</a>
                {{# return true}}   
            {{# } }}  
              {{# return true}}   
            {{#  })}}
          {{# } else{}}
             <a  lay-event="select"><i class="layui-icon" style="font-size: 16px; color: #1E9FFF;">&#xe630;</i>选择角色</a>
          {{# }}}
          </script>
		</shiro:hasPermission>
		<shiro:lacksPermission name="roleallocation:add">
		   <script type="text/html" id="barinfo">
                                           --
          </script>
		</shiro:lacksPermission>
	</div>
	<div id="show" style="display: none;">
		<form class="layui-form layui-form-pane" action="${cxt}/role/saveRoleAllocation" id="saveRoleAllocation" method="post">
		    <input type="hidden" id="uid" name="uId">
		    <div id="checkboxs"></div>
			<hr>
			<div class="layui-form-item layui-form-text btnsave">
				<div class="layui-input-inline">
					<button class="layui-btn" lay-filter="btnsave" lay-submit
						type="button" onclick="">保 存</button>
					<button type="reset" id="reset" class="layui-btn layui-btn-primary">重
						置</button>
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
				       if(checks.indexOf("1")>-1 && check.length > 1){
				          layer.msg("选择了系统管理员,就不能选择其他角色",{icon: 7}); 
				       }else{
				           $("#saveRoleAllocation").ajaxSubmit(function(data){
					       if(data.success){
						        layer.msg(data.msg,{icon: 6});
						        layer.closeAll('page');  
						         futable();//刷新表格
					       }else {
						        layer.msg(data.msg,{icon: 7}); 
						   }
					    })
				      }
				      layer.close(index);
					return false;
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
					,url: '${cxt}/role/selectRoleAllocation' //数据接口
					,page: true //开启分页
					,where: {info:info}//拼接参数
					,text: {none: '暂无相关数据'} //默认：无数据
					,id: 'infotext'
					,cols: [[ //表头
						{title: '序号', type:'numbers', width:70 ,fixed: 'left'}
						,{type:'checkbox',height:20}
						,{title: '用户昵称', width:100,templet: function(d){
                           return d.nickname
                         }}
						,{title: 'Email/帐号', width:180,sort: true,templet: function(d){
                           return d.email
                         }}
						,{title: '状态', width:80,sort: true,templet: function(d){
                           return d.status=="1"?"有效":"无效"
                         }}
						,{title: '拥有的角色', width:250,sort: true,templet: function(d){
						   var str="";
						   $.each(d.role,function(i){
						      if(i!=d.role.length-1){
						        str+=d.role[i].name+" , "
						      }else{
						        str+=d.role[i].name
						      }
						   })
                           return str
                         }}
						,{fixed: 'right', title: '操作',width:150, align:'center', toolbar: '#barinfo'} //这里的toolbar值是模板元素的选择器
					]]
				});
				//监听工具条
				table.on('tool(role)', function(obj){ //注：tool是工具条事件名，info是table原始容器的属性 lay-filter="对应的值"
				    $("#uid").val(obj.data.id)
					var data = obj.data.role; //获得当前行role数据
					var ids=[];
					$.each(data,function(i){
					   ids.push(data[i].id);
					})
					var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
					    if(layEvent === 'select'){ //选择角色
							layer.open({
								type : 1,
								area : [ "400px", "250px" ],
								content : $('#show'),
								title : '添加角色',
								shade: [0.1, '#fff']
							});
							 $.post("${cxt}/role/selectRoleList",function(d){ 
							    $("#checkboxs").empty();
					            d=d.data;
					            $.each(d,function(i){
					                 var id=d[i].id;
					                 $("#checkboxs").append('<div class="layui-form-item checkbox"><input type="checkbox" name="roleIds"'+
					                       'id=checkbox'+id+' value='+d[i].id+' title='+d[i].name+' lay-skin="primary"  ></div>');
					                 if(ids.indexOf(id)>-1){
					                     $("#checkbox"+id).attr("checked",true);
					                 } 
					            })
					             fulayui();//重新渲染复选框
					        })
					       
						} 
			    });
			    //添加按钮事件
			      active = {
					  clearRoleAllocation: function(){ //获取选中数据进行批量删除
					    var data = table.checkStatus('infotext').data;
					    var roleId=[],delId=[];
					    $.each(data,function(i){
					       delId.push(data[i].id);//把选择的id添加到数组中
					       roleId.push(data[i].role[0].id)//存储要删除的数据id
					    });
					   if(delId.length > 0){
					     if(roleId.indexOf(1)){//判断是否为系统管理员
					        var index = layer.load();
						    layer.confirm('确定清空选择的行吗?',{shade: 0}, function(index){
							 $.ajax({
				                type: "POST",
				                url: "${cxt}/role/deleteRoleAllocationByUseRId",
				                data: {userIds:delId},
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
						     })
						      layer.close(index);
					     }else{
					        layer.msg("系统管理员不能清空！");
					     }
				      }else{
				         layer.msg("请选择要清空的用户！");
				      } 
				   }
				};
		    })
	     }
        //注册按钮事件
	    $('.btnTable').on('click', function(){
		  var type = $(this).data('type');
		  active[type] ? active[type].call(this) : '';
		});
	</script>
  </body>
</html>
