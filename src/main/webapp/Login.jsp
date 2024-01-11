<%@page import="com.tech.loom.entities.Message"%>
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
.container-fluid {
	clip-path: polygon(50% 0%, 100% 0, 100% 35%, 100% 100%, 75% 94%, 49% 99%, 23% 94%,
		0 99%, 0% 35%, 0 0);
}
</style>


</head>
<body>

	<!-- Start Navbar -->
	<%@include file="normal_navbar.jsp"%>

	<div class="container-fluid p-0 m-0 bg-dark" style="height: 75vh">
		<div class="row ">
			<div class="col-md-3 offset-md-5 mt-4">

				<div class="card">
					<div class="card-header bg-dark text-white">
						<span class="fa fa-user fa-2x"></span>

						<P>Login here</P>
					</div>

					<%
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


					<div class="card-body">
						<form action="LoginServlet" method="post">
							<div class="form-group">
								<label for="exampleInputEmail1">Email address</label> <input
									name="email" required type="email" class="form-control"
									id="exampleInputEmail1" aria-describedby="emailHelp"
									placeholder="Enter email"> <small id="emailHelp"
									class="form-text text-muted">We'll never share your
									email with anyone else.</small>
							</div>
							<div class="form-group">
								<label for="exampleInputPassword1">Password</label> <input
									name="password" required type="password" class="form-control"
									id="exampleInputPassword1" placeholder="Password"> <small><a>Forget
										password</a></small>
							</div>

							<div class="container text-center">
								<button type="submit" class="btn btn-primary">Login</button>
							</div>

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
</body>
</html>