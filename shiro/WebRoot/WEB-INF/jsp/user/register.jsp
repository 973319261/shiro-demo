<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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

<title>My JSP 'register.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>
<link rel="stylesheet" href="${cxt}/Context/layui/css/layui.css"
	type="text/css"></link>
<link rel="stylesheet" href="${cxt}/Context/layui/css/layui.css"
	type="text/css"></link>
<script type="text/javascript" src="${cxt}/Context/layui/layui.js"></script>
<script type="text/javascript"
	src="${cxt}/Context/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="${cxt}/Context/js/jquery.form.js"></script>
<body>
	<div style="margin:50px 42%;width: 400px">
		<p style="font-size: 20px;color: red;text-align:center;height: 40px">会员注册</p>
		<form class="layui-form" action="${cxt}/user/register"
			method="post" id="Register">
			<div class="layui-form-item">
				<label class="layui-form-label">用户名：</label>
				<div class="layui-input-inline">
					<input type="text" name="nickname" required lay-verify="required"
						id="uname" placeholder="请输入用户" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">登录密码：</label>
				<div class="layui-input-inline">
					<input type="password" name="pswd" required lay-verify="required"
						id="passwd" placeholder="请输入密码" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">确认密码：</label>
				<div class="layui-input-inline">
					<input type="password" name="passwd1" required id="passwd1"
						lay-verify="required" placeholder="请输入密码" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">电子邮箱：</label>
				<div class="layui-input-inline">
					<input type="text" name="email" required lay-verify="required"
						id="email" placeholder="请输入邮箱" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item" style="margin-left: 110px;width: 90px">
				<div class="layui-input-inline">
					<input class="layui-btn" lay-filter="*" type="button" value="提 交"
						id="btn"> <a class="layui-btn layui-btn layui-btn-primary"
						href="${cxt }/user/page?page=login">返 回 登 录</a>
				</div>
			</div>
		</form>
	</div>

</body>
<script type="text/javascript">
	layui.use([ 'layer', 'form' ], function() {
		var layer = layui.layer, form = layui.form;
	});
	//提交事件
	$("#btn").click(function() {
		var uname = $("#Register [name='nickname']").val();
		var passwd = $("#Register [name='pswd']").val();
		var passwd1 = $("#Register [name='passwd1']").val();
		var email = $("#Register [name='email']").val();
		if (uname != "") {
			if (passwd != "") {
				if (passwd1 != "") {
					if (passwd == passwd1) {
						if (email != "") {
							$("#Register").ajaxSubmit(function(data) {
								if (data.success) {
									$("#Register").resetForm();
								}
								layer.msg(data.msg);
							})
						} else {
							layer.tips("邮箱不能为空", "#email", {
								tips : 2
							});
						}
					} else {
						layer.tips("密码不一致", "#passwd1", {
							tips : 2
						});
					}
				} else {
					layer.tips("确认密码不能为空", "#passwd1", {
						tips : 2
					});
				}
			} else {
				layer.tips("登录密码不能为空", "#passwd", {
					tips : 2
				});
			}
		} else {
			layer.tips("用户不能为空", "#uname", {
				tips : 2
			});
		}
	})
</script>
</html>
