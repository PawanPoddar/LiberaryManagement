<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<html>
	<head>
	<title>Library Management System</title>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel='shortcut icon' type='image/x-icon' href='images/favicon.ico' />
		<!-- <link rel="shortcut icon" type="image/png" href="images/favicon.png"/> -->
		
		<!-- custom css -->
		<link href="css/main.css" type="text/css" rel="stylesheet">
	</head>
	<body id="pg-login" class="pg-login-signup-bg">
	   	<div class="login_box">
		    <div class="box_content">
		    	<label class="errmsg">${message}</label>
					<form action="${pageContext.request.contextPath}/login" method="post">    	
						<label>Username</label><br/>
						<input class="text-align-center" type="text" name="uname"><br/><br/>
						<label>Password</label><br/>
						<input class="text-align-center" type="password" name="upasswd"><br/>
						<input type="submit" value="Log In"><br/>
		 			</form>
			</div>
	   	</div>
	</body>
</html>