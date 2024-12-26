<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>登录页面</title>
    <style>
        body, html {
            height: 100%;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #6f42c1, #007bff); /* 渐变背景色 */
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .container {
            text-align: center;
            padding: 40px;
            border-radius: 12px;
            background-color: #fff;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); /* 轻微阴影 */
            width: 380px;
            box-sizing: border-box;
        }
        h2 {
            margin-bottom: 20px;
            color: #333;
            font-size: 24px;
            font-weight: bold;
        }
        form {
            display: flex;
            flex-direction: column;
            align-items: stretch;
        }
        .form-group {
            margin-bottom: 20px;
            position: relative;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-size: 14px;
        }
        .form-group input[type="text"],
        .form-group input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 16px;
            transition: all 0.3s ease;
            background-color: #f7f7f7;
        }
        .form-group input[type="text"]:focus,
        .form-group input[type="password"]:focus {
            border-color: #007bff;
            background-color: #e6f4ff;
            outline: none;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 18px;
            transition: background-color 0.3s, transform 0.2s ease-in-out;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
            transform: scale(1.05); /* 按钮悬浮放大效果 */
        }
        p.error {
            color: red;
            margin-top: 10px;
            font-size: 14px;
        }
        a {
            display: inline-block;
            margin-top: 25px;
            color: #007bff;
            text-decoration: none;
            font-size: 16px;
            font-weight: 600;
            transition: color 0.3s ease;
        }
        a:hover {
            text-decoration: underline;
            color: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>登录页面</h2>
    <form action="login" method="post">
        <div class="form-group">
            <label for="username">用户名:</label>
            <input type="text" name="username" id="username" required placeholder="请输入用户名">
        </div>
        <div class="form-group">
            <label for="password">密码:</label>
            <input type="password" name="password" id="password" required placeholder="请输入密码">
        </div>
        <input type="submit" value="登录">
    </form>
    <% if (request.getParameter("error") != null) { %>
    <p class="error">用户名或密码错误。</p>
    <% } %>
    <a href="Register.jsp">没有账号？点击这里注册！</a>
</div>
</body>
</html>
