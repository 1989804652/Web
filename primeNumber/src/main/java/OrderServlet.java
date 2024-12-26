import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("buy".equals(action)) {
            buyProduct(request, response);
        } else if ("cancel".equals(action)) {
            cancelOrder(request, response);
        } else {
            processRequest(request, response);
        }
    }


    private void buyProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 获取参数
        int pid = Integer.parseInt(request.getParameter("pid"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("uid") == null) {
            // 如果没有有效的会话或uid不存在，则重定向到登录页面
            response.sendRedirect("login.jsp");
            return;
        }

        // 安全地获取uid
        Integer uidObj = (Integer) session.getAttribute("uid");
        if (uidObj == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int uid = uidObj.intValue();

        try (Connection conn = DBUtil.getConnection()) {
            // 查询产品价格
            double price = getProductPrice(conn, pid);

            // 插入订单信息到数据库
            String sql = "INSERT INTO orders (Uid, Pid, Quantity, Totalamount, Orderdate) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setInt(1, uid);
                stmt.setInt(2, pid);
                stmt.setInt(3, quantity);
                stmt.setDouble(4, price * quantity);
                stmt.setTimestamp(5, new java.sql.Timestamp(System.currentTimeMillis())); // 设置当前时间

                int affectedRows = stmt.executeUpdate();
                if (affectedRows > 0) {
                    response.sendRedirect("orderConfirmation.jsp?orderId=" + getGeneratedOrderId(stmt));
                } else {
                    throw new SQLException("购买失败，未插入任何记录");
                }
            }
        } catch (SQLException e) {
            throw new ServletException("数据库操作失败", e);
        }
    }

    private void cancelOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 获取参数
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("uid") == null) {
            // 如果没有有效的会话或uid不存在，则重定向到登录页面
            response.sendRedirect("login.jsp");
            return;
        }

        // 安全地获取uid
        Integer uidObj = (Integer) session.getAttribute("uid");
        if (uidObj == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int uid = uidObj.intValue();

        try (Connection conn = DBUtil.getConnection()) {
            // 查询订单是否存在以及是否属于当前用户
            String checkOrderSql = "SELECT * FROM orders WHERE OrderId = ? AND Uid = ?";
            try (PreparedStatement stmt = conn.prepareStatement(checkOrderSql)) {
                stmt.setInt(1, orderId);
                stmt.setInt(2, uid);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        // 订单存在并且属于当前用户，删除订单
                        String deleteOrderSql = "DELETE FROM orders WHERE OrderId = ?";
                        try (PreparedStatement deleteStmt = conn.prepareStatement(deleteOrderSql)) {
                            deleteStmt.setInt(1, orderId);
                            int affectedRows = deleteStmt.executeUpdate();
                            if (affectedRows > 0) {
                                // 删除成功，跳转到订单取消成功页面
                                response.sendRedirect("orderCancelSuccess.jsp");
                            } else {
                                throw new SQLException("取消订单失败");
                            }
                        }
                    } else {
                        // 如果订单不存在或不属于当前用户
                        response.sendRedirect("error.jsp?message=订单不存在或无权取消");
                    }
                }
            }
        } catch (SQLException e) {
            throw new ServletException("数据库操作失败", e);
        }
    }


    private double getProductPrice(Connection conn, int pid) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement("SELECT Price FROM products WHERE Pid = ?")) {
            stmt.setInt(1, pid);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("Price");
                }
            }
        }
        return 0;
    }

    private int getGeneratedOrderId(Statement stmt) throws SQLException {
        try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
            if (generatedKeys.next()) {
                return generatedKeys.getInt(1);
            } else {
                throw new SQLException("Creating order failed, no ID obtained.");
            }
        }
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 设置响应内容类型和字符编码
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 可以在这里添加其他请求处理逻辑
    }
}