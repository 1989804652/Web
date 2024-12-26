<!-- login.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>登录页面</title>
</head>
<body>
<h2>登录</h2>
<form action="login" method="post">
    <label for="username">用户名:</label>
    <input type="text" id="username" name="username" required><br><br>
    <label for="password">密码:</label>
    <input type="password" id="password" name="password" required><br><br>
    <input type="submit" value="登录">
    <input type="reset" value="重置">
</form>
</body>
</html>