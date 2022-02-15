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

@WebServlet("/updateStock")

public class StockDetailsUpdaeServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7699371904236922740L;

	public void doPost(HttpServletRequest req , HttpServletResponse res) throws ServletException, IOException{
		String id = req.getParameter("id");
		String book_name = req.getParameter("book_name");
		String auth_name = req.getParameter("auth_name");
		String category_name = req.getParameter("category_name");
		String no_of_books = req.getParameter("no_of_books");
		
		try {
			Connection con = DBConnection.getConnection();
			
			String message = "";
			boolean isValid = true;
			
			if(no_of_books==null || no_of_books.isEmpty()){
				isValid = false;
				message ="No of books can't be left blank";
			}
			
			if(!isValid){
				req.setAttribute("message", message);
				req.setAttribute("valid", false);
				req.setAttribute("id", id);
				req.setAttribute("book_name", book_name);
				req.setAttribute("auth_name", auth_name);
				req.setAttribute("category_name", category_name);
				req.setAttribute("no_of_books", no_of_books);
				req.getRequestDispatcher("action/stock_update").forward(req, res);
			}else{
				try{
					PreparedStatement stmt = con.prepareStatement("update stock_details set no_of_books=? where id=?");
					stmt.setInt(1, Integer.parseInt(no_of_books));
					stmt.setInt(2, Integer.parseInt(id));
					
					int i = stmt.executeUpdate();
					if(i==1){
						req.setAttribute("message", "Stock Details updated successfully");
						req.getRequestDispatcher("action/stock_update").forward(req, res);
					}
				}catch(Exception e){e.printStackTrace();}
			}
		}catch(Exception e){e.printStackTrace();} 	
	}
}
