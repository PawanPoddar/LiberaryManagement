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
import javax.servlet.http.HttpSession;

import com.lms.utilities.DBConnection;


@WebServlet("/updateAuthor")
public class AuthorUpdateServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = -4774033022910169196L;
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		boolean isValid = true;
		String message = "";
		
		String id = req.getParameter("id");
		String auth_id = req.getParameter("auth_id");
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
		
		//if request is not from HttpServletRequest, you should do a typecast before
		HttpSession session = req.getSession(false);
		if(!isValid){
			req.setAttribute("message", message);
			req.setAttribute("id", id);
			req.setAttribute("auth_id", auth_id);
			req.setAttribute("name", auth_name);
			req.setAttribute("address", address);
			req.setAttribute("tel_no", tel_no);
			req.setAttribute("speciality", speciality);
			//res.sendRedirect(req.getContextPath() + "/jsp/author_update.jsp?id="+id);
			req.getRequestDispatcher("action/author_update").forward(req, res);
		}else{
			try{
				Connection con = DBConnection.getConnection();
				PreparedStatement stmt = con.prepareStatement(
						"update author_details set auth_name=?, auth_address=?, auth_tel_no=?, specialty=? where id=? and auth_id=?");
				stmt.setString(1, auth_name);
				stmt.setString(2, address);
				stmt.setString(3, tel_no);
				stmt.setString(4, speciality);
				stmt.setString(5, id);
				stmt.setString(6, auth_id);
				
				int i = stmt.executeUpdate();
				if(i==1){
					//save message in session
					session.setAttribute("message", "Author details updated successfully");
					res.sendRedirect(req.getContextPath() + "/jsp/author_update.jsp?id="+id);
				}
			}catch(Exception e){e.printStackTrace();}
		}
	}
}
