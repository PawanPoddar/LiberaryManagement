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
		                <div class="panel-title">Welcome to the Category List</div>
		            </div>  
		            <div class="panel-body" >
		            	<div class="errmsg">${message}</div>
		            	<%
						request.getSession().removeAttribute("message");
						%>
	                    <form  class="form-horizontal" method="post" action="${pageContext.request.contextPath}/updateCategory">
	                       <%
				    		try{
				    			Connection con = DBConnection.getConnection();
				    			Statement stmt = con.createStatement();
				    			ResultSet rs = stmt.executeQuery("select * from category_list where id="+request.getParameter("id"));
				    			rs.next();
				    			request.setAttribute("id", rs.getString("id"));
				    			request.setAttribute("cat_id", rs.getString("cat_id"));
				    			request.setAttribute("cat_name", rs.getString("category_name"));
						   %>
						   <input type="hidden" name="id" value="${id}"/>
	                       <div id="div_category_id" class="form-group required"> 
	                            <label for="category_id" class="control-label col-md-4  requiredField">Category ID</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md category form-control" id="category_id" name="category_id" style="margin-bottom: 10px" type="text" value="${cat_id}" readonly="readonly"/>
	                            </div>
	                        </div>
	                        <div id="div_category" class="form-group required"> 
	                            <label for="category" class="control-label col-md-4  requiredField">Category Name</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md category form-control" id="category_name" name="category_name" style="margin-bottom: 10px" type="text" value="${cat_name}" />
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
			object.cat_id = '${cat_id}';
			object.cat_name = '${cat_name}';
			
			$("#f_reset").click(function(){
				$("#category_id").val(object.cat_id);
				$("#category_name").val(object.cat_name);
			});
			
			$("#signupbox input[type='text'],#signupbox input[type='date'],#signupbox select").focusin(function(){
				$(".errmsg").html("");
			});
		});
	</script>
<jsp:include page="include/footer.jsp" />