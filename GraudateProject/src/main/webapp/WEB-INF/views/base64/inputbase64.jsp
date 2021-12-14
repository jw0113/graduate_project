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

        <script type = "text/javascript" src="./resources/js/jquery-3.6.0.min.js"></script>


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
                        <li class="nav-item"><a class="nav-link" href="/graduateproject/main">BACK</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        
        <section class="contact-section bg-black">
        	<div class="container px-4 px-lg-5">
        		<div class="row gx-4 gx-lg-5">
        			<div class="col-md-5 col-lg-5 mx-auto text-center">
                        <h2 class="text-white">Base64 Encode & Decode</h2>
                        <h6 class="text-white mb-5 text-center">입력값에 따라 Base64 Encoding OR Decoding</h6>
                	</div>
        			<div class="col-md-10 col-lg-8 mx-auto text-center">
                        <form role="form" method="post">
                            
                        	<div class="col" style="width:50%; float:left; hight:100%;"><textarea class="form-control is-invalid" name="inputbase64"  placeholder="문자열을 입력하세요..." aria-label="문자열을 입력하세요..." style="heigh: 100%;"></textarea></div>
                            <div class="col" style="width:50%; float:right;">
                                <button class="btn btn-primary" id="submitButton1" type="submit" onclick="javascript: form.action='/graduateproject/encode';">Encode</button>
                                <button class="btn btn-primary" id="submitButton2" type="submit" onclick="javascript: form.action='/graduateproject/decode';">Decode</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-10 col-lg-8 mx-auto text-center" style="padding-top : 40px;">
                    	<div class="featured-text text-center text-lg-left">
                        	<p class="text-white-50 mb-2" style="word-wrap: break-word;">
                        		${encode_result}
                            	${decode_result}
                        	</p>
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

    </body>
</html>