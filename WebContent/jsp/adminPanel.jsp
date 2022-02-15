<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <!-- Header -->
    <jsp:include page="include/header.jsp" />
  		<body>
  			<%
			  response.setHeader("Cache-Control","no-cache");
			  response.setHeader("Cache-Control","no-store");
			  response.setHeader("Pragma","no-cache");
			  response.setDateHeader ("Expires", 0);
			
			  if(session.getAttribute("login_user")== null)
			  	  response.sendRedirect(request.getContextPath() + "/index.jsp");
			  else
				  response.sendRedirect(request.getContextPath() + "/jsp/search_all.jsp");
			 %>
  			<jsp:include page="include/Navbar.jsp" />
			
  		</body>
    <jsp:include page="include/footer.jsp" /> 