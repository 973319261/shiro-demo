<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<title>登 录</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="${cxt}/Context/layui/css/layui.css"
	type="text/css"></link>
<link rel="stylesheet" href="${cxt}/Context/layui/css/layui.css"
	type="text/css"></link>
<script type="text/javascript" src="${cxt}/Context/layui/layui.js"></script>
<script type="text/javascript"
	src="${cxt}/Context/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="${cxt}/Context/js/jquery.form.js"></script>
</head>
<body>
	<center>
		<div>
			<div style="float: letf">
				<p>
					你好，欢迎！<a href="${cxt }/user/page?page=login">[请登录] </a><a
						href="${cxt }/user/page?page=user/register">[免费注册]</a>
				</p>
			</div>
		</div>
		<div style="margin: 50px 40%;width: 400px;height: 300px">
			<form class="layui-form" action="${cxt}/user/login" method="post"
				autocomplete="off" id="Login">
				<div class="layui-form-item">
					<label class="layui-form-label">用户名：</label>
					<div class="layui-input-inline">
						<input type="text" name="username" required lay-verify="required"
							id="uname" placeholder="请输入用户" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">密码：</label>
					<div class="layui-input-inline">
						<input type="password" name=password required id="passwd"
							lay-verify="required" placeholder="请输入密码" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item" style="margin-left: 100px;">
					<div class="layui-input-inline">
						<input class="layui-btn" value="登 录" type="button" id="btn">
						<a href="${cxt }/user/page?page=user/register"
							class="layui-btn layui-btn-primary">注 册</a>
					</div>
				</div>
			</form>
		</div>

	</center>
	<script type="text/javascript">
		$(function() {
			//嵌套登陆问题
			if (top != window) {
				top.location.href = window.location.href;
			}
		})
		layui.use([ 'layer', 'form', 'jquery' ], function() {
			var layer = layui.layer, form = layui.form;
		});
		$("#btn")
				.click(
						function() {
							var uname = $("#Login [name='username']").val();
							var passwd = $("#Login [name='password']").val();
							if (uname != "") {
								if (passwd != "") {
									$("#Login")
											.ajaxSubmit(
													function(data) {
														if (data.success) {
															window.location.href = "${cxt}/user/page?page=main";
														} else {
															layer.msg(data.msg);
														}
													})
								} else {
									layer.tips("密码不能为空", "#passwd", {
										tips : 2
									});
								}
							} else {
								layer.tips("用户名不能为空", "#uname", {
									tips : 2
								});
							}
						})
	</script>
</body>

</html>
