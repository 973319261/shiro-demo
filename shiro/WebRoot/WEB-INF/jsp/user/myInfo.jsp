<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cxt" value="${pageContext.request.contextPath }"/>
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

<title>个人资料</title>

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
<script type="text/javascript" src="${cxt }/Context/js/jquery-3.3.1.min.js"></script>
<body>
	<fieldset class="layui-elem-field">
		<legend>个人信息</legend>
		<div class="layui-field-box" >
			<table class="layui-table" >
				<colgroup >
					<col width="20">
					<col width="20">
					<col>
				</colgroup>

				<tbody>
					<tr>
						<th>昵称</th>
						<th>${user.nickname}</th>
					</tr>
					<tr>
						<th>Email/帐号</th>
						<th>${user.email}</th>
					</tr>
					<tr>
							<th>创建时间</th>
							<td><fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						</tr>
						<tr>
							<th>最后登录时间</th>
							<td><fmt:formatDate value="${user.lastLoginTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						</tr>
				</tbody>
			</table>
		</div>
	</fieldset>
</body>
</html>
