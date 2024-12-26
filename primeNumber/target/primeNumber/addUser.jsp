<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>添加新用户</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7f6;
            color: #333;
            text-align: center;
            margin: 0;
            padding: 0;
        }

        h1 {
            color: #3e8e41;
            margin-top: 50px;
            font-size: 2.5em;
        }

        .form-container {
            background-color: #ffffff;
            width: 100%;
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: left;
        }

        label {
            font-size: 1.1em;
            margin-bottom: 8px;
            color: #555;
        }

        input[type="text"], input[type="password"], input[type="number"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 1em;
            transition: all 0.3s ease-in-out;
        }

        input[type="text"]:focus, input[type="password"]:focus, input[type="number"]:focus {
            border-color: #3e8e41;
            outline: none;
            box-shadow: 0 0 5px rgba(62, 142, 65, 0.5);
        }

        button {
            background-color: #3e8e41;
            color: white;
            font-size: 1.2em;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #357a38;
        }

        a {
            color: #3e8e41;
            text-decoration: none;
            font-size: 1.1em;
            margin: 10px;
        }

        a:hover {
            text-decoration: underline;
        }

        .footer-links {
            margin-top: 20px;
            font-size: 1.1em;
        }

        .footer-links a {
            margin: 0 10px;
        }

        @media (max-width: 600px) {
            h1 {
                font-size: 2em;
            }

            .form-container {
                width: 90%;
                padding: 20px;
            }

            button {
                width: 100%;
            }

            .footer-links a {
                display: block;
                margin: 5px 0;
            }
        }
    </style>
</head>
<body>

<h1>添加新用户</h1>

<div class="form-container">
    <form action="UserServlet?action=add" method="post">
        <label for="username">用户名:</label>
        <input type="text" id="username" name="username" required placeholder="请输入用户名">

        <label for="password">密码:</label>
        <input type="password" id="password" name="password" required placeholder="请输入密码">

        <label for="age">年龄:</label>
        <input type="number" id="age" name="age" placeholder="请输入年龄">

        <label for="phone">电话:</label>
        <input type="text" id="phone" name="phone" placeholder="请输入电话">

        <label for="address">地址:</label>
        <input type="text" id="address" name="address" placeholder="请输入地址">

        <button type="submit">添加用户</button>
    </form>
</div>

<div class="footer-links">
    <a href="userManagement.jsp">返回用户管理</a>
    <a href="home.jsp">返回主页</a>
</div>

</body>
</html>
