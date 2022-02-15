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
			  //request.getRequestDispatcher("/").forward(request, response);
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
	                    <form  class="form-horizontal" method="post" action="${pageContext.request.contextPath}/updateMember">
	                       <%
				    		try{
				    			Connection con = DBConnection.getConnection();
				    			Statement stmt = con.createStatement();
				    			ResultSet rs = stmt.executeQuery("select * from member_details where id="+request.getParameter("id"));
				    			rs.next();
				    			
				    			request.setAttribute("id", rs.getString("id"));
				    			request.setAttribute("member_id", rs.getString("mem_id"));
				    			request.setAttribute("member_name", rs.getString("mem_name"));
				    			request.setAttribute("member_address", rs.getString("mem_address"));
				    			request.setAttribute("member_tel", rs.getString("mem_tel_no"));
				    			request.setAttribute("date_of_reg", rs.getString("date_of_reg"));
				    			request.setAttribute("mem_type_id", rs.getString("mem_type_id"));
						    %>
	                        <input type="hidden" name="id" value="${id}"/>
	                        <div id="membership_type" class="form-group required"> 
	                            <label for="member_type" class="control-label col-md-4  requiredField">Member Type</label> 
	                           	<div class="controls col-md-8 ">
	                           		<select class="form-control" name="membership_type">
		                                <option value="">Select Membership type</option>
		                            	<%
							    		try{
								    		rs = stmt.executeQuery("select * from membership_type");
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
	                        <div id="div_member_id" class="form-group required"> 
	                            <label for="member_id" class="control-label col-md-4  requiredField">Member ID</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md form-control" id="member_id" name="member_id" placeholder="Enter member id" style="margin-bottom: 10px" type="text" readonly="readonly" value="${member_id}"/>
	                            </div>
	                        </div>
	                    	<div id="div_member_name" class="form-group required"> 
	                            <label for="member_name" class="control-label col-md-4  requiredField">Member Name</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md form-control" id="member_name" name="member_name" placeholder="Enter member name" style="margin-bottom: 10px" type="text" value="${member_name}"/>
	                            </div>
	                        </div>
	                        <div id="div_member_address" class="form-group required"> 
	                            <label for="member_address" class="control-label col-md-4  requiredField">Member Address</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md form-control" id="member_address" name="member_address" placeholder="Enter member address" style="margin-bottom: 10px" type="text" value="${member_address}"/>
	                            </div>
	                        </div>
	                        <div id="div_member_tel" class="form-group required"> 
	                            <label for="member_tel" class="control-label col-md-4  requiredField">Member Tel No.</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md form-control" id="member_tel" name="member_tel" placeholder="Enter member tel no." style="margin-bottom: 10px" type="text" value="${member_tel}"/>
	                            </div>
	                        </div>
	                        <div id="div_date_of_reg" class="form-group required"> 
	                            <label for="date_of_reg" class="control-label col-md-4  requiredField">Date of Registration</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md form-control" id="date_of_reg" name="date_of_reg" style="margin-bottom: 10px" type="date" value="${date_of_reg} " />
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
			object.member_id = '${member_id}';
			object.member_name = '${member_name}';
			object.member_address = '${member_address}';
			object.member_tel = '${member_tel}';
			object.mem_type_id = ${mem_type_id};
			object.date_of_reg = '${date_of_reg}';
			
			$("#membership_type select").val(object.mem_type_id);
			$("#date_of_reg").val(object.date_of_reg);
			
			$("#f_reset").click(function(){
				$("#member_id").val(object.member_id);
				$("#member_name").val(object.member_name);
				$("#member_address").val(object.member_address);
				$("#member_tel").val(object.member_tel);
				setTimeout(function(){
					$("#membership_type select").val(object.mem_type_id);
					$("#date_of_reg").val(object.date_of_reg);
				}, 200);
			});
			
			$("#signupbox input[type='text'],#signupbox input[type='date'],#signupbox select").focusin(function(){
				$(".errmsg").html("");
			});
		});
	</script>
<jsp:include page="include/footer.jsp" />