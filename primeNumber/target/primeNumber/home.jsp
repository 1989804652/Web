<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>主页</title>
  <style>
    /* 统一的全局设置 */
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      margin: 0;
      padding: 0;
      display: flex;
      min-height: 100vh;
      background-color: #f4f4f9;
      color: #333;
    }

    /* 侧边栏样式 */
    .sidebar {
      background: linear-gradient(135deg, #6a1b9a, #8e24aa);
      width: 250px;
      padding: 30px 20px;
      display: flex;
      flex-direction: column;
      justify-content: flex-start;
      align-items: stretch;
      height: 100vh;
      box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
      color: white;
    }

    .sidebar a {
      color: #ffffff;
      text-decoration: none;
      font-size: 18px;
      padding: 12px 0;
      display: block;
      margin-bottom: 10px;
      border-radius: 4px;
      transition: all 0.3s ease;
    }

    .sidebar a:hover {
      background-color: #ffffff;
      color: #6a1b9a;
      padding-left: 15px;
    }

    .sidebar a.active {
      background-color: #ffffff;
      color: #6a1b9a;
    }

    /* 内容区样式 */
    .content {
      flex-grow: 1;
      padding: 30px;
      text-align: center;
      background-color: #ffffff;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
      margin-left: 270px;
      border-radius: 8px;
    }

    .welcome-message {
      margin-bottom: 20px;
      padding: 20px;
      background-color: #ffffff;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      border-radius: 8px;
      text-align: center;
      max-width: 500px;
      width: 100%;
      margin: 0 auto;
    }

    .welcome-message h1 {
      font-size: 32px;
      color: #5c6bc0; /* 主标题颜色 */
      margin-bottom: 10px;
    }

    .welcome-message p {
      font-size: 18px;
      color: #888;
    }

    /* 响应式设计 */
    @media (max-width: 768px) {
      .sidebar {
        width: 100%;
        height: auto;
        flex-direction: row;
        justify-content: space-around;
      }

      .sidebar a {
        margin: 0 10px;
        padding: 10px 0;
      }

      .content {
        margin-left: 0;
        padding: 20px;
      }

      .welcome-message {
        left: 20px;
        top: 100px;
        max-width: 90%;
      }
    }
  </style>
</head>
<body>

<div class="sidebar">
  <a href="productList.jsp?category=food" class="active">食品列表</a>
  <a href="productList.jsp?category=books">图书列表</a>
  <a href="calendarView.jsp">日历</a>
  <a href="orderManagement.jsp">订单查询</a>
  <a href="userManagement.jsp">用户管理</a>
  <a href="productManagement.jsp">商品管理</a>
  <a href="LogoutServlet">退出登录</a>
</div>

<div class="content">
  <!-- 欢迎信息移到系统介绍框内 -->
  <div class="welcome-message">
    <h1>欢迎来到购物系统！</h1>
    <p>您已成功登录。</p>
  </div>

  <!-- 系统介绍 -->
  <h2>系统介绍</h2>
  <p>在这里您可以浏览食品、图书等商品，管理订单，并享受便捷的用户服务。</p>
</div>

</body>
</html>
