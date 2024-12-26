<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>订单取消成功</title>
  <link rel="stylesheet" href="styles.css"> <!-- 可以添加一个CSS样式文件 -->
</head>
<body>
<div class="container">
  <h1>订单取消成功</h1>

  <p>您的订单已经成功取消。感谢您使用我们的服务。</p>

  <p>您可以继续浏览我们的其他商品或服务，或者前往您的订单管理页面查看订单状态。</p>

  <div class="buttons">
    <a href="home.jsp" class="btn">返回首页</a> <!-- 主页链接 -->
    <a href="orderManagement.jsp" class="btn">查看我的订单</a> <!-- 订单管理页面链接 -->
  </div>
</div>

<!-- 页脚 -->
<footer>
  <p>&copy; 2024 你的公司名称. 保留所有权利。</p>
</footer>

<style>
  /* 简单的样式 */
  body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f9;
    margin: 0;
    padding: 0;
  }
  .container {
    text-align: center;
    padding: 50px;
    background-color: #ffffff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
    width: 60%;
    margin: 50px auto;
  }
  h1 {
    color: #4CAF50;
  }
  p {
    color: #333;
    font-size: 16px;
    margin: 20px 0;
  }
  .buttons {
    margin-top: 30px;
  }
  .btn {
    display: inline-block;
    padding: 12px 30px;
    margin: 5px;
    background-color: #4CAF50;
    color: white;
    text-decoration: none;
    border-radius: 4px;
    font-size: 16px;
  }
  .btn:hover {
    background-color: #45a049;
  }
  footer {
    text-align: center;
    margin-top: 50px;
    color: #888;
    font-size: 14px;
  }
</style>
</body>
</html>
