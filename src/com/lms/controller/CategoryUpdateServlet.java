package com.lms.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lms.utilities.DBConnection;

@WebServlet("/updateCategory")
public class CategoryUpdateServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1999858729581712243L;

	public void doPost(HttpServletRequest req , HttpServletResponse res) throws ServletException, IOException{
		boolean isValid = true;
		String message = "";
		
		String id = req.getParameter("id");
		String cat_name = req.getParameter("category");
		
		if(cat_name==null || cat_name.isEmpty()){
			isValid = false;
			message = "Name can't be left blank";
		}
		
		HttpSession session = req.getSession(false);
		if(!isValid){
			req.setAttribute("message", message);
			req.setAttribute("cat_name", cat_name);
			req.getRequestDispatcher("action/category_update").forward(req, res);
		}else{
			try{
				Connection con = DBConnection.getConnection();
				PreparedStatement stmt = con.prepareStatement(
						"update category_list set category_name=? where id=?");
				stmt.setString(1, cat_name);
				stmt.setInt(2, Integer.parseInt(id));
				
				
				int i = stmt.executeUpdate();
				if(i==1){
					session.setAttribute("message", "Category details updated successfully");
					res.sendRedirect(req.getContextPath() + "/jsp/category_update.jsp?id="+id);
				}
			}catch(Exception e){e.printStackTrace();}
		}
	}
}
