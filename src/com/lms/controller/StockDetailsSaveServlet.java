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

import com.lms.utilities.DBConnection;

@WebServlet("/saveStock")

public class StockDetailsSaveServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7699371904236922740L;

	public void doPost(HttpServletRequest req , HttpServletResponse res) throws ServletException, IOException{
		String book_id = req.getParameter("book_id");
		String auth_name = req.getParameter("auth_name");
		String category_name = req.getParameter("category_name");
		String no_of_books = req.getParameter("no_of_books");
		
		try {
			Connection con = DBConnection.getConnection();
			
			String message = "";
			boolean isValid = true;
			
			if(book_id==null || book_id.isEmpty()){
				isValid = false;
				message ="Book name can't be left blank";
			}else if(no_of_books==null || no_of_books.isEmpty()){
				isValid = false;
				message ="No of books can't be left blank";
			}else{
				PreparedStatement readStmt = con.prepareStatement("select count(1) as isExists from stock_details where book_id=?");
				readStmt.setInt(1, Integer.parseInt(book_id));
				ResultSet rSet = readStmt.executeQuery();
				rSet.next();
				
				if(rSet.getString("isExists") != null 
						&& Integer.parseInt(rSet.getString("isExists")) > 0){
					isValid = false;
					message = "Stock details for this book is already exists";
				}
			}
			
			if(!isValid){
				req.setAttribute("message", message);
				req.setAttribute("valid", false);
				req.setAttribute("book_id", book_id);
				req.setAttribute("auth_name", auth_name);
				req.setAttribute("category_name", category_name);
				req.setAttribute("no_of_books", no_of_books);
				req.getRequestDispatcher("action/stock_save").forward(req, res);
			}else{
				try{
					PreparedStatement readBookStmt = con.prepareStatement("select * from book_details where id=?");
					readBookStmt.setInt(1, Integer.parseInt(book_id));
					ResultSet rBookSet = readBookStmt.executeQuery();
					rBookSet.next();
					
					PreparedStatement stmt = con.prepareStatement("insert into stock_details(book_id,isbn_no,book_name,auth_id,auth_name,category_id,category_name,no_of_books) values(?,?,?,?,?,?,?,?)");
					stmt.setInt(1, Integer.parseInt(book_id));
					stmt.setString(2, rBookSet.getString("isbn_no"));
					stmt.setString(3, rBookSet.getString("book_name"));
					stmt.setInt(4, rBookSet.getInt("auth_id"));
					stmt.setString(5, rBookSet.getString("auth_name"));
					stmt.setInt(6, rBookSet.getInt("category_id"));
					stmt.setString(7, rBookSet.getString("category_name"));
					stmt.setInt(8, Integer.parseInt(no_of_books));
					
					int i = stmt.executeUpdate();
					if(i==1){
						req.setAttribute("message", "Stock Details saved successfully");
						req.getRequestDispatcher("action/stock_save").forward(req, res);
					}
				}catch(Exception e){e.printStackTrace();}
			}
		}catch(Exception e){e.printStackTrace();} 	
	}
}
