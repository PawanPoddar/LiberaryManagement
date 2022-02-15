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
		                <div class="panel-title">Welcome to the Category List</div>
		            </div>  
		            <div class="panel-body" >
		            	<div class="errmsg">${message}</div>
		            	<%
						request.getSession().removeAttribute("message");
						%>
	                    <form  class="form-horizontal" method="post" action="${pageContext.request.contextPath}/addCategory">
	                        <div id="div_category" class="form-group required"> 
	                            <label for="category" class="control-label col-md-4  requiredField">Category Name</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md category form-control" id="category_name" name="category_name" placeholder="Enter category name" style="margin-bottom: 10px" type="text" value="${cat_name}"/>
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