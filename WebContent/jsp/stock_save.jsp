<%@page import="org.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.lms.utilities.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!-- Header -->
<jsp:include page="include/header.jsp" />
<!-- Page Body -->
	<body id="pg-author">
	<%
	  response.setHeader("Cache-Control","no-cache");
	  response.setHeader("Cache-Control","no-store");
	  response.setHeader("Pragma","no-cache");
	  response.setDateHeader ("Expires", 0);
	
	  if(session.getAttribute("login_user")== null)
	  	  response.sendRedirect(request.getContextPath() + "/index.jsp");
	 %>
	<jsp:include page="include/Navbar.jsp" />
	
		<div class="container">     
    		<div id="signupbox" style=" margin-top:50px" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
        		<div class="panel panel-info">
		            <div class="panel-heading">
		                <div class="panel-title">Welcome to the Stock Details</div>
		            </div>  
		            <div class="panel-body">
		            	<div class="errmsg">${message}</div>
		            	<%
		            	request.getSession().removeAttribute("message");
		            	%>
	                    <form  class="form-horizontal" method="post" action="${pageContext.request.contextPath}/saveStock">
	                    	<div id="div_book_id" class="form-group required"> 
	                            <label for="book_id" class="control-label col-md-4  requiredField">Book Name</label> 
	                            <div class="controls col-md-8 ">
	                            	<select class="form-control" name="book_id">
	                                	<option value="">Select a book</option>
		                                <%
							    		try{
							    			Connection con = DBConnection.getConnection();
							    			Statement stmt = con.createStatement();
							    			ResultSet rs = stmt.executeQuery("select * from book_details");
							    			Map<Integer,Map<String,Object>> bookList = new HashMap<Integer,Map<String,Object>>();
								    		while(rs.next()){
								    			Map<String,Object> book = new HashMap<String,Object>();
								    			book.put("auth_name", rs.getString("auth_name"));
								    			book.put("category_name", rs.getString("category_name"));
								    			bookList.put(rs.getInt("id"),book);
								    	%>
	                                			<option value=<%=rs.getInt("id")%>><%=rs.getString("book_name")%></option>
              							<% 
			    							}
								    		request.setAttribute("bookList", new JSONObject(bookList));
			    		   			    }catch(Exception e){
			    		   			    	e.printStackTrace();
			    		   			    }
			    				    	%>
	                                </select>
	                            </div>
	                        </div>
	                    	<div id="div_auth_name" class="form-group required"> 
	                            <label for="auth_name" class="control-label col-md-4  requiredField">Author Name</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md form-control" id="auth_name" name="auth_name" placeholder="Enter author name" style="margin-bottom: 10px" type="text" value="${auth_name}" readonly="readonly"/>
	                            </div>
	                        </div>
	                        <div id="div_category_name" class="form-group required"> 
	                            <label for="category" class="control-label col-md-4  requiredField">Category Name</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md form-control" id="category_name" name="category_name" placeholder="Enter author name" style="margin-bottom: 10px" type="text" value="${category_name}" readonly="readonly"/>
  	                            </div>
	                        </div>
	                        <div id="div_no_of_books" class="form-group required"> 
	                            <label for="no_of_books" class="control-label col-md-4  requiredField">No. of Books</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md form-control" id="no_of_books" name="no_of_books" placeholder="Enter no. of books" style="margin-bottom: 10px" type="text" value="${no_of_books}"/>
	                            </div>
	                        </div>
   	                        <div class="form-group"> 
	                            <div class="aab controls col-md-5"></div>
	                            <div class="controls col-md-3">
	                                 <input type="submit" name="save" value="Save" class="btn btn-success" id="submit-id-save" />
	                            </div>
	                            <div class="controls col-md-3">
	                                 <input type="reset" name="reset" value="Reset" class="btn btn-danger btn-info" id="f_reset" />
	                            </div>
	                             <div class="aab controls col-md-2"></div>
	                        </div>
	                    </form>  
		            </div>
        		</div>
    		</div> 
		</div>
	</body>
	<script type="text/javascript">
		$(document).ready(function() {
			var bookList = '${bookList}';
			
			var valid = '${valid}';
			if(valid == 'false'){
				var book_id = '${book_id}';
				$("#div_book_id select").val(book_id);
			}
			
			$('#div_book_id select').change(function(event){
				bookList = JSON.parse(bookList);
				$("#auth_name").val(bookList[$(this).val()].auth_name);
				$("#category_name").val(bookList[$(this).val()].category_name);
			});
			
			$("#signupbox input[type='text'],#signupbox input[type='date'],#signupbox select").focusin(function(){
				$(".errmsg").html("");
			});
		});
	</script>
</html>