
<%@page import="java.sql.*"%>
<%@ page import="com.lms.utilities.DBConnection" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Purchase</title>
</head>
<body>
         <form action="${pageContext.request.contextPath}/purchaseProduct" method="post">
		<!--  			<div class="card">
					Product Name<input type="text" name="product">
					Quantity<input type="text" name="qty">
					
					<br><br>
					<input type="submit" value="Buy">
					
					</div>-->
				</form>
<div class="container list">
			  <h2>Products</h2>            
			  <table class="table">
			    <thead>
			      <tr>
			        <th>Product</th>
			        <th>Price</th>
			        <th>Qunatity</th>
			        <th></th><th></th>
			      </tr>
			    </thead>
				    <tbody>
			    		<%
			    		try{
			    			Connection con = DBConnection.getConnection();
			    			Statement stmt = con.createStatement();
			    			ResultSet rs = stmt.executeQuery("select * from shoping");
			    		
			    		%>
			    		<% while(rs.next()){ %>
			    			<tr>
			    				<td><%=rs.getString("product_name")%></td>
			    				<td><%=rs.getString("price")%></td>
			    				<td><%=rs.getString("qty")%></td>
			    				
			    				 <td><a href="${pageContext.request.contextPath}/purchaseProduct?id=<%=rs.getString("id")%>">Purchase</a></td>
	    						<!-- <td><a href="${pageContext.request.contextPath}/deleteBook?id=<%=rs.getString("id")%>" onclick="return confirm('Are you sure to delete this book, it will affact its references')">Delete</a></td>
			    			-->
			    			</tr>
			    		<% 
			    			}
			    		    }catch(Exception e){e.printStackTrace();}
			    		 %>
	  			   	</tbody>
			  </table>
			  
		</div>
	     	
</body>
</html>