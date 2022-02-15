<%@page import="java.sql.*"%>
<%@page import="com.lms.utilities.DBConnection"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
    
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
		<div class="container list">
			<h2>Author List</h2>            
			<table class="table">
				<thead>
					<tr>
				        <th>ID</th>
				        <th>Name</th>
				        <th>Address</th>
				        <th>Tel No.</th>
				        <th>Specialty</th>
				        <th></th><th></th>
			      	</tr>
			    </thead>
				<tbody>
				    <%
		    		try{
		    			Connection con = DBConnection.getConnection();
		    			Statement stmt = con.createStatement();
		    			ResultSet rs = stmt.executeQuery("select * from author_details");
				    	while(rs.next()){ 
				    %>
	    			<tr>
	    				<td><%=rs.getString("auth_id")%></td>
	    				<td><%=rs.getString("auth_name")%></td>
	    				<td><%=rs.getString("auth_address")%></td>
	    				<td><%=rs.getString("auth_tel_no")%></td>
	    				<td><%=rs.getString("specialty")%></td>
	    				<td><a href="${pageContext.request.contextPath}/jsp/author_update.jsp?id=<%=rs.getString("id")%>">Edit</a></td>
	    				<td><a href="${pageContext.request.contextPath}/deleteAuthor?id=<%=rs.getString("id")%>" onclick="return confirm('Are you sure to delete this author, it will affact its references')">Delete</a></td>
	    			</tr>
			    	<% 
			    		}
			    	}catch(Exception e){e.printStackTrace();}
			    	%>
	  			   	</tbody>
			  </table>
		</div>
	</body>
<jsp:include page="include/footer.jsp" />