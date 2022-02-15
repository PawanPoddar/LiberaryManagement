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

@WebServlet("/updateMember")
public class MemberUpdateServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7997191509326835867L;

	public void doPost(HttpServletRequest req , HttpServletResponse res) throws ServletException, IOException{
		boolean isValid = true;
		String message = "";
		
		String id = req.getParameter("id");
		String member_id = req.getParameter("member_id");
		String member_name = req.getParameter("member_name");
		String member_address = req.getParameter("member_address");
		String member_tel = req.getParameter("member_tel");
		String date_of_reg = req.getParameter("date_of_reg");
		String mem_type_id = req.getParameter("membership_type");
		
		if(mem_type_id==null || mem_type_id.isEmpty()){
			isValid = false;
			message = "Select the member type";
		}else if(member_name==null || member_name.isEmpty()){
			isValid = false;
			message = "Enter the member name";
		}else if(member_address==null || member_address.isEmpty()){
			isValid = false; 
			message = "Enter the member address";
		}else if(member_tel==null || member_tel.isEmpty()){
			isValid = false; 
			message = "Enter the tel no.";
		}else if(date_of_reg==null || date_of_reg.isEmpty()){
			isValid = false; 
			message = "Enter the date";
		}
		
		HttpSession session = req.getSession(false);
		if(!isValid){
			req.setAttribute("message", message);
			req.setAttribute("id", id);
			req.setAttribute("member_id", member_id);
			req.setAttribute("member_name", member_name);
			req.setAttribute("member_address", member_address);
			req.setAttribute("member_tel", member_tel);
			req.setAttribute("date_of_reg", date_of_reg);
			req.setAttribute("mem_type_id", mem_type_id);
			req.getRequestDispatcher("action/member_update").forward(req, res);
		}else{
			try{
				Connection con = DBConnection.getConnection();
				
				PreparedStatement readMembershiipTypeStmt = con.prepareStatement("select mem_type_name from membership_type where id=?");
				readMembershiipTypeStmt.setInt(1, Integer.parseInt(mem_type_id));
				ResultSet rMembershiipTypeSet = readMembershiipTypeStmt.executeQuery();
				rMembershiipTypeSet.next();
				
				PreparedStatement stmt = con.prepareStatement(
						"update member_details set mem_name=?, mem_address=?, mem_tel_no=?, date_of_reg=?, mem_type_id=?, mem_type_name=? where id=?");
				stmt.setString(1, member_name);
				stmt.setString(2, member_address);
				stmt.setString(3, member_tel);
				stmt.setString(4, date_of_reg);
				stmt.setInt(5, Integer.parseInt(mem_type_id));
				stmt.setString(6, rMembershiipTypeSet.getString("mem_type_name"));
				stmt.setString(7, id);
				
				int i = stmt.executeUpdate();
				if(i==1){
					//save message in session
					session.setAttribute("message", "Member updated successfully");
					res.sendRedirect(req.getContextPath() + "/jsp/member_update.jsp?id="+id);
				}
			}catch(Exception e){e.printStackTrace();}
		}
	}
}