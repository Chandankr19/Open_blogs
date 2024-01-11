<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add post</title>
</head>
<body>

<div class="container mt-4">
  <h2>Create a Post</h2>
  <form>
    <div class="form-group">
      <label for="pTitle">Title</label>
      <input type="text" class="form-control" id="pTitle" placeholder="Enter title" name="pTitle">
    </div>
    <div class="form-group">
      <label for="pContent">Content</label>
      <textarea class="form-control" id="pContent" rows="5" placeholder="Enter content" name="pContent"></textarea>
    </div>
    <div class="form-group">
      <label for="pCode">Code</label>
      <textarea class="form-control" id="pCode" rows="8" placeholder="Enter code" name="pCode"></textarea>
    </div>
    <div class="form-group">
      <label for="pPic">Picture</label>
      <input type="file" class="form-control-file" id="pPic" name="pPic">
    </div>
    <button type="submit" class="btn btn-primary">Submit</button>
  </form>
</div>

</body>
</html>