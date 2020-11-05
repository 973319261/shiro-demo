<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="cxt" value="${pageContext.request.contextPath }"></c:set>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>主 页 面</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="${cxt }/Context/layui/css/layui.css"
	type="text/css"></link>
<script type="text/javascript" src="${cxt }/Context/layui/layui.js"></script>
<script type="text/javascript"
	src="${cxt }/Context/js/jquery-3.3.1.min.js"></script>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<div class="layui-header">
			<div class="layui-logo">SSM Shiro DEMO 演示 </div>
			<!-- 头部区域（可配合layui已有的水平导航） -->
			<ul class="layui-nav layui-layout-left">
				<li class="layui-nav-item"><a href="javascript:;">个人中心</a>
					<dl class="layui-nav-child">
						<dd class="myInfo">
							<a href="javascript:;">个人资料</a>
						</dd>
						<dd class="updateInfo">
							<a href="javascript:;">资料修改</a>
						</dd>
						<dd class="updatePass">
							<a href="javascript:;">密码修改</a>
						</dd>
						<dd class="myPermission">
							<a href="javascript:;">我的权限</a>
						</dd>
					</dl></li>
					<shiro:hasPermission name="user:view">
				      <li class="layui-nav-item userList"><a href="javascript:;">用户列表</a></li>
					</shiro:hasPermission>
				<li class="layui-nav-item"><a href="javascript:;">权限管理</a>
					<dl class="layui-nav-child">
					<shiro:hasPermission name="rolelist:view">
					    <dd class="roleList">
							<a href="javascript:;">角色列表</a>
						</dd>
					</shiro:hasPermission>
					<shiro:hasPermission name="roleallocation:view">
					    <dd class="roleAllocation">
							<a href="javascript:;">角色分配</a>
						</dd>
					</shiro:hasPermission>
					<shiro:hasPermission name="permissionlist:view">
					    <dd class="permissionList">
							<a href="javascript:;">权限列表</a>
						</dd>
					</shiro:hasPermission>
				    <shiro:hasPermission name="permissionallocation:view">
				        <dd class="permissionAllocation">
							<a href="javascript:;">权限分配</a>
						</dd>
				    </shiro:hasPermission>
					</dl></li>
			</ul>
			<ul class="layui-nav layui-layout-right">
				<li class="layui-nav-item"><a href="javascript:;"> <shiro:principal
							defaultValue="未登陆" property="nickname" />
				</li>
				<li class="layui-nav-item" id="logout"><a href="javascript:;">注
						销</a>
				</li>
			</ul>
		</div>
		<div class="layui-side layui-bg-black">
			<div class="layui-side-scroll">
				<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
				<ul class="layui-nav layui-nav-tree" lay-filter="test">
					<li class="layui-nav-item layui-nav-itemed"><a class=""
						href="javascript:;">个人中心</a>
						<dl class="layui-nav-child">
							<dd class="myInfo">
								<a href="javascript:;">个人资料</a>
							</dd>
							<dd class="updateInfo">
								<a href="javascript:;">资料修改</a>
							</dd>
							<dd class="updatePass">
								<a href="javascript:;">密码修改</a>
							</dd>
							<dd class="myPermission">
								<a href="javascript:;">我的权限</a>
							</dd>
						</dl></li>
					<shiro:hasPermission name="user:view">
				      <li class="layui-nav-item userList"><a href="javascript:;">用户列表</a></li>
					</shiro:hasPermission>
					<li class="layui-nav-item layui-nav-itemed"><a
						href="javascript:;">权限管理</a>
						<dl class="layui-nav-child">
						   <shiro:hasPermission name="rolelist:view">
						      <dd class="roleList">
								<a href="javascript:;">角色列表</a>
							  </dd>
						   </shiro:hasPermission>
							<shiro:hasPermission name="roleallocation:view">
							   <dd class="roleAllocation">
								<a href="javascript:;">角色分配</a>
							   </dd>
							</shiro:hasPermission>
							<shiro:hasPermission name="permissionlist:view">
							  <dd class="permissionList">
								<a href="javascript:;">权限列表</a>
							  </dd>
							</shiro:hasPermission>
							<shiro:hasPermission name="permissionallocation:view">
							 <dd class="permissionAllocation">
								<a href="javascript:;">权限分配</a>
							</dd>
							</shiro:hasPermission>
						</dl></li>
				</ul>
			</div>
		</div>
		<div class="layui-body">
			<!-- 内容主体区域 -->
			<div style="padding: 15px;">
				<iframe id="content"
					style="display: block;width:100%;border:none;height:95%;"
					src=""></iframe>
			</div>
		</div>
		<div class="layui-footer">
			<!-- 底部固定区域 -->
			版权所有 - @capy
		</div>
	</div>

	<script>
		//JavaScript代码区域
		layui.use('element', function() {
			var element = layui.element;
		});
	   //我的信息
       $(".myInfo").click(function () {
           $("#content").attr("src", "${cxt}/user/page?page=user/myInfo");
       });
       //资料修改
       $(".updateInfo").click(function () {
           $("#content").attr("src", "${cxt}/user/page?page=user/updateInfo");
       });
       //修改密码
       $(".updatePass").click(function () {
           $("#content").attr("src", "${cxt}/user/page?page=user/updatePassword");
       });
        //我的权限
       $(".myPermission").click(function () {
           $("#content").attr("src", "${cxt}/permisson/selectPermissonById?userId=${user.id}");
       });
       //用户列表
       $(".userList").click(function(){
		 $("#content").attr("src", "${cxt}/user/page?page=user/userList");
      });
       //角色列表
        $(".roleList").click(function () {
           $("#content").attr("src", "${cxt}/user/page?page=role/roleList");
       });
       //角色分配
       $(".roleAllocation").click(function () {
           $("#content").attr("src", "${cxt}/user/page?page=role/roleAllocation");
       });
       //权限列表
        $(".permissionList").click(function () {
           $("#content").attr("src", "${cxt}/user/page?page=permission/permissionList");
       });
       //权限分配
       $(".permissionAllocation").click(function () {
           $("#content").attr("src", "${cxt}/user/page?page=permission/permissionAllocation");
       });
       //注销
       $("#logout").click(function(){
           window.location.href="${cxt}/user/logout";
		})
	</script>
</body>
</html>
