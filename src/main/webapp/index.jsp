<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8">
    <title>ssm三大框架整合方案</title>
</head>
<body>
<a href="test">springmvc-controller-test</a>
<hr>
<%=request.getRemoteAddr()%>
<c:forEach begin="1" end="5" step="1">
    <h2>SSM三大框架整合</h2>
</c:forEach>
</body>
</html>
