package com.lms.controller;

import java.io.IOException;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lms.utilities.DBConnection;
import java.sql.*;

@WebServlet("/saveBookIssue")
public class BookIssueDetailsSaveServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7545194312479439482L;

	public void doPost(HttpServletRequest req , HttpServletResponse res) throws ServletException, IOException{
	   String message = "";
	   boolean isValid = true;
	   
	   String mem_id = req.getParameter("mem_name");
	   String book_id = req.getParameter("book_name");
	   String date_of_issue = req.getParameter("date_of_issue");
	   String due_date = req.getParameter("due_date");
	   if(mem_id==null || mem_id.isEmpty()){
		   isValid = false;
		   message = "Select the member name";
	   }else if(book_id==null || book_id.isEmpty()){
		   isValid = false;
		   message = "Select the book name";
	   }else if(date_of_issue==null || date_of_issue.isEmpty()){
		   isValid = false;
		   message = "Select the date of issue";
	   }else if(due_date==null || due_date.isEmpty()){
		   isValid = false;
		   message = "Select the due date";
	   }
	   
	   if(!isValid){
		   req.setAttribute("message", message);
		   req.setAttribute("mem_id", mem_id);
		   req.setAttribute("book_id", book_id);
		   req.setAttribute("date_of_issue", date_of_issue);
		   req.setAttribute("due_date", due_date);
		   req.getRequestDispatcher("action/book_issue_details_save").forward(req, res);
	   }else{
		   try{
			   Connection con = DBConnection.getConnection();
			   Statement stmt = con.createStatement();
			   ResultSet rs = stmt.executeQuery("select * from member_details where id='"+mem_id+"'");
			   rs.next();
		       String mem_name = rs.getString("mem_name");
		       String mem_type_name = rs.getString("mem_type_name");
			     
			   rs = stmt.executeQuery("select * from book_details where id='"+book_id+"'");
			   rs.next();
			   String isbn_no = rs.getString("isbn_no");
			   String book_name = rs.getString("book_name");
			   String auth_name = rs.getString("auth_name");
			   String category_name = rs.getString("category_name");
			        
	           PreparedStatement pstmt = con.prepareStatement(
			        "insert into book_issue_details (mem_id, mem_name, mem_type_name, book_id, isbn_no, book_name, auth_name, category_name, date_of_issue, due_date) values(?,?,?,?,?,?,?,?,?,?)"); 
			        pstmt.setInt(1, Integer.parseInt(mem_id));
			        pstmt.setString(2, mem_name);
			        pstmt.setString(3, mem_type_name);
			        pstmt.setInt(4, Integer.parseInt(book_id));
			        pstmt.setString(5, isbn_no);
			        pstmt.setString(6, book_name);
			        pstmt.setString(7, auth_name);
			        pstmt.setString(8, category_name);
			        pstmt.setString(9, date_of_issue);
			        pstmt.setString(10, due_date);
			        int i = pstmt.executeUpdate();
			        if(i==1){
			        	//if request is not from HttpServletRequest, you should do a typecast before
						HttpSession session = req.getSession(false);
						
						//save message in session
						session.setAttribute("message", "Book Issue details saved successfully");
						res.sendRedirect(req.getContextPath() + "/jsp/book_issue_details_save.jsp"); 
			        }
			      PreparedStatement pstmt2 = con.prepareStatement("insert into issuefinder (mem_id,mem_name,book_name,date_of_issue,due_date) values(?,?,?,?,?)")  ;
			      pstmt2.setInt(1, Integer.parseInt(mem_id));
			       pstmt2.setString(2, mem_name);
			       pstmt2.setString(3, book_name);
			       pstmt2.setString(4, date_of_issue);
			        pstmt2.setString(5, due_date);
			       pstmt2.executeUpdate();
			       
//			       Statement st=con.createStatement("update stock_list SET no_of_book=no_of_books - 1 where book_name=(?)");
//				      pstmt3.setString(1,book_name);
//			       	pstmt.executeUpdate();
			       stmt.executeUpdate("update stock_details SET no_of_books=no_of_books - 1 where book_name='"+book_name+"'");
			   }catch(Exception e){e.printStackTrace();}
		  }
	 }
}