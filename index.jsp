<%@page import="com.tech.loom.entities.Users"%>
<%@page import="com.tech.loom.dao.LikeDao"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.loom.entities.Post"%>
<%@page import="com.tech.loom.dao.PostDao"%>
<%@page import="com.tech.loom.helper.ConnectionProvider"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>TechLoom</title>

<!-- CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
.container-fluid {
	clip-path: polygon(50% 0%, 100% 0, 100% 35%, 100% 100%, 75% 94%, 49% 99%, 23% 94%,
		0 99%, 0% 35%, 0 0);
}

body {
	background-color: #2f2f2f;
}

.card {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
	/* Adjust these values as needed */
}

/* Adjust card shadow on hover */
.card:hover {
	box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
	/* Adjust these values as needed */
}
/* Custom styles for the search input */
.form-inline .form-control[type="search"] {
	background-color: #333; /* Background color for the input */
	color: #aaa; /* Text color for the input */
	border-color: #333; /* Border color for the input */
	width: 350px; /* Adjust width of the input */
	text-align: left; /* Align text to the left */
	font-size: 16px;
}

/* Modify placeholder color if needed */
.form-inline .form-control[type="search"]::placeholder {
	color: #aaa; /* Placeholder text color for the input */
}
</style>
</head>
<body>

	<!--  This is normal navbar-->
	<%@include file="normal_navbar.jsp"%>

	<!-- Banner  -->
	<div class="container-fluid p-0 m-0">

		<div class="jumbotron bg-dark text-white">
			<div class="container">
				<h1 class="display-6" style="margin-top: -39px;">Hello, Tech
					Geniuses! Delve into TechLoom for Endless Technical Resources!</h1>


				<form class="form-inline my-2 my-lg-0 justify-content-center">
					<div class="input-group mt-5">
						<input class="form-control" type="search" placeholder="Search"
							aria-label="Search">
						<div class="input-group-append">
							<button class="btn btn-outline-success" type="submit">Search</button>
						</div>
					</div>
				</form>

				<div class="container mt-3">
					<div class="row justify-content-center">
						<div class="col-md-6 text-center">
							<a class="btn btn-outline-success btn-lg start"
								href="Register.jsp"> <span class="fa fa-external-link"></span>
								Start! it's free
							</a> <a href="Login.jsp"
								class="btn btn-outline-success btn-lg login ml-md-2 mt-3 mt-md-1">
								<span class="fa fa-user-o"></span> Login
							</a>
						</div>
					</div>
				</div>


			</div>
		</div>


	</div>


	<!-- Cards  -->
	<div class="container">

		<div class="row mb-2">

			<%
			PostDao posts = new PostDao(ConnectionProvider.getConnection());
			List<Post> p = posts.getAllPosts();

			for (Post post : p) {
			%>

			<div class="col-md-4 mb-2">
				<div class="card" style="background-color: #343a40; color: #fff;">
					<img class="card-img-top" style="height: 180px; width: 348px"
						src="blog_pics/<%=post.getpPic()%>" alt="Card image cap">
					<div class="card-body" style="height: 10em">
						<b><%=post.getpTitle()%></b>
						<!-- Use 'truncate-ellipsis' class to limit lines -->
						<p class="truncate-ellipsis"
							style="max-height: 6em; overflow: hidden;"><%=post.getpContent()%></p>
					</div>

					<div class="card-footer p-2 mr-0">

						<%
						try {

							LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
							Users users = (Users) session.getAttribute("currentUser");

							if (users != null) {
						%>
						<a onclick="doLike(<%=post.getPid()%>, <%=users.getId()%>)"
							class="btn btn-outline-success btn-sm "><i
							class="fa fa-thumbs-o-up"></i> <span class="like-counter"><%=ldao.countLikeOnPost(post.getPid())%></span></a>
						<!-- Other buttons or actions for logged in users -->
						<!-- Comment button for both logged in and guest users -->
						
						<%
						} else {
						%>

						<!-- Other buttons or actions for guest users -->
						<a href="Login.jsp" class="btn btn-outline-success btn-sm "><i
							class="fa fa-thumbs-o-up"></i> <span class="like-counter"><%=ldao.countLikeOnPost(post.getPid())%></span></a>
						
						<%
						}
						%>
						<%
						} catch (Exception e) {
						e.printStackTrace();
						}
						%>

						<a href="#" class="btn btn-outline-success btn-sm"> <i
							class="fa fa-commenting-o"></i><span>10</span></a>
						<!-- Read more button, works for both logged in and guest users -->
						<a href="show_blog.jsp?post_id=<%=post.getPid()%>"
							class="btn btn-outline-success btn-sm read-more-btn"
							style="margin-left: 133px"> Read more...</a>



					</div>
				</div>
			</div>

			<%
			}
			%>

		</div>



	</div>


	<!-- JavaScript -->
	<script src="js/like.js" type="text/javascript"></script>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
		integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
		crossorigin="anonymous"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>

</body>
</html>
