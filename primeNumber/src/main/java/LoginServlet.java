import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserService userService = new UserService();
        User user = userService.login(username, password);

        if (user != null) {
            HttpSession session = request.getSession(true); // 确保创建新会话
            session.setAttribute("uid", user.getUid());
            session.setAttribute("user", user);
            response.sendRedirect("home.jsp"); // 登录成功后跳转到主页
        } else {
            response.sendRedirect("login.jsp?error=true"); // 登录失败回到登录页
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}