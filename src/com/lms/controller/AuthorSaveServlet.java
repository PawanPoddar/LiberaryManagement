package com.lms.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lms.utilities.DBConnection;


@WebServlet("/saveAuthor")
public class AuthorSaveServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = -4774033022910169196L;
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		boolean isValid = true;
		String message = "";
		
		String auth_name = req.getParameter("name");
		String address = req.getParameter("address");
		String tel_no = req.getParameter("tel_no");
		String speciality = req.getParameter("speciality");
		
		if(auth_name==null || auth_name.isEmpty()){
			isValid = false;
			message = "Name can't be left blank";
		}else if(address==null || address.isEmpty()){
			isValid = false;
			message = "Address can't be left blank";
		}else if(tel_no==null || tel_no.isEmpty()){
			isValid = false;
			message = "Tel No. can't be left blank";
		}else if(!Pattern.matches("^[\\d]{10,10}$",tel_no)){
			isValid = false;
			message = "Tel No. should be 10 digits";
		}else if(speciality==null || speciality.isEmpty()){
			isValid = false;
			message = "Speciality can't be left blank";
		}
		
		if(!isValid){
			req.setAttribute("message", message);
			req.setAttribute("name", auth_name);
			req.setAttribute("address", address);
			req.setAttribute("tel_no", tel_no);
			req.setAttribute("speciality", speciality);
			req.getRequestDispatcher("action/author_save").forward(req, res);
		}else{
			try{
				Connection con = DBConnection.getConnection();
				
				Statement readStmt = con.createStatement();
				ResultSet rSet = readStmt.executeQuery("select max(id) as maxId from author_details");
				rSet.next();
				
				Integer maxId = null;
				if(rSet.getString("maxId") == null){
					maxId = 1;
				}else{
					maxId = Integer.parseInt(rSet.getString("maxId")) + 1;
				}
								
				PreparedStatement stmt = con.prepareStatement(
						"insert into author_details (auth_id,auth_name,auth_address,auth_tel_no,specialty) values(?,?,?,?,?)");
				stmt.setString(1, "A" + "00" + maxId);
				stmt.setString(2, auth_name);
				stmt.setString(3, address);
				stmt.setString(4, tel_no);
				stmt.setString(5, speciality);
				
				int i = stmt.executeUpdate();
				if(i==1){
					//if request is not from HttpServletRequest, you should do a typecast before
					HttpSession session = req.getSession(false);
					
					//save message in session
					session.setAttribute("message", "Author details saved successfully");
					res.sendRedirect(req.getContextPath() + "/jsp/author_save.jsp");
				}
			}catch(Exception e){e.printStackTrace();}
		}
	}
}
