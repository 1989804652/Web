<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>欢迎页面2</title>
</head>
<body>
<h2>欢迎，<%= session.getAttribute("username") %>!</h2>
<a href="welcome.jsp">栏目1图书</a>
<a href="welcome2.jsp">栏目2食品</a>
<form action="welcome2" method="post">
    <input type="checkbox" name="food" value="面包"> 面包<br>
    <input type="checkbox" name="food" value="薯片"> 薯片<br>
    <input type="checkbox" name="food" value="火腿肠"> 火腿肠<br>
    <input type="checkbox" name="food" value="辣条"> 辣条<br>
    <input type="submit" value="提交">
</form>

<%
    String[] gList = (String[]) session.getAttribute("g");
    if (gList != null && gList.length > 0) {
        out.println("<p>已加入购物车的数量：</p>");
        out.println(gList.length);
    }
    Integer number = (Integer) request.getAttribute("number");
    if (number != null) {
//        out.println("<p>已加入购物车的数量：</p>");
//        out.println(number);
        out.println("<a href='car.jsp'>查看购物车：</a>");
    }
%>
</body>
</html>