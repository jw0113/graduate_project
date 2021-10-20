<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Code Decryption</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link href="./resources/css/styles.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
        <style>
        	.dragAndDropDiv {
                border: 2px dashed #92AAB0;
                width: 650px;
                height: 200px;
                color: #92AAB0;
                text-align: center;
                vertical-align: middle;
                padding: 10px 0px 10px 10px;
                font-size:200%;
                display: table-cell;
            }
            .progressBar {
                width: 200px;
                height: 22px;
                border: 1px solid #ddd;
                border-radius: 5px; 
                overflow: hidden;
                display:inline-block;
                margin:0px 10px 5px 5px;
                vertical-align:top;
            }
             
            .progressBar div {
                height: 100%;
                color: #fff;
                text-align: right;
                line-height: 22px; /* same as #progressBar height if we want text middle aligned */
                width: 0;
                background-color: #0ba1b5; border-radius: 3px; 
            }
            .statusbar{
                border-top:1px solid #A9CCD1;
                min-height:25px;
                width:99%;
                padding:10px 10px 0px 10px;
                vertical-align:top;
            }
            .statusbar:nth-child(odd){
                background:#EBEFF0;
            }
            .filename{
                display:inline-block;
                vertical-align:top;
                width:250px;
            }
            .filesize{
                display:inline-block;
                vertical-align:top;
                color:#30693D;
                width:100px;
                margin-left:10px;
                margin-right:5px;
            }
            .abort{
                background-color:#A8352F;
                -moz-border-radius:4px;
                -webkit-border-radius:4px;
                border-radius:4px;display:inline-block;
                color:#fff;
                font-family:arial;font-size:13px;font-weight:normal;
                padding:4px 15px;
                cursor:pointer;
                vertical-align:top
            }
            .submit{
                background-color:#A8352F;
                -moz-border-radius:4px;
                -webkit-border-radius:4px;
                border-radius:4px;display:inline-block;
                color:#fff;
                font-family:arial;font-size:13px;font-weight:normal;
                padding:4px 15px;
                cursor:pointer;
                vertical-align:top
            }
        </style>
        <script type = "text/javascript" src="./resources/js/jquery-3.6.0.min.js"></script>
        <script type = "text/javascript">
			$(document).ready(function(){
				$(document).on("gragenter", ".dragAndDropDiv", function(e){
					e.stopPropagation();
					e.preventDefault();
					$(this).css('border', '2px solid #0B85A1');
				});
				$(document).on("dragover",".dragAndDropDiv", function(e){
					e.stopPropagation();
					e.preventDefault();
				});
				// 파일을 drop 했을 경우
				$(document).on("drop",".dragAndDropDiv", function(e){
					e.preventDefault();
					$(this).css("border",'2px solid #0B85A1');

					var files = e.originalEvent.dataTransfer.files;
					fileUpload(files,$(".dragAndDropDiv"));
				});
				function fileUpload(files,obj){
					
					for (var i=0; i<files.length; i++){
						var formData = new FormData();
						formData.append("file", files[i])
						console.log(files[i])
						
						// 파일 업로드시 
						var status = new createStatusBar(obj)
						status.setFile(files[i].name, files[i].size);
						sendFile(files.length,formData,status);
					}
					
				}
				var rowCount = 0;
				// 파일 drop시 파일 업로드 상태 표시
				function createStatusBar(obj){
					rowCount++;
					var row = "odd";
					if(rowCount %2 == 0) row = "even";
					this.statusbar = $("<div class='statusbar "+row+"'></div>");
					this.filename = $("<div class='filename'></div>").appendTo(this.statusbar);
					this.filesize = $("<div class='filesize'></div>").appendTo(this.statusbar);
					this.progressBar = $("<div class='progressBar'><div></div></div>").appendTo(this.statusbar);
					this.abort = $("<div class='abort'>중지</div>").appendTo(this.statusbar);

					// 파일 업로드 창에 statusbar 부분를 추가한다.
					obj.after(this.statusbar);

					// 파일 이름과 크기 나타내기
					this.setFile = function(name, size){
						var f_size = "";
						var f_sizekb = size/1024;
						if(parseInt(f_sizekb) > 1024){
							var f_sizemb = f_sizekb / 1024;
							f_size = f_sizemb.toFixed(2) + "MB";
						}
						else{
							f_size = f_sizekb.toFixed(2) + "KB";
						}

						this.filename.html(name);
						this.filesize.html(f_size);

					}
					this.setProgress = function(progress){

						var progressWidth = progress * this.progressBar.width() / 100;
						this.progressBar.find("div").animate({width : progressWidth},1000).html(progress + "%");
						if (parseInt(progress) >= 100){ 
							this.abort.hide();
						}
					}
					// 중지 버튼을 눌렀을 경우 이벤트 처리
					this.setAbort = function(f_ajax){
						this.abort.click(function(){
							f_ajax.abort();
							this.statusbar.hide();
						})

					}
				}
				var rearray = new Array();
				var reindex = 0;
				function sendFile(filesize, formData, status){
					var f_ajax = $.ajax({
						type : "POST",
						url : "/graduateproject/upload",
						data : formData,
						dataType : "text",
						processData : false,
						contentType : false,
						async: false,
						// xhr 객체를 이용하여 서버와의 데이터 전달 진행상황을 확인
						xhr: function(){
							var upload_xhr = $.ajaxSettings.xhr();
							if(upload_xhr.upload){
								upload_xhr.upload.addEventListener("progress", function(e){
									var percent = 0;
									var position = e.loaded || e.position;
									var total = e.total;
									// 전송 중이라면 전송된 바이트들을 계산하여 percent 생성
									if (e.lengthComputable){ 
										percent = Math.ceil((e.loaded / e.total * 100) - 10);
										
									}
									else{
										console.log("error");
									}
									status.setProgress(percent);
								}, false);
							}
							return upload_xhr;
						},
						success : function(data){
							if(data == "fail"){
								console.log("fail : ", data);
								alert("서버를 다시 시도해주세요!");
							}
							else{
								console.log("success : ", data);
								status.setProgress(100);
								rearray[reindex] = data;
								reindex++;
								if (reindex == filesize) nextPage(rearray);
							}
						},
					});
					status.setAbort(f_ajax);
				}

				// 결과 값 넘기기
				function nextPage(rearray){
					$.ajax({
						type : "POST",
						url : "/graduateproject/uploadfile",
						data : rearray,
						dataType : "html",
						processData : false,
						contentType : false
					})
				}

			});
		</script>
		
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="index.html">Code Decryption</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">
                    <input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                    <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
                </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#!">Settings</a></li>
                        <li><a class="dropdown-item" href="#!">Activity Log</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="#!">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Core</div>
                            <a class="nav-link" href="index.html">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                Code Decryption
                            </a>
                            <div class="sb-sidenav-menu-heading">Interface</div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                Layouts
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="layout-static.html">Static Navigation</a>
                                    <a class="nav-link" href="layout-sidenav-light.html">Light Sidenav</a>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                Pages
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseAuth" aria-expanded="false" aria-controls="pagesCollapseAuth">
                                        Authentication
                                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="pagesCollapseAuth" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
                                        <nav class="sb-sidenav-menu-nested nav">
                                            <a class="nav-link" href="login.html">Login</a>
                                            <a class="nav-link" href="register.html">Register</a>
                                            <a class="nav-link" href="password.html">Forgot Password</a>
                                        </nav>
                                    </div>
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseError" aria-expanded="false" aria-controls="pagesCollapseError">
                                        Error
                                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="pagesCollapseError" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
                                        <nav class="sb-sidenav-menu-nested nav">
                                            <a class="nav-link" href="401.html">401 Page</a>
                                            <a class="nav-link" href="404.html">404 Page</a>
                                            <a class="nav-link" href="500.html">500 Page</a>
                                        </nav>
                                    </div>
                                </nav>
                            </div>
                            <div class="sb-sidenav-menu-heading">Addons</div>
                            <a class="nav-link" href="charts.html">
                                <div class="sb-nav-link-icon"><i class="fas fa-chart-area"></i></div>
                                Charts
                            </a>
                            <a class="nav-link" href="tables.html">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                Tables
                            </a>
                        </div>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Code Decryption</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">파일을 업로드 하세요</li>
                        </ol>
                        <div id="fileUpload" class="dragAndDropDiv">Drag & Drop Files Here</div>
                        
                    </div>
                </main>
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; Your Website 2021</div>
                            <div>
                                <a href="#">Privacy Policy</a>
                                &middot;
                                <a href="#">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="./resources/js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="./resources/assets/demo/chart-area-demo.js"></script>
        <script src="./resources/assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script src="./resources/js/datatables-simple-demo.js"></script>
    </body>
</html>
