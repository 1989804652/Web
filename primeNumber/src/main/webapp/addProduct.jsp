<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>添加新商品</title>
    <!-- 引入样式 -->
    <style>
        /* 基础样式 */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7fa;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 50%;
            margin: 50px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
            font-size: 24px;
            margin-bottom: 30px;
        }

        /* 表单布局 */
        form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        label {
            font-size: 16px;
            color: #333;
        }

        input[type="text"], input[type="number"], select {
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 4px;
            outline: none;
            width: 100%;
            box-sizing: border-box;
        }

        input[type="text"]:focus, input[type="number"]:focus, select:focus {
            border-color: #3b9cff;
            box-shadow: 0 0 5px rgba(59, 156, 255, 0.5);
        }

        button {
            background-color: #4CAF50;
            color: white;
            padding: 12px 20px;
            font-size: 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #45a049;
        }

        a {
            display: inline-block;
            text-align: center;
            margin-top: 10px;
            font-size: 16px;
            color: #007bff;
            text-decoration: none;
            padding: 10px 20px;
            border: 1px solid #007bff;
            border-radius: 4px;
            transition: background-color 0.3s, color 0.3s;
        }

        a:hover {
            background-color: #007bff;
            color: white;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .container {
                width: 80%;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>添加新商品</h2>

    <!-- 设置数据源 -->
    <sql:setDataSource var="dataSource"
                       driver="com.mysql.cj.jdbc.Driver"
                       url="jdbc:mysql://localhost:3306/web"
                       user="root" password="123456"/>

    <!-- 查询所有类别 -->
    <sql:query dataSource="${dataSource}" var="categories">
        SELECT Categoryid, CName FROM categories
    </sql:query>

    <form action="ProductServlet?action=add" method="post">
        <!-- 商品名称输入 -->
        <label for="name">商品名称:</label>
        <input type="text" id="name" name="name" required placeholder="请输入商品名称">

        <!-- 商品价格输入 -->
        <label for="price">商品价格:</label>
        <input type="number" id="price" name="price" step="0.01" required placeholder="请输入商品价格">

        <!-- 商品类别选择 -->
        <label for="category">商品类别:</label>
        <select id="category" name="categoryid" required>
            <!-- 使用JSTL遍历类别并生成选项 -->
            <c:forEach var="cat" items="${categories.rows}">
                <option value="${cat.Categoryid}">${cat.CName}</option>
            </c:forEach>
        </select>

        <!-- 提交按钮 -->
        <button type="submit">添加商品</button>
        <!-- 取消按钮 -->
        <a href="productManagement.jsp">取消</a>
    </form>
</div>
</body>
</html>
