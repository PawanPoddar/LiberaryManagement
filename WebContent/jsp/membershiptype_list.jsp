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
			<h2>Membership List</h2>            
			<table class="table">
				<thead>
					<tr>
				        <th>ID</th>
				        <th>Membership Type ID</th>
				        <th>Membership Type Name</th>
				        <th>Reg. Fees</th>
				        <th></th><th></th>
			      	</tr>
			    </thead>
				<tbody>
				    <%
		    		try{
		    			Connection con = DBConnection.getConnection();
		    			Statement stmt = con.createStatement();
		    			ResultSet rs = stmt.executeQuery("select * from membership_type");
				    	while(rs.next()){ 
				    %>
	    			<tr>
	    				<td><%=rs.getInt("id")%></td>
	    				<td><%=rs.getString("mem_type_id")%></td>
	    				<td><%=rs.getString("mem_type_name")%></td>
	    				<td><%=rs.getInt("reg_fees")%></td>
	    				<td><a href="${pageContext.request.contextPath}/jsp/membershiptype_update.jsp?id=<%=rs.getString("id")%>">Edit</a></td>
	    				<td><a href="${pageContext.request.contextPath}/deleteMembership?id=<%=rs.getString("id")%>" onclick="return confirm('Are you sure to delete this membership type, it will affact its references')">Delete</a></td>
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