<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../include/header.jsp"%>

<title>저리카 | 카테고리 </title>
<link rel="stylesheet" href="/resources/vendors/linericon/style.css">
<link rel="stylesheet"
	href="/resources/vendors/nouislider/nouislider.min.css">

<style>
.card-product__imgOverlay li button:hover .ti-heart {
	margin: 0;
	width: 15px;
	height: 15.2px;
	background-size: cover;
	background-position: center;
	background-image: url(/resources/img/heart/heart_white_full.png);
}

.heart_white_full {
	margin: 0;
	width: 15px;
	height: 15.2px;
	background-size: cover;
	background-position: center;
	background-image: url(/resources/img/heart/heart_white_full.png);
}
</style>

<!-- ================ start banner area ================= -->
<section class="blog-banner-area" id="category">
<img class="img-fluid" src="/resources/img/cart/title.png" alt="배너"
      style="position: absolute; top: 0; left: 0; width: 100%; height: 100%" />
	<div class="container h-100">
		<div class="blog-banner">
			<div class="text-center">
				<h1> Category</h1>
				<nav aria-label="breadcrumb" class="banner-breadcrumb">
					
				</nav>
			</div>
		</div>
	</div>
</section>
<!-- ================ end banner area ================= -->


<!-- ================ category section start ================= -->
<section class="section-margin--small mb-5">
	<div class="container">
		<div class="row">
			<div class="col-xl-3 col-lg-4 col-md-5">
				<div class="sidebar-categories">
					<div class="head">부품선택</div>
					<ul class="main-categories">
						<li class="common-filter">
							<ul>
								<!-- default값으로 value = 0 을 설정, 전체 상품목록을 조회할때 사용한다 -->
								<li class="filter-list"><input
									class="pixel-radio parts-radio parent-radio" type="radio"
									name="brand" id="cateParentDefault" value="0" checked>
									<label for="cateParentDefault">전체보기</label></li>
								<!-- 카테고리를 each문으로 출력 -->
								<c:forEach items="${cateParent }" var="cateParent">
									<li class="filter-list"><input
										class="pixel-radio parts-radio parent-radio" type="radio"
										id="${cateParent.c_no}" name="brand"
										value="${cateParent.c_no}"> <label
										for="${cateParent.c_no}"> <c:out
												value="${cateParent.c_name}" />
									</label></li>
								</c:forEach>
							</ul>
						</li>
					</ul>
				</div>
				<div class="sidebar-categories">
					<div class="head">상세부품선택</div>
					<div class="common-filter parts_radio">
						<!-- 전면부품 체크시 나타날 radio -->
						<ul class="main-categories" id="details-parts">
							<li class="filter-list"><input class="pixel-radio"
								type="radio" name="details-parts" value="0" id="detailDefault"
								checked> <label for="detailDefault">전체보기</label></li>
						</ul>
					</div>

				</div>
			</div>
			<div class="col-xl-9 col-lg-8 col-md-7">
				<!-- Start Filter Bar -->
				<div class="filter-bar d-flex flex-wrap align-items-center">
					<div class="sorting" id="sortingAmountOrName">
						<select>
							<option value="" selected disabled>정렬 순서</option>
							<option value="amount ASC">가격 낮은 순</option>
							<option value="amount DESC">가격 높은 순</option>
							<option value="p_name ASC">이름 순(a-z)</option>
							<option value="p_name DESC">이름 순(z-a)</option>
						</select>
					</div>
					<div class="sorting mr-auto" id="viewProduct">
						<select>
							<option value="12" selected>12개씩 보기</option>
							<option value="21">21개씩 보기</option>
							<option value="30">30개씩 보기</option>
						</select>
					</div>
					<!-- 내 차량 검색 체크박스 -->
					<div id="mycarSearchCheckBoxArea" style="margin: 25px 15px 0 0">
						<input style="zoom: 1.5" type="checkbox" name="mycarSearch"
							id="mycarSearch"><label
							style="position: relative; top: -4.5px; margin-left: 10px;"
							for="mycarSearch">내 차량 검색</label>
					</div>
					<!-- 검 색 창 -->
					<div>
						<div class="input-group filter-bar-search">
							<input type="text" id="search-input-box" placeholder="Search">
							<div class="input-group-append">
								<button type="button">
									<i class="ti-search"></i>
								</button>
							</div>
						</div>
					</div>
				</div>
				<!-- End Filter Bar -->
				<!-- Start Best Seller -->
				<section class="lattest-product-area pb-40 category-list">
					<div class="row" id="product-list-area">

						<!-- 상품 리스트가 들어갈 곳이다. -->
					</div>
					<!-- 페이지  -->
					<div id="pagination-parent">
						<div id='pagination-div'></div>

					</div>
				</section>
				<!-- End Best Seller -->
				<!-- Button trigger modal -->

			</div>
		</div>
	</div>
</section>
<!-- ================ category section end ================= -->
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



<%@ include file="../include/footer.jsp"%>

<script src="/resources/vendors/nouislider/nouislider.min.js"></script>
<script src="/resources/js/shopproduct.js"></script>
<script type="text/javascript" src="/resources/js/twbsPagination.js"></script>
<script>


function addCartEvent(p_no,quantity) { //장바구니
	let userId = getUserId();
	if(loginTypeCheck()){ // 비회원, 판매자 아이디면 각각상황에 따른 모달창을 띄워준다.
		return false;
	}
	

	$.ajax({
		url : '/carshop/product/addcart', //컨트롤러 주소
		type : 'POST', //메소드 방식
		data : { //넘겨줄 데이터
			"u_id" : userId, // "넘겨줄 데이터 이름(key) : 넘겨줄 값(value)"
			"p_no" : p_no,
			"quantity":quantity
		},
		dataType : 'JSON', //데이터 방식? json방식으로 데이터를 넘겨줘요 
		success : function(stats) {
			$(".modal-body").html("\""+getUserId() + "\"님 장바구니에 넣었습니다.");
			
			$("#cart-btn-area").html(`<button type="button" onClick="location.href='/carshop/cart'"
											class="btn btn-primary" data-dismiss="modal">장바구니로 이동</button>`);
			$('#notice').modal('show');

			
		},
		error : function() {
			console.log("장바구니 통신실패");
		}
	})
}
function addLikeEvent(p_no,$obj) { //찜목록추가
	let userId = getUserId(); //유저아이디 가져온다 뭐가
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
			$obj.children(".ti-heart").addClass("heart_white_full");								
			$(".modal-body").html("\""+getUserId() + "\"님 찜 목록에 넣었습니다.");
			$("#cart-btn-area").empty();
			$('#notice').modal('show');
		},
		error : function() {
			console.log("통신실패");
		}
	})
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
			$obj.children(".ti-heart").removeClass("heart_white_full");
			$(".modal-body").html("\""+getUserId() + "\"님 찜 목록에서 삭제되었습니다.");
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
	if(sessoinExistenceChecked() || getSellerCheck()){
		return false;
	}

	$(".btn_like_toggle").each(function(index){
		let $obj = $(this);
		let p_no = $(this).val();
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
					$obj.children(".ti-heart").addClass("heart_white_full");					
				}
			},
			error : function() {
				console.log("통신실패");
			}
		})
	});
} 

function setDisplay(obj) { //카테고리창
	let cateId = obj.attr('id');
	$.ajax({
				url : '/carshop/cateChek?cateId=' + cateId,
				type : 'get',
				dataType : 'JSON',
				success : function(data) {
					//console.log(" success 데이터 값 : ", data);
					let text = '';
					let details = $("#details-parts");
					// 비우기
					details.empty();
					$.each(data,function(index, value) {
										//상세카테고리 html 작성
										if(index == 0){
											text += `<li class="filter-list">
														<input class="pixel-radio"type="radio"name="details-parts" value="0" id="detailDefault" checked>
														<label for="detailDefault">전체보기</label></li>`;
										}
										text += '<li class="filter-list"><input class="pixel-radio"type="radio" id="'
												+ value.c_no+'" name="details-parts" value="'
												+ value.c_no+'"><label for="'
												+ value.c_no+'">'
												+ value.c_name
												+ '</label></li>';
									})
					details.append(text);
					details.show();
					categoryDetailChange(); //상세카테고리 작성후 이벤트 등록

				},
				error : function() {
					console.log("통신실패");
				}
			})
}
// 처음에는 파라미터로 각 옵션들을 넘겨받았으나 기능이 더해질 수록 코드가 지저분해지고 꼬여감에 따라서 함수 안에서 직접 값을 부르는 형식으로 코드 변
//function setProductList(category,url,obj,direction) { //카테고리 함수 파라미터로 url을 입력받는다.
function setProductList() { //상품을 그려주는 함수
	
	let categoryParents; //부모카테고리
	let categoryDetails;// 자식카테고리
	let url;//url을 담을 변수
			
	let sortingAmountOrName =  $("#sortingAmountOrName option:selected").val(); //정렬 순서 select option의 값을 저장
	
	categoryParents = $("input[type=radio][name=brand]:checked").val(); //부모 카테고리의 값
	categoryDetails = $("input[type=radio][name=details-parts]:checked").val(); //자식 카테고리의 값
	

	url = "/carshop/product/selectCategory"; // 컨트롤러 주소
	
	//정렬 순서 select option의 값에 따라서 order by 문으로 들어갈 문자가 정해진다.
	
	$.ajax({
				url : url,
				type : 'Post',
				data : {
					"categoryParents" : categoryParents, //부모 카테고리의 값을 전송한다.
					"categoryDetails" : categoryDetails, //자식 카테고리의 값을 전송한다.
					"sorting" : sortingAmountOrName,//정렬 객체와 방향
				},
				dataType : 'JSON',

				success : function(data) {
					let text; //append 할 html문을 저장한다. 
					let totalProductCnt = 0; //총 상품의 갯수를 저장할 변수이다.
					let $productListArea = $("#product-list-area");//상품을 그려넣을 장소
					$productListArea.empty(); //append하기전 비워준다.
					$.each(data,function(index, product) {
						text = '';
						let productName = product.p_name;
						product.p_name = product.p_name.toUpperCase();
						productNum = index +1; //상품아이디 product + productNum 의 형식으로 아이디 지
											//text는 백틱으로 처음부터 끝까지 해결하려했으나 태그 다음에 오류 ex) `src="${product.img}"`동작 안함
										  	text += `<div class="`;
											text += ` col-md-6 col-lg-4 product-area" data-product-amount="`;
										  	text += product.amount;
											text +=`" data-product-name="`;
											text += product.p_name;
											text +=`" data-compa-name="`;
											text += product.compa;
											text += `" id ="product`
											text += productNum + `"> 
											<div class="card text-center card-product">
											<div class="card-product__img">
												<img class="card-img" onerror="this.src='/resources/img/noimage.gif'"  src="/resources/img/upload/`;
											text += product.img1;
											text += `" onClick="location.href='/carshop/product/details?p_no='`;
											text += product.p_no;
											text += ` ">
												<ul class="card-product__imgOverlay">
													<li><button
															onClick="location.href='/carshop/product/details?p_no=`;
											text += product.p_no;
											text += `'">
															<i class="ti-search"></i>
														</button></li>
													<li><button class="btn_shopping-cart" value="`
											text += product.p_no;
											text += `">
															<i class="ti-shopping-cart"></i>
														</button></li>
													<li><button class="btn_like_toggle" value="`;
											text += product.p_no;
											text += `"><i class="ti-heart"></i></button></li></ul></div><div class="card-body"><p>`;
											text += product.compa;
											text +=`</p>
														<h5 class="card-product__title">
														<a href="/carshop/product/details?p_no=`;
											text += product.p_no;
											text += `">`;
											text += productName;
											text += `</a></h4><p class="card-product__price">`;
											text += product.amount;
											text += `원</p></div></div></div>`;
											$productListArea.append(text);//상품 출력
											
									})
					
					$productListArea.show();
					 //리스트 새로불러왔으니까 다시 이벤트 등록
					checkLiked(); //찜리스트인지 확인
					clickEvent(); //장바구니, 찜리스트 클릭이벤트 등록
					search(); // 검색이벤트 등록
					pagingEvent(); //페이지 이벤트 등록
					
				},
				error : function() {
					console.log("상품출력 통신실패");
				}
			}) 
}

function clickEvent(){ //찜, 장바구니 버튼 클릭 이벤트
	
	let likeToggle = $(".btn_like_toggle");
	let shoppingCart = $(".btn_shopping-cart"); //장바구니 버튼
	likeToggle.off("click"); //클릭이벤트 루프돌아서 클릭 이벤트 해제
	shoppingCart.off("click");//클릭이벤트 루프돌아서 클릭 이벤트 해제
	likeToggle.click(function(){ //찜목록 추가 삭제
		let $obj = $(this);
		//하트클래스 포함여부
		if($obj.children().hasClass("heart_white_full")){ //여기에서 하트에 불이 들어와있는이미지를 클래스로 가지고있으면
			removeLikeEvent($(this).val(),$obj); //찜목록에서 삭제 파라미터(지금 클릭한 객체의 value값,클릭한 객체 )
		}
		else {
			addLikeEvent($(this).val(),$obj);
		}
	});
	shoppingCart.click(function(){ //장바구니 add
		addCartEvent($(this).val(),1);// 카트 추가 (객체의 value,수량)
	})
	
}
// -- 처음에는 클릭이벤트와 같이있었지만 상품리스트출력후 클릭이벤트를 다시등록해줄때에 루프를 돌아서 따로 분리하였다.
function categoryParentChange(){ //부모 카테고리
	
	let radioBrand = $("input[type=radio][name=brand]");
	radioBrand.off("change");
	radioBrand.change(function(){
		var obj = $(this);
		//아래의 코드는 버그 fix 상세카테고리가 선택되어있을때(상세카티고리의 값이 0이 아닐 때) 부모카테고리를 바꾸면 없는 카테고리를 참조하여 데이터를 가져오지 못한다.
		//부모카테고리가 바뀔때 상세부품카테고리의 값을 강제로 0(default)으로바꾸어 주었다. 
		$("input[type=radio][name=details-parts][value='0']").prop("checked",true);
		//obj.val()는 부모카테고리 넘버
		if(obj.val() != 0){
			setDisplay(obj); //상세카테고리를 그려주는 함수
			setProductList();//상품을 그려주는 함수
		}else{
			setProductList();//상품을 그려주는 함수
		}
	})
}
function categoryDetailChange(){//상세 카테고리
	
	let radioDetails = $("input[type=radio][name=details-parts]");
	radioDetails.off("change");
	radioDetails.change(function(){
		setProductList();//상품을 그려주는 함수
	})
}
function search(){ //검색(프론트에서 구현)
	let searchInputBox = $("#search-input-box"); //검색창
	let productArea = $(".product-area"); //상품
	searchInputBox.off('keyup'); //키업이벤트 삭제..
	searchInputBox.keyup(function(){
		let text = $(this).val(); //키보드입력에따라 매 순간 text값을 받아온다.
		if(text===''){
			productArea.show();
			pagingEvent();
		}else{
			//console.log("keyup 동작");
			text=text.toUpperCase();
			productArea.hide(); //키보드가 입력 될때에 모든 상품을 숨긴다.
			let searchProduct = $(".product-area[data-product-name*='"+text+"']"); //상품클래스 중 date-product-name속성에 text가 포함(contains이용)
			$(searchProduct).show(); //검색어를 포함하면 다시 보여준다.
			let searchCompa = $(".product-area[data-compa-name*='"+text+"']"); //상품클래스 중 date-compa-name속성에 text가 포함( *= 는 포함이다.(매우중요))
			$(searchCompa).show(); //검색어를 포함하면 다시 보여준다.
			$("#pagination-parent").empty(); //페이지 버튼이 들어갈 곳을 비워준다.
		}
	})
}

function sortOption(){ //정렬 
	let sortingAmountOrName = $("#sortingAmountOrName"); //정렬 방법 선택창
	sortingAmountOrName.off("change");
	sortingAmountOrName.change(function(){
		setProductList();//상품을 그려주는 함수
	})
}
function ProductViewEvent(){//몇개씩 볼것인지 선택
	let viewProduct = $("#viewProduct");
	viewProduct.off("change");
	viewProduct.change(function(){
		setProductList();//상품을 그려주는 함수
	})
}
function pagingEvent(){//페이지 함수(프론트에서 구현)
	//$("#pagination-div").empty();를 하면 실행이 안된다.(아직 이유를 못찾음..)
	$("#pagination-parent").empty(); //페이지 버튼이 들어갈 곳을 비워준다.		
	$("#pagination-parent").append("<div id= 'pagination-div'></div>"); //페이지 버튼이 들어갈곳을 생성해준다.
	
	let pageCnt = 1; //페이지 저장 변수
	let productArea = $(".product-area").attr("style", "display:block") ;//상품클래스
	let totalProductCnt = 0; //총 상품의 갯수를 저장할 변수
	let viewProduct =  $("#viewProduct option:selected").val();//상품출력 갯수 select option중 선택된값을 저장
	productArea.each(function(index,item){//상품갯수를 파악, 페이지 크기도 파악하기위한 each문
		totalProductCnt++;
		if((index+1)%viewProduct == 0){//상품목록의 크기와 상품출력갯수를 나누어서 나머지가 없으면 페이지카운트를 늘려준다.
			pageCnt++;
		}
		
	})
	let totalPages = Math.ceil(totalProductCnt/viewProduct); //총 상품갯수와 상품출력갯수를 나눈후 올림하여 페이지의 크기를 구한다.
	let visiblePages = totalPages > 5 ? 5 : totalPages; //하단에 한번에 보여지는 페이지 번호 수 5보다 크면 5 작으면 작은값을 출력하도록하였다.
	productArea.hide(); //최초 함수 실행시 모든상품을 숨긴다.
	$('.page1').show();//최초 함수 실행시 page1클래스를 보여준다.
	$('#pagination-div').twbsPagination({
	    totalPages: totalPages,	// 총 페이지 번호 수
	    visiblePages: visiblePages,	// 하단에서 한번에 보여지는 페이지 번호 수
	    startPage : 1, // 시작시 표시되는 현재 페이지
	    initiateStartPageClick: true,	// 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
	    first : "<<",	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
	    prev : "이전",	// 이전 페이지 버튼에 쓰여있는 텍스트
	    next : "다음",	// 다음 페이지 버튼에 쓰여있는 텍스트
	    last : ">>",	// 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
	    nextClass : "page-item next",	// 이전 페이지 CSS class
	    prevClass : "page-item prev",	// 다음 페이지 CSS class
	    lastClass : "page-item last",	// 마지막 페이지 CSS class
	    firstClass : "page-item first",	// 첫 페이지 CSS class
	    pageClass : "page-item",	// 페이지 버튼의 CSS class
	    activeClass : "active",	// 클릭된 페이지 버튼의 CSS class
	    disabledClass : "disabled",	// 클릭 안된 페이지 버튼의 CSS class
	    anchorClass : "page-link",	//버튼 안의 앵커에 대한 CSS class
	    
	    onPageClick: function (event, page) { //페이지 버튼이 클릭되었을때 실행합수 파라미터 page는 클릭한 페이지번호이다.
	    	paging(page,totalProductCnt,totalPages); //paging 함수에 (page:클릭한페이지,totalProductCnt:총 상품갯수,totalPages:총페이지)를 넘겨준다.
	    }
	});
	
}
 function paging(page,totalProductCnt,totalPages) {//페이지함수
	$(".product-area").hide(); //상품목록을 숨긴다.
	let pageSize = $("#viewProduct option:selected").val(); //한 페이지당 보여줄 게시물의 갯수
	let totalCount = totalProductCnt; // 게시물 총 갯수
	
	var startRow = (page - 1) * pageSize; //출력할 상품의 번호 ex) product1에서 시작할지 product7에서 시작할지
	var endRow = page * pageSize; //마지막 상품번호
	if (endRow > totalCount){ 
		endRow = totalCount;
	}  
	for (var j = startRow+1; j <= endRow; j++){	
		$("#product" + j).show(); //상품출력
	}
	
}
 function getUserId(){ //유저아이디 getter
		var u_id = '<c:out value="${user.id}"></c:out>'; //js파일에서 읽히지 않는다. jstl임포트 불가능 (해결방안 : js파일을 jsp로 변환 or json을 이용)
		return u_id;
}
function getUserCar(){
	var u_car = '<c:out value="${UserCar}"></c:out>'; //js파일에서 읽히지 않는다. jstl임포트 불가능 (해결방안 : js파일을 jsp로 변환 or json을 이용)
	return u_car;
}
function sessoinExistenceChecked(){
	let userId = getUserId();

	if(userId === "" || typeof userId === "undefined" || userId === null){
		
		return true;
	}
	return false;
}

function carSearchCheckEvent(){
	let mycarSearch = $("#mycarSearch");
	let userCar = getUserCar();
	let mycarSearchCheckBoxArea = $('#mycarSearchCheckBoxArea');
	if(userCar === ''){
		mycarSearchCheckBoxArea.hide();
	}else{
		mycarSearchCheckBoxArea.show();
	}
	mycarSearch.off("change");
	mycarSearch.change(function(){
		
		if(mycarSearch.is(":checked")){
			$("#search-input-box").val(userCar);
			$(".product-area").hide();
			let searchCompa = $(".product-area[data-compa-name*='"+userCar+"']"); //상품클래스 중 date-compa-name속성에 text가 포함( *= 는 포함이다.(매우중요))
			$(searchCompa).show(); //검색어를 포함하면 다시 보여준다.
			$("#pagination-parent").empty(); //페이지 버튼이 들어갈 곳을 비워준다.
		}else{
			$("#search-input-box").val('');
			setProductList();
		}
	}) 
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

function loginTypeCheck(){ //비회원, 판매자 접속시 모달창
	
	let result = false;
	if(sessoinExistenceChecked()){
		$("#notice .modal-body").html("로그인 후 이용해주세요.");
		$('#notice').modal('show');
		result = true;
	}else if(getSellerCheck()){
		$("#notice .modal-body").html("판매자는 이용할수 없습니다. 일반유저 로그인 후 이용해주세요.");
		$('#notice').modal('show');
		result = true;
	}
	return result;
}
function init(){ //이벤트함수 init
	setProductList(); // 최초 상품목록 불러오기
	categoryParentChange(); //부모카테고리 값이 바뀌면 동작하는 이벤트
	sortOption();//정렬옵션함수
	//search();//검색 
	ProductViewEvent();//몇개씩 볼것인지
	getUserId();//유저아이디 getter
	
}
$(document).ready(function() {
	init();
	carSearchCheckEvent();
	// 인덱스 페이지 에서 카테고리 상품클릭하여 해당 no랑 구분자를 제이쿼리 객체를 만든다
	let cate_no = "${param.cate_no}";
	let click = "${param.click}";
	// 클릭이 y였을시 라디오버튼을 해당 id에 맞게 체크하고 trigger를 이용해 강제로 발생하게한다
	if(click =='Y'){
		$("#"+cate_no).prop('checked',true);
		$("#"+cate_no).trigger("change");
		
	}
	
})
</script>
