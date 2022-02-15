package com.lms.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lms.utilities.DBConnection;

@WebServlet("/addCategory")

public class CategorySaveServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = -2874469933857169690L;

	public void doPost(HttpServletRequest req , HttpServletResponse res) throws ServletException, IOException{
	   String category_name = req.getParameter("category_name");
	  		   
	   String message = "";
	   boolean isValid = true;
	   if(category_name==null || category_name.isEmpty()){
		   isValid = false;
		   message = "Enter the category";
	   }
	   
	   if(!isValid){
		   req.setAttribute("message", message);
		   req.setAttribute("cat_name", category_name);
		   req.getRequestDispatcher("action/category_save").forward(req, res);
	   }
	   else{
		   try{
			   Connection con = DBConnection.getConnection();

				Statement readStmt = con.createStatement();
				ResultSet rSet = readStmt.executeQuery("select max(id) as maxId from category_list");
				rSet.next();
				
				Integer maxId = null;
				if(rSet.getString("maxId") == null){
					maxId = 1;
				}else{
					maxId = Integer.parseInt(rSet.getString("maxId")) + 1;
				}
								
				PreparedStatement stmt = con.prepareStatement(
						"insert into category_list (cat_id,category_name) values(?,?)");
				stmt.setString(1, "C" + "00" + maxId);
				stmt.setString(2, category_name);
				
				int i = stmt.executeUpdate();
				if(i==1){
					//if request is not from HttpServletRequest, you should do a typecast before
					HttpSession session = req.getSession(false);
					
					//save message in session
					session.setAttribute("message", "Category details saved successfully");
					res.sendRedirect(req.getContextPath() + "/jsp/category_save.jsp");
				}
			}catch(Exception e){e.printStackTrace();}
	   	}
	}
}