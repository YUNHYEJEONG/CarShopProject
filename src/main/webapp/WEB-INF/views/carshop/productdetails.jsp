<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<%@ include file="../include/header.jsp"%>

<title>CarShop - Product Details</title>
<link rel="stylesheet" href="/resources/vendors/linericon/style.css">
<style>
.icon_heart_empty {
	margin: 0;
	width: 50px;
	height: 50px;
	background-size: cover;
	background-position: center;
	background-image: url(/resources/img/heart/heart_empty.png);
}

.icon_heart_red {
	margin: 0;
	width: 50px;
	height: 50px;
	background-position: center;
	background-size: cover;
	background-image: url(/resources/img/heart/heart_red.png);
}
</style>
<!-- ================ start banner area ================= -->
<section class="blog-banner-area" id="blog">
	<div class="container h-100">
		<div class="blog-banner">
			<div class="text-center">
				<h1>Shop Single</h1>
				<nav aria-label="breadcrumb" class="banner-breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="#">Home</a></li>
						<li class="breadcrumb-item active" aria-current="page">Shop
							Single</li>
					</ol>
				</nav>
			</div>
		</div>
	</div>
</section>
<!-- ================ end banner area ================= -->


<!--================Single Product Area =================-->
<div class="product_image_area">
	<div class="container">
		<div class="row s_product_inner">
			<div class="col-lg-6">
				<div class="owl-carousel owl-theme s_Product_carousel">
					<div class="single-prd-item">
						<img class="img-fluid" src="/resources/img/upload/${product.img1}"
							onerror="this.src='/resources/img/noimage.gif'">
					</div>

				</div>
			</div>
			<div class="col-lg-5 offset-lg-1">

				<div class="s_product_text">
					<h3>
						<c:out value="${product.p_name}" />
					</h3>
					<h2>
						<fmt:formatNumber type="number" value="${product.amount}" />
						원
					</h2>
					<ul class="list">
						<li><span>카테고리 </span> : ${product.c_name }</li>
						<%-- <li><span>재고 상태 </span> : 재고 있음(<strong>${product.quantity}개</strong>)</li> --%>
					</ul>
					<p><c:out value="${product.discribe}" /></p>
					<div class="card_area d-flex align-items-center">
					
						<div class="product_count"
							style="margin-top: 20px; float: left; vertical-align: middle;">
							
							<label for="qty" style="margin-top:10px;float: left">수량 : </label> 
							<input
								type="number" min="1" name="qty" id="sst" size="2" maxlength="12"
								value="1" title="Quantity" class="input-text qty"
								style="margin-top:8px;float: left"> 
							
							
							<label for=""
								style="margin-top:10px;margin-left: 15px; float: left">찜 : </label>
							<div class="icon_heart_empty" style="float: left"></div>
							
						</div>
					</div>
				</div><div>
						<div>
							<button class="button primary-btn btn-shopping-cart"
								style="float: left; margin-left: 30px; background-color: blue;">장바구니</button>
						</div>
						<div>
							<form action="/carshop/report" method='get' id = "formReport">
								<input type="hidden" value="${product.p_no }" name="p_no">
							
								<button class="button danger-btn" id="btn-report"
										style="float: left; margin-left: 30px; background-color: red;">신고</button>
							</form>

						</div></div>
						
			</div>
		</div>
	</div>
</div>
<!--================End Single Product Area =================-->

<!--================Product Description Area =================-->
<section class="product_description_area">
	<div class="container">
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item"><a class="nav-link" id="home-tab"
				data-toggle="tab" href="#home" role="tab" aria-controls="home"
				aria-selected="true">상세설명</a></li>
			
			<li class="nav-item"><a class="nav-link" id="contact-tab"
				data-toggle="tab" href="#contact" role="tab" aria-controls="contact"
				aria-selected="false">상품문의</a></li>
			<li class="nav-item"><a class="nav-link active" id="review-tab"
				data-toggle="tab" href="#review" role="tab" aria-controls="review"
				aria-selected="false">리뷰</a></li>
		</ul>
		<div class="tab-content" id="myTabContent">
			<div class="tab-pane fade" id="home" role="tabpanel"
				aria-labelledby="home-tab">
				<p><c:out value="${product.discribe}" /></p>
			</div>
			<div class="tab-pane fade" id="contact" role="tabpanel"
				aria-labelledby="contact-tab">
				<div class="">
					<div class="review_box">
						<h4>상품문의</h4>
						<div class="col-md-12">
							제목 <input type="text" id="ask_title" class="form-control">

							<div class="form-group">
								내용
								<textarea class="form-control" name="" id="p_ask" cols="30"
									rows="5"></textarea>
							</div>
						</div>
						<div class="col-md-12 text-right">
							<button type="button" id="product_ask" class="btn primary-btn">작성</button>
						</div>
					</div>
				</div>
				<div class="ask" id="ask">
					<c:forEach items="${askList }" var="list">
						<div class="comment_list">
							<div class="review_item">
								<div class="media">
									<div class="media-body">
										<h4>
											유저 ID :
											<c:out value="${list.u_id }" />
										</h4>
										<h5>
											<small><c:out value="${list.ask_date }" /></small>
										</h5>
										<c:if test="${user.id == product.s_id }">
											<a class="reply_btn" id="askReply"
												data-ask_no="${list.ask_no }">Reply</a>
										</c:if>
									</div>
								</div>
								<p>
									문의 제목 :
									<c:out value="${list.ask_title }" />
								</p>
								<h6>
									문의 내용 :
									<c:out value="${list.ask_content }" />
								</h6>
								<div id="ask${list.ask_no }">
									<c:if test="${list.ask_reply != null}">
										<strong>답글 : <c:out value="${list.ask_reply }"></c:out></strong>
									</c:if>
								</div>
								<br>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="tab-pane fade show active" id="review" role="tabpanel"
				aria-labelledby="review-tab">
				<div class="">
					<div class="col-lg-12">
						<div class="review_box">
							<h4>상품리뷰 작성</h4>
							<form action="replyForm" class="form-contact form-review mt-3"
								method="post" enctype="multipart/form-data">
								<input type="hidden" name="u_id" value="${user.id }"> <input
									type="hidden" name="p_no" value="${product.p_no }"> <input
									type="hidden" name="s_id" value="${product.s_id }">
								<div class="form-group">

									<!-- 제목 <input type="text" id="ask_title" class="form-control" 아이디값중복으로 아이디삭 -->
									제목 <input type="text" id="" class="form-control" name="r_title">
									내용
									<textarea class="form-control different-control w-100"
										name="r_content" id="textarea" cols="30" rows="5"></textarea>
								</div>
								<div class="form-group text-center text-md-right mt-3">
									<input type="file" name="img" multiple="multiple"
										class="form-control" onchange="setThumbnail(event);">
									<div id="image_container"></div>
									<button type="submit"
										class="button button--active button-review">등록</button>
								</div>
							</form>
						</div>
					</div>
					<div class="col-lg-12">
						<div class="review_list">
							<c:forEach items="${replyList }" var="reply_list">
								<div class="review_item">
									<div class="media">
										<div class="media-body">
											<h4>
												유저 ID :
												<c:out value="${reply_list.u_id }"></c:out>
											</h4>
											<small><c:out value="${reply_list.r_date }" /></small> 제목 :
											<small><c:out value="${reply_list.r_title }" /></small>

										</div>
									</div>
									<p>
										<c:out value="${reply_list.r_content }"></c:out>
									</p>
									<c:if test="${reply_list.r_img1 != null}">
										<img src="/resources/img/replyUpload/${reply_list.r_img1 }"
											width="150px;" height="200px;" onclick="fnImgPop(this.src)"
											 onerror="this.src='/resources/img/noimage.gif'">
									</c:if>
									<c:if test="${reply_list.r_img2 != null}">
										<img src="/resources/img/replyUpload/${reply_list.r_img2 }"
											width="150px;" height="200px;" onclick="fnImgPop(this.src)"
											 onerror="this.src='/resources/img/noimage.gif'">
									</c:if>
									<c:if test="${reply_list.r_img3 != null}">
										<img src="/resources/img/replyUpload/${reply_list.r_img3 }"
											width="150px;" height="200px;" onclick="fnImgPop(this.src)"
											 onerror="this.src='/resources/img/noimage.gif'">
									</c:if>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!--  Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLongTitle">답글달기</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<div class="form-group">
						<label for="message-text" class="col-form-label">내용</label>
						<textarea class="form-control" id="message-text" name="content"></textarea>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="ask_replyBtn">답글달기</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- /.modal -->
<!-- Modal -->
<div class="modal fade" id="notice" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLongTitle">알림</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">...</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
				<div id = "cart-btn-area"></div>
			</div>
		</div>
	</div>
</div>
<!-- Modal end -->

<!--================End Product Description Area =================-->

<%@ include file="../include/footer.jsp"%>
<script>
function clickEvent(){
	//하트 토글 이벤
		
	let p_no = getP_no();
	let heart_empty = $(".icon_heart_empty");
	heart_empty.off("click");
	heart_empty.click(function(){ //찜목록 추가 삭제
		let obj = $(this);
		//하트클래스 포함여부
		if(obj.hasClass("icon_heart_red")){
			removeLikeEvent(p_no,obj);
		}
		else{
			addLikeEvent(p_no,obj);
		}
	});
		/* $heart_empty.toggleClass("icon_heart_red"); */
	//장바구니 추가 이벤트
	let btnShoppingCart = $(".btn-shopping-cart");
	btnShoppingCart.click(function(){
		
		let quantity = $(".product_count").children("input").val();
		addCartEvent(p_no,quantity);
	})
	
	let btnReport = $("#btn-report");
	btnReport.click(function(){
		if(loginTypeCheck()){
			return false;
		}
		btnReport.preventDefault();
		console.log("report click!");
		addReportEvent();
	})
	
}
function getUserId(){
	let u_id = "${user.id}";
	return u_id;
}
function getP_no(){
	let p_no = "${product.p_no}";
	return p_no;
}
function getS_id(){
	let s_id = "${product.s_id}";
	return s_id;
}
function getSellerCheck(){
	let sellerCheck = "${user.seller}"
	//console.log("sellerCheck : " +  sellerCheck);
	if(sellerCheck === 'N'){
		return false;
	}else if(sellerCheck === 'Y') {
		return true;
	}
}

$(document).ready(function() {
					clickEvent();
					checkLiked();
					//getSellerCheck();
					if(getSellerCheck() || sessoinExistenceChecked()){
						$(".review_box").hide();
					}
					let u_id = "${user.id}";
					let seller ="${user.seller}";
					let seller_id = "${product.s_id}";
					let p_no = "${product.p_no}";
					let s_id = "${product.s_id}";
					let list = $("#ask");
					let text = '';
					
	$(document).on("click","#product_ask",function() {
						list.empty();
						let ask_title = $("#ask_title").val();
						let ask_content = $("#p_ask").val();
				// 상품 문의 댓글 ajax 처리
					$.ajax({url : "product_ask",
							data : {
									"p_no" : p_no,
									"u_id" : u_id,
									"s_id" : s_id,
									"ask_title" : ask_title,
									"ask_content" : ask_content},

							dataType : "JSON",
								type : "POST",
							 success : function(data) {
								 console.log("data : " , data);
								 if(data.code == 1){
										$.each(data.list,function(index,value) {
											text =  '<div class="comment_list">';
											text += '<div class="review_item">';
											text += '<div class="media">';
											text += '<div class="media-body">';
											text += '<h4>유저 ID : '+ value.u_id +'</h4>';
											text += '<small><h5>' +value.ask_date + '</h5></small>';
											
											if(seller == 'Y'){
											text += '<a class="reply_btn" id="askReply">Reply</a>';
											}
											
											text += '</div></div>';
											text += '<p>문의 제목 : ' +value.ask_title+ '</p>';
											text += '<h6>문의 내용 : ' +value.ask_content+ '</h6>';
											text += '<div id="ask'+value.ask_no+'">'
											if(value.ask_reply !=null){
											text +='<strong>답글 : '+value.ask_reply+'</strong>'
											}
											text +='</div><br></div></div>';
											list.append(text);
											
											Swal.fire({
												  icon: 'success',
												  title: 'Wow...',
												  text: '문의가 등록되었습니다'
												  
												})
									})	
								 }else{
					  	    			Swal.fire({
						    				  title: '처리되지 않았습니다',
						    				  confirmButtonText: `확인`
						    				}).then((result) => {
						    				  /* Read more about isConfirmed, isDenied below */
						    				  if (result.isConfirmed) {
						    					  location.reload();
						    				  }
						    				})
									 
								 }

							},error : function() {
									console.log("통신실패");
													}
												})
									})
			let ask_no ='';
			// reply(답글) 클릭 시 modal 이벤트 발생						
			$(document).on("click","#askReply",function(){
				ask_no = $(this).data("ask_no");
				// 모달 
				$("#exampleModalCenter").modal();
				

				
					})
	// modal 에서 작성 버튼 누를 시 이벤트 발생
	$(document).on("click","#ask_replyBtn",function(){
		
		
		
		let ask_reply = $("#message-text").val();
			let msg = "";
			
		$.ajax({
			url : "product_ask_reply",
			data : {"ask_no" : ask_no,
					"ask_reply" : ask_reply,
					"p_no" : p_no},
			dataType:"JSON",
			type:"POST",
			success : function(data){
				if(data.code ==1){
					$("#ask"+ask_no).empty();
					$("#ask"+ask_no).append('<strong>답글 : '+ ask_reply +'</strong>');
					console.log("#ask"+ask_no);
					Swal.fire({
						  icon: 'success',
						  text: '등록되었습니다'
						})
				}else{
  	    			Swal.fire({
  	    				  
	    				  title: '처리되지 않았습니다',
	    				  confirmButtonText: `확인`
	    				}).then((result) => {
	    				  /* Read more about isConfirmed, isDenied below */
	    				  if (result.isConfirmed) {
	    					  location.reload();
	    				  }
	    				})
				}
				 
			},error : function(request,error){
				console.log("통신실패", request.status,"\n",request.responseText);
			}
		})			
			
	})

		

		
			
})
	// 이미지 미리보기
	function setThumbnail(event) {

		$("#image_container").empty();
		let size = event.target.files.length;
		if(size>=4){
			alert("최대 3개까지 가능합니다");
			$("#image").val("");
			return false;
		}
		for (var image of event.target.files) { 
			var reader = new FileReader();
			reader.onload = function(event) { 
				var img = document.createElement("img");				
				img.setAttribute("src", event.target.result); 
				img.setAttribute("width", "150px;"); 
				img.setAttribute("height", "200px;"); 
				document.querySelector("div#image_container").appendChild(img)
				}; 
				console.log(image); reader.readAsDataURL(image); } 

				
			}
	//이미지 클릭시 팝업에서 이미지 보기
	 function fnImgPop(url){
			  var img=new Image();
			  img.src=url;
			  var img_width=img.width;
			  var win_width=img.width+25;
			  var img_height=img.height;
			  var win=img.height+30;
			  var OpenWindow=window.open('','_blank', 'width='+img_width+', height='+img_height+', menubars=no, scrollbars=auto');
			  OpenWindow.document.write("<style>body{margin:0px;}</style><img src='"+url+"' width='"+win_width+"'>");
			 }	
	
	
	
	 function addCartEvent(p_no,quantity) { //장바구니
			let userId = getUserId();
			
			if(loginTypeCheck()){ // 비회원, 판매자 아이디면 각각상황에 따른 모달창을 띄워준다.
				return false;
			}
	
			$.ajax({
				url : '/carshop/product/addcart',
				type : 'POST',
				data : {
					"u_id" : userId,
					"p_no" : p_no,
					"quantity":quantity
				},
				dataType : 'JSON',
				success : function(stats) {
					$("#notice .modal-body").html("\""+ userId + "\"님 장바구니에 넣었습니다.");
					$("#cart-btn-area").empty().append(`<button type="button" onClick="location.href='/carshop/cart'"
						class="btn btn-primary" data-dismiss="modal">장바구니로 이동</button>`);
					$('#notice').modal('show');
	
				},
				error : function() {
					console.log("장바구니 통신실패");
				}
			})
		}
	function addLikeEvent(p_no,$obj) { //찜목록추가
		let userId = getUserId();
		if(loginTypeCheck()){ // 비회원, 판매자 아이디면 각각상황에 따른 모달창을 띄워준다.
			return false;
		}

		$.ajax({
			url : '/carshop/product/addlike',
			type : 'POST',
			data : {
				"u_id" : userId,
				"p_no" : p_no
			},
			dataType : 'JSON',
			success : function(stats) {
				$(".icon_heart_empty").addClass("icon_heart_red");								
				$("#notice .modal-body").html("\""+ userId + "\"님 찜 목록에 넣었습니다.");
				$("#cart-btn-area").empty();
				$('#notice').modal('show');
			},
			error : function() {
				console.log("통신실패");
			}
		})
	}
	function addReportEvent() { //신고
		if(loginTypeCheck()){ // 비회원, 판매자 아이디면 각각상황에 따른 모달창을 띄워준다.
			return false;
		}else{
			$("#formReport").submit();
		}

	}
	function removeLikeEvent(p_no,$obj) { //찜목록삭제
		//console.log("상품번호 : " + p_no);
		let userId = getUserId();
		if(loginTypeCheck()){ // 비회원, 판매자 아이디면 각각상황에 따른 모달창을 띄워준다.
			return false;
		}
		$.ajax({
			url : '/carshop/product/removeLiked',
			type : 'POST',
			data : {
				"u_id" : userId,
				"p_no" : p_no
			},
			dataType : 'JSON',
			success : function(stats) {
				$(".icon_heart_empty").removeClass("icon_heart_red");
				$("#notice .modal-body").html("\""+ userId + "\"님 찜 목록에서 삭제되었습니다.");
				$("#cart-btn-area").empty();
				$('#notice').modal('show');
			},
			error : function() {
				console.log("통신실패");
			}
		})
	}
	function checkLiked(){
		let userId = getUserId();
		let p_no = getP_no();
		if(sessoinExistenceChecked()){
			return false;
		}

			$.ajax({
				url : '/carshop/product/checkLiked',
				type : 'POST',
				data : {
					"u_id" : userId, //나중에 로그인완성되면 넣을것!
					"p_no" : p_no
				},
				dataType : 'JSON',
				success : function(data) {
					if(data){
						$(".icon_heart_empty").addClass("icon_heart_red");					
					}
				},
				error : function() {
					console.log("통신실패");
				}
			})
		
	} 
	function sessoinExistenceChecked(){
		let userId = getUserId();
		if(userId === "" || typeof userId === "undefined" || userId === null){
			
			return true;
		}
		return false;
	}
	function loginTypeCheck(){
		
		let result = false;
		if(sessoinExistenceChecked()){
			$("#notice .modal-body").html("로그인 후 이용해주세요.");
			$("#cart-btn-area").empty();
			$('#notice').modal('show');
			result = true;
		}else if(getSellerCheck()){
			$("#notice .modal-body").html("판매자는 이용할수 없습니다. 일반유저 로그인 후 이용해주세요.");
			$("#cart-btn-area").empty();
			$('#notice').modal('show');
			result = true;
		}
		return result;
	}
</script>
