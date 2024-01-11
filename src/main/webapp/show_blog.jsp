<%@page import="com.tech.loom.dao.LikeDao"%>
<%@page import="com.tech.loom.entities.Users"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.loom.dao.UserDao"%>
<%@page import="com.tech.loom.entities.Post"%>
<%@page import="com.tech.loom.helper.ConnectionProvider"%>
<%@page import="com.tech.loom.dao.PostDao"%>
<%
PostDao d = new PostDao(ConnectionProvider.getConnection());
int postId = Integer.parseInt(request.getParameter("post_id"));

Post post = d.getPostByPostId(postId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>This is blog page</title>
<!-- Bootstrap CSS -->
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
/* Custom CSS for styling */
.custom-card {
	background-color: #343a40; /* Dark background color */
	color: #fff; /* White text color */
}

.post-title {
	font-weight: 400;
	font-size: 35px;
}

.post-content {
	font-size: 17px;
}

.post-date {
	font-style: italic;
	font-weight: bold;
}

.post-user-info {
	font-size: 17px;
}

body {
	background-color: #2f2f2f;
	color: #fff;
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

/* Styles for the button when it's in the liked state */
.liked {
    /* Your CSS styles for the liked state */
    color: blue;
    /* ... */
}

/* Styles for the button when it's in the disliked state */
.disliked {
    /* Your CSS styles for the disliked state */
    color: red;
    /* ... */
}

/* Style for the like button */

</style>
</head>
<body>
	<div class="container mt-2">
		<div class="row justify-content-center">

			<div class="col-md-10">
				<div class="card custom-card">
					<div class="card-body">

						<h5 class="post-title"><%=post.getpTitle()%></h5>
						<h6 class="card-subtitle mb-2 text-muted">Subtitle or
							additional details</h6>
						<p class="post-content"><%=post.getpContent()%></p>

						<div class="post-code">
							<pre class="card-text text-white"><%=post.getpCode()%></pre>

						</div>

						<div class="row my-3">
							<div class="col-md-8">


								<%
								UserDao ud = new UserDao(ConnectionProvider.getConnection());
								%>
								<p class="post-user-info">
									<a href="#"><%=ud.getUserByUserId(post.getUserId()).getName()%></a>
									has posted:
								</p>
							</div>

							<div class="col-md-4">
								<p class="post-date"><%=DateFormat.getDateInstance().format(post.getpDate())%></p>
							</div>


							<div class="card-footer p-2 mr-0">
								<%
								Users user = (Users) session.getAttribute("currentUser");
								LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
								%>
								<%
								if (user != null) {
								%>

								
									<!-- If user is  login then they can like the post -->
								 <a  onclick="doLike(<%=post.getPid()%>, <%=user.getId()%>)"
									class="btn btn-outline-success btn-sm "><i
									class="fa fa-thumbs-o-up"></i> <span class="like-counter"><%=ldao.countLikeOnPost(post.getPid())%></span></a>
									 

								<%
								} else {
								%>

								<!-- If user is not login then redirect on login page if they try to like the post -->

								<a  href="Login.jsp" class="btn btn-outline-success btn-sm"
									class="like-btn"><i class="fa fa-thumbs-o-up"></i> <span
									class="like-counter"><%=ldao.countLikeOnPost(post.getPid())%></span></a>

								<%
								}
								%>

								<a href="#" class="btn btn-outline-success btn-sm"> <i
									class="fa fa-commenting-o"></i><span>10</span></a>

							</div>
						</div>
						<!-- Additional content or links can be added here -->
						<a href="#" class="card-link">Card Link</a> <a href="#"
							class="card-link">Another Link</a>

					</div>

				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap JS and dependencies -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
		integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
		crossorigin="anonymous"></script>
	<script src="js/like.js" type="text/javascript"></script>

	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>





</body>
</html>
