package connexion.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SingletonConnection {

  private static Connection connection;
  final static ResourceBundle bundle = ResourceBundle.getBundle("configuration.application");
 

  static {

    try {
      Class.forName("org.postgresql.Driver");
      connection = DriverManager.getConnection("jdbc:postgresql://localhost/"+bundle.getString("DBName"), "postgres", "samir");

    } catch (ClassNotFoundException | SQLException ex) {
      Logger.getLogger(SingletonConnection.class.getName()).log(Level.SEVERE, null, ex);
    }

  }

  public static Connection getConnection() {
    try {
      connection.setAutoCommit(false);
    } catch (SQLException ex) {
      Logger.getLogger(SingletonConnection.class.getName()).log(Level.SEVERE, null, ex);
    }
    return connection;
  }

  public static void main(String[] args) {
    System.out.println(getConnection());
  }

}
