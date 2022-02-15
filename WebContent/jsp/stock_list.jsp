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
			  <h2>Books Stock List</h2>            
			  <table class="table">
			    <thead>
			      <tr>
			        <th>ISBN No.</th>
			        <th>Book Name</th>
			        <th>Author Name</th>
			        <th>Category</th>
			        <th>No. of books</th>
			        <th></th><th></th>
			      </tr>
			    </thead>
				    <tbody>
			    		<%
			    		try{
			    			Connection con = DBConnection.getConnection();
			    			Statement stmt = con.createStatement();
			    			ResultSet rs = stmt.executeQuery("select * from stock_details");
			    		
			    		%>
			    		<% while(rs.next()){ %>
			    			<tr>
			    				<td><%=rs.getString("isbn_no")%></td>
			    				<td><%=rs.getString("book_name")%></td>
			    				<td><%=rs.getString("auth_name")%></td>
			    				<td><%=rs.getString("category_name")%></td>
			    				<td><%=rs.getString("no_of_books")%></td>
			    				<td><a href="${pageContext.request.contextPath}/jsp/stock_update.jsp?id=<%=rs.getString("id")%>">Edit</a></td>
	    						<td><a href="${pageContext.request.contextPath}/deleteStock?id=<%=rs.getString("id")%>" onclick="return confirm('Are you sure to delete this stock, it will affact its references')">Delete</a></td>
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