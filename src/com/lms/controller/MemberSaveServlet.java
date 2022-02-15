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

@WebServlet("/saveMember")

public class MemberSaveServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 2307420771344407184L;
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		 
		boolean isValid = true;
		String message = "";
		
		String mem_type_id = req.getParameter("membership_type");
		String member_name = req.getParameter("member_name");
		String member_address = req.getParameter("member_address");
		String member_tel = req.getParameter("member_tel");
		String date_of_reg = req.getParameter("date_of_reg");

		if(mem_type_id==null || member_name.isEmpty()){
			isValid = false;
			message = "Member name can't be left blank";
		}else if(member_name==null || member_name.isEmpty()){
			isValid = false;
			message = "Member name can't be left blank";
		}else if(member_address==null || member_address.isEmpty()){
			isValid = false;
			message = "Address can't be left blank";
		}else if(member_tel==null || member_tel.isEmpty()){
			isValid = false;
			message = "Tel. No. can't be left blank";
		}else if(!Pattern.matches("^[\\d]{10,10}$",member_tel)){
			isValid = false;
			message = "Tel No. should be 10 digits";
		}else if(date_of_reg==null || date_of_reg.isEmpty()){
			isValid = false;
			message = "Date of Reg. can't be left blank";
		}
		
		if(!isValid){
			req.setAttribute("message", message);
			req.setAttribute("membership_type", mem_type_id);
			req.setAttribute("member_name", member_name);
			req.setAttribute("member_address", member_address);
			req.setAttribute("member_tel", member_tel);
			req.getRequestDispatcher("action/member_save").forward(req, res);
		}
		else{
			try{
				Connection con = DBConnection.getConnection();
				Statement readStmt = con.createStatement();
				ResultSet rSet = readStmt.executeQuery("select max(id) as maxId from member_details");
				rSet.next();
				
				Integer maxId = null;
				if(rSet.getString("maxId") == null){
					maxId = 1;
				}else{
					maxId = Integer.parseInt(rSet.getString("maxId")) + 1;
				}
				
				PreparedStatement readMembershiipTypeStmt = con.prepareStatement("select mem_type_name from membership_type where id=?");
				readMembershiipTypeStmt.setInt(1, Integer.parseInt(mem_type_id));
				ResultSet rMembershiipTypeSet = readMembershiipTypeStmt.executeQuery();
				rMembershiipTypeSet.next();
				
				PreparedStatement stmt = con.prepareStatement("insert into member_details(mem_id,mem_name,mem_address,mem_tel_no,date_of_reg,mem_type_id,mem_type_name) values(?,?,?,?,?,?,?)");
				stmt.setString(1, "MEM" + "00" + maxId);
				stmt.setString(2, member_name);
				stmt.setString(3, member_address);
				stmt.setString(4, member_tel);
				stmt.setString(5, date_of_reg);
				stmt.setInt(6, Integer.parseInt(mem_type_id));
				stmt.setString(7, rMembershiipTypeSet.getString("mem_type_name"));
				
				int i = stmt.executeUpdate();
				if(i==1){
					//if request is not from HttpServletRequest
					HttpSession session = req.getSession(false);
					
					//save message in session
					session.setAttribute("message", "Member details saved successfully");
					res.sendRedirect(req.getContextPath() + "/jsp/member_save.jsp");
				}
			}catch(Exception e){e.printStackTrace();}
		}
	}
}
