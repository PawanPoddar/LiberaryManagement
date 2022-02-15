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
		                <div class="panel-title">Welcome to the Late Fees Details</div>
		            </div>  
		            <div class="panel-body" >
			            <div class="errmsg">${message}</div>
		            	<%
		            	request.getSession().removeAttribute("message");
		            	%>
	                    <form  class="form-horizontal" method="post" action="${pageContext.request.contextPath}/updateLateFee">
	                    	<%
				    		try{
				    			Connection con = DBConnection.getConnection();
				    			Statement stmt = con.createStatement();
				    			ResultSet rs = stmt.executeQuery("select * from late_fees where id="+request.getParameter("id"));
				    			rs.next();
				    			request.setAttribute("id", rs.getString("id"));
				    			request.setAttribute("mem_type_id", rs.getString("mem_type_id"));
				    			request.setAttribute("days_10", rs.getString("days_0_10"));
				    			request.setAttribute("days_15", rs.getString("days_11_15"));
				    			request.setAttribute("days_30", rs.getString("days_16_30"));
				    			request.setAttribute("more_30", rs.getString("days_gt_30"));
						    %>
						    <input type="hidden" name="id" value="${id}"/>
	                    	<div id="member_type" class="form-group required"> 
	                            <label for="member_type" class="control-label col-md-4  requiredField">Member Type</label> 
	                            <div class="controls col-md-8 "> 
	                           		<select class="form-control" name="member_type" disabled="disabled">
	                                	<option value="">Select Membership type</option>
		                           	    <%
							    		try{
							    			rs = stmt.executeQuery("select * from membership_type");
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
	                    	<div id="days_10" class="form-group required"> 
	                            <label for="days_10" class="control-label col-md-4  requiredField">Days 0-10</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md form-control" id="days" name="days_10" style="margin-bottom: 10px" type="text" value="${days_10}" />
	                            </div>
	                        </div>
	                    	<div id="days_15" class="form-group required"> 
	                            <label for="days_15" class="control-label col-md-4  requiredField">Days 11-15</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md form-control" id="days" name="days_15" style="margin-bottom: 10px" type="text" value="${days_15}" />
	                            </div>
	                        </div>
	                        <div id="days_30" class="form-group required"> 
	                            <label for="days_30" class="control-label col-md-4  requiredField">Days 16-30</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md form-control" id="days" name="days_30" style="margin-bottom: 10px" type="text" value="${days_30}" />
	                            </div>
	                        </div>
	                        <div id="more_30" class="form-group required"> 
	                            <label for="more_30" class="control-label col-md-4  requiredField">Days >30</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md form-control" id="more_30" name="more_30" style="margin-bottom: 10px" type="text" value="${more_30}" />
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
			var mem_type_id = '${mem_type_id}';
			$("#member_type select").val(mem_type_id);
			$('option:not(:selected)').attr('disabled', true);
			
			$("#signupbox input[type='text'],#signupbox input[type='date'],#signupbox select").focusin(function(){
				$(".errmsg").html("");
			});
		});
	</script>
</html>