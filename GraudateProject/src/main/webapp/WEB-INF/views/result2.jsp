<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Code Obfuscation</title>
        <link rel="icon" type="image/x-icon" href="./resources/assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Varela+Round" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="./resources/css/styles-home.css" rel="stylesheet" />
        
        <style>
            .highlight{
            	font-weight:bold;
            	color:red;
           	}
           	div.left {
        		width: 50%;
        		float: left;
        		box-sizing: border-box;
        		flex-direction : column;
        		flex-wrap : wrap;
        		word-break : break-all;
    		}
    		div.right {
        		width: 50%;
        		float: right;
        		box-sizing: border-box;
        		flex-direction : column;
        		flex-wrap : wrap;
        		word-break : break-all;
        	
    		}
    		.box {
    			width: 600px;
    			height: 500px;
    			padding: 10;
    			border: 3px black solid;
    		}

        </style>

        <script type = "text/javascript" src="./resources/js/jquery-3.6.0.min.js"></script>
        <script type = "text/javascript">
        	var arr = new Array();
        	<c:forEach var="r" items="${dbresult}">
        		
        		arr.push({deob: "${fn:escapeXml(r.deob)}"});
        	</c:forEach>
        	
        	function display(index){
            	alert(index);
            	if(document.getElementById("deob")){
                	var deob = document.getElementById("deob");
                	var deobp = deob.parentElement;
                	deobp.removeChild(deob);
                }
                var newDiv = document.createElement("div");
                var location = document.getElementById("right");
                newDiv.innerHTML = arr[index].deob;
                newDiv.setAttribute("class","box");
                newDiv.setAttribute("id", "deob");
                newDiv.setAttribute("style","overflow:scroll");
                location.appendChild(newDiv); 
        	}

        	// 뒤로가기 버튼을 눌렀을 경우
        	$(document).on("click",".back",function(){
				location.href="/graduateproject/result1";
            });

        	// 분석종료 버튼을 눌렀을 경우
        	$(document).on("click",".home",function(){
				location.href="/graduateproject/";
            });

    	</script>
		
    </head>
    <body class="page-top">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="#page-top">Code Obfuscation</a>
                <button class="navbar-toggler navbar-toggler-right" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fas fa-bars"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="#page-top">home</a></li>
                        <li class="nav-item"><a class="nav-link" href="#projects">login</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Code Decryption</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">결과 확인</li>
                        </ol>
                       	<div class="card mb-4">
                        	<div class="card-header">
                        		<div class="left">
                                	<i class="fas fa-table me-1"></i>
                                	원본 파일             		
                            	</div>
                            	
                            	<div class="right">
                                	<i class="fas fa-table me-1"></i>
                                	탐지 부분 해제
                        		</div>
                        	</div>
                        	<div class="card-body">
                        		<div class="left">
                        			<div class="box" style="overflow:scroll">${data}</div>
                        		</div>
                        		<div class="right" id="right">
                        		</div>
                        	</div>
                        	<div class="card-footer">
                        		<button class="back">뒤로가기</button>
                        		<button class="home">분석 종료</button>
                        	</div>

                        </div>
                        
                    </div>
                </main>
                
            </div>
        </div>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="./resources/js/scripts-home.js"></script>
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
    </body>
</html>