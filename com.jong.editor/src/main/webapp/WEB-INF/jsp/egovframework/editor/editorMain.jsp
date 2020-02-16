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

</head>

<body id="page-top">

	<!-- Navigation -->
	<button class="menu-toggle form-control form-control-sm" type="button"><i class="fas fa-bars"></i></button>
	<div id="sidebar-wrapper">
		<ul class="sidebar-nav">
			<li class="sidebar-brand"><a class="js-scroll-trigger" href="editorMain.do">Editor</a></li>
			<li class="sidebar-nav-item"><a class="js-scroll-trigger" href="uploadFolderList.do">UploadFolder List</a></li>
			<li class="sidebar-nav-item"><a class="js-scroll-trigger" href="#">Delete Unused Folders</a></li>
		</ul>
	</div>

	<!-- Header -->
	<div class="masthead pt-5">
		<div class="container text-center">
			<h1 class="mb-1">Self Create Editor</h1>
			<h3 class="mb-5"><em>A Free Bootstrap Theme by Start Bootstrap</em></h3>
			<div id="editor">
				<input type="hidden" name="uploadFolder" value="<c:out value="${uploadFolder }"/>">
				<div class="editorToolbar form-control col-lg-8 mx-auto">
					<button class="btn btn-sm" onclick="document.execCommand('bold')"><i class="fa fa-bold" aria-hidden="true"></i></button>
					<button class="btn btn-sm" onclick="document.execCommand('Italic')"><i class="fa fa-italic" aria-hidden="true"></i></button>
					<button class="btn btn-sm" onclick="document.execCommand('Underlin')"><i class="fa fa-underline" aria-hidden="true"></i></button>
					<button class="btn btn-sm" onclick="document.execCommand('StrikeThrough')"><i class="fa fa-strikethrough" aria-hidden="true"></i></button> |
					<button class="btn btn-sm" onclick="document.execCommand('justifyleft')"><i class="fa fa-align-left" aria-hidden="true"></i></button>
					<button class="btn btn-sm" onclick="document.execCommand('justifycenter')"><i class="fa fa-align-center" aria-hidden="true"></i></button>
					<button class="btn btn-sm" onclick="document.execCommand('justifyright')"><i class="fa fa-align-right" aria-hidden="true"></i></button> |
					<button class="btn btn-sm imgModalBtn"><i class="fa fa-image" aria-hidden="true"></i></button>
					<button class="btn btn-sm toHTMLBtn"><i class="fa fa-code" aria-hidden="true"></i></button>
				</div>
				<div class="editorDiv form-control col-lg-8 mx-auto text-left" contenteditable="true"></div>
				<div class="editorHTMLDiv form-control col-lg-8 mx-auto text-left"></div>
				<!-- Modal -->
				<div class="modal fade" role="dialog">
					<!-- Modal content-->
					<div class="modal-dialog modal-content">
						<div class="modal-header">
							<h4 class="modal-title">이미지 업로드</h4>
							<button type="button" class="close" data-dismiss="modal">×</button>
						</div>
						<div class="modal-body">
							<label>파일 선택</label>
							<div class="row mb-2">
								<div class="col-12">
									<input class="imgFile form-control form-control-sm" type="file">
								</div>
							</div>
							<label>가로 X 세로</label>
							<div class="row mb-2">
								<div class="col-6">
									<input class="width form-control form-control-sm" type="number" value="300">
								</div>
								<div class="col-6">
									<input class="height form-control form-control-sm" type="number" value="200">
								</div>
							</div>
							<label>미리보기</label> 
							<div class="row mb-2">
								<div class="col-12">
									<img class="miribogi form-control form-control-sm mx-auto"/>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button class="sendImgBtn btn btn-sm btn-secondary" type="button">서버로 전송</button>
						</div>
					</div>
				</div>
			</div>
			<form name="sendForm">
				<input type="hidden" name="editorData">
				<input type="hidden" name="imgNmArr">
				<input type="hidden" name="uploadFolder" value="<c:out value="${uploadFolder }"/>">
				<button class="btn btn-primary btn-xl mt-3" type="button" name="sendBtn">Send Editor Content</button>
			</form>
		</div>
	</div>

	<!-- Bootstrap core JavaScript -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- Plugin JavaScript -->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>
  	<!-- Custom scripts for this template -->
  	<script src="js/stylish-portfolio.min.js"></script>
	
	<script src="js/editorFn.js"></script>
	<script type="text/javascript">
		editorFn.init(document.getElementById("editor"));
		
		document.sendForm.sendBtn.onclick = function() {
			var form = document.sendForm;
			
			form.editorData.value = editorFn.getEditorHTML();
			form.imgNmArr.value = editorFn.getImgNmArr();

			form.setAttribute("action", "write.do");
			form.setAttribute("method", "POST");
			form.submit();
		};
	</script>
</body>

</html>
