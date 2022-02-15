<%@page import="java.sql.*"%>
<%@page import="com.lms.utilities.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!-- Header -->
<jsp:include page="include/header.jsp" />
<!-- Page Body -->
	<body id="pg-author">
		<jsp:include page="include/Navbar.jsp" />
		<%
		  response.setHeader("Cache-Control","no-cache");
		  response.setHeader("Cache-Control","no-store");
		  response.setHeader("Pragma","no-cache");
		  response.setDateHeader ("Expires", 0);
		
		  if(session.getAttribute("login_user")== null)
			  response.sendRedirect(request.getContextPath() + "/index.jsp");
		 %>
		<div class="container">     
    		<div id="signupbox" style=" margin-top:50px" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
        		<div class="panel panel-info">
		            <div class="panel-heading">
		                <div class="panel-title">Welcome to the Book Details</div>
		            </div>  
		            <div class="panel-body" >
		            <div class="errmsg">${message}</div>
		            	<%
		            	request.getSession().removeAttribute("message");
		            	%>
	                    <form  class="form-horizontal" method="POST" action="${pageContext.request.contextPath}/updateBook">
	                    	 <%
				    		try{
				    			Connection con = DBConnection.getConnection();
				    			Statement stmt = con.createStatement();
				    			ResultSet rs = stmt.executeQuery("select * from book_details where id="+request.getParameter("id"));
				    			rs.next();
				    			request.setAttribute("id", rs.getLong("id"));
				    			request.setAttribute("isbn_no", rs.getString("isbn_no"));
				    			request.setAttribute("auth_id", rs.getLong("auth_id"));
				    			request.setAttribute("auth_name", rs.getString("auth_name"));
				    			request.setAttribute("category_id", rs.getLong("category_id"));
				    			request.setAttribute("category_name", rs.getString("category_name"));
				    			request.setAttribute("book_name", rs.getString("book_name"));
				    			request.setAttribute("price", rs.getLong("price"));
				    			request.setAttribute("cd", rs.getString("cd_y_n"));
						    %>
	                    	<input type="hidden" name="id" value="${id}"/>
	                    	<div id="isbn_no" class="form-group required"> 
	                            <label for="id" class="control-label col-md-4  requiredField">ISBN  No. </label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md isbn_no form-control" id="isbn_ no." name="isbn_no" placeholder="Enter ISBN no." style="margin-bottom: 10px" type="text" value="${isbn_no}" readonly="readonly" />
	                            </div>
	                        </div>
	                        <div id="book_name" class="form-group required"> 
	                            <label for="book_name" class="control-label col-md-4  requiredField">Book Name </label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md book_name form-control" id="book_name" name="book_name" placeholder="Enter book name" style="margin-bottom: 10px" type="text" value="${book_name}" />
	                            </div>
	                        </div>
	                        <div id="auth_name" class="form-group required"> 
	                            <label for="name" class="control-label col-md-4  requiredField">Author Name </label> 
	                            <div class="controls col-md-8 "> 
	                            	<select class="form-control" name="auth_id">
		                                <option value="">Select Author</option>
		                            	<%
							    		try{
								    		rs = stmt.executeQuery("select * from author_details");
								    		while(rs.next()){
								    	%>
		                                		<option value=<%=rs.getString("id")%>><%=rs.getString("auth_name")%></option>
	              						<% 
				    						}
				    		   			}catch(Exception e){
				    		   				e.printStackTrace();
				    		   			}
				    				    %>
	                                </select>
  	                            </div>
	                        </div>
	                        <div id="category_name" class="form-group required"> 
	                            <label for="category" class="control-label col-md-4  requiredField">Category Name</label> 
	                            <div class="controls col-md-8 ">
	                            	<select class="form-control" name="category_id">
		                                <option value="">Select Category</option>
		                            	<%
							    		try{
							    			rs = stmt.executeQuery("select * from category_list");
							    			while(rs.next()){
								    	%>
		                                		<option value="<%=rs.getString("id")%>"><%=rs.getString("category_name")%></option>
	              						<% 
				    						}
				    		   			}catch(Exception e){
				    		   				e.printStackTrace();
				    		   			}
				    				    %>
	                                </select>
  	                            </div>
	                        </div>
	                        <div id="div_price" class="form-group required"> 
	                            <label for="id_price" class="control-label col-md-4  requiredField">Price </label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md price form-control" id="id_price" name="price" placeholder="Price of book" style="margin-bottom: 10px" type="text" value="${price}" />
	                            </div>
	                        </div>
	                        <div id="div_cd" class="form-group required"> 
	                            <label for="cd" class="control-label col-md-4  requiredField">CD_Y_N</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md CD form-control" id="id_CD" name="cd" placeholder="Enter Y/N" style="margin-bottom: 10px" type="text" value="${cd}"/>
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
	                       	<% 
					    	}catch(Exception e){
					    		e.printStackTrace();
					    	}
					    	%>
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
			object.isbn_no = '${isbn_no}';
			object.book_name = '${book_name}';
			object.auth_id = ${auth_id};
			object.category_id = ${category_id};
			object.price = ${price};
			object.cd = '${cd}';
			
			var auth_id = ${auth_id};
			var category_id = ${category_id};
			$("#auth_name select").val(auth_id);
			$("#category_name select").val(category_id);
			
			$("#f_reset").click(function(){
				$("#isbn_no input[type='text']").val(object.isbn_no);
				$("#book_name").val(object.book_name);
				$("#div_price input[type='text']").val(object.price);
				$("#div_cd input[type='text']").val(object.cd);
				setTimeout(function(){ 
					$("#auth_name select").val(object.auth_id);
					$("#category_name select").val(object.category_id); 
				}, 200);
			});
			
			$("#signupbox input[type='text'],#signupbox input[type='date'],#signupbox select").focusin(function(){
				$(".errmsg").html("");
			});
		});
	</script>
<jsp:include page="include/footer.jsp" />