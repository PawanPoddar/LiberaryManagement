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
		                <div class="panel-title">Welcome to the Member Details</div>
		            </div>  
		            <div class="panel-body" >
		            	<div class="errmsg">${message}</div>
		            	<%
						request.getSession().removeAttribute("message");
						%>
	                    <form  class="form-horizontal" method="post" action="${pageContext.request.contextPath}/saveMember">
	                        <div id="membership_type" class="form-group required"> 
	                            <label for="member_type" class="control-label col-md-4  requiredField">Member Type</label> 
	                           	<div class="controls col-md-8 "> 
	                           		<select class="form-control" name="membership_type">
	                                	<option value="">Select Membership type</option>
		                           	    <%
							    		try{
							    			Connection con = DBConnection.getConnection();
							    			Statement stmt = con.createStatement();
							    			ResultSet rs = stmt.executeQuery("select * from membership_type");
								    		while(rs.next()){ 
								    	%>
		                                		<option value=<%=rs.getString("id")%>><%=rs.getString("mem_type_name")%></option>
	              						<% 
				    						}
				    		   			}catch(Exception e){
				    		   				e.printStackTrace();
				    		   			}
				    				    %>
	                                </select>
		                        </div>
	                        </div>
	                    	<div id="member_name" class="form-group required"> 
	                            <label for="member_name" class="control-label col-md-4  requiredField">Member Name</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md form-control" id="m_name" name="member_name" placeholder="Enter member name" style="margin-bottom: 10px" type="text" value="${member_name}"/>
	                            </div>
	                        </div>
	                        <div id="member_address" class="form-group required"> 
	                            <label for="member_address" class="control-label col-md-4  requiredField">Member Address</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md form-control" id="m_address" name="member_address" placeholder="Enter member address" style="margin-bottom: 10px" type="text" value="${member_address}"/>
	                            </div>
	                        </div>
	                        <div id="member_tel" class="form-group required"> 
	                            <label for="member_tel" class="control-label col-md-4  requiredField">Member Tel No.</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md form-control" id="m_tel" name="member_tel" placeholder="Enter member tel no." style="margin-bottom: 10px" type="text" value="${member_tel}"/>
	                            </div>
	                        </div>
	                        <div id="date_of_reg" class="form-group required"> 
	                            <label for="date_of_reg" class="control-label col-md-4  requiredField">Date of Registration</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md form-control" id="date_of_reg" name="date_of_reg" style="margin-bottom: 10px" type="date" />
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
			var mem_type_id = ${membership_type};
			$("#membership_type select").val(mem_type_id);
			
			$("#signupbox input[type='text'],#signupbox input[type='date'],#signupbox select").focusin(function(){
				$(".errmsg").html("");
			});
		});
	</script>
<jsp:include page="include/footer.jsp" />