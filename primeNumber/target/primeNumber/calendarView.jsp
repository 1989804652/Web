<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>实时日历</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      background-color: #f0f4f8;
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      font-size: 18px;
    }

    .calendar {
      width: 500px;
      background-color: #ffffff;
      padding: 40px;
      border-radius: 15px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
      text-align: center;
    }

    h1 {
      font-size: 36px;
      color: #4e73df;
      margin-bottom: 20px;
    }

    form {
      margin-bottom: 30px;
      display: flex;
      justify-content: center;
      gap: 15px;
    }

    select, button {
      font-size: 18px;
      padding: 10px 20px;
      border-radius: 8px;
      border: 1px solid #d1d8e0;
      background-color: #ffffff;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    select:focus, button:focus {
      outline: none;
      box-shadow: 0 0 5px rgba(72, 118, 255, 0.5);
    }

    select:hover, button:hover {
      background-color: #e0e6f0;
      border-color: #8a97b1;
    }

    table {
      width: 100%;
      margin-top: 30px;
      border-collapse: collapse;
    }

    th, td {
      padding: 15px;
      text-align: center;
      font-size: 20px;
      border: 1px solid #ddd;
      transition: background-color 0.3s ease;
    }

    th {
      background-color: #4e73df;
      color: #fff;
      font-weight: bold;
    }

    td {
      background-color: #f9fafb;
      color: #495057;
    }

    td:hover {
      background-color: #dfe6ed;
    }

    td.other-month {
      color: #d1d8e0;
    }

    .error-message {
      color: #e74a3b;
      font-size: 20px;
      margin-top: 20px;
      text-align: center;
    }

    /* 响应式设计 */
    @media (max-width: 600px) {
      .calendar {
        width: 90%;
        padding: 20px;
      }

      h1 {
        font-size: 28px;
      }

      select, button {
        font-size: 16px;
        padding: 8px 15px;
      }

      table {
        font-size: 18px;
      }
    }

    /* 添加返回链接样式 */
    .return-link {
      display: block;
      margin-top: 30px;
      font-size: 18px;
      color: #4e73df;
      text-decoration: none;
      transition: color 0.3s ease;
    }

    .return-link:hover {
      color: #365ec6;
    }
  </style>
</head>
<body>
<div class="calendar">
  <h1><fmt:formatDate value="${calendar.time}" pattern="yyyy年M月"/></h1>

  <form action="calendar" method="get">
    <label for="year">选择年份:</label>
    <select name="year" id="year">
      <c:forEach var="i" begin="2020" end="2030">
        <option value="${i}" ${i == year ? 'selected' : ''}>${i}</option>
      </c:forEach>
    </select>

    <label for="month">选择月份:</label>
    <select name="month" id="month">
      <c:forEach var="i" begin="1" end="12">
        <option value="${i}" ${i == month ? 'selected' : ''}>${i}</option>
      </c:forEach>
    </select>

    <button type="submit">显示日历</button>
  </form>

  <table>
    <thead>
    <tr>
      <th>日</th>
      <th>一</th>
      <th>二</th>
      <th>三</th>
      <th>四</th>
      <th>五</th>
      <th>六</th>
    </tr>
    </thead>
    <tbody>
    <c:if test="${not empty calendar}">
      <c:set var="startOffset" value="${firstDayOfWeek == 1 ? 0 : firstDayOfWeek - 1}" />
      <c:set var="endOffset" value="${7 - ((daysInMonth + startOffset) % 7)}" />

      <!-- 上个月的日期 -->
      <c:forEach begin="1" end="${startOffset}" varStatus="loop">
        <td class='other-month'>${prevMonthDays - startOffset + loop.count}</td>
        <c:if test="${(loop.index) % 7 == 0}">
          </tr><tr>
        </c:if>
      </c:forEach>

      <!-- 本月的日期 -->
      <c:forEach begin="1" end="${daysInMonth}" var="day" varStatus="status">
        <td>${day}</td>
        <c:if test="${(status.index + startOffset) % 7 == 0}">
          </tr><tr>
        </c:if>
      </c:forEach>

      <!-- 下个月的日期 -->
      <c:forEach begin="1" end="${endOffset}" var="i">
        <td class='other-month'>${i}</td>
        <c:if test="${i % 7 == 0}">
          </tr>
        </c:if>
      </c:forEach>

      <!-- 确保最后一行有7个单元格 -->
      <c:if test="${(daysInMonth + startOffset + endOffset) % 7 != 0}">
        <c:forEach begin="1" end="${7 - ((daysInMonth + startOffset + endOffset) % 7)}" var="dummy">
          <td></td>
        </c:forEach>
      </c:if>
    </c:if>
    <c:if test="${empty calendar}">
      <tr><td colspan='7' class='error-message'>无法加载日历，请稍后再试。</td></tr>
    </c:if>
    </tbody>
  </table>

  <!-- 返回主页面的链接 -->
  <a href="home.jsp" class="return-link">返回主页面</a>
</div>
</body>
</html>