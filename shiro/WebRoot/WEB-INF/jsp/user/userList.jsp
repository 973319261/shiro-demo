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
				<input type="text" name="info" placeholder="输入用户昵称" id="info"
					autocomplete="off" class="layui-input">
			</div>
			<button class="layui-btn" id="btn" type="button" onclick="futable()">查 询</button>
			<shiro:hasPermission name="user:delete">
			  <button class="layui-btn layui-btn-danger btnTable" type="button"  data-type="deleteUser">删 除</button>
			</shiro:hasPermission>
		</div>
	</form>
	<div>
	  <table id="infos" lay-filter="user"></table>
	   
	  <script type="text/html" id="barinfo">
		<shiro:hasPermission name="user:forbid">
             {{# if(d.id==1){ }}
                 --
            {{# } else { }}
            {{# if(d.status==1){ }}
                 <a  lay-event="status"><i class="layui-icon" style="font-size: 16px; color: #1E9FFF;">&#xe69c;</i> 禁止登录</a>
            {{# } else { }}
               <a  lay-event="status"><i class="layui-icon" style="font-size: 16px; color: #1E9FFF;">&#xe6af;</i> 激活登录</a>
            {{# } }}  
           
		</shiro:hasPermission>
        <shiro:hasPermission name="user:delete">
             <a  lay-event="delete"> 删 除</a>
  		</shiro:hasPermission>
       {{# } }}  
		</script>
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
		  });
	    }
	    //加载表格数据
	     function futable(){
	          layui.use('table', function() {
				var table = layui.table;
			    var info=$("#info").val();
		        table.render({
					elem: '#infos'
					,width:1078
					,height:473
					,url: '${cxt}/user/selectUserList' //数据接口
					,page: true //开启分页
					,where: {info:info}//拼接参数
					,text: {none: '暂无相关数据'} //默认：无数据
					,id: 'infotext'
					,cols: [[ //表头
						{title: '序号', type:'numbers', width:70 ,fixed: 'left'}
						,{type:'checkbox',height:20}
						,{field:'nickname',title: '用户昵称', width:100}
						,{field:'email',title: 'Email/帐号', width:180,sort: true}
						,{title: '登录状态', width:120,sort: true,templet: function(d){
                           return d.status==1?"有效":"无效"
                         }}
						,{field:'createTime',title: '创建时间', width:200,sort: true}
						,{field:'lastLoginTime',title: '最后登录时间', width:200,sort: true}
						,{fixed: 'right', title: '操作',width:150, align:'center', toolbar: '#barinfo'} //这里的toolbar值是模板元素的选择器
					]]
				});
				//监听工具条
				table.on('tool(user)', function(obj){ //注：tool是工具条事件名，info是table原始容器的属性 lay-filter="对应的值"
					var data = obj.data; //获得当前行role数据
					console.log(data);
					var id=data.id;
					var status=data.status==1?0:1;
					var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
					    if(layEvent === 'status'){ //改变登录状态
						   layer.confirm(status==1?"确定启用这个用户?":"确定禁止这个用户?",{shade: 0}, function(index){
							   $.post("${cxt}/user/updateUserStatuByUserId?id="+id+"&status="+status,function(data){
							    if(data.success){
							       layer.msg(data.msg);
							        obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
							       futable();
							    }else{
							       layer.msg(data.msg);
							    }
							 })
							 layer.close(index);
						    })
						} else if(layEvent === 'delete'){ //改变登录状态
							 layer.confirm("确定删除该用户?",{shade: 0}, function(index){
							   //向服务端发送删除指令
							  $.post("${cxt}/user/deleteUserByUserId?userIds="+id,function(data){
							    if(data.success){
							       layer.msg(data.msg);
							        obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
							       futable();
							    }else{
							       layer.msg(data.msg);
							    }
							 })
							 layer.close(index);
							 })
						} 
			    });
			    //添加按钮事件
			      active = {
					  deleteUser: function(){ //获取选中数据进行批量删除
					    var data = table.checkStatus('infotext').data;
					    var delId=[];
					    $.each(data,function(i){
					       delId.push(data[i].id);//把选择的id添加到数组中
					    });
					   if(delId.length > 0){
					     if(delId.indexOf(1)){//判断是否为系统管理员
					        var index = layer.load();
						    layer.confirm('确定删除选择的行吗?',{shade: 0}, function(index){
							 $.ajax({
				                type: "POST",
				                url: "${cxt}/user/deleteUserByUserId",
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
					        layer.msg("系统管理员不能删除！");
					     }
				      }else{
				         layer.msg("请选择要删除的用户！");
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
