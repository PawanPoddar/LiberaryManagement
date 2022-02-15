package com.lms.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.lms.utilities.DBConnection;

@WebServlet("/search_all")

public class SearchAllServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 577397621221135727L;

	public void doPost(HttpServletRequest req , HttpServletResponse res) throws ServletException, IOException{
		String type = req.getParameter("type");
		String search_keyword = req.getParameter("search_keyword");
		
		String message = "";
		boolean isValid = true;
		
		if(type==null || type.isEmpty()){
			isValid = false; 
			message ="Please select the type";
		}else if (search_keyword==null || search_keyword.isEmpty()){
			isValid = false;
			message = "Search Keyword is required";
		}
		
		req.setAttribute("type", type);
		req.setAttribute("search_keyword", search_keyword);
		if(!isValid){
			req.setAttribute("message", message);
			req.getRequestDispatcher("action/search_all").forward(req, res);
		}else{
			try{
				Connection con = DBConnection.getConnection();
				Statement stmt = con.createStatement();
				List<String> headerList = new ArrayList<String>();
				List<List<Object>> searchList = new ArrayList<List<Object>>();
				if(type.equals("author")){
					ResultSet rSet = stmt.executeQuery("select * from author_details where auth_id like '%"+search_keyword+"%' OR auth_name like '%"+search_keyword+"%'");
					headerList.add("ID");
					headerList.add("Name");
					headerList.add("Address");
					headerList.add("Tel No.");
					headerList.add("Specialty");
					while(rSet.next()){
		    			List<Object> author = new ArrayList<Object>();
		    			author.add(rSet.getString("auth_id"));
		    			author.add(rSet.getString("auth_name"));
		    			author.add(rSet.getString("auth_address"));
		    			author.add(rSet.getString("auth_tel_no"));
		    			author.add(rSet.getString("specialty"));
		    			searchList.add(author);
					}
				}else if(type.equals("book")){
					ResultSet rSet = stmt.executeQuery("select * from book_details where isbn_no like '%"+search_keyword+"%' OR book_name like '%"+search_keyword+"%'");
					headerList.add("ISBN No");
					headerList.add("Name");
					headerList.add("Author Name");
					headerList.add("Category");
					headerList.add("Price");
					headerList.add("CD Y/N");
					while(rSet.next()){
		    			List<Object> book = new ArrayList<Object>();
		    			book.add(rSet.getString("isbn_no"));
		    			book.add(rSet.getString("book_name"));
		    			book.add(rSet.getString("auth_name"));
		    			book.add(rSet.getString("category_name"));
		    			book.add(rSet.getString("price"));
		    			book.add(rSet.getString("cd_y_n"));
		    			searchList.add(book);
					}
				}else if(type.equals("category")){
					ResultSet rSet = stmt.executeQuery("select * from category_list where cat_id like '%"+search_keyword+"%' OR category_name like '%"+search_keyword+"%'");
					headerList.add("ID");
					headerList.add("Name");
					while(rSet.next()){
		    			List<Object> category = new ArrayList<Object>();
		    			category.add(rSet.getString("cat_id"));
		    			category.add(rSet.getString("category_name"));
		    			searchList.add(category);
					}
				}else if(type.equals("employee")){
					ResultSet rSet = stmt.executeQuery("select * from employee_personal_details where emp_id like '%"+search_keyword+"%' OR emp_name like '%"+search_keyword+"%'");
					headerList.add("ID");
					headerList.add("Name");
					headerList.add("Address");
					headerList.add("Tel. No.");
					headerList.add("Date of Birth");
					while(rSet.next()){
		    			List<Object> employee = new ArrayList<Object>();
		    			employee.add(rSet.getString("emp_id"));
		    			employee.add(rSet.getString("emp_name"));
		    			employee.add(rSet.getString("emp_address"));
		    			employee.add(rSet.getString("emp_tel_no"));
		    			employee.add(rSet.getString("emp_dob"));
		    			searchList.add(employee);
					}
				}else if(type.equals("member")){
					ResultSet rSet = stmt.executeQuery("select * from member_details where mem_id like '%"+search_keyword+"%' OR mem_name like '%"+search_keyword+"%'");
					headerList.add("ID");
					headerList.add("Name");
					headerList.add("Address");
					headerList.add("Tel No.");
					headerList.add("Member Type");
					headerList.add("Date Of Reg.");
					while(rSet.next()){
		    			List<Object> member = new ArrayList<Object>();
		    			member.add(rSet.getString("mem_id"));
		    			member.add(rSet.getString("mem_name"));
		    			member.add(rSet.getString("mem_address"));
		    			member.add(rSet.getString("mem_tel_no"));
		    			member.add(rSet.getString("mem_type_name"));
		    			member.add(rSet.getString("date_of_reg"));
		    			searchList.add(member);
					}
				}
				
				Map<String, Object> headerMap = new HashMap<String, Object>();
				headerMap.put("headerList", headerList);
				req.setAttribute("headerList", new JSONObject(headerMap));
				Map<String, Object> searchMap = new HashMap<String, Object>();
				searchMap.put("searchList", searchList);
				req.setAttribute("searchList", new JSONObject(searchMap));
				req.getRequestDispatcher("action/search_all").forward(req, res);
			}catch(Exception e){e.printStackTrace();}
		}
	}
}