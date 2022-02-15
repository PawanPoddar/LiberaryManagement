package com.lms.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lms.utilities.DBConnection;
@WebServlet("/updateMembershipType")
public class MembershipUpdateServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1902465854862744650L;

	public void doPost(HttpServletRequest req , HttpServletResponse res) throws ServletException, IOException{
		String id = req.getParameter("id");
		String membership_type_id = req.getParameter("membership_type_id");
		String membership_type = req.getParameter("membership_type");
		String reg_fees = req.getParameter("reg_fees");
		
		try {
			Connection con = DBConnection.getConnection();
			
			boolean isValid = true;
			String message = "";
			
			if(membership_type==null || membership_type.isEmpty()){
				isValid = false;
				message = "Select the membership type";
			}else if(reg_fees==null || reg_fees.isEmpty()){
				isValid = false;
				message = "Enter the registration fees";
			}else {
			   	PreparedStatement readStmt = con.prepareStatement("select count(1) as membershiptypeExists from membership_type where id!=? and mem_type_name=?");
			   	readStmt.setInt(1, Integer.parseInt(id));
			   	readStmt.setString(2, membership_type.trim());
				ResultSet rSet = readStmt.executeQuery();
				rSet.next();
				
				if(rSet.getString("membershiptypeExists") != null 
					&& Integer.parseInt(rSet.getString("membershiptypeExists")) > 0){
				isValid = false;
				message = "Membership Type already exists";
				}
			}
			
			HttpSession session = req.getSession(false);
			if(!isValid){
				req.setAttribute("message", message);
				req.setAttribute("id", id);
				req.setAttribute("membership_type_id", membership_type_id);
			 	req.setAttribute("membership_type", membership_type);
			 	req.setAttribute("reg_fees", reg_fees);
			 	req.getRequestDispatcher("action/membershiptype_update").forward(req, res);
			}else{
				try{
					PreparedStatement stmt = con.prepareStatement(
							"update membership_type set mem_type_name=?, reg_fees=? where id=?");
					stmt.setString(1, membership_type.trim());
					stmt.setInt(2, Integer.parseInt(reg_fees));
					stmt.setInt(3, Integer.parseInt(id));
					
					int i = stmt.executeUpdate();
					if(i==1){
						//save message in session
						session.setAttribute("message", "Membership type details updated successfully");
						res.sendRedirect(req.getContextPath() + "/jsp/membershiptype_update.jsp?id="+id);
					}
				}catch(Exception e){e.printStackTrace();}
			}
		}catch(Exception e){e.printStackTrace();}
	}
}
