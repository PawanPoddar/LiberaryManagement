package com.lms.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lms.utilities.DBConnection;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6382614472274024068L;
	
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException, ServletException{
		   
		String name=req.getParameter("name");
		String email=req.getParameter("email");
		String username=req.getParameter("username");
		String password=req.getParameter("password1");
		String re_password=req.getParameter("password2");
		String address=req.getParameter("address");
		String mob_no=req.getParameter("mobile_no");
		String gender=req.getParameter("gender");
		try{
			boolean isValid = true;
		   
			String message = "";
			if(name==null||name.isEmpty()){
				isValid = false;
				message = "Name can't be left blank";
			}else if(email==null||email.isEmpty()){
				isValid = false;
				message = "Email can't be left blank";
			}else if(username==null||username.isEmpty()){
				isValid = false;
				message = "Username can't be left blank";
			}else if(password==null||password.isEmpty()){
				isValid = false;
				message = "Password can't be left blank";
			}else if(re_password==null||re_password.isEmpty()){
				isValid = false;
				message = "Confirm Password can't be left blank";
			}else if(gender==null||gender.isEmpty()){
				isValid = false;
				message = "Gender can't be left blank";
			}else if(!password.equals(re_password)) {
				isValid = false;
				message = "Both Password(s) not matched";
			}else if(!Pattern.matches("[\\w-.]+@([\\w-\\.])+[\\w-]+",email)){
				isValid = false;
				message = "Invalid email format";
			}
		   
			if(!isValid){
				req.setAttribute("message", message);
				req.getRequestDispatcher("action/signup").forward(req, res);
			}else{
				try{
					Connection con = DBConnection.getConnection();
					PreparedStatement stmt = con.prepareStatement("insert into user_details values(?,?,?,?,?,?,?,?,?)");
					stmt.setString(1,name);
					stmt.setString(2, username);
					stmt.setString(3, email);
					stmt.setString(4, password);
					stmt.setString(5, gender);
					stmt.setString(6, mob_no);
					stmt.setString(7, address);
					stmt.setLong(8, System.currentTimeMillis()/1000);
					stmt.setInt(9, 1);
					int i = stmt.executeUpdate();  
					con.close();
					
					if(i==1){
						req.setAttribute("message", "User registered successfully");
						req.getRequestDispatcher("index.jsp").forward(req, res);
					}
				}catch(Exception e){
					e.printStackTrace();
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}