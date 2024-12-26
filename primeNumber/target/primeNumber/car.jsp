<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>购物车</title>
</head>
<body>
<h2>购物车</h2>
<%
    String[] gList = (String[]) session.getAttribute("g");
    if (gList != null && gList.length > 0) {
        out.println("<p>已加入购物车：</p>");
        for (String item : gList) {
            out.println(item + "<br>");
        }
    } else {
        out.println("<p>购物车为空。</p>");
    }
%>
<a href="welcome.jsp">返回主页</a>
</body>
</html>