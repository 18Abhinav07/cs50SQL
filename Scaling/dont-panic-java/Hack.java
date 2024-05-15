import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Scanner;

public class Hack {
    public static void main(String[] args) throws Exception {
        // Establishing connection to the SQLite database
        Connection sqliteConnection = DriverManager.getConnection("jdbc:sqlite:dont-panic.db");

        // Prompting the user for the new password
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter the new password: ");
        String password = scanner.nextLine();

        // SQL query to update the password for the admin user
        String query = """
            UPDATE "users"
            SET "password" = ?
            WHERE "username" = 'admin';
        """;

        // Creating a prepared statement and setting the password parameter
        PreparedStatement sqliteStatement = sqliteConnection.prepareStatement(query);
        sqliteStatement.setString(1, password);

        // Executing the SQL update statement
        sqliteStatement.executeUpdate();

        // Closing resources
        sqliteStatement.close();
        sqliteConnection.close();
        scanner.close();

        // Confirmation message
        System.out.println("Password updated successfully!");
    }
}
