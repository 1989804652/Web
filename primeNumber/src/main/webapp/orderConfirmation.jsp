<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>订单确认</title>
  <style>
    body { font-family: Arial, sans-serif; }
    .container { width: 60%; margin: auto; padding: 20px; border: 1px solid #ccc; }
    h1 { color: #333; }
    p { font-size: 1.2em; }
  </style>
</head>
<body>
<div class="container">
  <h1>订单已成功提交</h1>

  <%
    // 获取请求参数中的订单ID
    String orderId = request.getParameter("orderId");
    if (orderId == null || orderId.isEmpty()) {
      System.out.println("<p>无法获取订单信息，请联系客服。</p>");
    } else {
      System.out.println("<p>您的订单号是：" + orderId + "。</p>");
      System.out.println("<p>感谢您的购买！我们将在处理完您的订单后发送电子邮件通知。</p>");

      // 这里可以添加更多逻辑，例如查询数据库以获取订单详细信息并显示给用户。
      // 请确保使用适当的Java代码或JSTL标签库来实现这些功能。
    }
  %>

  <a href="home.jsp">返回首页</a>
</div>
</body>
</html>