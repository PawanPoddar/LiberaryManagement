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
		                <div class="panel-title">Welcome to the Author Details</div>
		            </div>  
		            <div class="panel-body" >
		            	<div class="errmsg">${message}</div>
		            	<%
		            	request.getSession().removeAttribute("message");
		            	%>
	                    <form  class="form-horizontal" method="POST" action="${pageContext.request.contextPath}/saveAuthor">
	                        <div id="auth_name" class="form-group required"> 
	                            <label for="name" class="control-label col-md-4  requiredField">Author Name </label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md name form-control" id="auth_name" name="name" placeholder="Author name" style="margin-bottom: 10px" type="text" value="${name}"/>
	                            </div>
	                        </div>
	                        <div id="div_auth_address" class="form-group required"> 
	                            <label for="auth_address" class="control-label col-md-4  requiredField">Author Address </label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md address form-control" id="auth_address" name="address" placeholder="Author address" style="margin-bottom: 10px" type="text" value="${address}"/>
	                            </div>
	                        </div>
	                        <div id="div_tel_no" class="form-group required"> 
	                            <label for="id_tel_no" class="control-label col-md-4  requiredField">Author Tel No. </label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md tel_no form-control" id="auth_tel_no" name="tel_no" placeholder="Telephone number" style="margin-bottom: 10px" type="text" value="${tel_no}"/>
	                            </div>
	                        </div>
	                        <div id="div_speciality" class="form-group required"> 
	                            <label for="speciality" class="control-label col-md-4  requiredField">Speciality</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md speciality form-control" id="auth_speciality" name="speciality" placeholder="Specialist" style="margin-bottom: 10px" type="text" value="${speciality}"/>
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
<jsp:include page="include/footer.jsp" />