package com.lms.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lms.utilities.DBConnection;

@WebServlet("/saveBookSubmit")
public class BookSubmitDetailsSaveServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = -1048547110726949033L;

	public void doPost(HttpServletRequest req , HttpServletResponse res){
		String message="";
		boolean isValid=true;
		
		String mem_id = req.getParameter("mem_name");
		String book_id = req.getParameter("book_name");
		String date_of_submit = req.getParameter("date_of_submit");
		String late_days = req.getParameter("late_days");
		String late_fees = req.getParameter("late_fees");
		String paid_amount = req.getParameter("paid_amount");
		String bal_amount = req.getParameter("bal_amount");
		String date_of_payment = req.getParameter("date_of_payment");
		
		try{
			if(mem_id==null || mem_id.isEmpty()){
				isValid = false;
				message = "Select member name";
			}else if(book_id==null || book_id.isEmpty()){
				isValid = false;
				message = "Select book name";
			}else if(date_of_submit==null || date_of_submit.isEmpty()){
				isValid = false;
				message = "Enter the date of submit";
			}else if(late_days==null || late_days.isEmpty()){
				isValid = false;
				message = "Enter the late days";
			}else if(late_fees==null || late_fees.isEmpty()){
				isValid = false;
				message = "Enter the late fees";
			}else if(paid_amount==null || paid_amount.isEmpty()){
				isValid = false;
				message = "Enter the paid amount";
			}else if(bal_amount==null || bal_amount.isEmpty()){
				isValid = false;
				message = "Enter the balance amount";
			}else if(date_of_payment==null || date_of_payment.isEmpty()){
				isValid = false;
				message = "Enter the date of payment";
			}
			if(!isValid){
				req.setAttribute("message", message);
				req.setAttribute("mem_id", mem_id);
				req.setAttribute("book_id", book_id);
				req.setAttribute("date_of_submit", date_of_submit);
				req.setAttribute("late_days", late_days);
				req.setAttribute("late_fees", late_fees);
				req.setAttribute("paid_amount", paid_amount);
				req.setAttribute("bal_amount", bal_amount);
				req.setAttribute("date_of_payment", date_of_payment);
				req.getRequestDispatcher("action/book_submit_details_save").forward(req, res);
			}else{
				try{
					Connection con = DBConnection.getConnection();
					Statement sstmt = con.createStatement();
					ResultSet rs = sstmt.executeQuery(
					"select * from book_issue_details where mem_id='"+mem_id+"' and book_id='"+book_id+"'");
					rs.next();
					String mem_name = rs.getString("mem_name");
					String mem_type_name = rs.getString("mem_type_name");
					String isbn_no = rs.getString("isbn_no");
					String book_name = rs.getString("book_name");
					String auth_name = rs.getString("auth_name");
					String category_name = rs.getString("category_name");
				       
					PreparedStatement stmt = con.prepareStatement(
					"insert into book_submit_details(mem_id, mem_name, mem_type_name, book_id, isbn_no, book_name, auth_name, category_name, date_of_submit, late_days, late_fees, paid_amount, bal_amount, date_of_payment) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					stmt.setInt(1, Integer.parseInt(mem_id));
					stmt.setString(2, mem_name);
					stmt.setString(3, mem_type_name);
					stmt.setInt(4, Integer.parseInt(book_id));
					stmt.setString(5, isbn_no);
					stmt.setString(6, book_name);
					stmt.setString(7, auth_name);
					stmt.setString(8, category_name);
					stmt.setString(9, date_of_submit);
					stmt.setInt(10, Integer.parseInt(late_days));
					stmt.setInt(11, Integer.parseInt(late_fees));
					stmt.setInt(12, Integer.parseInt(paid_amount));
					stmt.setInt(13, Integer.parseInt(bal_amount));
					stmt.setString(14, date_of_payment);
					
					int i=stmt.executeUpdate();
				    stmt.executeUpdate("update stock_details SET no_of_books=no_of_books + 1 where book_name='"+book_name+"'");

					if(i==1){
						HttpSession session = req.getSession(false);
						session.setAttribute("message", "Book submit details saved successfully");
						res.sendRedirect(req.getContextPath() + "/jsp/book_submit_details_save.jsp");
					}
				}catch(Exception e){e.printStackTrace();}
			}
		}catch(Exception e){e.printStackTrace();}
	}
}