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
		<div class="container">     
    		<div id="signupbox" style=" margin-top:50px" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
        		<div class="panel panel-info">
		            <div class="panel-heading">
		                <div class="panel-title">Welcome to the Employees Personal Details</div>
		            </div>  
		            <div class="panel-body" >
		            	<div class="errmsg">${message}</div>
		            	<%
		            	request.getSession().removeAttribute("message");
		            	%>
	                    <form  class="form-horizontal" method="post" action="${pageContext.request.contextPath}/updateEmployee">
	                    	<%
				    		try{
				    			Connection con = DBConnection.getConnection();
				    			Statement stmt = con.createStatement();
				    			ResultSet rs = stmt.executeQuery("select * from employee_personal_details where id="+request.getParameter("id"));
				    			rs.next();
				    			request.setAttribute("id", rs.getString("id"));
				    			request.setAttribute("emp_id", rs.getString("emp_id"));
				    			request.setAttribute("emp_name", rs.getString("emp_name"));
				    			request.setAttribute("emp_address", rs.getString("emp_address"));
				    			request.setAttribute("emp_tel_no", rs.getString("emp_tel_no"));
				    			request.setAttribute("emp_dob", rs.getString("emp_dob"));
						    %>
						    <input type="hidden" name="id" value="${id}"/>
						    <div id="emp_id" class="form-group required"> 
	                            <label for="emp_id" class="control-label col-md-4  requiredField">Employee ID </label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md emp_id form-control" id="emp_id" name="emp_id" placeholder="Enter author id" style="margin-bottom: 10px" type="text" value="${emp_id}" readonly="readonly"/>
	                            </div>
	                        </div>
	                    	<div id="emp_name" class="form-group required"> 
	                            <label for="id_name" class="control-label col-md-4  requiredField">Employee Name</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md emp_name form-control" id="emp_name" name="emp_name" placeholder="Enter employee name" style="margin-bottom: 10px" type="text" value="${emp_name}"/>
	                            </div>
	                        </div>
	                        <div id="emp_address" class="form-group required"> 
	                            <label for="address" class="control-label col-md-4  requiredField">Employee Address</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md emp_address form-control" id="emp_address" name="emp_address" placeholder="Enter employee address" style="margin-bottom: 10px" type="text" value="${emp_address}"/>
	                            </div>
	                        </div>
	                        <div id="emp_tel" class="form-group required"> 
	                            <label for="telephone" class="control-label col-md-4  requiredField">Employee Tel No.</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md emp_tel form-control" id="id_emp_tel" name="emp_tel_no" placeholder="Enter employee tel no." style="margin-bottom: 10px" type="text" value="${emp_tel_no}"/>
	                            </div>
	                        </div>
	                        <div id="emp_dob" class="form-group required"> 
	                            <label for="emp_dob" class="control-label col-md-4  requiredField">Date of Birth </label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md dob form-control" id="id_emp_dob" name="emp_dob" style="margin-bottom: 10px" type="date"/>
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
		object.date_of_reg = '${emp_dob}';
		$("#id_emp_dob").val(object.date_of_reg);
		
		$("#signupbox input[type='text'],#signupbox input[type='date'],#signupbox select").focusin(function(){
			$(".errmsg").html("");
		});
	});
	</script>
<jsp:include page="include/footer.jsp" />