import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("Username");
        String password = request.getParameter("Password");
        String age =request.getParameter("Age");
        String phone = request.getParameter("Phone");
        String address = request.getParameter("Address");

        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setAge(age);
        newUser.setPhone(phone);
        newUser.setAddress(address);

        UserService userService = new UserService();
        if (userService.register(newUser)) {
            response.sendRedirect("login.jsp?registered=true"); // 注册成功后提示并跳转到登录页
        } else {
            response.sendRedirect("Register.jsp?error=true"); // 注册失败回到注册页
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}