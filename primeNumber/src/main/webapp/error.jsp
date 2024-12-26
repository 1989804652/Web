<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>错误</title>
  <style>
    body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; }
    .error-message { color: red; font-size: 18px; }
  </style>
</head>
<body>
<h1>发生错误</h1>
<p class="error-message">${errorMessage}</p>
<a href="calendar">返回日历</a>
</body>
</html>