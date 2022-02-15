package com.lms.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lms.utilities.DBConnection;

@WebServlet("/deleteStock")
public class StockDetailsDeleteServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 2340406181486647372L;

	public void doGet(HttpServletRequest req , HttpServletResponse res){
		String id = req.getParameter("id");
		
		try{
			Connection con = DBConnection.getConnection();
			
			PreparedStatement stmt = con.prepareStatement("delete from stock_details where id=?");
			stmt.setString(1, id);
			stmt.executeUpdate();
			res.sendRedirect(req.getContextPath() + "/jsp/stock_list.jsp");
		}catch(Exception e){e.printStackTrace();}
	}
}
