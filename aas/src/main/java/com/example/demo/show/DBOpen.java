package com.example.demo.show;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBOpen {
    public Connection getConnection(){
        Connection con = null;
        try {
			String url = "jdbc:mariadb://192.168.14.14:3306/aas"; 
			String user = "team";
			String password = "1234";
			String driver = "org.mariadb.jdbc.Driver"; 
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
		} catch (Exception e) {
			System.out.println("MariaDB 연결 실패 : "+e);
		}
        return con;
    }
}