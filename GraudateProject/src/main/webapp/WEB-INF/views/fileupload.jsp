<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<title>file upload</title>
<style>
	.fileDrop {
		width: 600px;
		height: 200px;
		border: 1px dotted blue;
	}
	
	small {
		margin-left : 3px;
		font-weight : bold;
		color : gray;
	}
	
</style>
<script type = "text/javascript" src="./resources/js/jquery-3.6.0.min.js"></script>
<script type = "text/javascript">
		
	$(document).ready(function(){
		
		$(".fileDrop").on("gragenter", function(event){
			event.preventDefault();
			event.stopPropagation();
			$(".fileDrop").css("background-color","#FFF");
		}).on("dragleave",function(event){
			$(".fileDrop").removeClass('drag-over');
		}).on("dragover", function(event){
			event.stopPropagation();
			event.preventDefault();
			$(".fileDrop").css("background-color","#FFF");
		}).on("drop", function(event){
			$(".fileDrop").css("background-color","#FFF");
			event.preventDefault();

			// 드래그된 파일의 정보
			var files = event.originalEvent.dataTransfer.files;

			var file = files[0];

			console.log(file);

			var formData = new FormData();

			formData.append("file",file);

			$.ajax({
				type : "POST",
				url : "/graduateproject/upload/",
				data : formData,
				dataType : "text",
				processData : false,
				contentType : false,
				success : function(data){
					alert(data);
				}

			});
		});
	});
</script>
</head>
<body>
	<h2>File Upload</h2>
	<div class="fileDrop"></div>
	<div class="uploadedList"></div>
</body>
</html>