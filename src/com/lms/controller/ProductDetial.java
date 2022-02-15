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
@WebServlet("/productDetail")
public class ProductDetial extends HttpServlet{
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String product_name = req.getParameter("product");
		String price=req.getParameter("price");
		String qty=req.getParameter("qty");
		System.out.print(""+product_name);
		
		try {
			Connection connection = DBConnection.getConnection();
			PreparedStatement stmt = connection.prepareStatement("insert into shoping(product_name,price,qty) values(?,?,?)");
			stmt.setString(1,product_name);
			stmt.setInt(2, Integer.parseInt(price));
			stmt.setInt(3, Integer.parseInt(qty));
			
			stmt.execute();
			 resp.sendRedirect(req.getContextPath() + "/ShopingCart.jsp");

		}
		catch(Exception e) {
			
		System.err.print(e);
		}
		
		
	}
	

}
