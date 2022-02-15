<%@page import="java.sql.*"%>
<%@ page import="com.lms.utilities.DBConnection" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
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
		<div class="container list">
			  <h2>Late Fee List</h2>            
			  <table class="table">
			    <thead>
			      <tr>
			        <th>Member Type ID</th>
			        <th>Days 0-10</th>
			        <th>Days 11-15</th>
			        <th>Days 16-30</th>
			        <th>Days>30</th>
			        <th></th><th></th>
			      </tr>
			    </thead>
				    <tbody>
			    		<%
			    		try{
			    			Connection con = DBConnection.getConnection();
			    			Statement stmt = con.createStatement();
			    			ResultSet rs = stmt.executeQuery("select * from late_fees");
			    		
			    		%>
			    		<% while(rs.next()){ %>
			    			<tr>
			    				<td><%=rs.getString("mem_type_name")%></td>
			    				<td><%=rs.getString("days_0_10")%></td>
			    				<td><%=rs.getString("days_11_15")%></td>
			    				<td><%=rs.getString("days_16_30")%></td>
			    				<td><%=rs.getString("days_gt_30")%></td>
			    				<td><a href="${pageContext.request.contextPath}/jsp/late_fee_update.jsp?id=<%=rs.getString("id")%>">Edit</a></td>
	    						<td><a href="${pageContext.request.contextPath}/deleteLateFee?id=<%=rs.getString("id")%>" onclick="return confirm('Are you sure to delete this late fee details, it will affact its references')">Delete</a></td>
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