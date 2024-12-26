<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>猜字母游戏</title>
</head>
<body>
<h1>猜字母游戏</h1>
<p>${message}</p>
<form action="guess" method="post">
    请输入一个字母: <input type="text" name="guess" maxlength="1" required>
    <input type="submit" value="提交">
</form>
</body>
</html>