<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Stylish Portfolio - Start Bootstrap Template</title>

<!-- Bootstrap Core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">
<link href="vendor/simple-line-icons/css/simple-line-icons.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="css/stylish-portfolio.min.css" rel="stylesheet">

<style type="text/css">
	#uploadDirLink {
	    text-decoration: underline;
	    cursor: pointer;
	}
	.table {
		background-color: #fff;
	} 
</style>

</head>

<body id="page-top">
	
	<!-- Navigation -->
	<button class="menu-toggle form-control form-control-sm" type="button"><i class="fas fa-bars"></i></button>
	<div id="sidebar-wrapper">
		<ul class="sidebar-nav">
			<li class="sidebar-brand"><a class="js-scroll-trigger" href="editorMain.do">Editor</a></li>
			<li class="sidebar-nav-item"><a class="js-scroll-trigger" href="uploadFolderList.do">UploadFolder List</a></li>
			<li class="sidebar-nav-item" id="deleteUnusedFolders"><a class="js-scroll-trigger" href="#">Delete Unused Folders</a></li>
		</ul>
	</div>

	<!-- Header -->
	<div class="masthead pt-5">
		<div class="container text-center">
			<h1 class="mb-1">Self Create Editor</h1>
			<h3 class="mb-5"><em>A Free Bootstrap Theme by Start Bootstrap</em></h3>
			<h5>- 폴더 상위 경로 -</h5>
			<h5 id="uploadDirLink"><c:out value="${uploadDir }"/>\</h5>
			<hr>
			<div class="col-lg-8 mx-auto">
				<table class="table">
					<thead>
						<tr>
							<th>폴더명</th>
							<th>사용여부</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${uploadFolderList }" var="uploadFolderList">
							<tr>
								<td><c:out value="${uploadFolderList.uploadFolder }" /></td>
								<td><c:out value="${uploadFolderList.useYn }" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<h5>사용여부가 N이라면 폴더만 존재하는 경우로 삭제가 필요</h5>
				<h5>! 단 작성 중인 게시글의 경우에는 폴더의 사용여부가 'N'이라는 점을 고려</h5>
			</div>
		</div>
	</div>

	<!-- Bootstrap core JavaScript -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- Plugin JavaScript -->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>
	<!-- Custom scripts for this template -->
	<script src="js/stylish-portfolio.min.js"></script>
	
	<script type="text/javascript">
		function deleteUnusedFolders() {
			var delDate = prompt("일정 날짜를 기준으로 사용하지않는 폴더를 일괄 삭제합니다.\n기준이 되는 날짜를 구분자 없이 입력해주십시오.");
			$.ajax({
				url : 'deleteFolder.do',
				type : 'GET',
				data : {"delDate" : delDate},
				dataType : "json",
				success : function(data) {
					location.href = "uploadFolderList.do";
				},
				error:function(request,status,error){
					alert("에러가 발생하였습니다. console을 확이해주십시오.");
					console.log(error);
			    }
			});
		}
		document.getElementById("deleteUnusedFolders").onclick = deleteUnusedFolders;
	</script>
	
</body>

</html>
