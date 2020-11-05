<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cxt" value="${pageContext.request.contextPath }" />
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

<title>My JSP 'updateInfo.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>
<link rel="stylesheet" href="${cxt }/Context/layui/css/layui.css"
	type="text/css"></link>
<script type="text/javascript" src="${cxt }/Context/layui/layui.js"></script>
<script type="text/javascript"
	src="${cxt }/Context/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="${cxt }/Context/js/jquery.form.js"></script>
<body>
	<fieldset class="layui-elem-field">
		<legend>修改基本信息</legend>
		<div class="layui-field-box">
			<form class="layui-form" id="UpdateInfo"
				action="${cxt}/user/updateInfo" method="post">
				<input name="id" type="hidden" value="${user.id }">
				<div class="layui-form-item">
					<label class="layui-form-label">用户名：</label>
					<div class="layui-input-inline">
						<input type="text" name="nickname" required lay-verify="required"
							id="uname" autocomplete="off" class="layui-input"
							value="${user.nickname }">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">电子邮箱：</label>
					<div class="layui-input-inline">
						<input type="text" name="email" required lay-verify="required"
							id="email" disabled="disabled" autocomplete="off"
							class="layui-input" value="${user.email }">
					</div>
				</div>
				<div class="layui-form-item" style="margin-left: 110px;width: 50px">
					<input class="layui-btn" value="修  改" type="button" id="btn" />
				</div>
			</form>
		</div>
	</fieldset>
	<script type="text/javascript">
		layui.use([ 'layer', 'form' ], function() {
			var layer = layui.layer, form = layui.form;
		});
		//提交事件
		$("#btn").click(function() {
			var uname = $("#UpdateInfo [name='nickname']").val();
			if (uname != "") {
				$("#UpdateInfo").ajaxSubmit(function(data) {
				    var load = layer.load(0);
					if (data.success) {
						layer.alert(data.msg, {shade: 0},function(index) {
							layer.close(index);
							window.location.href="${cxt}/user/logout";
						});
					} else {
						layer.msg(data.msg);
					}
					layer.close(load);
				})
			} else {
				layer.tips("用户名不能为空", "#uname", {
					tips : 2
				});
			}
		})
	</script>
</body>
</html>
