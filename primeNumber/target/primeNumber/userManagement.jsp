<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>用户管理</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      background-color: #f9f9f9;
      color: #333;
      margin: 0;
      padding: 0;
    }
    h1 {
      color: #4CAF50;
      margin-top: 40px;
      font-size: 36px;
    }
    .container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 20px;
      background-color: #fff;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }
    th, td {
      padding: 12px;
      text-align: left;
      border: 1px solid #ddd;
    }
    th {
      background-color: #4CAF50;
      color: white;
    }
    tr:nth-child(even) {
      background-color: #f2f2f2;
    }
    tr:hover {
      background-color: #e8f5e9;
    }
    td button {
      background-color: #f44336;
      color: white;
      border: none;
      padding: 8px 16px;
      cursor: pointer;
      border-radius: 4px;
      transition: background-color 0.3s ease;
    }
    td button:hover {
      background-color: #d32f2f;
    }
    td a {
      color: #2196F3;
      text-decoration: none;
      padding: 4px 12px; /* 减少内边距 */
      font-size: 14px; /* 减小字体大小 */
      border-radius: 3px; /* 边角变小 */
      border: 1px solid #2196F3;
      transition: background-color 0.3s ease;
    }

    td a:hover {
      background-color: #2196F3;
      color: white;
    }

    .links {
      margin-top: 20px;
      text-align: center;
    }
    .links a {
      text-decoration: none;
      color: #4CAF50;
      font-size: 16px;
      margin: 0 15px;
      padding: 8px 20px;
      border: 1px solid #4CAF50;
      border-radius: 4px;
      transition: background-color 0.3s ease;
    }
    .links a:hover {
      background-color: #4CAF50;
      color: white;
    }
  </style>
</head>
<body>

<div class="container">
  <h1>用户管理</h1>

  <sql:setDataSource var="dataSource"
                     driver="com.mysql.cj.jdbc.Driver"
                     url="jdbc:mysql://localhost:3306/web"
                     user="root" password="123456"/>

  <sql:query dataSource="${dataSource}" var="result">
    SELECT Uid, Username, Password, Age, Phone, Address FROM user
  </sql:query>

  <table>
    <tr>
      <th>ID</th>
      <th>用户名</th>
      <th>密码</th>
      <th>年龄</th>
      <th>电话</th>
      <th>地址</th>
      <th>操作</th>
    </tr>
    <c:forEach var="row" items="${result.rows}">
      <tr>
        <td><c:out value="${row.Uid}"/></td>
        <td><c:out value="${row.Username}"/></td>
        <td><c:out value="${row.Password}"/></td>
        <td><c:out value="${row.Age}"/></td>
        <td><c:out value="${row.Phone}"/></td>
        <td><c:out value="${row.Address}"/></td>
        <td style="display: flex; justify-content: space-between; gap: 10px;">
          <!-- 删除按钮 -->
          <form action="UserServlet?action=delete&id=${row.Uid}" method="post" onsubmit="return confirm('确定要删除此用户吗？')">
            <button type="submit">删除</button>
          </form>

          <!-- 编辑按钮 -->
          <a href="editUser.jsp?id=${row.Uid}">编辑</a>
        </td>

      </tr>
    </c:forEach>
  </table>

  <div class="links">
    <a href="addUser.jsp">添加新用户</a>
    <a href="home.jsp">返回主页</a>
  </div>
</div>

</body>
</html>
