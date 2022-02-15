package com.lms.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lms.utilities.DBConnection;

@WebServlet("/addJobDetails")

public class EmployeeJobsSaveServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 2561732622283501211L;

	public void doPost(HttpServletRequest req , HttpServletResponse res) throws ServletException, IOException{
		String message = "";
		boolean isValid = true;
		
		String id = req.getParameter("id");
		String emp_id = req.getParameter("emp_id");
		String emp_post = req.getParameter("emp_post");
		String emp_salary = req.getParameter("emp_salary");
		String date_of_join = req.getParameter("date_of_join");
		
		if(emp_id==null || emp_id.isEmpty()){
			isValid = false;
			message ="Employee Id can't be left blank";
		}else if(emp_post==null || emp_post.isEmpty()){
			isValid = false;
			message ="Post can't be left blank";
		}else if(emp_salary==null || emp_salary.isEmpty()){
			isValid = false;
			message ="Salary can't be left blank";
		}else if(date_of_join==null || date_of_join.isEmpty()){
			isValid = false;
			message ="Date of Join can't be left blank";
		}
		if(!isValid){
			req.setAttribute("message", message);
			req.setAttribute("id", id);
			req.setAttribute("emp_id", emp_id);
			req.setAttribute("emp_post", emp_post);
			req.setAttribute("emp_salary", emp_salary);
			req.setAttribute("date_of_join", date_of_join);
			req.getRequestDispatcher("action/emp_job_details_save").forward(req, res);
		}else{
			try{
				Connection con = DBConnection.getConnection();
				PreparedStatement stmt = con.prepareStatement("insert into employee_job_details(emp_id,emp_post,emp_salary,date_of_join) values(?,?,?,?)");
				stmt.setString(1, id);
				stmt.setString(2, emp_post);
				stmt.setString(3, emp_salary);
				stmt.setString(4, date_of_join);
				int i = stmt.executeUpdate();
				
				if(i==1){
					//if request is not from HttpServletRequest, you should do a typecast before
					HttpSession session = req.getSession(false);
					
					//save message in session
					session.setAttribute("message", "Employee Job details saved successfully");
					res.sendRedirect(req.getContextPath() + "/jsp/emp_job_details_save.jsp?id="+id);
				}
			}catch(Exception e){e.printStackTrace();}
		}
	}
}
