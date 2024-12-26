<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>注册页面</title>
  <style>
    /* 整个页面背景渐变 */
    body {
      margin: 0;
      font-family: 'Arial', sans-serif;
      background: linear-gradient(to right, #6a11cb, #2575fc); /* 渐变背景 */
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      color: white;
    }

    /* 核心容器样式 */
    .container {
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      padding: 40px;
      max-width: 400px;
      width: 100%;
      box-sizing: border-box;
    }

    /* 表单标题样式 */
    h2 {
      font-size: 28px;
      margin-bottom: 20px;
      color: #333;
    }

    /* 表单布局 */
    form {
      display: flex;
      flex-direction: column;
      gap: 20px; /* 设置每个表单项之间的间距 */
    }

    /* 表单元素容器 */
    .form-group {
      display: flex;
      flex-direction: column;
    }

    /* 标签样式 */
    .form-group label {
      font-size: 16px;
      font-weight: bold;
      color: #333;
      margin-bottom: 5px;
    }

    /* 输入框样式 */
    .form-group input {
      padding: 12px;
      border-radius: 8px;
      border: 1px solid #ccc;
      font-size: 16px;
      color: #333;
      outline: none;
      transition: all 0.3s ease;
    }

    /* 输入框获得焦点时的效果 */
    .form-group input:focus {
      border-color: #2575fc;
      box-shadow: 0 0 8px rgba(37, 117, 252, 0.6);
    }

    /* 提交按钮样式 */
    input[type="submit"] {
      background-color: #2575fc;
      color: white;
      border: none;
      padding: 12px;
      font-size: 16px;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.3s ease;
      font-weight: bold;
    }

    input[type="submit"]:hover {
      background-color: #6a11cb;
    }

    /* 提示消息样式 */
    .message {
      font-size: 16px;
      font-weight: bold;
      margin-top: 20px;
      text-align: center;
    }

    .error {
      color: red;
    }

    .success {
      color: green;
    }

    /* 登录链接样式 */
    a {
      display: block;
      margin-top: 20px;
      text-align: center;
      text-decoration: none;
      color: #2575fc;
      font-size: 16px;
    }

    a:hover {
      color: #6a11cb;
    }
  </style>
</head>
<body>
<div class="container">
  <h2>注册页面</h2>
  <form action="register" method="post">
    <div class="form-group">
      <label for="username">用户名:</label>
      <input type="text" name="Username" id="username" required>
    </div>
    <div class="form-group">
      <label for="password">密码:</label>
      <input type="password" name="Password" id="password" required>
    </div>
    <div class="form-group">
      <label for="age">年龄:</label>
      <input type="number" name="Age" id="age" min="1" required>
    </div>
    <div class="form-group">
      <label for="phone">电话:</label>
      <input type="text" name="Phone" id="phone" required>
    </div>
    <div class="form-group">
      <label for="address">地址:</label>
      <input type="text" name="Address" id="address" required>
    </div>
    <input type="submit" value="注册">
  </form>

  <% if (request.getParameter("error") != null) { %>
  <p class="message error">注册失败，请重试。</p>
  <% } else if (request.getParameter("registered") != null) { %>
  <p class="message success">注册成功！您现在可以登录。</p>
  <% } %>
  <a href="login.jsp">已有账号？点击这里登录！</a>
</div>
</body>
</html>
