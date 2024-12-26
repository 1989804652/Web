import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 设置请求和响应的字符编码为UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addUser(request, response);
        } else if ("update".equals(action)) {
            updateUser(request, response);
        } else if ("delete".equals(action)) {
            deleteUser(request, response);
        } else {
            processRequest(request, response);
        }
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 获取表单参数
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String ageStr = request.getParameter("age");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        int age = 0;
        if (ageStr != null && !ageStr.isEmpty()) {
            age = Integer.parseInt(ageStr);
        }

        // 插入数据库
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "INSERT INTO user (Username, Password, Age, Phone, Address) VALUES (?, ?, ?, ?, ?)")) {

            stmt.setString(1, username);
            stmt.setString(2, password); // 注意：实际应用中应使用密码加密
            stmt.setInt(3, age);
            stmt.setString(4, phone);
            stmt.setString(5, address);

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                response.sendRedirect("userManagement.jsp"); // 添加成功后重定向到用户管理页面
            } else {
                response.getWriter().println("添加失败");
            }

        } catch (SQLException e) {
            throw new ServletException("数据库操作失败", e);
        }
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 获取表单参数
        int uid = Integer.parseInt(request.getParameter("id"));
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String ageStr = request.getParameter("age");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        int age = 0;
        if (ageStr != null && !ageStr.isEmpty()) {
            age = Integer.parseInt(ageStr);
        }

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "UPDATE user SET Username=?, Password=?, Age=?, Phone=?, Address=? WHERE Uid=?")) {

            stmt.setString(1, username);
            stmt.setString(2, password); // 注意：实际应用中应使用密码加密
            stmt.setInt(3, age);
            stmt.setString(4, phone);
            stmt.setString(5, address);
            stmt.setInt(6, uid);

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                response.sendRedirect("userManagement.jsp"); // 更新成功后重定向到用户管理页面
            } else {
                response.getWriter().println("更新失败");
            }

        } catch (SQLException e) {
            throw new ServletException("数据库操作失败", e);
        }
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int uid = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement("DELETE FROM user WHERE Uid=?")) {

            stmt.setInt(1, uid);

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                response.sendRedirect("userManagement.jsp"); // 删除成功后重定向到用户管理页面
            } else {
                response.getWriter().println("删除失败");
            }

        } catch (SQLException e) {
            throw new ServletException("数据库操作失败", e);
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
