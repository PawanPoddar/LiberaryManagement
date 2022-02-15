package com.lms.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lms.utilities.DBConnection;
@WebServlet("/checkout")
public class checkout extends HttpServlet {
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String product_name = req.getParameter("product");
		String qty=req.getParameter("qty");
		String name=req.getParameter("user");
		String pr=req.getParameter("price");
		String id = req.getParameter("id");
		String address = req.getParameter("address");
		
		int total=Integer.parseInt(pr)*Integer.parseInt(qty);
		System.out.print(""+product_name);
		PrintWriter out=resp.getWriter();
		out.println("<html>");
		out.println("<h2>"+name+" Thank you for purchaing </h2>");
		out.println("<h2>Product : "+product_name+"</h2>");
		out.println("<h2>Qunatity : "+qty+"</h2>");
		out.println("<h2>Amount : "+total+"</h2>");
		
		out.println("</html>");

		
		try {
			Connection connection = DBConnection.getConnection();
//			String qr="select *from shoping where product_name='+product_name+'";
			PreparedStatement stmt = connection.prepareStatement("insert into order_detail(user_name,address,status,id,order_date,delivery_date) values(?,?,?,?,?,?)");
			stmt.setString(1,name);
			stmt.setString(2,address);
			stmt.setString(3,"N");
			stmt.setString(4,id);
			long millis=System.currentTimeMillis();  
			java.sql.Date date=new java.sql.Date(millis);  
			stmt.setString(5,String.valueOf(date));
			LocalDate cdate =  LocalDate.now();
			LocalDate curr = cdate.plusDays(1);
			stmt.setString(6,String.valueOf(curr));
			
			
			
			stmt.execute();
			out.println("successfully insert");
			Statement st = connection.createStatement();
			ResultSet rs = st.executeQuery("select *from shoping where id="+id);
////			System.out.print("resutlt set llllll"+rs);
			
			int val=1;
			while(rs.next()) {
				val=Integer.parseInt(rs.getString("qty"))-Integer.parseInt(qty);
					
			}
			String qri="update shoping set qty="+val+" where id="+id;
			Statement stm = connection.createStatement();
			stm.executeUpdate(qri);
			
			
			
			
			
		}
		catch(Exception e) {
			
		System.err.print(e);
		}
	}	

}
