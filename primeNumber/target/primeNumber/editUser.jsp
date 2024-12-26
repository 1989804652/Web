<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>编辑用户信息</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f9;
            color: #333;
            text-align: center;
            padding: 0;
            margin: 0;
        }
        h1 {
            color: #4CAF50;
            font-size: 2em;
            margin-top: 30px;
        }
        .container {
            width: 50%;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        form {
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }
        label {
            font-size: 1.1em;
            margin-bottom: 5px;
            color: #4CAF50;
        }
        input {
            font-size: 1em;
            padding: 10px;
            margin-bottom: 15px;
            width: 100%;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input:focus {
            border-color: #4CAF50;
            outline: none;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1.1em;
        }
        button:hover {
            background-color: #45a049;
        }
        a {
            color: #4CAF50;
            text-decoration: none;
            font-size: 1.2em;
            margin-top: 20px;
            display: inline-block;
        }
        a:hover {
            text-decoration: underline;
        }
        .footer-links {
            margin-top: 30px;
            font-size: 1.1em;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>编辑用户信息</h1>

    <sql:setDataSource var="dataSource"
                       driver="com.mysql.cj.jdbc.Driver"
                       url="jdbc:mysql://localhost:3306/web"
                       user="root" password="123456"/>

    <sql:query dataSource="${dataSource}" var="result">
        SELECT * FROM user WHERE Uid = ?
        <sql:param value="${param.id}"/>
    </sql:query>

    <c:forEach var="row" items="${result.rows}">
        <form action="UserServlet?action=update&id=${row.Uid}" method="post">
            <label for="username">用户名:</label>
            <input type="text" id="username" name="username" value="${row.Username}" required>

            <label for="password">密码:</label>
            <input type="password" id="password" name="password" value="${row.Password}" required>

            <label for="age">年龄:</label>
            <input type="number" id="age" name="age" value="${row.Age}">

            <label for="phone">电话:</label>
            <input type="text" id="phone" name="phone" value="${row.Phone}">

            <label for="address">地址:</label>
            <input type="text" id="address" name="address" value="${row.Address}">

            <button type="submit">保存修改</button>
        </form>
    </c:forEach>

    <div class="footer-links">
        <a href="userManagement.jsp">返回用户管理</a>
        <br/>
        <a href="home.jsp">返回主页</a>
    </div>
</div>
</body>
</html>
