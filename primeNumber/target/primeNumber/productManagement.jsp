<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>商品管理</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      background-color: #f4f7fc;
      color: #333;
      margin: 0;
      padding: 0;
    }
    header {
      background-color: #3f72af;
      color: #fff;
      padding: 20px 0;
      text-align: center;
    }
    h1 {
      margin: 0;
      font-size: 36px;
    }
    .container {
      width: 85%;
      max-width: 1200px;
      margin: 40px auto;
      background-color: #fff;
      padding: 30px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      border-radius: 8px;
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
      background-color: #4f81bd;
      color: #fff;
    }
    tr:hover {
      background-color: #f1f1f1;
    }
    button {
      background-color: #e94e77;
      color: #fff;
      padding: 8px 16px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }
    button:hover {
      background-color: #d4416a;
    }
    a {
      color: #3f72af;
      text-decoration: none;
      font-size: 16px;
    }
    a:hover {
      text-decoration: underline;
    }
    .form-container {
      margin-top: 40px;
      padding: 20px;
      background-color: #fafafa;
      border-radius: 8px;
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
    }
    .form-container h2 {
      margin-bottom: 20px;
      color: #3f72af;
    }
    label {
      font-size: 16px;
      margin-bottom: 8px;
      display: block;
    }
    input[type="text"], input[type="number"], select {
      width: 100%;
      padding: 10px;
      margin-bottom: 20px;
      border-radius: 4px;
      border: 1px solid #ddd;
      font-size: 16px;
      box-sizing: border-box;
    }
    select {
      cursor: pointer;
    }
    /* 添加新的样式类 */
    .btn-add {
      display: inline-block;
      background-color: #e94e77;
      color: #fff;
      padding: 8px 16px;
      border: none;
      border-radius: 4px;
      text-decoration: none;
      transition: background-color 0.3s ease;
    }
    .btn-add:hover {
      background-color: #d4416a;
    }
  </style>
</head>
<body>
<header>
  <h1>商品管理</h1>
</header>

<div class="container">
  <!-- 设置数据源 -->
  <sql:setDataSource var="dataSource"
                     driver="com.mysql.cj.jdbc.Driver"
                     url="jdbc:mysql://localhost:3306/web"
                     user="root" password="123456"/>

  <!-- 查询所有商品 -->
  <sql:query dataSource="${dataSource}" var="result">
    SELECT Pid, Name, Price, Categoryid FROM products
  </sql:query>

  <!-- 显示商品列表 -->
  <table>
    <thead>
    <tr>
      <th>ID</th>
      <th>名称</th>
      <th>价格</th>
      <th>类别</th>
      <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="row" items="${result.rows}">
      <tr>
        <td><c:out value="${row.Pid}"/></td>
        <td><c:out value="${row.Name}"/></td>
        <td><c:out value="${row.Price}"/></td>
        <td>
          <sql:query dataSource="${dataSource}" var="categoryNameResult">
            SELECT CName FROM categories WHERE Categoryid = ?
            <sql:param value="${row.Categoryid}"/>
          </sql:query>
          <c:out value="${categoryNameResult.rows[0].CName}"/>
        </td>
        <td>
          <form action="ProductServlet?action=delete&pid=${row.Pid}" method="post" onsubmit="return confirm('确定要删除此商品吗？')">
            <button type="submit">删除</button>
          </form>
          <!-- 修改后的编辑链接 -->
          <a href="editProduct.jsp?pid=${row.Pid}&name=${row.Name}&price=${row.Price}">编辑</a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>

  <!-- 修改后的添加商品按钮 -->
  <a href="addProduct.jsp" class="btn-add">添加新商品</a>

  <br/>
  <div>
    <a href="userManagement.jsp">返回用户管理</a> |
    <a href="home.jsp">返回主页</a>
  </div>
</div>
</body>
</html>