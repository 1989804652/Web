<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>产品列表</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      text-align: center;
      background-color: #f4f4f9;
      color: #333;
      margin: 0;
      padding: 0;
    }

    h1 {
      font-size: 2.5em;
      margin-bottom: 20px;
      color: #5a5a5a;
    }

    .navbar {
      background: linear-gradient(45deg, #4caf50, #2e7d32);
      overflow: hidden;
      margin-bottom: 30px;
      border-radius: 8px;
    }

    .navbar a {
      float: left;
      color: white;
      text-align: center;
      padding: 14px 20px;
      text-decoration: none;
      font-size: 1.2em;
      transition: background-color 0.3s;
    }

    .navbar a:hover {
      background-color: #ddd;
      color: black;
      border-radius: 4px;
    }

    table {
      margin: 0 auto;
      width: 90%;
      border-collapse: collapse;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      border-radius: 10px;
      overflow: hidden;
    }

    th, td {
      border: 1px solid #ddd;
      padding: 12px;
      text-align: left;
    }

    th {
      background-color: #f8f8f8;
      color: #4caf50;
    }

    tr:nth-child(even) {
      background-color: #f9f9f9;
    }

    tr:hover {
      background-color: #f1f1f1;
    }

    .button-container {
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 20px;
    }

    .buy-button {
      background-color: #4caf50;
      color: white;
      border: none;
      padding: 10px 20px;
      font-size: 1em;
      cursor: pointer;
      border-radius: 5px;
      transition: all 0.3s;
    }

    .buy-button:hover {
      background-color: #45a049;
      transform: scale(1.05);
    }

    .quantity-input {
      padding: 5px 10px;
      font-size: 1em;
      border: 1px solid #ddd;
      border-radius: 4px;
      width: 80px;
      margin-right: 10px;
    }

    .home-link {
      margin-top: 30px;
      font-size: 1.2em;
    }

    .home-link a {
      text-decoration: none;
      color: #4caf50;
      transition: color 0.3s;
    }

    .home-link a:hover {
      color: #2e7d32;
    }
  </style>
</head>
<body>

<div class="navbar">
  <a href="productList.jsp?category=食品">食品列表</a>
  <a href="productList.jsp?category=图书">图书列表</a>
</div>

<div style="margin-top: 50px;">
  <h1>${param.category} 列表</h1>

  <sql:setDataSource var="dataSource"
                     driver="com.mysql.cj.jdbc.Driver"
                     url="jdbc:mysql://localhost:3306/web"
                     user="root" password="123456"/>

  <!-- 获取类别ID -->
  <sql:query dataSource="${dataSource}" var="categoryIdResult">
    SELECT Categoryid FROM categories WHERE CName = ?
    <sql:param value="${param.category}"/>
  </sql:query>

  <c:choose>
    <c:when test="${categoryIdResult.rowCount == 0}">
      <p>未找到名为 ${param.category} 的类别。</p>
    </c:when>
    <c:otherwise>
      <c:set var="categoryId" value="${categoryIdResult.rows[0].Categoryid}" />

      <!-- 根据类别ID查询产品 -->
      <sql:query dataSource="${dataSource}" var="result">
        SELECT Pid, Name, Price, Categoryid
        FROM products
        WHERE Categoryid = ?
        <sql:param value="${categoryId}"/>
      </sql:query>

      <c:if test="${result.rowCount == 0}">
        <p>没有找到 ${param.category} 类别的产品。</p>
      </c:if>

      <c:if test="${result.rowCount > 0}">
        <table>
          <tr>
            <th>ID</th>
            <th>名称</th>
            <th>价格</th>
            <th>类别</th>
            <th>操作</th>
          </tr>
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
                <div class="button-container">
                  <form action="OrderServlet?action=buy&pid=${row.Pid}" method="post">
                    <input class="quantity-input" type="number" name="quantity" min="1" required/>
                    <button class="buy-button" type="submit">购买</button>
                  </form>
                </div>
              </td>
            </tr>
          </c:forEach>
        </table>
      </c:if>
    </c:otherwise>
  </c:choose>

  <!-- 添加返回主页链接 -->
  <div class="home-link">
    <a href="home.jsp">返回主页</a>
  </div>

</div>

</body>
</html>
