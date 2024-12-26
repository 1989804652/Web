import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserService {


    // 用户注册方法
    public boolean register(User user) {
        String sql = "INSERT INTO user (Username, Password, Age, Phone, Address) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getAge()); // 确保Age是整数
            pstmt.setString(4, user.getPhone());
            pstmt.setString(5, user.getAddress());

            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            return rowsAffected > 0;

        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            System.err.println("Failed to register user: " + e.getMessage());
            return false;
        }
    }

    // 用户登录方法
    public User login(String username, String password) {
        String sql = "SELECT * FROM user WHERE Username=?";
        try (Connection conn = DBUtil.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, username);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    // 如果找到用户名，进一步比较密码
                    String dbPassword = rs.getString("Password");

                    if (dbPassword.equals(password)) {
                        // 用户名和密码都匹配，登录成功
                        User user = new User();
                        user.setUid(rs.getInt("Uid"));
                        user.setUsername(rs.getString("Username"));
                        user.setPassword(rs.getString("Password"));
                        user.setAge(rs.getString("Age")); // 注意：这里假设User类中的setAge接受String
                        user.setPhone(rs.getString("Phone"));
                        user.setAddress(rs.getString("Address"));
                        return user;
                    } else {
                        // 密码不匹配
                        System.out.println("密码错误");
                    }
                } else {
                    // 用户名不存在
                    System.out.println("用户名不存在");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // 登录失败
    }
}