<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8">
    <title>显示学生信息</title>
    <link rel="stylesheet" href="css/index.css">
</head>
<body>
<h3>添加学生信息</h3>
<div>
    <form action="save" method="post">
        &nbsp;&nbsp;姓名: <input type="text" autofocus placeholder="姓名" name="uname"><br>
        家庭地址: <input type="text" name="address" placeholder="地址"><br>
        <input type="submit" value="提交">
    </form>
</div>
<h3>显示学生表的信息</h3>
<c:forEach items="${student}" var="st">
    <div>${st.uname}--${st.address}--<a href="del?id=${st.id}">删除</a></div>
</c:forEach>

</body>
</html>
