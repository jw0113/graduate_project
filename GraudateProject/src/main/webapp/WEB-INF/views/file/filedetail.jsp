<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Code Decryption</title>
        <link rel="icon" type="image/x-icon" href="./resources/assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Varela+Round" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="./resources/css/styles-home.css" rel="stylesheet" />
        <style>
        	div.box{
        		height: 50px;
        		width: 100%;
        		padding-top: 30px; 
        	}
        </style>
        <script type = "text/javascript" src="./resources/js/jquery-3.6.0.min.js"></script>
        <!--  
        <script>
     		// 뒤로가기 버튼을 눌렀을 경우
    		$(document).on("click",".back",function(){
				location.href="/graduateproject/filelist";
        	});

    		// home 버튼을 눌렀을 경우
    		$(document).on("click",".home",function(){
				location.href="/graduateproject/";
        	});
        </script>
        -->

    </head>
    <body class="page-top">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="#page-top">Code Decryption</a>
                <button class="navbar-toggler navbar-toggler-right" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fas fa-bars"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="/graduateproject/">HOME</a></li>
                        <li class="nav-item"><a class="nav-link" href="/graduateproject/main">MAIN</a></li>
                        <li class="nav-item"><a class="nav-link" href="/graduateproject/filelist">BACK</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <section class="contact-section bg-black">
        	<div class="container px-4 px-lg-5">
        		<div class="row gx-4 gx-lg-5">
        			<div class="col-md-4 col-lg-5 mx-auto text-center">
                        <h1 class="text-white text-center">Files Collection</h1>
                        <h6 class="text-white mb-5 text-center">악성코드 파일 자세히 살펴보기</h6>
                	</div>
        		</div>
        		<div class="row gx-0 mb-5 mb-lg-0 justify-content-center">
        			<div class="col-lg-6" style="padding-top : 50px;">
        				<h4 class="text-white mb-4">File Detail</h4>
        				<div class="d-flex h-100">
        					<p class="mb-4 text-white-50">
        					Filename : ${filedetail.filename}<br>
        					Filetype :  ${filedetail.filetype}<br>
        					Filesize :  ${filedetail.filesize}<br>
        					Analysis :  ${filedetail.deob}</p>
        				</div>
        			</div>
        			<div class="col-lg-6" style = "padding-left : 20px;">
        				<!-- <h4 class="text-white">Dangerous</h4>-->
        				<div class="d-flex h-100">
        					<canvas id="myPieChart" width="100%" height="50"></canvas>
        				</div>
        			</div>
        		</div>
        	</div>
        </section>
        
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="./resources/js/scripts-home.js"></script>
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="./resources/js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>

        <script>
        	var ctx = document.getElementById("myPieChart");
        	var aa = ${filedetail.deobcount};
        	var math = 100-aa

        	var myPieChart = new Chart(ctx, {
          		type: 'pie',
          		data: {
            		labels: ["Normal", "Dangerous"],
            		datasets: [{
              			data: [math, aa],
              			backgroundColor: ['#007bff', '#dc3545'],
            		}],
          		},
        	});
        </script>
        
    </body>
</html>