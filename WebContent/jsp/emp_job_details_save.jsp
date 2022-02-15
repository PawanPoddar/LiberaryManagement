<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="com.lms.utilities.DBConnection"%>
<!-- Header -->
<jsp:include page="include/header.jsp" />
<!-- Page Body -->
	<jsp:include page="include/Navbar.jsp" />
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
		                <div class="panel-title">Welcome to the Employee Job Details</div>
		            </div>  
		            <div class="panel-body" >
		            	<div class="errmsg">${message}</div>
		            	<%
		            	request.getSession().removeAttribute("message");
		            	%>
	                    <form  class="form-horizontal" method="post" action="${pageContext.request.contextPath}/addJobDetails">
	                    	<%
				    		try{
				    			Connection con = DBConnection.getConnection();
				    			Statement stmt = con.createStatement();
				    			ResultSet rs = stmt.executeQuery("select * from employee_personal_details where id="+request.getParameter("id"));
				    			rs.next();
				    			request.setAttribute("id", rs.getString("id"));
				    			request.setAttribute("emp_id", rs.getString("emp_id"));
						    %>
	                    	<input type="hidden" name="id" value="${id}"/>
	                    	<div id="emp_id" class="form-group required"> 
	                            <label for="empid" class="control-label col-md-4  requiredField">Employee ID</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md emp_id form-control" id="emp_id" name="emp_id" placeholder="Enter employee id" style="margin-bottom: 10px" type="text" value="${emp_id}" readonly="readonly"/>
	                            </div>
	                        </div>
	                    	<div id="emp_post" class="form-group required"> 
	                            <label for="id_post" class="control-label col-md-4  requiredField">Post</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md emp_post form-control" id="emp_post" name="emp_post" placeholder="Enter employee post" style="margin-bottom: 10px" type="text" value="${emp_post}"/>
	                            </div>
	                        </div>
	                        <div id="salary" class="form-group required"> 
	                            <label for="salary" class="control-label col-md-4  requiredField">Salary</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md emp_salary form-control" id="id_emp_salary" name="emp_salary" placeholder="Enter employee salary" style="margin-bottom: 10px" type="text" value="${emp_salary}"/>
	                            </div>
	                        </div>
	                        <div id="date_of_join" class="form-group required"> 
	                            <label for="doj" class="control-label col-md-4  requiredField">Date of Joining </label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md doj form-control" id="emp_doj" name="date_of_join" style="margin-bottom: 10px" type="date" />
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
		object.date_of_join = '${date_of_join}';
		$("#emp_doj").val(object.date_of_join);
		
		$("#signupbox input[type='text'],#signupbox input[type='date'],#signupbox select").focusin(function(){
			$(".errmsg").html("");
		});
	});
	</script>
</html>