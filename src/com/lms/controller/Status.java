package com.lms.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lms.utilities.DBConnection;

/**
 * Servlet implementation class Status
 */
@WebServlet("/Status")
public class Status extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String or=req.getParameter("order_id");
		

	
		try {
			Connection connection = DBConnection.getConnection();
//			String qr="select *from shoping where product_name='+product_name+'";
			
			Statement st = connection.createStatement();
			ResultSet rs = st.executeQuery("select status from order_detail where order_id="+or);
////			System.out.print("resutlt set llllll"+rs);
			String qri="";
			while(rs.next()) {
				String s=rs.getString("status");
				if(s.equals("N")) {
				   qri="update order_detail set status='Y' where order_id="+or;
					
				}else {
					qri="update order_detail set status='N' where order_id="+or;
					
				}
			}
			st.executeUpdate(qri);
			resp.sendRedirect("/LibManSys/viewOrder");  
			
			rs.close();
			
			
		}
		catch(Exception e) {
			
		System.err.print(e);
		}
	}	

}
