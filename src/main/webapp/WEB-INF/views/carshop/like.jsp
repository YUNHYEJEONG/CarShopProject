<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>




<!-- ================ start banner area ================= -->
<title>저리카 | 찜목록</title>
<link rel="stylesheet" href="/resources/vendors/linericon/style.css">

<!-- hraet 아이콘 css 생성 2020.12.22 -->
<style>
.icon_heart_empty {
	width: 50px;
	height: 50px;
	background-size: cover;
	background-position: center;
	background-image: url(/resources/img/heart/heart_empty.png);
}

.icon_heart_red {
	width: 50px;
	height: 50px;
	background-position: center;
	background-size: cover;
	background-image: url(/resources/img/heart/heart_red.png);
	primary-btn: ml-2;
}

.icon_cart {
	width: 50px;
	height: 50px;
	background-position: center;
	background-size: cover;
	background-image: url(/resources/img/cart/cart_icon.png);
}
</style>
<!-- ===================== css 종료 ===========================-->





<!-- ================== start banner area =================== -->
<section class="blog-banner-area" id="category">
	<img class="img-fluid" src="/resources/img/like/like1.png" alt="like배너"
		style="position: absolute; top: 0; left: 0; width: 100%; height: 100%" />
	<!-- 정상 출력 안되면 like 문구 출 -->
	<div class="blog-banner">
		<div class="text-center">
			<h1 style="color: white">LIKE</h1>
			<nav aria-label="breadcrumb" class="banner-breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item active" aria-current="page"></li>
				</ol>
			</nav>
		</div>
	</div>
</section>
<!-- ================ end banner area ================= -->






<!--================Cart Area =================-->
<section class="cart_area">
	<div class="container">
		<div class="cart_inner">
			<div class="table-responsive">
				<table class="table">
					<thead>
						<tr align="center">
							<th scope="col"><b>상품명</b></th>
							<th scope="col"><b>price</b></th>
							<th scope="col"><b>장바구니 담기</b></th>
							<th scope="col"><b>삭제</b></th>
						</tr>
					</thead>

					<!-- like 리스트 반복문으로 출력 -->
					<tbody>
										<!-- 상품코드를 히든타입으로 넘김 -->
					<c:forEach items="${likeList_like}" var="like">
							 <form name="cartform" method="post" action="/carshop/insert_cart">
								
								<tr align="center">
									<td>${like.p_name}</td>
									<td><fmt:formatNumber value="${like.amount}" pattern="#,###,###" />원</td>		
									<!-- <td><button class="btn-shopping-cart" style="float: left; margin-left: 30px; background-color: blue;">장바구니</button></td> -->
									<!-- <td><input type = "submit" value = "장바구니"></td>	 -->
									<td><a href="/carshop/insert_cart?p_no=${like.p_no}" class="fas fa-cart-arrow-down"></a></td> 
									<td><a href="/carshop/like_delete?u_id=${like.u_id}&p_no=${like.p_no}" 	class="fas fa-trash-alt"></a></td>
									<!-- <td><a href="${path}/carshop/like/delete?p_no=${like.p_no}" class="icon_heart_red"></a></td> -->
								</tr>
							</form>
					
						</c:forEach>
					<!-- 2021/01/08 yunhj 찜목록 삭제와 장바구니 연동 아이콘 저장 -->


						<!--btnUpdate와 btnDelete id는 위쪽에 있는 자바스크립트가 처리한다.  -->
						<tr class="out_button_area">
							<td class="d-none-l"></td>
							<td></td>
							<td></td>
							<td></td>
							<td>


								<div class="checkout_btn_inner d-flex align-items-center">
									<a class="primary-btn ml-2" href="cart">장바구니</a>
									<a class="gray_btn ml-2" id="Delete" href="${path}/carshop/like_deleteAll?u_id=${u_id}">비우기</a>
								</div>

							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</section>
<!--================End Cart Area =================-->
<%@ include file="../include/footer.jsp"%>




<!-- ============== 쿼리문 start =================== -->
<script>
	

	
$empty = $(".icon_heart_empty");

$empty.click(function(){
	$empty.toggleClass("icon_heart_empty");
	$empty.toggleClass("icon_heart_red");
})

	// like 동작 확인 출력 2020/01/05 yunhj
	$(document).ready(function(){
		console.log("like 동작 ");
	})
		
	
	/* let btnShoppingCart = $(".btn-shopping-cart");
	btnShoppingCart.click(function(){
		
		let quantity = $(".product_count").children("input").val();
		addCartEvent(p_no,quantity);
	}) */


	
	
	//장바구니 담기
	 function addCartEvent(p_no, quantity) { 
			let userId = getUserId();
			
			
			if(loginTypeCheck()){ // 모달
				return false;
			}
	
			$.ajax({
				url : '/carshop/insertCart',
				type : 'POST',
				data : {
					"u_id" : userId,
					"p_no" : p_no,
					"quantity":quantity
				},
				dataType : 'JSON',
				success : function(stats) {
					$("#notice .modal-body").html("상품이 장바구니에 담겼습니다.");
					$("#cart-btn-area").empty().append(`<button type="button" onClick="location.href='/carshop/cart'"
						class="btn btn-primary" data-dismiss="modal">장바구니</button>`);
					$('#notice').modal('show');
	
				},
				error : function() {
					console.log("오류");
				}
			})
		}
	
	
	
	// 장바구니 버튼 클릭 이벤트
	 function clickEvent(){ 
			
			
			let shoppingCart = $(".btn_shopping-cart");

			shoppingCart.click(function(){ //장바구니 add
				addCartEvent($(this).val(),1);
			})
			
		}
	 
	 
</script>