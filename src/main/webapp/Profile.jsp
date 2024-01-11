

<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.loom.helper.ConnectionProvider"%>
<%@page import="com.tech.loom.dao.PostDao"%>
<%@page import="com.tech.loom.entities.Message"%>
<%@page import="com.tech.loom.entities.Users"%>
<%@page import="com.tech.loom.entities.Category"%>
<%@page errorPage="error_page.jsp"%>
<%

Users user = (Users) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("Login.jsp");
}
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

/* Add a shadow to all cards */
    .card {
      box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2); /* Adjust these values as needed */
    }

    /* Adjust card shadow on hover */
    .card:hover {
      box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2); /* Adjust these values as needed */
    }

    /* Your existing styles */
    .container-fluid {
      clip-path: polygon(50% 0%, 100% 0, 100% 35%, 100% 100%, 75% 94%, 49% 99%, 23% 94%, 0 99%, 0% 35%, 0 0);
    }

    body {
      background-color:  #2f2f2f;
    }

    .c-link {
      color: #fff;
    }
</style>
</head>
<body>

	<!-- Start navbar  -->



	<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
	<a class="navbar-brand" href="index.jsp">Tech Blog</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">

			<li class="nav-item active"><a class="nav-link" href="#">Data
					Structure <span class="sr-only">(current)</span>
			</a></li>
			<li class="nav-item active"><a class="nav-link" href="#">Networking</a>
			</li>
			<li class="nav-item dropdown active"><a
				class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> Course </a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#">Machine Learning</a> <a
						class="dropdown-item" href="#">Cyber Security</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#">Devops</a>
				</div></li>
			<li class="nav-item active"><a class="nav-link " href="#">Operating
					System</a></li>

			<li class="nav-item active"><a class="nav-link " href="#"
				data-toggle="modal" data-target="#addPostModal"><span
					class="fa fa-pencil"></span>Do post</a></li>
		</ul>
		<ul class="navbar-nav mr-right">
			<li class="nav-item active"><a class="nav-link " href="#!"
				data-toggle="modal" data-target="#profileModal"><span
					class="fa fa-user-circle"></span><%=user.getName()%></a></li>

			<li class="nav-item active"><a class="nav-link "
				href="LogoutServlet"><span class="fa fa-sign-out"></span>Logout</a>
			</li>

		</ul>

	</div>
	</nav>

	<!-- end navbar -->


	<%
	// to show the message
	Message m = (Message) session.getAttribute("msg");

	if (m != null) {
	%>
	<div class="alert <%=m.getCssClass()%>" role="alert">
		<%=m.getContent()%>
	</div>

	<%
	session.removeAttribute("msg");
	}
	%>


	<div class="container ml-1 p-0">

		<div class="row">
			<!-- first column -->
			<div class="col-md-4 mt-2">
				<!-- categories -->
				<div class="list-group">
					<a href="#" onclick="getPosts(0, this)"
						class="c-link list-group-item list-group-item-action active">
						All Posts </a>

					<!-- Get all categories -->
					<%
					// to show the category
					PostDao post = new PostDao(ConnectionProvider.getConnection());
					ArrayList<Category> list1 = post.getAllCategories();

					for (Category cc : list1) {
					%>
					<!-- here onclick use to get cid and pass to the getPosts function to ajax  -->
					<a href="#" onclick="getPosts(<%=cc.getCid()%>, this )"
						class="c-link list-group-item list-group-item-action"><%=cc.getName()%></a>

					<%
					}
					%>

				</div>

			</div>

			<!-- second column -->
			<div class="col-md-8">
				<!-- Show all Posts -->
				<div class="container text-center text-white" id="loader">

					<i class="fa fa-refresh fa-4x fa-spin"></i>
					<h3 class="mt-3">Loading...</h3>
				</div>
				<div class="container" id="post-container"></div>
			</div>
		</div>


	</div>
	<!-- Start profile modal -->
	<!-- Modal -->
	<div class="modal fade" id="profileModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header bg-dark text-white">
					<h5 class="modal-title" id="exampleModalLabel">TechLoom</h5>
					<button type="button" class="close text-white" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<img alt="" src="pics/<%=user.getProfile()%>"
							style="width: 110px; height: 110px; border-radius: 50%; object-fit: cover;">

						<h5 class="modal-title mt-3" id="exampleModalLabel"><%=user.getName()%></h5>

						<!--  Admin details -->

						<div id="profile-details">
							<table class="table">

								<tbody>
									<tr>
										<th scope="row">ID:</th>
										<td><%=user.getId()%></td>

									</tr>
									<tr>
										<th scope="row">Email:</th>
										<td><%=user.getEmail()%></td>

									</tr>
									<tr>
										<th scope="row">Gender:</th>
										<td><%=user.getGender()%></td>

									</tr>
									<tr>
										<th scope="row">About:</th>
										<td><%=user.getAbout()%></td>

									</tr>

								</tbody>
							</table>
						</div>

						<!-- Profile Edit -->

						<div id="profile-edit" style="display: none">

							<h3 class="mt-2">Please Edit carefully</h3>
							<form action="EditServlet" method="post"
								enctype="multipart/form-data">

								<table class="table">
									<tr>
										<td>ID:</td>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<td>Name:</td>
										<td><input class="form-control" type="text"
											name="user_name" value="<%=user.getName()%>"></td>
									</tr>
									<tr>
										<td>Email:</td>
										<td><input class="form-control" type="email"
											name="user_email" value="<%=user.getEmail()%>"></td>
									</tr>
									<tr>
										<td>Password</td>
										<td><input class="form-control" type="password"
											name="user_password" value="<%=user.getPassword()%>"></td>
									</tr>
									<tr>
										<td>Gender:</td>
										<td><%=user.getGender()%></td>
									</tr>
									<tr>
										<td>New profile pic:</td>
										<td><input type="file" name="profile_pic"
											class="form-control"></td>
									</tr>
									<tr>
										<td>About:</td>
										<td><textarea class="form-control" rows="5"
												name="user_about"><%=user.getAbout()%></textarea></td>
									</tr>

								</table>

								<div>
									<button type="submit" class="btn btn-primary">Update</button>

								</div>

							</form>
						</div>

					</div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button id="edit-profile-button" type="button"
						class="btn btn-primary">Edit</button>
				</div>
			</div>
		</div>
	</div>

	<!-- End profile modal -->


	<!-- Start add post modal  -->
	<div class="modal fade" id="addPostModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Please provide
						post details..</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="add-post-form" action="AddPostServlet" method="post">

						<div class="form-group">
							<select class="form-control" name="cid">
								<option selected="selected">---Select category---</option>

								<%
								// to show the category
								PostDao postd = new PostDao(ConnectionProvider.getConnection());
								ArrayList<Category> list = postd.getAllCategories();

								for (Category c : list) {
								%>

								<option value="<%=c.getCid()%>"><%=c.getName()%></option>

								<%
								}
								%>
							</select>

						</div>
						<div class="form-group">
							<input name="pTitle" type="text" class="form-control"
								placeholder="Enter post title">
						</div>
						<div class="form-group">
							<textarea name="pContent" class="form-control"
								style="height: 200px" placeholder="Enter your content"></textarea>
						</div>
						<div class="form-group">
							<textarea name="pCode" class="form-control" style="height: 200px"
								placeholder="Enter post program(if any)"></textarea>
						</div>
						<div class="form">
							<label>Select your pic: </label> <br> <input type="file"
								name="pic">
						</div>

						<div class="container text-center">
							<button type="submit" class="btn btn-primary">Post</button>

						</div>

					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>

				</div>
			</div>

		</div>


	</div>
	<!-- End add post modal  -->
	<!-- JavaScript -->
	
	<script src="js/myjs.js" type="text/javascript"></script>
	
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
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script
		type="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>


	<script>
		$(document).ready(function() {
			let editStatus = false;

			$('#edit-profile-button').click(function() {
				if (editStatus == false) {
					$("#profile-edit").show();
					$("#profile-details").hide();
					editStatus = true;
					$(this).text("Back");
				} else {
					$("#profile-details").show()
					$("#profile-edit").hide();
					editStatus = false;
					$(this).text("Edit");
				}

			})
		});
	</script>

	<!-- add post js -->

	<script>
		// using ajax data sent to AddPostServlet

		$(document).ready(function(e) {

			$('#add-post-form').on('submit', function(event) {
				// this function is gets called when form is submitted
				event.preventDefault();
				console.log("submiting to servlet...");
				let form = new FormData(this);

				// now requesting to server
				$.ajax({
					url : 'AddPostServlet',
					type : "POST",
					data : form,
					success : function(data, textStatus, jqXHR) {
						// when request success
						console.log(data);
						if (data.trim() == 'done') {
							Swal.fire({
								position : "top",
								icon : "success",
								title : "Posted Successfully",
								showConfirmButton : true,

							})
							/* .then(function() {
								window.location = "Profile.jsp"; // Redirect to Login page after showing the success message
							}); */

						} else {

							Swal.fire({
								icon : "error",
								title : "Oops...",
								text : "Something went wrong!",

							});
						}

					},
					error : function(jqXHR, textStatus, errorThrown) {
						//error
						Swal.fire({
							icon : "error",
							title : "Oops...",
							text : "Something went wrong!",

						});

					},
					processData : false,
					contentType : false
				})
			});

		});
	</script>


	<!-- Loading post using ajax -->
	<script>
	
		function getPosts(catId, temp){
			
			$('#loader').show();
			$('#post-container').hide();
			
			$('.c-link').removeClass('active').css('background-color', '#343a40');
			
			$.ajax({
				url: "load_posts.jsp",
				data: {cid: catId},
				success: function(data, textStatus, jqXHR){
					console.log(data);
					$('#loader').hide();
					$('#post-container').show();
					$('#post-container').html(data);
					$(temp).addClass("active").css('background-color', '#28a745');
				}
			})
		}
		$(document).ready(function(){
			let allPostRef = $('.c-link')[0];
			getPosts(0, allPostRef);
			
		})
	
	</script>
</body>
</html>