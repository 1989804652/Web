import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    // JDBC URL, 用户名和密码
    private static final String URL = "jdbc:mysql://localhost:3306/web?useUnicode=true&characterEncoding=UTF-8";
    private static final String USER = "root";
    private static final String PASSWORD = "123456";

    // 单例模式下的唯一实例
    private static DBUtil instance;

    // 私有构造函数
    private DBUtil() {}

    // 获取DatabaseConnection的唯一实例
    public static synchronized DBUtil getInstance() {
        if (instance == null) {
            instance = new DBUtil();
        }
        return instance;
    }

    // 获取数据库连接
    public static Connection getConnection() throws SQLException {
        try {
            // 加载MySQL JDBC驱动程序
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found.");
            e.printStackTrace();
            return null;
        }

        // 建立与数据库的连接
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // 关闭数据库连接
    public void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}