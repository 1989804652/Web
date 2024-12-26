<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>编辑商品</title>
  <style>
    /* 通用样式 */
    body {
      font-family: 'Arial', sans-serif;
      background-color: #f4f7fc;
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      color: #333;
    }

    /* 主容器样式 */
    .container {
      background-color: #fff;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      width: 100%;
      max-width: 600px;
    }

    /* 标题样式 */
    h1 {
      color: #4CAF50;
      text-align: center;
      font-size: 2rem;
      margin-bottom: 20px;
    }

    /* 表单样式 */
    form {
      display: flex;
      flex-direction: column;
      gap: 15px;
    }

    label {
      font-size: 1rem;
      font-weight: bold;
      color: #555;
    }

    input, select {
      padding: 10px;
      font-size: 1rem;
      border: 1px solid #ddd;
      border-radius: 5px;
      width: 100%;
      box-sizing: border-box;
      transition: border-color 0.3s;
    }

    input:focus, select:focus {
      border-color: #4CAF50;
      outline: none;
    }

    button {
      background-color: #4CAF50;
      color: white;
      padding: 12px;
      border: none;
      border-radius: 5px;
      font-size: 1rem;
      cursor: pointer;
      transition: background-color 0.3s;
      width: 100%;
    }

    button:hover {
      background-color: #45a049;
    }

    a {
      display: inline-block;
      text-align: center;
      color: #4CAF50;
      text-decoration: none;
      margin-top: 15px;
      font-size: 1rem;
    }

    a:hover {
      text-decoration: underline;
    }

    .cancel-link {
      margin-top: 20px;
      display: block;
      text-align: center;
      color: #888;
    }

    .cancel-link a {
      color: #f44336;
    }

    .cancel-link a:hover {
      color: #d32f2f;
    }

    /* 空结果提示 */
    .no-result {
      text-align: center;
      color: #f44336;
      font-size: 1.2rem;
    }
  </style>
</head>
<body>
<div class="container">
  <h1>编辑商品</h1>

  <!-- 设置数据源 -->
  <sql:setDataSource var="dataSource"
                     driver="com.mysql.cj.jdbc.Driver"
                     url="jdbc:mysql://localhost:3306/web"
                     user="root" password="123456"/>

  <!-- 查询特定商品 -->
  <sql:query dataSource="${dataSource}" var="result">
    SELECT Pid, Name, Price, Categoryid FROM products WHERE Pid = ?
    <sql:param value="${param.pid}"/>
  </sql:query>

  <!-- 显示编辑表单 -->
  <c:if test="${not empty result.rows}">
    <form action="ProductServlet?action=update&pid=${param.pid}" method="post">
      <label for="name">名称:</label>
      <input type="text" id="name" name="name" required value="${result.rows[0].Name}">

      <label for="price">价格:</label>
      <input type="number" id="price" name="price" step="0.01" value="${result.rows[0].Price}">

      <label for="category">类别:</label>
      <select id="category" name="categoryid" required>
        <sql:query dataSource="${dataSource}" var="categories">
          SELECT Categoryid, CName FROM categories
        </sql:query>
        <c:forEach var="cat" items="${categories.rows}">
          <option value="${cat.Categoryid}" ${cat.Categoryid == result.rows[0].Categoryid ? 'selected' : ''}>
              ${cat.CName}
          </option>
        </c:forEach>
      </select>

      <button type="submit">保存修改</button>
    </form>

    <div class="cancel-link">
      <a href="productManagement.jsp">取消</a>
    </div>
  </c:if>

  <!-- 空结果提示 -->
  <c:if test="${empty result.rows}">
    <div class="no-result">
      <p>未找到ID为 ${param.pid} 的商品。</p>
      <a href="productManagement.jsp">返回商品管理</a>
    </div>
  </c:if>
</div>
</body>
</html>
