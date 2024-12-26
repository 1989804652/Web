<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>欢迎页面</title>
</head>
<body>
<h2>欢迎，<%= session.getAttribute("username") %>!</h2>
<a href="welcome.jsp">栏目1图书</a>
<a href="welcome2.jsp">栏目2食品</a>
<form action="welcome" method="post">
    <input type="checkbox" name="courses" value="数据库"> 数据库<br>
    <input type="checkbox" name="courses" value="计算机组成原理"> 计算机组成原理<br>
    <input type="checkbox" name="courses" value="计算机网络"> 计算机网络<br>
    <input type="checkbox" name="courses" value="操作系统"> 操作系统<br>
    <input type="submit" value="提交">
</form>

<%
    Integer number = (Integer) request.getAttribute("number");
    if (number != null) {
        out.println("<p>已加入购物车的数量：</p>");
        out.println(number);
        out.println("<a href='car.jsp'>查看购物车：</a>");
    }
%>
</body>
</html>