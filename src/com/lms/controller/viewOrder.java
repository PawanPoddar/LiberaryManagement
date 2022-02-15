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
 * Servlet implementation class viewOrder
 */
@WebServlet("/viewOrder")
public class viewOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
			PrintWriter out=response.getWriter();
			out.print("<html>");
		 out.println("<form action='/LibManSys/Status' method='get'>");
			out.print("<table>");
			out.print("<th> Order ID</th>");
			out.print("<th> Name</th>");
			out.print("<th> Addreess</th>");
			out.print("<th> Product ID</th>");
			out.print("<th> STATUS</th>");
			out.print("<th> Order Date</th>");
			out.print("<th> Deliver Date</th>");
			 out.println("<tbody>");
	    	
	    		try{
	    			Connection con = DBConnection.getConnection();
	    			Statement stmt = con.createStatement();
	    			ResultSet rs = stmt.executeQuery("select * from order_detail");
	    		out.print("<style> table, th, td { border:1px solid black;}</style>");
	    	 
	    		while(rs.next()){ 
	    			out.println("<tr>");
	    			out.println("<input type='hidden' value="+rs.getString("order_id")+" name='order_id'>");
	    			
	    			    out.println("<td>"+rs.getString("order_id")+"</td>");
	    				out.println("<td>"+rs.getString("user_name")+"</td>");
	    				out.println("<td>"+rs.getString("address")+"</td>");
	    				out.println("<td>"+rs.getString("id")+"</td>");
	    				out.println("<td>"+rs.getString("status")+"</td>");
	    				out.println("<td>"+rs.getString("order_date")+"</td>");
	    				out.println("<td>"+rs.getString("delivery_date")+"</td>");
	    				out.println("<td><input type='submit' value='ChangeStatus'></td>");
	    				
	    			 out.println("</tr>");
	    		
	    			}
	    		    }catch(Exception e){e.printStackTrace();}
	    		
		   	out.println("</tbody>");
			out.print("<tr></tr>");
			
			out.print("</table>");
			out.println("</form>");
			out.print("</html>");
	}

}
