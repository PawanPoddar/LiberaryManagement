package com.lms.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lms.utilities.DBConnection;


@WebServlet("/deleteAuthor")
public class AuthorDeleteServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = -4774033022910169196L;
	
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		String id = req.getParameter("id");
		
		try{
			Connection con = DBConnection.getConnection();
			
			PreparedStatement stmt = con.prepareStatement("delete from author_details where id=?");
			stmt.setString(1, id);
			stmt.executeUpdate();
			res.sendRedirect(req.getContextPath() + "/jsp/author_list.jsp");
		}catch(Exception e){e.printStackTrace();}
	}
}
