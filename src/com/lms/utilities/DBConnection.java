package com.lms.utilities;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

	private static Connection connection;
	
	public static Connection getConnection(){
		if(connection == null){
			try {
				Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
				connection = DriverManager.getConnection(
						PropertyReader.getPropValues("db.url"),
						PropertyReader.getPropValues("db.user"),
						PropertyReader.getPropValues("db.password"));
			} catch (InstantiationException | IllegalAccessException | ClassNotFoundException | SQLException e) {
				e.printStackTrace();
			}
		}
		
		return connection;
	}
}