<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="com.lms.utilities.DBConnection"%>
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
		                <div class="panel-title">Welcome to the Membership Type</div>
		            </div>  
		            <div class="panel-body" >
		            	<div class="errmsg">${message}</div>
		            	<%
						request.getSession().removeAttribute("message");
						%>
	                    <form  class="form-horizontal" method="post" action="${pageContext.request.contextPath}/updateMembershipType">
	                    	<%
				    		try{
				    			Connection con = DBConnection.getConnection();
				    			Statement stmt = con.createStatement();
				    			ResultSet rs = stmt.executeQuery("select * from membership_type where id="+request.getParameter("id"));
				    			rs.next();
				    			request.setAttribute("id", rs.getString("id"));
				    			request.setAttribute("membership_type_id", rs.getString("mem_type_id"));
				    			request.setAttribute("membership_type", rs.getString("mem_type_name"));
				    			request.setAttribute("reg_fees", rs.getString("reg_fees"));
						    %>
						    <input type="hidden" name="id" value="${id}"/>
						    <div id="div_mem_id" class="form-group required"> 
	                            <label for="mem_id" class="control-label col-md-4  requiredField">Member ID</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md form-control" id="membership_type_id" name="membership_type_id" placeholder="Enter membership type id" style="margin-bottom: 10px" type="text" value="${membership_type_id}" readonly="readonly"/>
	                            </div>
	                        </div>
	                    	<div id="div_membership_type" class="form-group required"> 
	                            <label for="member_type" class="control-label col-md-4  requiredField">Member Type</label> 
	                           	<div class="controls col-md-8 "> 
	                           	    <input class="input-md form-control" id="membership_type" name="membership_type" placeholder="Enter fees" style="margin-bottom: 10px" type="text" value="${membership_type}"/>
		                        </div>
	                        </div>
	                    	<div id="div_reg_fees" class="form-group required"> 
	                            <label for="reg_fees" class="control-label col-md-4  requiredField">Registration Fees</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md form-control" id="reg_fee" name="reg_fees" placeholder="Enter fees" style="margin-bottom: 10px" type="text" value="${reg_fees}"/>
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
			object.membership_type_id = '${membership_type_id}';
			object.membership_type = '${membership_type}';
			object.reg_fees = ${reg_fees};
			
			$("#f_reset").click(function(){
				$("#membership_type_id").val(object.membership_type_id);
				$("#membership_type").val(object.membership_type);
				$("#reg_fee").val(object.reg_fee);
			});
			
			$("#signupbox input[type='text'],#signupbox input[type='date'],#signupbox select").focusin(function(){
				$(".errmsg").html("");
			});
		});
	</script>
</html>