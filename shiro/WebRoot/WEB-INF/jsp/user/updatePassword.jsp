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

<title>My JSP 'updatePassword.jsp' starting page</title>

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
		<legend>修改密码</legend>
		<div class="layui-field-box">
			<form class="layui-form" id="UpdatePass" method="post"
				action="${cxt}/user/updatePassword">
				<input type="hidden" name="id" value="${user.id }">
				<div class="layui-form-item">
					<label class="layui-form-label">旧密码：</label>
					<div class="layui-input-inline">
						<input type="password" name="oldPassword" required id="oldpasswd"
							lay-verify="required" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">新密码：</label>
					<div class="layui-input-inline">
						<input type="password" name="pswd" required id="newpasswd"
							lay-verify="required" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">确认密码：</label>
					<div class="layui-input-inline">
						<input type="password" name="newpasswd1" required id="newpasswd1"
							lay-verify="required" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item" style="margin-left: 110px;width: 50px">
					<button class="layui-btn" lay-filter="formDemo" value="修 改"
						type="button" id="btn">提 交</button>
				</div>
			</form>
		</div>
	</fieldset>
	<script type="text/javascript" language="javascript">
		layui.use([ 'layer', 'form' ], function() {
			var layer = layui.layer, form = layui.form;
		});
		//提交事件
		$("#btn")
				.click(
						function() {
							var oldpasswd = $(
									"#UpdatePass [name='oldPassword']").val();
							var newpasswd = $("#UpdatePass [name='pswd']")
									.val();
							var newpasswd1 = $(
									"#UpdatePass [name='newpasswd1']").val();
							if (oldpasswd != "") {
								if (newpasswd != "") {
									if (newpasswd1 != "") {
										if (newpasswd == newpasswd1) {
											$("#UpdatePass")
													.ajaxSubmit(
															function(data) {
																var load = layer
																		.load(0);
																if (data.success) {
																	layer
																			.alert(
																					data.msg,
																					{
																						shade : 0
																					},
																					function(
																							index) {
																						layer
																								.close(index);
																						window.location.href = "${cxt}/user/logout";
																					});
																} else {
																	layer
																			.msg(data.msg);
																}
																layer
																		.close(load);
															})
										} else {
											layer.tips("与新密码不一致",
													"#newpasswd1", {
														tips : 2
													});
										}
									} else {
										layer.tips("确认密码不能为空", "#newpasswd1", {
											tips : 2
										});
									}
								} else {
									layer.tips("新密码不能为空", "#newpasswd", {
										tips : 2
									});
								}
							} else {
								layer.tips("旧密码不能为空", "#oldpasswd", {
									tips : 2
								});
							}

						})
	</script>
</body>
</html>
