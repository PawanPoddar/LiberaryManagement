package com.lms.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lms.utilities.DBConnection;

@WebServlet("/saveLateFee")
public class LateFeeSaveServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3420720512449302538L;

	public void doPost(HttpServletRequest req , HttpServletResponse res) throws ServletException, IOException{
		boolean isValid = true;
		String message = "";
		
		String mem_type_id = req.getParameter("member_type");
		String days_10 = req.getParameter("days_10");
		String days_15 = req.getParameter("days_15");
		String days_30 = req.getParameter("days_30");
		String more_30 = req.getParameter("more_30");
		
		if(mem_type_id==null || mem_type_id.isEmpty()){
			isValid = false;
			message = "Select the member type";
		}else if(days_10==null || days_10.isEmpty()){
			isValid = false;
			message = "Days 0-10 can't be left blank";
		}else if(days_15==null || days_15.isEmpty()){
			isValid = false;
			message = "Days 11-15 can't be left blank";
		}else if(days_30==null || days_30.isEmpty()){
			isValid = false;
			message = "Days 16-30 can't be left blank";
		}else if(more_30==null || more_30.isEmpty()){
			isValid = false;
			message = "Days > 30 can't be left blank";
		}
		if(!isValid){
			req.setAttribute("message", message);
			req.setAttribute("mem_type_id", mem_type_id);
			req.setAttribute("days_10", days_10);
			req.setAttribute("days_15", days_15);
			req.setAttribute("days_30", days_30);
			req.setAttribute("more_30", more_30);
			req.getRequestDispatcher("action/late_fee_save").forward(req, res);
		}else{
			try{
				Connection con = DBConnection.getConnection();
				
				Statement readStmt = con.createStatement();
				ResultSet rs = readStmt.executeQuery("select * from membership_type where id='"+mem_type_id+"'");
				rs.next();
				
				PreparedStatement stmt = con.prepareStatement(
						"insert into late_fees (mem_type_id,mem_type_name,days_0_10,days_11_15,days_16_30,days_gt_30) values(?,?,?,?,?,?)");
				
				stmt.setInt(1, Integer.parseInt(mem_type_id));
				stmt.setString(2, rs.getString("mem_type_name"));
				stmt.setInt(3, Integer.parseInt(days_10));
				stmt.setInt(4, Integer.parseInt(days_15));
				stmt.setInt(5, Integer.parseInt(days_30));
				stmt.setInt(6, Integer.parseInt(more_30));
				
				int i = stmt.executeUpdate();
				if(i==1){
					//if request is not from HttpServletRequest, you should do a typecast before
					HttpSession session = req.getSession(false);
					
					//save message in session
					session.setAttribute("message", "Late Fee details saved successfully");
					res.sendRedirect(req.getContextPath() + "/jsp/late_fee_save.jsp");
				}
			}catch(Exception e){e.printStackTrace();}
		}
	}
}
