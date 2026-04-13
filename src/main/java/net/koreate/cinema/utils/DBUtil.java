package net.koreate.cinema.utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {

    public static Connection getConnection() throws Exception {
        return DriverManager.getConnection(
            "jdbc:oracle:thin:@localhost:1521:xe",
            "final_project",
            "12345"
        );
    }	
	
}
