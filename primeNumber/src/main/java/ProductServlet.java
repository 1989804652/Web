import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            handleAdd(request, response);
        } else if ("delete".equals(action)) {
            handleDelete(request, response);
        } else if ("update".equals(action)) {
            handleUpdate(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "未知的操作");
        }
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        int categoryid = Integer.parseInt(request.getParameter("categoryid"));

        try (Connection conn = DBUtil.getConnection()) {
            String insertSql = "INSERT INTO products (Name, Price, Categoryid) VALUES (?, ?, ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(insertSql)) {
                pstmt.setString(1, name);
                pstmt.setDouble(2, price);
                pstmt.setInt(3, categoryid);
                pstmt.executeUpdate();
                response.sendRedirect("productManagement.jsp?msg=添加成功");
            }
        } catch (SQLException e) {
            throw new ServletException("数据库操作失败: " + e.getMessage(), e);
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int pid = Integer.parseInt(request.getParameter("pid"));
        try (Connection conn = DBUtil.getConnection()) {
            String deleteSql = "DELETE FROM products WHERE Pid = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(deleteSql)) {
                pstmt.setInt(1, pid);
                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                    response.sendRedirect("productManagement.jsp?msg=删除成功");
                } else {
                    response.sendRedirect("productManagement.jsp?msg=删除失败，未找到该商品");
                }
            }
        } catch (SQLException e) {
            throw new ServletException("数据库操作失败: " + e.getMessage(), e);
        }
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int pid = Integer.parseInt(request.getParameter("pid"));
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        int categoryid = Integer.parseInt(request.getParameter("categoryid"));

        try (Connection conn = DBUtil.getConnection()) {
            String updateSql = "UPDATE products SET Name = ?, Price = ?, Categoryid = ? WHERE Pid = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(updateSql)) {
                pstmt.setString(1, name);
                pstmt.setDouble(2, price);
                pstmt.setInt(3, categoryid);
                pstmt.setInt(4, pid);
                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                    response.sendRedirect("productManagement.jsp?msg=更新成功");
                } else {
                    response.sendRedirect("productManagement.jsp?msg=更新失败，未找到该商品");
                }
            }
        } catch (SQLException e) {
            throw new ServletException("数据库操作失败: " + e.getMessage(), e);
        }
    }
}