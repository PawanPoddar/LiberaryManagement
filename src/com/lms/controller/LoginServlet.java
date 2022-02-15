package com.lms.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lms.utilities.DBConnection;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8727783429770925865L;
	
	public void doPost(HttpServletRequest req , HttpServletResponse res){
		String uri= req.getRequestURI();
		System.out.println(uri);
		String username=req.getParameter("uname");
		String upassword=req.getParameter("upasswd");	
		try{
			boolean isValid = true;
			String message="";
			if(username==null||username.isEmpty()){
				isValid = false;
				message = "Please enter username";
			}else if(upassword==null||upassword.isEmpty()){
				isValid = false;
				message = "Please enter password";
			}
			if(!isValid){
				req.setAttribute("message", message);
				req.getRequestDispatcher("index.jsp").include(req, res);
			}else{
				try{
					Connection con = DBConnection.getConnection();
					PreparedStatement stmt=con.prepareStatement("SELECT username,email,password FROM user_details WHERE email=? OR username=? LIMIT 1");
					stmt.setString(1, username);
					stmt.setString(2, username);
					ResultSet rs = stmt.executeQuery();
					
					String dbUpass = null;
					
					int idx = 0;
					while(rs.next()){
						idx++;
						dbUpass = rs.getString(3);
					}
					
					if(idx==0){
						req.setAttribute("message", "Username OR Email didn't find");
						req.getRequestDispatcher("index.jsp").include(req, res);
					}else{
						if(!dbUpass.equals(upassword)){
							req.setAttribute("message", "Incorrect password");
							req.getRequestDispatcher("index.jsp").include(req, res);
						}else{
							req.getSession().setAttribute("login_user", true);
							req.getRequestDispatcher("action/adminPanel").forward(req, res);
						}
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