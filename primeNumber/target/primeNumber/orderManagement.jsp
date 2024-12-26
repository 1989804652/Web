<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>订单管理</title>
    <style>
        /* Reset some default styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #6a11cb, #2575fc);
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            padding: 30px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin: 30px auto;
        }

        h2 {
            font-size: 2rem;
            color: #333;
            text-align: center;
            margin-bottom: 20px;
            font-weight: bold;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
        }

        th {
            background-color: #333;
            color: #fff;
        }

        td {
            background-color: #f9f9f9;
            color: #000; /* 将字体颜色设置为黑色 */
        }

        tr:nth-child(even) td {
            background-color: #f1f1f1;
        }

        tr:hover td {
            background-color: #ddd;
        }

        button {
            background-color: #e94e77;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        button:hover {
            background-color: #d4416a;
            transform: scale(1.05);
        }

        a {
            color: #2575fc;
            font-size: 16px;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        a:hover {
            color: #e94e77;
            text-decoration: underline;
        }

        .actions {
            display: flex;
            gap: 10px;
            justify-content: center;
        }

        .actions form {
            margin: 0;
        }

        .actions a, .actions button {
            font-size: 14px;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .container {
                width: 100%;
                padding: 15px;
            }

            h2 {
                font-size: 1.5rem;
            }

            th, td {
                font-size: 14px;
                padding: 10px;
            }

            button {
                padding: 8px 16px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h2>订单管理</h2>

    <!-- 设置数据源 -->
    <sql:setDataSource var="dataSource"
                       driver="com.mysql.cj.jdbc.Driver"
                       url="jdbc:mysql://localhost:3306/web"
                       user="root" password="123456"/>

    <!-- 查询所有订单 -->
    <sql:query dataSource="${dataSource}" var="result">
        SELECT OrderId, Uid, Totalamount, Orderdate, Quantity FROM orders
    </sql:query>

    <!-- 显示订单列表 -->
    <table>
        <thead>
        <tr>
            <th>订单ID</th>
            <th>用户ID</th>
            <th>总金额</th>
            <th>下单日期</th>
            <th>数量</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="row" items="${result.rows}">
            <tr>
                <td><c:out value="${row.OrderId}"/></td>
                <td><c:out value="${row.Uid}"/></td>
                <td><c:out value="${row.Totalamount}"/></td>
                <td><c:out value="${row.Orderdate}"/></td>
                <td><c:out value="${row.Quantity}"/></td>
                <td class="actions">
                    <form action="OrderServlet?action=cancel&orderId=${row.OrderId}" method="post" onsubmit="return confirm('确定要取消此订单吗？')">
                        <button type="submit">取消订单</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>