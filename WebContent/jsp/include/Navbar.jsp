	<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="${pageContext.request.contextPath}/jsp/adminPanel.jsp">
				<img class="logo" src="${pageContext.request.contextPath}/images/lms_logo.png">
			</a>
		</div>
		<ul class="nav navbar-nav">
			<li class="dropdown">
				<a class="dropdown-toggle" href="${pageContext.request.contextPath}/jsp/search_all.jsp">Search</a>
			</li>
			<li class="dropdown">
				<a class="dropdown-toggle" data-toggle="dropdown" href="#">Author
       				<span class="caret"></span>
       			</a>
       			<ul class="dropdown-menu">
					<li><a href="${pageContext.request.contextPath}/jsp/author_save.jsp">Add New</a></li>
					<li><a href="${pageContext.request.contextPath}/jsp/author_list.jsp">List View</a></li>
				</ul>
			</li>
			<li class="dropdown">
        		<a class="dropdown-toggle" data-toggle="dropdown" href="#">Books
       				<span class="caret"></span>
       			</a>
      			<ul class="dropdown-menu">
					<li><a href="${pageContext.request.contextPath}/jsp/book_save.jsp">Add New</a></li>
					<li><a href="${pageContext.request.contextPath}/jsp/book_list.jsp">List View</a></li>
					<li><a href="${pageContext.request.contextPath}/jsp/book_issue_details_save.jsp">Issue a Book</a></li>
					<li><a href="${pageContext.request.contextPath}/jsp/book_submit_details_save.jsp">Submit a Book</a></li>
					<li><a href="${pageContext.request.contextPath}/jsp/Issue_finder.jsp">Book Issue Finder</a></li>
				</ul>
			</li>
			<li class="dropdown">
        		<a class="dropdown-toggle" data-toggle="dropdown" href="#">Books Stock
       				<span class="caret"></span>
       			</a>
      			<ul class="dropdown-menu">
					<li><a href="${pageContext.request.contextPath}/jsp/stock_save.jsp">Add New</a></li>
					<li><a href="${pageContext.request.contextPath}/jsp/stock_list.jsp">List View</a></li>
				</ul>
			</li>
			<li class="dropdown">
				<a class="dropdown-toggle" data-toggle="dropdown" href="#">Category
					<span class="caret"></span>
				</a>
				<ul class="dropdown-menu">
					<li><a href="${pageContext.request.contextPath}/jsp/category_save.jsp">Add New</a></li>
					<li><a href="${pageContext.request.contextPath}/jsp/category_list.jsp">List View</a></li>
				</ul>
			</li>
			<li class="dropdown">
				<a class="dropdown-toggle" data-toggle="dropdown" href="#">Employee
					<span class="caret"></span>
				</a>
       			<ul class="dropdown-menu">
					<li><a href="${pageContext.request.contextPath}/jsp/emp_per_details_save.jsp">Add New</a></li>
					<li><a href="${pageContext.request.contextPath}/jsp/emp_details_list.jsp">List View</a></li>
				</ul>
			</li>
			<li class="dropdown">
       			<a class="dropdown-toggle" data-toggle="dropdown" href="#">Late Fees
       				<span class="caret"></span>
       			</a>
       			<ul class="dropdown-menu">
					<li><a href="${pageContext.request.contextPath}/jsp/late_fee_save.jsp">Add New</a></li>
					<li><a href="${pageContext.request.contextPath}/jsp/late_fee_list.jsp">List View</a></li>
				</ul>
			</li>
			<li class="dropdown">
       			<a class="dropdown-toggle" data-toggle="dropdown" href="#">Member
       				<span class="caret"></span>
       			</a>
       			<ul class="dropdown-menu">
					<li><a href="${pageContext.request.contextPath}/jsp/member_save.jsp">Add New</a></li>
					<li><a href="${pageContext.request.contextPath}/jsp/member_list.jsp">List View</a></li>
					<li><a href="${pageContext.request.contextPath}/jsp/membershiptype_save.jsp">Add New Membership Type</a></li>
					<li><a href="${pageContext.request.contextPath}/jsp/membershiptype_list.jsp">Membership Tpye List View</a></li>
				</ul>
			</li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="${pageContext.request.contextPath}/logout"><i class="fa fa-sign-out"></i> Logout</a></li>
	    </ul>
	</div>
</nav>