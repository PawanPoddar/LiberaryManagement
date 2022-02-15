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

@WebServlet("/saveMembershipType")

public class MembershipTypeSaveServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5774906487112247597L;

	public void doPost(HttpServletRequest req , HttpServletResponse res) throws ServletException, IOException{
	   String membership_type = req.getParameter("membership_type");
	   String reg_fees = req.getParameter("reg_fees");
	  	
	   try {
		   Connection con = DBConnection.getConnection();
		   
		   String message = "";
	       boolean isValid = true;
		   
		   if(membership_type==null || membership_type.isEmpty()){
			   isValid = false;
			   message = "Select the membership type";
		   }else if(reg_fees==null || reg_fees.isEmpty()){
			   isValid = false;
			   message = "Enter the registration fees";
		   }else {
			   	PreparedStatement readStmt = con.prepareStatement("select count(1) as membershiptypeExists from membership_type where mem_type_name=?");
				readStmt.setString(1, membership_type.trim());
				ResultSet rSet = readStmt.executeQuery();
				rSet.next();
				
				if(rSet.getString("membershiptypeExists") != null 
					&& Integer.parseInt(rSet.getString("membershiptypeExists")) > 0){
				isValid = false;
				message = "Membership Type already exists";
				}
		   }
		   
		   if(!isValid){
			   req.setAttribute("message", message);
			   req.setAttribute("membership_type", membership_type);
			   req.setAttribute("reg_fees", reg_fees);
			   req.getRequestDispatcher("action/membershiptype_save").forward(req, res);
		   }
		   else{
			   try{
				   	Statement readStmt = con.createStatement();
					ResultSet rSet = readStmt.executeQuery("select max(id) as maxId from membership_type");
					rSet.next();
					
					Integer maxId = null;
					if(rSet.getString("maxId") == null){
						maxId = 1;
					}else{
						maxId = Integer.parseInt(rSet.getString("maxId")) + 1;
					}
				   
					PreparedStatement stmt = con.prepareStatement(
							"insert into membership_type(mem_type_id,mem_type_name,reg_fees) values(?,?,?)");
					stmt.setString(1, "MEM" + "00" + maxId);
					stmt.setString(2, membership_type.trim());
					stmt.setInt(3, Integer.parseInt(reg_fees));
					
					int i = stmt.executeUpdate();
					if(i==1){
						//if request is not from HttpServletRequest, you should do a typecast before
						HttpSession session = req.getSession(false);
						
						//save message in session
						session.setAttribute("message", "Membership details saved successfully");
						res.sendRedirect(req.getContextPath() + "/jsp/membershiptype_save.jsp");
					}
				}catch(Exception e){e.printStackTrace();}
		   }
	   } catch(Exception e){e.printStackTrace();}
	}
}
