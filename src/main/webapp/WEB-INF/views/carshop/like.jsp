<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<!-- ================ start banner area ================= -->


<title>CarShop - like</title>
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

<!-- css 종료 -->

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
						<tr>
							<th scope="col"><b>상품명</b></th>
							<th scope="col" style="text-align: center;">price</th>
							<th scope="col" style="text-align: center;"><b>장바구니 담기</b></th>
							<th scope="col" style="text-align: center;"><b>찜</b></th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${map.count == 0 }">
							
  								 ※찜한 상품이 없습니다.
  							</c:when>
							<!-- 장바구니가 0 비었을 때, 장바구니가 비었다고 뜬다. -->

							<c:otherwise>
								<!-- map.count가 0이 아닐때, 즉 자료가 있을때 -->
								<!-- form을 실행한다.  -->
								<!-- form의 id를 form1로 하고, method 방식을 post로 한다. 그리고 update.do페이지로 이동 -->
								<form id="form1" name="form1" method="post"
									action="${path}/carshop/like/update.do">

									<!-- map에 있는 list출력하기 위해 forEach문을 사용해 row라는 변수에 넣는다. -->
									<c:forEach var="row" items="${map.list}">
										<tr align="center">
											<td>${row.pname}</td>

											<td><fmt:formatNumber value="${row.amount}"
													pattern="#,###,###" />원</td>
											<!-- fmt:formatNumber 태그는 숫자를 양식에 맞춰서 문자열로 변환해주는 태그이다 -->
											<!-- 여기서는 금액을 표현할 때 사용 -->
											<!-- ex) 5,000 / 10,000 등등등-->
											<!-- 물건의 개수 (quantity)를 fmt태그를 사용해서 패턴의 형식에 맞춰서 문자열로 변환함 -->
											<!--1,000 / 5,000 등등~  -->
											<td><a href="#" class="icon_cart"></a></td>
											<!-- 혜정 : 나중에 장바구니로 경로 설ㅈ -->


											<td><a
												href="${path}/carshop/cart/delete.do?pno=${row.pno}"
												class="icon_heart_empty"></a></td>
										</tr>

									</c:forEach>
									<tr class="bottom_button">
										<td><a class="gray_btn ml-2" id="btnDelete" href="#">비우기</a></td>

										<!--btnUpdate와 btnDelete id는 위쪽에 있는 자바스크립트가 처리한다.  -->

										<td></td>
										<td></td>
										<td></td>
									<tr class="out_button_area">
										<td class="d-none-l"></td>
										<td class="d-none-l"></td>
										<td class="d-none-l"></td>
										
										
										
										<td>
											<div class="checkout_btn_inner d-flex align-items-center">
												<a class="primary-btn ml-2" href="#">장바구니</a>
											</div>
										</td>
									</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</section>
<!--================End Cart Area =================-->
<%@ include file="../include/footer.jsp"%>

<script>
		$empty = $(".icon_heart_empty");

		$empty.click(function(){
            $empty.toggleClass("icon_heart_empty");
			$empty.toggleClass("icon_heart_red");
		})
</script>



