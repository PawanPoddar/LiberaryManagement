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
		                <div class="panel-title">Welcome to the Membership Type</div>
		            </div>  
		            <div class="panel-body" >
		            	<div class="errmsg">${message}</div>
		            	<%
						request.getSession().removeAttribute("message");
						%>
	                    <form  class="form-horizontal" method="post" action="${pageContext.request.contextPath}/saveMembershipType">
	                    	<div id="div_membership_type" class="form-group required"> 
	                            <label for="membership_type" class="control-label col-md-4  requiredField">Member Type</label> 
	                           	<div class="controls col-md-8 "> 
	                                <input class="input-md form-control" id="membership_type" name="membership_type" placeholder="Enter membership type" style="margin-bottom: 10px" type="text" value="${membership_type}"/>
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
			$("#signupbox input[type='text'],#signupbox input[type='date'],#signupbox select").focusin(function(){
				$(".errmsg").html("");
			});
		});
	</script>
</html>