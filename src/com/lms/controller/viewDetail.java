package com.lms.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.lms.utilities.DBConnection;
/**
 * Servlet implementation class viewDetail
 */
@WebServlet("/viewDetail")
public class viewDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
			PrintWriter out=response.getWriter();
			out.print("<html>");
			out.print("<style> table, th, td { border:1px solid black;}</style>");
			out.print("<table>");
			out.print("<th> Products</th>");
			out.print("<th> Price</th>");
			out.print("<th> Quantity</th>");
			 out.println("<tbody>");
	    	
	    		try{
	    			Connection con = DBConnection.getConnection();
	    			Statement stmt = con.createStatement();
	    			ResultSet rs = stmt.executeQuery("select * from shoping");
	    		
	    
	    		while(rs.next()){ 
	    			out.println("<tr>");
	    			    out.println("<td>"+rs.getString("product_name")+"</td>");
	    				out.println("<td>"+rs.getString("price")+"</td>");
	    				out.println("<td>"+rs.getString("qty")+"</td>");
	    				
	    			 out.println("</tr>");
	    		
	    			}
	    		    }catch(Exception e){e.printStackTrace();}
	    		
		   	out.println("</tbody>");
			out.print("<tr></tr>");
		
			out.print("</table>");
			out.print("</html>");
	}

	

}
