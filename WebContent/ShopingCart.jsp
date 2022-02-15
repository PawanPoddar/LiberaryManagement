<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ShopingCart</title>
</head>
<body>
	<form action="productDetail" method="post">
		<div class="card">
		Product Name<input type="text" name="product">
		Price <input type="text" name="price">
		Quantity<input type="text" name="qty">
		<br><br>
		<input type="submit" value="submit">
		
		</div>
		
	</form>
	<form action="viewDetail" method="get">
		
		<input type="submit" value="View All Products">
		
		</div>
		
	</form>
	<form action="viewOrder" method="get">
		
		<input type="submit" value="View All Orders">
		
		</div>
		
	</form>
</body>
</html>