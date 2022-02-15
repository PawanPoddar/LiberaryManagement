package com.lms.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lms.utilities.DBConnection;

@WebServlet("/updateBook")
public class BookUpdateServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 593778099932195941L;

	public void doPost(HttpServletRequest req , HttpServletResponse res) throws ServletException, IOException{
		boolean isValid = true;
		String message = "";
		
		String id = req.getParameter("id");
		String isbn = req.getParameter("isbn_no");
		String auth_id = req.getParameter("auth_id");
		String category_id = req.getParameter("category_id");
		String book_name = req.getParameter("book_name");
		String price = req.getParameter("price");
		String cd = req.getParameter("cd");
		
		if(book_name==null || book_name.isEmpty()){
			isValid = false;
			message = "Enter the book name";
		}else if(auth_id==null || auth_id.isEmpty()){
			isValid = false;
			message = "Enter the author name";
		}else if(category_id==null || category_id.isEmpty()){
			isValid = false;
			message = "Enter the category";
		}else if(price==null || price.isEmpty()){
			isValid = false;
			message = "Enter the price";
		}else if(cd==null || cd.isEmpty()){
			isValid = false;
			message = "Enter the cd availability";
		}
		
		if(!isValid){
			req.setAttribute("message", message);
			req.setAttribute("isbn", isbn);
			req.setAttribute("book_name", book_name);
			req.setAttribute("auth_id", auth_id);
			req.setAttribute("category", category_id);
			req.setAttribute("price", price);
			req.setAttribute("cd", cd);
			req.getRequestDispatcher("action/book_update").forward(req, res);
		}
		else{
			try{
				Connection con = DBConnection.getConnection();
				
				PreparedStatement readAuthorStmt = con.prepareStatement("select auth_name from author_details where id=?");
				readAuthorStmt.setInt(1, Integer.parseInt(auth_id));
				ResultSet rAuthSet = readAuthorStmt.executeQuery();
				rAuthSet.next();
				
				PreparedStatement readCategoryStmt = con.prepareStatement("select category_name from category_list where id=?");
				readCategoryStmt.setInt(1, Integer.parseInt(category_id));
				ResultSet rCatSet = readCategoryStmt.executeQuery();
				rCatSet.next();
				
				PreparedStatement stmt = con.prepareStatement("update book_details set auth_id=?,auth_name=?,category_id=?,category_name=?,book_name=?,price=?,cd_y_n=? where id=?");
				
				stmt.setInt(1, Integer.parseInt(auth_id));
				stmt.setString(2, rAuthSet.getString("auth_name"));
				stmt.setInt(3, Integer.parseInt(category_id));
				stmt.setString(4, rCatSet.getString("category_name"));
				stmt.setString(5, book_name);
				stmt.setString(6, price);
				stmt.setString(7, cd);
				stmt.setInt(8, Integer.parseInt(id));
				
				int i=stmt.executeUpdate();
				if(i==1){
					HttpSession session = req.getSession(false);
					
					session.setAttribute("message", "Book details updated successfully");
					res.sendRedirect(req.getContextPath() + "/jsp/book_update.jsp?id="+id);
				}
			}catch(Exception e){e.printStackTrace();}
		}
	}
}