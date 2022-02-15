package com.lms.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lms.utilities.DBConnection;

@WebServlet("/deleteLateFee")
public class LateFeeDeleteServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 146382505717376699L;

	public void doGet(HttpServletRequest req , HttpServletResponse res){
		String id = req.getParameter("id");
		
		try{
			Connection con = DBConnection.getConnection();
			
			PreparedStatement stmt = con.prepareStatement("delete from late_fees where id=?");
			stmt.setString(1, id);
			stmt.executeUpdate();
			res.sendRedirect(req.getContextPath() + "/jsp/late_fee_list.jsp");
		}catch(Exception e){e.printStackTrace();}
	}
}