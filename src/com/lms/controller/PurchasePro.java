package com.lms.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lms.utilities.DBConnection;

@WebServlet("/purchaseProduct")
public class PurchasePro extends HttpServlet {
	
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		String product_name = req.getParameter("product");
//		String qty=req.getParameter("qty");
//		String a=req.getParameter("price");
		String id=req.getParameter("id");

		System.out.print(""+id);
		PrintWriter out=resp.getWriter();
		try {
			Connection connection = DBConnection.getConnection();
			Statement st = connection.createStatement();
			ResultSet rs = st.executeQuery("select *from shoping where id="+id);			
			out.println("<html>");
			out.println("<form action='/LibManSys/checkout' method='get'>");
			out.print ("Your Name :<input type='text' name='user'>");
			out.print ("Address :<input type='text' name='address'>");
			while(rs.next()) {
				out.println("<table>");
				out.println("<input type='hidden' value="+rs.getString("id")+" name='id'>");
				out.println("<input type='hidden' value="+rs.getString("product_name")+" name='product'>");
//				out.println("<input type='hidden' value="+rs.getString("qty")+" name='qty'>");
				out.println("<input type='hidden' value="+rs.getString("price")+" name='price'>");
				out.print("Product:");
				out.print("<p name='product' value="+rs.getString("product_name")+">"+rs.getString("product_name")+"</p>");
				out.print("Price:");
				out.print("<p name='price' value="+rs.getString("price")+">"+rs.getString("price")+"</p>");
			
				out.print ("Qty :<input type='text' name='qty's>");
				out.println("<input type='submit' value='Buy'>");
				out.println("</table>");
			}
			
	    	out.println("</form>");
	    	out.println("</html>");
			
//			int total=Integer.parseInt(a)*Integer.parseInt(qty);
//			int total=5;
//			 resp.sendRedirect(req.getContextPath() + "/checkout?total="+total+"&product="+product_name+"&qty="+qty+"&q"+q);
			
			
		}
		catch(Exception e) {
			
		System.err.print(e);
		}
		
		
	}

}
