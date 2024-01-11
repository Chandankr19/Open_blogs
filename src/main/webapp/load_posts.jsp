
<%@page import="java.sql.Connection"%>
<%@page import="com.tech.loom.entities.Users"%>
<%@page import="com.tech.loom.dao.LikeDao"%>
<%@page import="com.tech.loom.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.loom.helper.ConnectionProvider"%>
<%@page import="com.tech.loom.dao.PostDao"%>
<script src="ja/like.js" type="text/javascript"></script>

<div class="row">


	<%
	PostDao d = new PostDao(ConnectionProvider.getConnection());
		
	Users user = (Users) session.getAttribute("currentUser");
	int catId= Integer.parseInt(request.getParameter("cid"));
	
	
	List<Post> posts = null;

	if (catId == 0) {
		posts = d.getAllPostsByUserId(user.getId());
	}else{
		
		posts = d.getPostByCatIdAndUserId(catId, user.getId());
	}
	
	if(posts.size()==0){
		
		out.println("<h3 class ='display-3 text-center text-white'>No Posts in this category..</h3>");
		return;
	}
	
	for (Post p : posts) {
	%>
	<div class="col-md-6 mb-2">
		<div class="card mt-2" style="background-color: #343a40; color: #fff;">
			<img class="card-img-top" style="height: 180px; width: 344px;"
				src="blog_pics/<%=p.getpPic()%>" alt="Card image cap">
			<div class="card-body" style="height: 10em">
            <b><%=p.getpTitle()%></b>
            <!-- Use 'truncate-ellipsis' class to limit lines -->
            <p class="truncate-ellipsis" style="max-height: 6em; overflow: hidden;"><%=p.getpContent()%></p>
        	</div>
			
			
				<div class="card-footer p-2 mr-0">
				
					<% LikeDao ldao = new LikeDao(ConnectionProvider.getConnection()); %>
					
					<a href="#" onclick="doLike( <%=p.getPid() %>, <%=p.getUserId() %>)" class="btn btn-outline-success btn-sm "><i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%=ldao.countLikeOnPost(p.getPid()) %></span></a>
					<a href="#" class="btn btn-outline-success btn-sm"> <i class="fa fa-commenting-o"></i><span>10</span></a>
					<a href="show_blog.jsp?post_id=<%=p.getPid() %>" class="btn btn-outline-success btn-sm" style="margin-left:133px"> Read more...</a>

				</div>
			
			
		</div>

	</div>

	<%
	}
	%>

</div>