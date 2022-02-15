package com.lms.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lms.utilities.DBConnection;

@WebServlet("/deleteBook")
public class BookDeleteServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = -4283350613615037170L;

	public void doGet(HttpServletRequest req , HttpServletResponse res){
		String id = req.getParameter("id");
		try{
			Connection con = DBConnection.getConnection();
			
			PreparedStatement stmt = con.prepareStatement("delete from book_details where id=?");
			stmt.setInt(1, Integer.parseInt(id));
			stmt.executeUpdate();
			res.sendRedirect(req.getContextPath() + "/jsp/book_list.jsp");
		}catch(Exception e){e.printStackTrace();}
		
	}
}
