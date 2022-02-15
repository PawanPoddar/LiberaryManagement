package com.lms.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lms.utilities.DBConnection;
@WebServlet("/deleteMembership")
public class MembershipDeleteServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7294697395409207692L;

	public void doGet(HttpServletRequest req , HttpServletResponse res){
		String id = req.getParameter("id");
		
		try{
			Connection con = DBConnection.getConnection();
			
			PreparedStatement stmt = con.prepareStatement("delete from membership_type where id=?");
			stmt.setString(1, id);
			stmt.executeUpdate();
			res.sendRedirect(req.getContextPath() + "/jsp/membership_list.jsp");
		}catch(Exception e){e.printStackTrace();}
	}
}
