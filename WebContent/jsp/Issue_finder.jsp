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
			  <h2>Books List</h2>            
			  <table class="table">
			    <thead>
			      <tr>
			        <th>Member Id</th>
			        <th>Member Name</th>
			        <th>Book Name</th>
			        <th>Date Of Issue</th>
			        <th>Due Date</th>
			        
			     
			      </tr>
			    </thead>
				    <tbody>
			    		<%
			    		try{
			    			Connection con = DBConnection.getConnection();
			    			Statement stmt = con.createStatement();
			    			ResultSet rs = stmt.executeQuery("select * from issuefinder");
			    		
			    		%>
			    		<% while(rs.next()){ %>
			    			<tr>
			    				<td><%=rs.getInt("mem_id")%></td>
			    				<td><%=rs.getString("mem_name")%></td>
			    				<td><%=rs.getString("book_name")%></td>
			    				<td><%=rs.getString("date_of_issue")%></td>
			    				<td><%=rs.getString("due_date")%></td>
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