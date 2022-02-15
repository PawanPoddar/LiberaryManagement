<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*, com.lms.utilities.DBConnection"%>
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
		                <div class="panel-title">Welcome to the Book Submit Details</div>
		            </div>  
		            <div class="panel-body" >
		            	<div class="errmsg">${message}</div>
		            	<%
		            	request.getSession().removeAttribute("message");
		            	%>
	                    <form  class="form-horizontal" method="post" action="${pageContext.request.contextPath}/saveBookSubmit">
	                    	<div id="mem_name" class="form-group required"> 
	                            <label for="id" class="control-label col-md-4  requiredField">Member Name</label> 
	                            <div class="controls col-md-8 "> 
	                           		<select class="form-control" name="mem_name">
	                                	<option value="">Select Member name</option>
		                           	    <%
							    		try{
							    			Connection con = DBConnection.getConnection();
							    			Statement stmt = con.createStatement();
							    			ResultSet rs = stmt.executeQuery("select * from member_details");
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
	                        <div id="book_name" class="form-group required"> 
	                            <label for="book_name" class="control-label col-md-4  requiredField">Book Name </label> 
	                             <div class="controls col-md-8 "> 
	                           		<select class="form-control" name="book_name">
	                                	<option value="">Select Book name</option>
		                           	    <%
							    		try{
							    			Connection con = DBConnection.getConnection();
							    			Statement stmt = con.createStatement();
							    			ResultSet rs = stmt.executeQuery("select * from book_details");
								    		while(rs.next()){ 
								    	%>
		                                		<option value=<%=rs.getString("id")%>><%=rs.getString("book_name")%></option>
	              						<% 
				    						}
				    		   			}catch(Exception e){
				    		   				e.printStackTrace();
				    		   			}
				    				    %>
	                                </select>
		                        </div>
	                        </div>
	                        <div id="div_dos" class="form-group required"> 
	                            <label for="id_dos" class="control-label col-md-4  requiredField">Date of Submit</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md date_of_submit form-control" id="date_of_submit" name="date_of_submit" placeholder="Enter the date" style="margin-bottom: 10px" type="date" />
	                            </div>
	                        </div>
	                        <div id="div_late_days" class="form-group required"> 
	                            <label for="late_days" class="control-label col-md-4  requiredField">Late Days</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md late_days form-control" id="id_late_days" name="late_days" placeholder="Enter late days" style="margin-bottom: 10px" type="text" value="${late_days}"/>
	                            </div>
	                        </div>
	                        <div id="div_late_fees" class="form-group required"> 
	                            <label for="late_fees" class="control-label col-md-4  requiredField">Late Fees</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md late_fees form-control" id="id_late_fees" name="late_fees" placeholder="Enter late fees" style="margin-bottom: 10px" type="text" value="${late_fees}"/>
	                            </div>
	                        </div>
	                        <div id="div_paid_amount" class="form-group required"> 
	                            <label for="late_paid_amount" class="control-label col-md-4  requiredField">Paid Amount</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md paid_amount form-control" id="paid_amount" name="paid_amount" placeholder="Enter paid amount" style="margin-bottom: 10px" type="text" value="${paid_amount}"/>
	                            </div>
	                        </div>
	                        <div id="div_bal_amount" class="form-group required"> 
	                            <label for="bal_amount" class="control-label col-md-4  requiredField">Balance Amount</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md bal_amount form-control" id="bal_amount" name="bal_amount" placeholder="Enter balance amount" style="margin-bottom: 10px" type="text" value="${balance_amount}"/>
	                            </div>
	                        </div>
	                        <div id="div_date_of_pay" class="form-group required"> 
	                            <label for="date_pay" class="control-label col-md-4  requiredField">Date of Payment</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md date_pay form-control" id="date_of_payment" name="date_of_payment" placeholder="Enter date of payment" style="margin-bottom: 10px" type="date" />
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
			var object = {};
			object.mem_id = '${mem_id}';
			object.book_id = '${book_id}';
			object.date_of_submit = '${date_of_submit}';
			object.date_of_payment = '${date_of_payment}';
			
			$("#mem_name select").val(object.mem_id);
			$("#book_name select").val(object.book_id);
			$("#date_of_submit").val(object.date_of_submit);
			$("#date_of_payment").val(object.date_of_payment);
			
			$("#signupbox input[type='text'],#signupbox input[type='date'],#signupbox select").focusin(function(){
				$(".errmsg").html("");
			});
		});
	</script>
</html>