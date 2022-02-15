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

@WebServlet("/updateLateFee")
public class LateFeeUpdateServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5057042475725500513L;

	public void doPost(HttpServletRequest req , HttpServletResponse res) throws ServletException, IOException{
		boolean isValid = true;
		String message = "";
		
		String id = req.getParameter("id");
		String mem_type_id = req.getParameter("member_type");
		String days_10 = req.getParameter("days_10");
		String days_15 = req.getParameter("days_15");
		String days_30 = req.getParameter("days_30");
		String more_30 = req.getParameter("more_30");
		
		if(days_10==null || days_10.isEmpty()){
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
		//if request is not from HttpServletRequest, you should do a typecast before
				HttpSession session = req.getSession(false);
		if(!isValid){
			req.setAttribute("message", message);
			req.setAttribute("id", id);
			req.setAttribute("mem_type_id", mem_type_id);
			req.setAttribute("days_10", days_10);
			req.setAttribute("days_15", days_15);
			req.setAttribute("days_30", days_30);
			req.setAttribute("more_30", more_30);
			req.getRequestDispatcher("action/late_fee_update").forward(req, res);
		}else{
			try{
				Connection con = DBConnection.getConnection();
				PreparedStatement stmt = con.prepareStatement(
						"update late_fees set days_0_10=?, days_11_15=?, days_16_30=?, days_gt_30=? where id=?");
				stmt.setInt(1, Integer.parseInt(days_10));
				stmt.setInt(2, Integer.parseInt(days_15));
				stmt.setInt(3, Integer.parseInt(days_30));
				stmt.setInt(4, Integer.parseInt(more_30));
				stmt.setInt(5, Integer.parseInt(id));
				
				int i = stmt.executeUpdate();
				if(i==1){
					//save message in session
					session.setAttribute("message", "Late Fee details updated successfully");
					res.sendRedirect(req.getContextPath() + "/jsp/late_fee_update.jsp?id="+id);
				}
			}catch(Exception e){e.printStackTrace();}
		}
	}
}
