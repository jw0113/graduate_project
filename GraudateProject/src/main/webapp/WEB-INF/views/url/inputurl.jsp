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
        	.chart {width: 33.33%; height: 230px; text-align: center; vertical-align: middle;}
			.chart span.percent{position: relative; display: block; width: 100%; text-align: center; top: 110px; color:#fff;}
        </style>

        <script type = "text/javascript" src="./resources/js/jquery-3.6.0.min.js"></script>
        <script src="./resources/js/jquery.easypiechart.min.js"></script>
		<script>
			$(function() {
				$('.chart').easyPieChart({
					barColor: '#FF0000',
					trackColor : '#ccc',
					scaleColor : '#fff',
					lineCap : 'butt',
					lineWidth : 30,
					size : 200,
					animate : 1000,
					easing: 'easeOutBounce',
					onStep: function(from, to, percent) {
						$(this.el).find('.percent').text(Math.round(percent)+'%');
					}
				});
		
			});
		</script>


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
        		<div class="row gx-4 gx-lg-5 align-items-center justify-content-center">
        			<div class="col-md-10 col-lg-8 mx-auto text-center">
                        <h2 class="text-white">URL Check</h2>
                        <h6 class="text-white mb-5 text-center">URL 입력하여 확인하세요!</h6>
                        <form role="form" method="post">
                            <div class="row input-group-newsletter">
                                <div class="col"><input class="form-control" name="inputurl" type="text" placeholder="URL을 입력하세요..." aria-label="URL을 입력하세요..." style="height:100%;" /></div>
                                <div class="col-auto"><button class="btn btn-primary" value="Analysis" type="submit" onclick="javascript: form.action='/graduateproject/inputurl';">CHECK</button></div>
                            </div>
                            
                        </form>
                    </div>
                    <div class="col-md-8 col-lg-8 mx-auto" style = "padding-top : 40px;">
                    	<div class="featured-text text-center text-lg-left">
                        	<span class="chart" data-percent="${percent}">
                            	<span class="percent"></span>
                            </span>
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