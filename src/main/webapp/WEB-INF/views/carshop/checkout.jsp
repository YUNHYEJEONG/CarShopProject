<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../include/header.jsp"%>


<style>

.order_box .list li:nth-child(4) a .middle {
    margin-left: 30px;
}

</style>

  <title>저리카 | 주문창</title>
	<link rel="stylesheet" href="/resources/vendors/linericon/style.css">
  	<link rel="stylesheet" href="/resources/vendors/nouislider/nouislider.min.css">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.13.0/dist/sweetalert2.all.min.js"></script>

	<!-- ================ start banner area ================= -->	
	<section class="blog-banner-area" id="category">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<h1><img src="/resources/img/checkout/bankcash.png" style="width:80px; heigh:100%; padding-right:10px"/>상품 구매 페이지</h1>
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item">구매할 상품을 확인해주세요</li>
            </ol>
          </nav>
				</div>
			</div>
    </div>
	</section>
	<!-- ================ end banner area ================= -->
  
  
  <!--================Checkout Area =================-->
  <section class="checkout_area section-margin--small">
    <div class="container">
        <div class="billing_details">
            <div class="row">
                <div class="col-lg-8" style="padding-top:30px; padding-bottom:30px">
                	    <!-- 일반 유저 테이블 에서 실명, 아이디, 전화번호, 이메일, 주소(대분류), 상세주소(소분류), 차종 jstl로 가져오기 (2020.12.18 재원)  -->
                    <h3>구매자 정보</h3> 
                    <form class="row contact_form" action="" method="get" novalidate="novalidate">
                       <c:forEach items="${pUser}" var="pUser">
                        <div class="col-md-6 form-group p_star">받는사람
                            <input type="text" class="form-control" name="name" value='${pUser.name}' readonly="readonly">
                            <span class="placeholder" data-placeholder="First name"></span>                            
                        </div>
                        <div class="col-md-6 form-group p_star">아이디
                            <input type="text" class="form-control" id="last" name="u_id" value='${pUser.u_id}' readonly="readonly">
                            <span class="placeholder" data-placeholder="Last name"></span>
                        </div>
                        <div class="col-md-12 form-group p_star">전화 번호
                            <input type="text" class="form-control" id="number" name="phone" value='${pUser.phone}' readonly="readonly">
                            <span class="placeholder" data-placeholder="Phone number"></span>
                        </div>
                        <div class="col-md-12 form-group p_star">이메일
                            <input type="text" class="form-control" id="email" name="email" value='${pUser.email}' readonly="readonly">
                            <span class="placeholder" data-placeholder="Email Address"></span>
                        </div>
                        <div class="col-md-12 form-group p_star">주소
                            <input type="text" class="form-control" id="add1" name="addr" value='${pUser.addr}' readonly="readonly">
                            <span class="placeholder" data-placeholder="Address line 01"></span>
                        </div>
                        <div class="col-md-12 form-group p_star">상세 주소
                            <input type="text" class="form-control" id="add2" name="addr2" value='${pUser.addr2}' readonly="readonly">
                            <span class="placeholder" data-placeholder="Address line 02"></span>
                            <button type="button" class="btn btn-outline-info font-weight-light" style="float:right;" data-toggle="modal" data-target="#exampleModalCenter1">주소 바꾸기</button>
                        </div>
                        <div class="col-md-12 form-group p_star">구매자 차종
                            <input type="text" class="form-control" id="city" name="cars" value='${pUser.cars}' readonly="readonly">
                            <span class="placeholder" data-placeholder="Town/City"></span>
                        </div>  
                    </c:forEach>                   
                    </form>
                </div>
                <div class="col-lg-4" style="padding-top:80px; padding-bottom:30px">
                 <!-- form으로 구매이력의 데이터를 넘겨야 함  (2020.12.18 재원)  -->
                 <form action="checkout" method="post" id="checkoutform">
                    <div class="order_box">
                      <h2>결제 정보</h2>
                      <!-- 장바구니 테이블 에서 상품명, 상품번호, 상품수량, 상품 금액 jstl로 가져오기 (2020.12.18 재원)  -->
                        <ul class="list">
                        	<li><a href="#"><h4>상품이름 <span style="position:absolute;width:50px;float:none;margin-left:30px;left:38%">수량</span><span>Total</span></h4></a></li>
                        	<c:set var="col_sum" value="0"/>
                        	<c:forEach items="${cartList}" var ="cart" varStatus="status">
                            	<li><a href="#"><c:out value="${cart.pname}"></c:out><span class="middle" style="position:absolute;left:30%;"> <c:out value="${cart.quantity}"></c:out></span> <span class="last"><c:out value="${cart.total}" /></span></a></li>
                        		<c:set var="col_sum" value="${col_sum + cart.total}" />
                        	</c:forEach>
                        </ul>
                        <hr>
                        <ul class="list list_2">
                            <li><a href="#">총 금액<span><fmt:setLocale value="ko_kr"/><fmt:formatNumber type="currency" maxFractionDigits="3" value="${col_sum}"></fmt:formatNumber></span></a></li>
                        </ul>
                        <!-- Todo : 결제 수단 (pay)가 구매이력(buylist) 테이블에 들어가야함 (2020.12.18 재원) -->
                        <div class="payment_item">
                            <div class="radion_btn">
                                <input type="radio" id="f-option5" name="pay" value="신용카드">
                                <label for="f-option5">신용카드</label>
                                <img src="/resources/img/product/card.jpg" alt="">
                                <div class="check"></div>
                            </div>
                        </div>
                        <div class="payment_item active">
                            <div class="radion_btn">
                                <input type="radio" id="f-option6" name="pay" value="카카오페이">
                                <label for="f-option6">카카오페이</label>  
                                <img src="/resources/img/checkout/payment_icon_yellow_medium.png" alt="카카오페이" style="width:60px; heigth:60px;">                              
                                <div class="check"></div>
                            </div>
                        </div>
                    <!-- a 태그에 onclick 줘서 데이터 넘겨야함  (2020.12.18 재원)  -->
                       	<div class="text-center">
                          <a class="button button-paypal" href="#">결제하기</a>
                        </div>
                    </div>
                   </form>
                </div>
            </div>
        </div>
    </div>
  </section>
  <!--================End Checkout Area =================-->
<!-- 주소 Modal -->
<div class="modal fade" id="exampleModalCenter1" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">주소를 새롭게 설정하시겠습니까?</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        마이페이지 > 개인 정보 수정으로 이동합니다. 
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" onclick="location.href='/carshop/userupdateform'">이동</button>
      </div>
    </div>
  </div>
</div>


<!-- 신용카드 결제 Modal -->
<div class="modal fade" id="exampleModalCenter2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
      <h5 class="modal-title" id="exampleModalLongTitle">결제를 진행하시겠습니까?</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        결제 수단: 신용카드 <br>결제 완료 후 구매이력창으로 이동합니다.
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-danger btn-creditchecks">결제하기</button>
      </div>
    </div>
  </div>
</div>

<!-- 카카오페이 결제 Modal -->
<div class="modal fade" id="exampleModalCenter4" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
      <h5 class="modal-title" id="exampleModalLongTitle">결제를 진행하시겠습니까?</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        결제 수단: 카카오페이 <br>결제 완료 후 구매이력창으로 이동합니다.
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-danger btn-creditcheck" id="kakaoPayCheck">결제하기</button>
      </div>
    </div>
  </div>
</div>


<!-- 구매 방법 Modal -->
<div class="modal fade" id="exampleModalCenter3" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
      <h5 class="modal-title" id="exampleModalLongTitle">구매방법을 결정하십시오</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        결제 수단을 선택하여 주십시오.
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
  
  <script src="/resources/vendors/jquery/jquery-3.2.1.min.js"></script>
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script> 
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script> 
  <script src="http://malsup.github.com/jquery.form.js"></script> 
  <!-- 결제수단 라디오 버튼 체크 확인 및 name 설정 (재원/20.12.22) -->
 	<script type="text/javascript">
			
 		$(document).ready(function(){
 			
 			
  		 	//jstl 을 javascript에서 사용, 실행 순서가 제일 느려서 사용가능 (재원/20.12.30)	
  			var totalPrice = ${col_sum};
			
  		 	<c:forEach items="${pUser}" var="pUser">	
  		 		var u_id = "${pUser.u_id}";
	  		 	var email= "${pUser.email}"; 					
	  		 	var name = "${pUser.name}";  					
	  		 	var phone = "${pUser.phone}";  					
	  		 	var address = "${pUser.addr}";		
  		 	</c:forEach> 
 			
  			$("input[type='radio']").on('change', function() {
  				//console.log("input[type='radio']들어오는지");
  				
 	  				if($('#f-option6').is(":checked")){
 	 					$('#f-option6').attr('name', 'pay');
 	 					$('#f-option5').removeAttr('name'); 
 	 					//console.log("카카오페이 체크");
 	 				}
 	 				if($('#f-option5').is(":checked")) {
 	 					$('#f-option5').attr('name', 'pay');
 	 					$('#f-option6').removeAttr('name');
 	 					//console.log("신용카드 체크");
 	 				}
 			}); 
  			
  			$('.button-paypal').click(function() {
  				
  				//구매 가격 제한을 둠 (재원/21.01.13)
  				if(0 < totalPrice && totalPrice < 10000000) {
  				
	  	  			if($('#f-option5').is(":checked")){
	  						$("#exampleModalCenter2").modal('show'); //신용카드결제 modal 창 보여줌 (재원/20.12.29)	
	  				}
	  				else if($('#f-option6').is(":checked")){
	  						$("#exampleModalCenter4").modal('show'); //카카오페이결제 modal 창 보여줌 (재원/20.12.29)
	  				}
	  				else {
	  					
	  					$("#exampleModalCenter3").modal('show'); //구매 방법 선택 modal창 띄움(재원/20.12.29)
	  					
	  				}
  					
  				}
  				else if(totalPrice <= 0){
      				Swal.fire({
        				  icon: 'error',
        				  title:'0원 이상부터 구매할 수 있습니다.',
        				  text: '물품이 선택되어 있는지 확인 부탁드립니다',      				  
        			});
  				}
  				else {
      				Swal.fire({
      				  icon: 'error',
      				  title:'한도초과',
      				  text: '10,000,000 이상은 구매할 수 없습니다.',      				  
      			});
  				}
  				
  			});
  			
  			
  			//form submit(재원/20.12.29)	
  			$('.btn-creditchecks').click(function() {
  				
  				if(totalPrice == 0) {
  					alert("구매하실 물품이 없습니다. 물품을 선택 후 구매해주세요");
  				}
  				else {
  					$('#checkoutform').submit(); 
  				}				
  				
  			});


  			
  		 	//iamport 일반 결제 api 사용 https://docs.iamport.kr/implementation/payment?lang=ko (재원/20.12.30)  		 	
  			$("#kakaoPayCheck").click(function() {
  				 	var form = $("form")[1];
  				 	var formData = new FormData(form);
  				 
	 		        var IMP = window.IMP; // 생략가능
	 		        IMP.init('imp20831122'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
	 		        var msg;
			   	IMP.request_pay({ // param
			            pg : 'kakaopay',
			            pay_method : 'kakaopay',
			            merchant_uid : 'merchant_' + new Date().getTime(),
			            name : '저리카 부품 결제',
			            amount : totalPrice,
			            buyer_email : email,
			            buyer_name : name,
			            buyer_tel : phone,
			            buyer_addr : address			           
			      }, function (rsp) { // callback
			    	 if ( rsp.success ) {

			        $('#checkoutform').submit();
			        
			      } else {
	 			        //alert("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
	 			        //location.href="checkout";
	      				Swal.fire({
	        				  icon: 'error',
	        				  title: '결제에 실패했습니다.',
	        				  text: rsp.error_msg,      				  
	        			});
     					
			      	}
			      
			      }); 
  			});
 		
 		});
 			
 		
  	</script>



  <!--================ Start footer Area  =================-->	

<%@ include file="../include/footer.jsp"%>