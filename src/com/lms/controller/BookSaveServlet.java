package com.lms.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lms.utilities.DBConnection;

@WebServlet("/saveBook")
public class BookSaveServlet extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8719906990200469004L;

	public void doPost(HttpServletRequest req, HttpServletResponse res){
		String isbn = req.getParameter("isbn_no");
		String book_name = req.getParameter("book_name");
		String auth_id = req.getParameter("auth_id");
		String category_id = req.getParameter("category_id");
		String price = req.getParameter("price");
		String cd = req.getParameter("cd_y_n");
		
		try{
			Connection con = DBConnection.getConnection();
			
			String message="";
			boolean isValid=true;
			if(isbn==null || isbn.isEmpty()){
				isValid = false;
				message = "Enter the isbn no.";
			}else if(auth_id==null || auth_id.isEmpty()){
				isValid = false;
				message = "Enter the author name";
			}else if(book_name==null || book_name.isEmpty()){
				isValid = false;
				message = "Enter the book name";
			}else if(category_id==null || category_id.isEmpty()){
				isValid = false;
				message = "Enter the category";
			}else if(price==null || price.isEmpty()){
				isValid = false;
				message = "Enter the price";
			}else if(cd==null || cd.isEmpty()){
				isValid = false;
				message = "Enter the cd availability";
			}else {
				PreparedStatement readStmt = con.prepareStatement("select count(1) as isbnExists from book_details where isbn_no=? and auth_id=? and category_id=?");
				readStmt.setString(1, isbn);
				readStmt.setInt(2, Integer.parseInt(auth_id));
				readStmt.setInt(3, Integer.parseInt(category_id));
				ResultSet rSet = readStmt.executeQuery();
				rSet.next();
				
				if(rSet.getString("isbnExists") != null 
						&& Integer.parseInt(rSet.getString("isbnExists")) > 0){
					isValid = false;
					message = "ISBN No already exists";
				}
			}
			
			if(!isValid){
				req.setAttribute("message", message);
				req.setAttribute("valid", false);
				req.setAttribute("isbn", isbn);
				req.setAttribute("book_name", book_name);
				req.setAttribute("auth_id", auth_id);
				req.setAttribute("category_id", category_id);
				req.setAttribute("price", price);
				req.setAttribute("cd", cd);
				req.getRequestDispatcher("action/book_save").forward(req, res);
			}
			else{
				try{
					PreparedStatement readAuthorStmt = con.prepareStatement("select auth_name from author_details where id=?");
					readAuthorStmt.setInt(1, Integer.parseInt(auth_id));
					ResultSet rAuthSet = readAuthorStmt.executeQuery();
					rAuthSet.next();
					
					PreparedStatement readCategoryStmt = con.prepareStatement("select category_name from category_list where id=?");
					readCategoryStmt.setInt(1, Integer.parseInt(category_id));
					ResultSet rCatSet = readCategoryStmt.executeQuery();
					rCatSet.next();
					
					PreparedStatement stmt = con.prepareStatement("insert into book_details(isbn_no,auth_id,auth_name,category_id,category_name,book_name,price,cd_y_n) values(?,?,?,?,?,?,?,?)");
					stmt.setString(1, isbn);
					stmt.setInt(2, Integer.parseInt(auth_id));
					stmt.setString(3, rAuthSet.getString("auth_name"));
					stmt.setInt(4, Integer.parseInt(category_id));
					stmt.setString(5, rCatSet.getString("category_name"));
					stmt.setString(6, book_name);
					stmt.setString(7, price);
					stmt.setString(8, cd);
					
					int i=stmt.executeUpdate();
					if(i==1){
						HttpSession session = req.getSession(false);
						
						session.setAttribute("message", "Book details saved successfully");
						res.sendRedirect(req.getContextPath() + "/jsp/book_save.jsp");
					}
				}catch(Exception e){e.printStackTrace();}
			}
		}catch(Exception e){e.printStackTrace();}
	}
}
