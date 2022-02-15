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
	                    <form  class="form-horizontal" method="post" action="${pageContext.request.contextPath}/updateStock">
	                    	<%
				    		try{
				    			Connection con = DBConnection.getConnection();
				    			Statement stmt = con.createStatement();
				    			ResultSet rs = stmt.executeQuery("select * from stock_details where id="+request.getParameter("id"));
				    			rs.next();
				    			request.setAttribute("id", rs.getString("id"));
				    			request.setAttribute("book_name", rs.getString("book_name"));
				    			request.setAttribute("auth_name", rs.getString("auth_name"));
				    			request.setAttribute("category_name", rs.getString("category_name"));
				    			request.setAttribute("no_of_books", rs.getString("no_of_books"));
			   			    }catch(Exception e){
			   			    	e.printStackTrace();
			   			    }
						    %>
						    <input type="hidden" name="id" value="${id}"/>
	                    	<div id="div_book_name" class="form-group required"> 
	                            <label for="book_name" class="control-label col-md-4  requiredField">Book Name</label> 
	                            <div class="controls col-md-8 ">
	                            	<input class="input-md form-control" id="book_name" name="book_name" placeholder="Enter book name" style="margin-bottom: 10px" type="text" value="${book_name}" readonly="readonly"/>
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
	                                 <input type="submit" name="save" value="Update" class="btn btn-success" id="submit-id-save" />
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
			var object = {};
	    	object.id = ${id};
			object.book_name = '${book_name}';
			object.auth_name = '${auth_name}';
			object.category_name = '${category_name}';
			object.no_of_books = ${no_of_books};
						
			$("#f_reset").click(function(){
				$("#book_name").val(object.book_name);
				$("#auth_name").val(object.auth_name);
				$("#category_name").val(object.category_name);
				$("#no_of_books").val(object.no_of_books);
			});
						
			$("#signupbox input[type='text'],#signupbox input[type='date'],#signupbox select").focusin(function(){
				$(".errmsg").html("");
			});
		});
	</script>
</html>