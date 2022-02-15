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
		                <div class="panel-title">Search All</div>
		            </div>  
		            <div class="panel-body" >
		            	<div class="errmsg">${message}</div>
	                    <form  class="form-horizontal" method="post" action="${pageContext.request.contextPath}/search_all">
	                    	<div id="search_type" class="form-group required"> 
	                            <label for="id" class="control-label col-md-4  requiredField">Type </label> 
	                            <div class="controls col-md-8 "> 
	                                <select class="form-control" name="type">
	                                	<option value="">Select Type</option>
	                                	<option value="author">Author</option>
	                                	<option value="book">Book</option>
	                                	<option value="category">Category</option>
	                                	<option value="employee">Employee</option>
	                                	<option value="member">Member/Student</option>
	                                </select>
	                            </div>
	                        </div>
	                    	<div id="search_keyword_div" class="form-group required"> 
	                            <label for="search_keyword_div" class="control-label col-md-4  requiredField">Search ID or Name</label> 
	                            <div class="controls col-md-8 "> 
	                                <input class="input-md auth_id form-control" id="search_keyword" name="search_keyword" 
	                                placeholder="Enter ID or Name" style="margin-bottom: 10px" type="text" value="${search_keyword}" />
	                            </div>
	                        </div>
	                        <div class="form-group"> 
	                            <div class="aab controls col-md-5"></div>
	                            <div class="controls col-md-3">
	                                 <input type="submit" name="save" value="Search" class="btn btn-success" id="submit-id-save" />
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
		<div class="container list">           
			<table class="table">
				<thead>
					<tr id="tableHeader">
			      	</tr>
			    </thead>
				<tbody id="tableBody">
				</tbody>
			  </table>
		</div>
	</body>
	<script type="text/javascript">
		$(document).ready(function() {
			var type = '${type}';
			$("#search_type select").val(type);
			
			var headerList = '${headerList}';
			var searchList = '${searchList}';
			if(headerList != '' && searchList != ''){
				headerList = JSON.parse(headerList);
				searchList = JSON.parse(searchList);
				
				$("#tableHeader").html("");
				$("#tableBody").html("");
				
				for(var i=0; i<headerList.headerList.length;i++){
					$("#tableHeader").append("<th>"+headerList.headerList[i]+"</th>");
				}
				
				if(searchList.searchList.length == 0){
					$("#tableBody").html("No data available");
				}else{
					for(var i=0; i<searchList.searchList.length;i++){
						var searchResult = searchList.searchList[i];
						$("#tableBody").append("<tr>");
						for(var j=0; j<searchResult.length;j++){
							$("#tableBody").append("<td>"+searchResult[j]+"</td>");
						}
						$("#tableBody").append("</tr>");
					}
				}
			}
			
			$("#signupbox input[type='text'],#signupbox input[type='date'],#signupbox select").focusin(function(){
				$(".errmsg").html("");
			});
		});
	</script>
</html>