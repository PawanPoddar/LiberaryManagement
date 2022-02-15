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
@WebServlet("/updateEmployee")
public class EmployeeUpdateServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6763454041610206085L;

	public void doPost(HttpServletRequest req , HttpServletResponse res) throws ServletException, IOException{
		boolean isValid = true;
		String message = ""; 
		
		int id = Integer.parseInt(req.getParameter("id"));
		String emp_id = req.getParameter("emp_id");
		String emp_name = req.getParameter("emp_name");
		String emp_address = req.getParameter("emp_address");
		String emp_tel_no = req.getParameter("emp_tel_no");
		String emp_dob = req.getParameter("emp_dob");
		
		if(emp_name==null || emp_name.isEmpty()){
			isValid = false;
			message = "Employee name can't be left blank";
		}else if(emp_address==null || emp_address.isEmpty()){
			isValid = false;
			message = "Address can't be left blank";
		}else if(emp_tel_no==null || emp_tel_no.isEmpty()){
			isValid = false;
			message = "Tel. No. can't be left blank";
		}else if(!Pattern.matches("^[\\d]{10,10}$",emp_tel_no)){
			isValid = false;
			message = "Tel No. should be 10 digits";
		}else if(emp_dob==null || emp_dob.isEmpty()){
			isValid = false;
			message = "Date of Birth can't be left blank";
		}
		
		if(!isValid){
			req.setAttribute("message", message);
			req.setAttribute("id", id);
			req.setAttribute("emp_id", emp_id);
			req.setAttribute("emp_name", emp_name);
			req.setAttribute("emp_address", emp_address);
			req.setAttribute("emp_tel_no", emp_tel_no);
			req.setAttribute("emp_dob", emp_dob);
			req.getRequestDispatcher("action/emp_per_details_update").forward(req, res);
		}
		else{
			try{
				Connection con = DBConnection.getConnection();
				PreparedStatement stmt = con.prepareStatement(
						"update employee_personal_details set emp_name=?,emp_address=?,emp_tel_no=?,emp_dob=? where id=?");
			
				stmt.setString(1, emp_name);
				stmt.setString(2, emp_address);
				stmt.setString(3, emp_tel_no);
				stmt.setString(4, emp_dob);
				stmt.setInt(5, id);
				
				int i = stmt.executeUpdate();
				if(i==1){
					//if request is not from HttpServletRequest, you should do a typecast before
					HttpSession session = req.getSession(false);
					
					//save message in session
					session.setAttribute("message", "Employee details update successfully");
					res.sendRedirect(req.getContextPath() + "/jsp/emp_per_details_update.jsp?id="+id);
				}
			}catch(Exception e){e.printStackTrace();}
		}
	}
}
