<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html SYSTEM "about:legacy-compat">
<html>
	<head>
	<title>Library Management System</title>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel='shortcut icon' type='image/x-icon' href='../images/favicon.ico' />
		<!-- <link rel="shortcut icon" type="image/png" href="images/favicon.png"/> -->
		
		<!-- custom css -->
		<link href="${pageContext.request.contextPath}/css/main.css" type="text/css" rel="stylesheet">
		
		<!-- jQuery.js -->
		<script src="${pageContext.request.contextPath}/js/jquery-1.11.1.min.js"></script>
			
		<!-- bootstarp.css/js -->
		<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
		<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	</head>
<!-- Page Body -->
<body id="pg-signup" class="pg-login-signup-bg">
	<div class="container">
   		<div id="signupbox" style=" margin-top:30px" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
       		<div class="panel panel-info">
	            <div class="panel-heading">
	                <div class="panel-title">Create New Account</div>
	            </div>  
	            <div class="panel-body" >
	           	 <div class="errmsg"> ${message}</div>
                    <form  class="form-horizontal" method="post" action="${pageContext.request.contextPath}/signup">
                    	<div id="div_id_name" class="form-group required"> 
                            <label for="id_name" class="control-label col-md-4  requiredField">Name<span class="asteriskField">*</span> </label> 
                            <div class="controls col-md-8 "> 
                                <input class="input-md name form-control" id="id_name" name="name" placeholder="Your First name and Last name" style="margin-bottom: 10px" type="text" />
                            </div>
                        </div>
                        <div id="div_id_email" class="form-group required">
                            <label for="id_email" class="control-label col-md-4  requiredField"> E-mail<span class="asteriskField">*</span> </label>
                            <div class="controls col-md-8 ">
                                <input class="input-md emailinput form-control" id="id_email" name="email" placeholder="Your current email address" style="margin-bottom: 10px"  />
                            </div>     
                        </div>
                        <div id="div_id_username" class="form-group required">
                            <label for="id_username" class="control-label col-md-4  requiredField"> Username<span class="asteriskField">*</span> </label>
                            <div class="controls col-md-8 ">
                                <input class="input-md  textinput textInput form-control" id="id_username" maxlength="30" name="username" placeholder="Choose your username" style="margin-bottom: 10px" type="text" />
                            </div>
                        </div>
                        <div id="div_id_password1" class="form-group required">
                            <label for="id_password1" class="control-label col-md-4  requiredField">Password<span class="asteriskField">*</span> </label>
                            <div class="controls col-md-8 "> 
                                <input class="input-md textinput textInput form-control" id="id_password1" name="password1" placeholder="Create a password" style="margin-bottom: 10px" type="password" />
                            </div>
                        </div>
                        <div id="div_id_password2" class="form-group required">
                             <label for="id_password2" class="control-label col-md-4  requiredField"> Re:password<span class="asteriskField">*</span> </label>
                             <div class="controls col-md-8 ">
                                <input class="input-md textinput textInput form-control" id="id_password2" name="password2" placeholder="Confirm your password" style="margin-bottom: 10px" type="password" />
                            </div>
                        </div>
                        <div id="div_address" class="form-group required"> 
                            <label for="id_address" class="control-label col-md-4  requiredField">Address </label> 
                            <div class="controls col-md-8 "> 
                                <input class="input-md address form-control" id="id_address" name="address" placeholder="Your address" style="margin-bottom: 10px" type="text" />
                            </div>
                        </div>
                        <div id="div_mobile_no" class="form-group required"> 
                            <label for="id_mobile_no" class="control-label col-md-4  requiredField">Mobile No. </label> 
                            <div class="controls col-md-8 "> 
                                <input class="input-md mobile_no form-control" id="id_mobile_no" name="mobile_no" placeholder="Your mobile number" style="margin-bottom: 10px" type="text" />
                            </div>
                        </div>
                        <div id="div_gender" class="form-group required"> 
                            <label for="id_gender" class="control-label col-md-4  requiredField">Gender<span class="asteriskField">*</span></label> 
                            <div class="controls col-md-8" style="margin: 6px 0px 0px 0px;"> 
                               <label>Male</label>
                               <input type="radio" name="gender" value="M"/>&nbsp;&nbsp;
                               <label>Female</label>
                               <input type="radio" name="gender" value="F"/>
                            </div>
                        </div>
                        <div class="form-group"> 
                            <div class="aab controls col-md-2"></div>
                            <div class="controls col-md-8">
                                 <input type="submit" name="Signup" value="Signup" class="btn btn-success btn btn-info" id="submit-id-signup" />
                            </div>
                             <div class="aab controls col-md-2"></div>
                        </div> 
                        <div class="form-group1"> 
                            <div class="aab controls col-md-3 "></div>
                            <div class="controls col-md-8">
                                 <label>Already Have An Account, <a href="../index.jsp">Login</a></label>
                            </div>
                             <div class="aab controls col-md-2"></div>
                        </div>
                    </form>  
	            </div>
       		</div>
   		</div> 
	</div>
</body>

<!-- Footer -->
<jsp:include page="include/footer.jsp" />