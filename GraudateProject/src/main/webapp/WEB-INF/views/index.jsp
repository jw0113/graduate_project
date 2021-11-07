<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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
        	.dragAndDropDiv {
                border: 2px dashed #92AAB0;
                width: 680px;
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
                width:680px;
                padding:10px 10px 0px 10px;
                vertical-align:top;
            }
            .statusbar:nth-child(odd){
                background:#000000;
            }
            .filename{
                display:inline-block;
                vertical-align:top;
                width:250px;
                color: #fff
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
				// ������ drop ���� ���
				$(document).on("drop",".dragAndDropDiv", function(e){
					e.preventDefault();
					$(this).css("border",'2px solid #0B85A1');
					var files = e.originalEvent.dataTransfer.files;
					fileUpload(files,$(".dragAndDropDiv"));
				});
				function fileUpload(files,obj){
					for (var i=0; i<files.length;i++){
						var formData = new FormData();
						formData.append("file", files[i])
						console.log(files[i])
						
						// ���� ���ε�� 
						var status = new createStatusBar(obj)
						status.setFile(files[i].name, files[i].size);
						sendFile(files.length,formData,status);
					}
					
				}
				var rowCount = 0;
				// ���� drop�� ���� ���ε� ���� ǥ��
				function createStatusBar(obj){
					rowCount++;
					var row = "odd";
					if(rowCount %2 == 0) row = "even";
					this.statusbar = $("<div class='statusbar "+row+"'></div>");
					this.filename = $("<div class='filename'></div>").appendTo(this.statusbar);
					this.filesize = $("<div class='filesize'></div>").appendTo(this.statusbar);
					this.progressBar = $("<div class='progressBar'><div></div></div>").appendTo(this.statusbar);
					this.abort = $("<div class='abort'>����</div>").appendTo(this.statusbar);
					// ���� ���ε� â�� statusbar �κи� �߰��Ѵ�.
					obj.after(this.statusbar);
					// ���� �̸��� ũ�� ��Ÿ����
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
					// �����
					this.setProgress = function(progress){
						var progressWidth = progress * this.progressBar.width() / 100;
						if (progress != 100)
							this.progressBar.find("div").animate({width : progressWidth},1000).html(progress + "%");
						else {
							this.progressBar.find("div").animate({width : progressWidth},1000,function(){
								alert("����");
								location.href="/graduateproject/result1";
							}).html(progress + "%");
						}
						
						if (parseInt(progress) >= 100){ 
							this.abort.hide();
						}
					}
					// ���� ��ư�� ������ ��� �̺�Ʈ ó��
					this.setAbort = function(f_ajax){
						var sb = this.statusbar;
						this.abort.click(function(){
							f_ajax.abort();
							sb.hide();
							alert("�����Ǿ����ϴ�!");
						})
					}
				}
				var rearray = new Array();
				var reindex = 0;
				function sendFile(filesize, formData, status){
					var f_ajax = $.ajax({
						// xhr ��ü�� �̿��Ͽ� �������� ������ ���� �����Ȳ�� Ȯ��
						xhr: function(){
							var upload_xhr = $.ajaxSettings.xhr();
							if(upload_xhr.upload){
								upload_xhr.upload.addEventListener("progress", function(e){
									var percent = 0;
									var position = e.loaded || e.position;
									var total = e.total;
									console.log("total : ", total);
									// ���� ���̶�� ���۵� ����Ʈ���� ����Ͽ� percent ����
									if (e.lengthComputable){ 
										percent = Math.ceil((e.loaded / e.total * 100) - 10);
										console.log(percent);
										
									}
									else{
										console.log("error");
									}
									status.setProgress(percent);
								}, false);
							}
							return upload_xhr;
						},
						type : "POST",
						url : "/graduateproject/upload",
						data : formData,
						dataType : "text",
						processData : false,
						contentType : false,
						async:false,
						success : function(data){
							if(data == "fail"){
								console.log("fail : ", data);
								alert("������ �ٽ� �õ����ּ���!");
							}
							else{
								console.log("success : ", data);
								status.setProgress(100);
								reindex++;
								//if(reindex == filesize) nextPage();
								
							}
						},
					});
					status.setAbort(f_ajax);
				}
				// ���� �������� �̵�
				function nextPage(){
					alert("����!");
					//location.href="/graduateproject/result1";
					
				}
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
                <div class="row gx-10 gx-lg-10 d-flex h-100 mx-auto align-items-center justify-content-center" style="padding-top : 50px;">
           
                    <div class="col-xl-8 col-lg-8">
                        <h2 class="text-white mb-5">Code Obfuscation</h2>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">�Ǽ� �ڵ� ������ ���ε� �ϼ���!</li>
                        </ol>
                        <div id="fileUpload" class="dragAndDropDiv">Drag & Drop Files Here</div>
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