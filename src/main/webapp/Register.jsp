<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>TechLoom</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
</style>

</head>
<body>

	<%@include file="normal_navbar.jsp"%>
	<div class="container-fluid m-0 bg-dark" style="height: 110vh">
		<div class="row ">
			<div class="col-md-4 offset-md-4">

				<div class="card">
					<div class="card-header bg-dark text-white text-center p-1">
						<span class="fa fa-user-circle fa-2x"></span>

						<P>Register here</P>
					</div>
					<div class="card-body">
						<form id="reg-form" action="RegisterServlet" method="post">
							<div class="form-group">
								<label for="user_name">User name</label> <input name="user_name"
									type="text" class="form-control" id="user_name"
									aria-describedby="emailHelp" placeholder="Enter name">

							</div>
							<div class="form-group">
								<label for="email_id">Email id</label> <input name="user_email"
									type="email" class="form-control" id="email_id"
									placeholder="Enter email">
							</div>
							<div class="form-group">
								<label for="password">Password</label> <input name="password"
									type="password" class="form-control" id="password"
									placeholder="Enter Password">

							</div>
							<div class="form-group">
								<label for="gender">Select Gender </label> <br> <input
									type="radio" name="gender" value="Male">Male <input
									type="radio" name="gender" value="Female">Female

							</div>

							<div class="form-group">
								<textarea class="form-control" name="about" rows="4"
									placeholder="Enter something about yourself"></textarea>
							</div>
							<div class="form-check">
								<input name="check" type="checkbox" class="form-check-input"
									id="exampleCheck1"> <label class="form-check-label"
									for="exampleCheck1"> Agree terms & conditions</label>

							</div>
							<br>
							<div class="container text-center" id="loader"
								style="display: none"%>
								> <span class="fa fa-refresh fa-spin fa-4x"></span>
								<h4>Please wait...</h4>
							</div>

							<button id="submit-btn" type="submit" class="btn btn-primary">Signup</button>


						</form>
					</div>
				</div>
			</div>

		</div>
	</div>

	<!-- JavaScript -->
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
	<script src="js/myjs.js" type="text/javascript"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script>
		$(document).ready(function() {

			console.log("loaded....");

			$('#reg-form').on('submit', function(event) {
				event.preventDefault();

				let form = new FormData(this);

				$('#submit-btn').hide();
				$('#loader').show();

				//send register servlet
				$.ajax({
					url : "RegisterServlet",
					type : 'POST',
					data : form,
					success : function(data, textStatus, jqXHR) {
						console.log(data)

						$('#submit-btn').show();
						$('#loader').hide();

						if (data.trim() == 'done') {
							Swal.fire({
								position : "top",
								icon : "success",
								title : "Registered Successfully",
								showConfirmButton : false,
								timer : 2000

							}).then(function() {
								window.location = "Profile.jsp"; // Redirect to Login page after showing the success message
							});
							
						} else if (data.trim() == 'emailExists') {
							Swal.fire({
								position : "error",
								icon : "Oops",
								title : "Emial already exists!",
								timer : 20000
								
							});
						
					 	} else {
							Swal.fire({
								icon : "error",
								title : "Oops...",
								text : "Check box not checked!",
								timer : 20000
							});
						}

					},
					error : function(jqXHR, textStatus, errorThrown) {
						console.log(jqXHR)
						$('#submit-btn').show();
						$('#loader').hide();

					},
					processData : false,
					contentType : false
				})

			});
		});
	</script>
</body>
</html>