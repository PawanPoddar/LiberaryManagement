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

@WebServlet("/add_student")

public class StudentSaveServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 3297626224187400259L;

	public void doPost(HttpServletRequest req , HttpServletResponse res) throws ServletException, IOException{
		
		String student_id = req.getParameter("student_id");
		String student_name = req.getParameter("student_name");
		String student_address = req.getParameter("student_address");
		String student_tel = req.getParameter("student_tel");
		String date_of_reg = req.getParameter("date_of_reg");
		
		boolean isValid = true;
		String message = "";
		
		if(student_id==null || student_id.isEmpty()){
			isValid = false;
			message = "ID can't be left blank";
		}else if(student_name==null || student_name.isEmpty()){
			isValid = false;
			message = "Name can't be left blank";
		}else if(student_address==null || student_address.isEmpty()){
			isValid = false;
			message = "Address can't be left blank";
		}else if(student_tel==null || student_tel.isEmpty()){
			isValid = false;
			message = "Tel No. can't be left blank";
		}else if(date_of_reg==null || date_of_reg.isEmpty()){
			isValid = false;
			message = "Date can't be left blank";
		}
		if(!isValid){
			req.setAttribute("message", message);
			req.getRequestDispatcher("action/student_details").forward(req, res);
		}else{
			try{
				Connection con = DBConnection.getConnection();
				PreparedStatement stmt = con.prepareStatement("insert into student_details values(?,?,?,?,?)");
				stmt.setString(1, student_id);
				stmt.setString(2, student_name);
				stmt.setString(3, student_address);
				stmt.setString(4, student_tel);
				stmt.setString(5, date_of_reg);
				int i = stmt.executeUpdate();
				
				if(i==1){
					req.setAttribute("message", "Student details saved successfully");
					req.getRequestDispatcher("action/student_details").forward(req, res);
				}
			}catch(Exception e){e.printStackTrace();}
		}
	}

}
