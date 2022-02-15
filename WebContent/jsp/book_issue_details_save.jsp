<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*, com.lms.utilities.DBConnection"%>
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
		                <div class="panel-title">Welcome to the Book Issue Details</div>
		            </div>  
		            <div class="panel-body" >
		            	<div class="errmsg">${message}</div>
		            	<%
		            	request.getSession().removeAttribute("message");
		            	%>
	                    <form  class="form-horizontal" method="post" action="${pageContext.request.contextPath}/saveBookIssue">
	                    	<div id="mem_name" class="form-group required"> 
	                            <label for="id" class="control-label col-md-4  requiredField">Member Name</label> 
	                            <div class="controls col-md-8 "> 
	                           		<select class="form-control" name="mem_name">
	                                	<option value="">Select Member name</option>
		                           	    <%
							    		try{
							    			Connection con = DBConnection.getConnection();
							    			Statement stmt = con.createStatement();
							    			ResultSet rs = stmt.executeQuery("select * from member_details");
								    		while(rs.next()){ 
								    	%>
		                                		<option value=<%=rs.getString(1)%>><%=rs.getString(3)%></option>
	              						<% 
				    						}
				    		   			}catch(Exception e){
				    		   				e.printStackTrace();
				    		   			}
				    				    %>
	                                </select>
		                        </div>
	                        </div>
	                        <div id="book_name" class="form-group required"> 
	                            <label for="book_name" class="control-label col-md-4  requiredField">Book Name </label> 
	                             <div class="controls col-md-8 "> 
	                           		<select class="form-control" name="book_name">
	                                	<option value="">Select Book name</option>
		                           	    <%
							    		try{
							    			Connection con = DBConnection.getConnection();
							    			Statement stmt = con.createStatement();
							    			ResultSet rs = stmt.executeQuery("select * from book_details");
								    		while(rs.next()){ 
								    	%>
		                                		<option value=<%=rs.getString("id")%>><%=rs.getString("book_name")%></option>
	              						<% 
				    						}
				    		   			}catch(Exception e){
				    		   				e.printStackTrace();
				    		   			}
				    				    %>
	                                </select>
		                        </div>
	                        </div>
	                        <div id="date_of_issue_div" class="form-group required"> 
	                            <label for="date_of_issue" class="control-label col-md-4  requiredField">Date of Issue</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md date_of_issue form-control" id="date_of_issue" name="date_of_issue" placeholder="Enter the date" style="margin-bottom: 10px" type="date" />
	                            </div>
	                        </div>
	                        <div id="due_date_div" class="form-group required"> 
	                            <label for="due_date" class="control-label col-md-4  requiredField">Due Date</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md due_date form-control" id="due_date" name="due_date" placeholder="Enter due date" style="margin-bottom: 10px" type="date" />
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
			var object = {};
			object.mem_id = '${mem_id}';
			object.book_id = '${book_id}';
			object.date_of_issue = '${date_of_issue}';
			object.due_date = '${due_date}';
			
			$("#mem_name select").val(object.mem_id);
			$("#book_name select").val(object.book_id);
			$("#date_of_issue").val(object.date_of_issue);
			$("#due_date").val(object.due_date);
			
			$("#signupbox input[type='text'],#signupbox input[type='date'],#signupbox select").focusin(function(){
				$(".errmsg").html("");
			});
		});
	</script>
<jsp:include page="include/footer.jsp" />