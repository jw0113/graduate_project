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
        <title>Code Obfuscation</title>
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
        <section class="contact-section bg-black">
            <div class="container px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5">
           
                    <div class="col-md-10 col-lg-8 mx-auto text-center">
                        <h2 class="text-white mb-5">Code Obfuscation</h2>
                        <ol class="breadcrumb mb-4">
                            <li class="text-black-50 mb-0">결과 확인</li>
                        </ol>
                        <c:forEach var="r" items="${result}">
                			<div class="col-md-4 mb-3 mb-md-0 align-items-center justify-content-center">
                        		<div class="card py-4 h-100">
                            		<div class="card-body text-center">
                                		<i class="fas fa-envelope text-primary mb-2"></i>
                                		<h4 class="text-uppercase m-0">${r.filename}</h4>
                                		<hr class="my-4 mx-auto" />
                                		<a class="btn btn-primary" href="/graduateproject/result2?filename=${r.filename}" style="padding : 10px, 10px;">Result</a>
                            		</div>
                        		</div>
                    		</div>
                		</c:forEach>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="./resources/js/scripts-home.js"></script>
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
    </body>
</html>