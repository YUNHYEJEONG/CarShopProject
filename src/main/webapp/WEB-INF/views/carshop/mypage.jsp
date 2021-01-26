<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%
   String sessId = (String)session.getAttribute("id");
%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html">
<!--  TITLE 삭제 2021.01.12 YHJ 개별 타이틀 속성 제공예정 -->
<title>저리카 | 마이페이지</title>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<link rel="shortcut icon" type="image/x-icon" href="/resources/img/papicon.png">
<!-- 파피콘 이미지 수정 2020/01/08 yunhj -->
<link rel="stylesheet"
   href="/resources/vendors/bootstrap/bootstrap.min.css">
<link rel="stylesheet"
   href="/resources/vendors/fontawesome/css/all.min.css">
<link rel="stylesheet"
   href="/resources/vendors/themify-icons/themify-icons.css">
<link rel="stylesheet"
   href="/resources/vendors/owl-carousel/owl.theme.default.min.css">
<link rel="stylesheet"
   href="/resources/vendors/owl-carousel/owl.carousel.min.css">
<link rel="stylesheet" href="/resources/vendors/linericon/style.css">

<link rel="stylesheet" href="/resources/css/style.css">
<link href='/resources/lib/main.css' rel='stylesheet' />
<!-- 달력 css -->
<script src='/resources/lib/main.js'></script>
<!-- 달력 js  -->
<script src="https://code.jquery.com/jquery-3.5.1.js" ></script>
<script> 
   $.ajax({
      url: '/carshop/headerAjax',
      type : 'get',
      dataType : "json",
       contentType: "application/json; charset=utf-8",
      success:function(data){
         if(data){
            console.log("header if완료완료");
         }else {
            console.log("header else완료");
            $('.nav-login').attr("style","show");
            $('.nav-logout').hide();
         }
      },
      error :function(){
         console.log("실패함");
      },
      complete : function(){
         console.log("ajax통신완료");
      }
   });
</script>
<script>
//제이쿼리와 스크립트 둘 다 사용하기 위해 가장 바깥쪽에 객체, 변수들 선언 -Monica 2020.12.31
var modal = document.getElementById('modalEvent'); 
var schdtitle = "";
var schdstart = "";
var schdend = "";
var calendar = null;
const open = () => {  //이클립스 버그로 빨간줄 뜰 때가 있지만 버그입니다. 실행 문제없이 잘 됨 -Monica 2020.12.31
    document.querySelector(".modalc").classList.remove("hiddenc");
  }

  const close = () => { //이클립스 버그로 빨간줄 뜰 때가 있지만 버그입니다. 실행 문제없이 잘 됨 -Monica 2020.12.31
    document.querySelector(".modalc").classList.add("hiddenc");
  }
  
   
       /* 달력 실행을 위한 스크립트 */
      document.addEventListener('DOMContentLoaded', function() {
         var calendarEl = document.getElementById('calendar');

         calendar = new FullCalendar.Calendar(calendarEl, {
            //initialDate : '2020-12-17',
            editable : true,
            selectable : true,
            businessHours : true,
            navLinks : true,
            dayMaxEvents : true, // allow "more" link when too many events
            headerToolbar : {
               left : 'prev,next today',
               center : 'title',
               right : 'dayGridMonth,timeGridDay'
            },
            selectMirror : true,
            select : function(arg) {  //달력 날짜칸이 눌렸을 때 -Monica 2020.12.31
               /* console.log("arg start: " + arg.start);
               console.log("arg end: " + arg.end);
               console.log("arg allday: " + arg.allDay); */
               
               var syear = arg.start.getFullYear();  //년도 추출
               var smonth = arg.start.getMonth() + 1;  //월 추출
               var sday = arg.start.getDate();  //일 추출
               var stime = arg.start.toTimeString().substring(0,8);  //시간 추출
               if(smonth < 10){
                  smonth = '0' + smonth;
               }
               if(sday < 10){
                  sday = '0' + sday;
               }
               console.log('sday: ' + sday);
               schdstart = syear+ "-" + smonth + "-" + sday + " " + stime;  //맞는 형식으로 재조합
               schdend = arg.end;
               
               //console.log(schdstart);
               document.getElementById('schdstart').value = schdstart;  //재조합 한 시작일을 모달창 form에 주입 -Monica 2020.12.31
               document.getElementById('schdtitle').value = '';  //일정제목 부분 리셋 -Monica 2020.12.31
               
               
                 open();  //모달창 오픈
                 
                  document.querySelector(".bgc").addEventListener("click", close);  //모달 창 배경이 클릭되면 아무 실행 없이 닫음 -Monica 2020.12.31
                  document.querySelector(".closeBtnc2").addEventListener("click", close);  //모달 창 배경이 클릭되면 아무 실행 없이 닫음 -Monica 2020.12.31

                  calendar.unselect() //달력 클릭 취소됨
            },
            eventClick : function(arg) {  //일정이 클릭되면
               //console.log('선택된 일정 제목: ' + arg.event.title);
               var evttitle = arg.event.title;  //일정 제목 추출
               if (confirm('이 일정을 삭제하겠습니까?')) {  //확인이 눌리면 밑에 페이지 이동 실행 + 일정 삭제 실행 -Monica 2020.12.31
                  //console.log("주소: " + "/carshop/delschd?u_id=<c:out value='${idcal}' />&schdtitle=" +  evttitle);
                  location.replace("/carshop/delschd?u_id=<c:out value='${idcal}' />&schdtitle=" +  evttitle);
                  //arg.event.remove();
               }
            },
            events : [ {  //상관 없음 보여주기 식 부분 ~139줄 -Monica 2020.12.31
               title : 'All Day Event',
               start : '2020-09-01'
            }, {
               title : 'Long Event',
               start : '2020-09-07',
               end : '2020-09-10'
            }, {
               groupId : 999,
               title : 'Repeating Event',
               start : '2020-09-09T16:00:00'
            }, {
               groupId : 999,
               title : 'Repeating Event',
               start : '2020-09-16T16:00:00'
            }, {
               title : 'Conference',
               start : '2020-09-11',
               end : '2020-09-13'
            }, {
               title : 'Meeting',
               start : '2020-09-12T10:30:00',
               end : '2020-09-12T12:30:00'
            }, {
               title : 'Lunch',
               start : '2020-09-12T12:00:00'
            }, {
               title : 'Meeting',
               start : '2020-09-12T14:30:00'
            }, {
               title : 'Happy Hour',
               start : '2020-09-12T17:30:00'
            }, {
               title : 'Dinner',
               start : '2020-09-12T20:00:00'
            }, {
               title : 'Birthday Party',
               start : '2020-09-13T07:00:00'
            }, {
               title : 'Click for Google',
               url : 'http://google.com/',
               start : '2020-09-28'
            } ]
         });

         calendar.render();  //달력 출력
         
         
         document.querySelector(".closeBtnc").addEventListener("click", function() { //모달의 입력 버튼이 눌리면 -Monica 2020.12.31
              schdtitle = document.getElementById('schdtitle').value;  //입력한 일정제목 값 가져옴
              /* schdtitle = document.getElementById('schdtitle').value;
              schdtitle = document.getElementById('schdtitle').value; */
              var schdstart2 = schdstart.substring(0,10) + "T" + schdstart.substring(11);  //시작시간 값 가져와서 재조립
              schdtitle = document.getElementById('schdtitle').value; //
               
              //일정 마감일 각각 select 값 가져와서 맞는 형식ㅇ로 재조립 -Monica 2020.12.31
              schdend = document.getElementById('cal_year').value + "-" + document.getElementById('cal_month').value
                          + "-" + document.getElementById('cal_day').value + "T" + "23:59:59"; 
              
               //console.log(schdtitle);
               //console.log("arg2 start: " + schdstart2);
               //console.log("arg2 end: " + schdend);
               //console.log("arg2 allday: " + true);
               
               //console.log("syear:" + schdstart);
               //console.log("smonth:" + schdstart);
               //console.log("sday:" + schdstart);
               //console.log("stime:" + schdstart);
               
               
               if (schdtitle) {  //일정제목이 들어왔을 때
                  calendar.addEvent({  //캘린더api 메서드, 달력에 입력된 일정 출력 -Monica 2020.12.31
                     title : schdtitle,
                     start : schdstart2,
                     end : schdend
                  });
                  //console.log("스케쥴 start:" + schdstart);
                  //console.log("스케쥴 end: " + schdend);
                  
                  
               }
               
               
               calendar.unselect();  //달력 선택 취소
               close();  //모달 창 닫음 -Monica 2020.12.31
               
         });
      });  //달력 끝 -Monica 2020.12.31
       
       $(document).ready(function() {  //제이쿼리 동작을 위한 구역 -Monica 2020.12.31
          
          <c:forEach items='${schedules}' var="schd">//db에서 가져온 아이디에 해당하는 일정 반복문으로 달력에 입력 -Monica 2020.12.31
          //console.log('${schd.schdtitle}:${schd.schdstart}:${schd.schdend}');
             calendar.addEvent({
               title : "<c:out value='${schd.schdtitle}' />",
               start : "<c:out value='${schd.schdstart}' />",
               end : "<c:out value='${schd.schdend}' />"
            });
          </c:forEach>
          
         var askprint = $(".askhere");
         showaskList(1);  //기본적으로 첫번째 페이지 출력 -성연 2021.01.07
         
         function showaskList(pageNum) { //아이디에 따른 문의글 목록 출력 -성연 2021.01.07
            getasklist({pageNum: pageNum || 1}, function(askCnt, askList) {  //콜백, json데이터가 잘 받아졌을 경우에 -성연 2021.01.07
               //console.log("askCnt: " + askCnt);
               var str = '';
               str += '<h3 class="widget_title"style="padding-top: 20px; padding-bottom: 20px">문의 내역</h3>'; //반복출력 전 맨 위에 한번 추가 
               for(var i = 0; i < askList.length; i++){
                  str += '<div class="media post_item">';
                  str += '<img class="prod_pic" src="/resources/img/upload/' + askList[i].img1 + '"alt="post">';  //문의를 남긴 상품의 사진 -성연 2021.01.07
                  str += '<div class="media-body">';
                  str += '<a href="/carshop/product/details?p_no=' + askList[i].p_no + '"><h3>' + askList[i].ask_title + '</h3></a>';  //문의제목에 상품detail로 가는 링크 -성연 2021.01.07
                  str += '<p>' + askList[i].ask_date + '</p></div></div>';
               }
               
               str += '<div class="br"></div>';  //목록글을 출력 한 후 마지막에 추가
               askprint.html(str);
               //console.log(str);
               showAskPage(askCnt);  //문의 페이징 풀력
               
            });
         }
         
         
         
         function getasklist(param, callback, error) {
            var pageNum = param.pageNum || 1;
         
            $.getJSON("/carshop/asklistget.json?pageNum=" + pageNum, //get json data through written url with pageNum -SungYeon 20.12.23
               function(data) {
                  if(callback){
                     callback(data.askCnt, data.askList);  //when success, call callback fn with count no and list of json data -SungYeon 20.12.23
               }
            }).fail(function(xhr, status, err) { //if fail
               if(error){
                  error();
               }
            });
         }
         
         var pageNum =1;
         var askpageFooter = $(".ask_list_page");
         function showAskPage(askCnt) {  //문의페이징출력 -성연 2021.01.07
            var endNum = Math.ceil(pageNum/5.0)*5; //다섯페이지 단위로 끊음 -성연 2021.01.07
            var startNum = endNum -4;
            
            var prev = startNum != 1;
            var next = false;
            
            if(endNum*4 >= askCnt){  //한 페이지당 문의글 4개이기때문에 *4 -성연 2021.01.07
               endNum = Math.ceil(askCnt/4.0);
            }
            if(endNum*4 < askCnt){
               next = true;
            }
            
            var str = "<ul class='pagination pull-right'>";
            
            if(prev){ //if previous page exists
               str += "<li class='page-item'><a class='page-link' href='" + (startNum -1) + "'>Previous</a></li>";
            }
            
            for(var i = startNum; i<=endNum; i++){
               var active = pageNum == i? "active" : ""; //make current page active
               
               str += "<li class='page-item " + active + "'><a class='page-link' href='" + i + "'>"+ i +"</a></li>";
            }
            
            if(next){ //if next page exists
               str += "<li class='page-item'><a class='page-link' href='" + (endNum +1) + "'>Next</a></li>";
            }
            str += "</ul>" //close ul
            askpageFooter.html(str);
         }
         
         askpageFooter.on("click", "li a", function(e) {  //페이징 번호가 클릭되면 문의목록페이지 이동 -성연 2021.01.07
            e.preventDefault();
            
            console.log("page clicked");
            var targetPageNum = $(this).attr("href");
            
            pageNum = targetPageNum;
            showaskList(pageNum);
         });
         
         
         
         
         
         
      });
       
</script>
<style>
body {
   margin: 40px 10px;
   padding: 0;
   font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
   font-size: 14px;
}

#calendar { /* 달력 크기 */
   max-width: 750px;
   margin: 0 auto;
}

button {
   background-color: #F9B514;
   padding: 5px 10px;
   border-radius: 4px;
   cursor: pointer;
}

/* 이하는 모달 설정 */
.modalc {
   position: fixed;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%;
   display: flex;
   justify-content: center;
   align-items: center;
   z-index: 5;
}

.modalc .bgc {
   width: 100%;
   height: 100%;
   background-color: rgba(0, 0, 0, 0.6);
}

.modalBoxc {
   position: absolute;
   background-color: #fff;
   width: 400px;
   height: 200px;
   padding: 15px;
}

.modalBoxc button {
   display: block;
   width: 80px;
   margin: 0 auto;
}

.hiddenc {
   display: none;
}

.prod_pic {
   height: 60px;
   width: 100px;
}

.searchbar {
   margin-bottom: auto;
   margin-top: auto;
   height: 60px;
   background-color: #353b48;
   border-radius: 30px;
   padding: 10px;
}

.search_input {
   color: white;
   border: 0;
   outline: 0;
   background: none;
   width: 0;
   caret-color: transparent;
   line-height: 40px;
   transition: width 0.4s linear;
}

.searchbar:hover>.search_input {
   padding: 0 10px;
   width: 450px;
   caret-color: red;
   transition: width 0.4s linear;
}

.searchbar:hover>.search_icon {
   background: white;
   color: #e74c3c;
}

.search_icon {
   height: 40px;
   width: 40px;
   float: right;
   display: flex;
   justify-content: center;
   align-items: center;
   border-radius: 50%;
   color: white;
   text-decoration: none;
}
.header_area .main_menu .navbar .container .collapse .nav-right{
   display : flex;
   align-items : center;
}
.header_area .main_menu .navbar .container .collapse .nav-right .nav-log .nav-login {
   margin-top : 20px;
   margin-bottom : 20px;
}
</style>

</head>

<body>
<!--  Modal -->
   <div class="modalc hiddenc">
      <div class="bgc"></div>
      <div class="modalBoxc">
         <p>모달창입니다.</p>
         <form action="/carshop/insert" method="post" id="calform">  <!-- 일정 입력을 위한 폼 -Monica 2020.12.31 -->
            <input type="hidden" name="u_id" value='<c:out value="${idcal }" />'>  <!-- 유저아이디 hidden -->
            일정 제목: <input type="text" name="schdtitle" id="schdtitle"><br>
            시작일: <input type="text" name="schdstart" id="schdstart" readonly><br>
            마감일:<br>
            <select name="cal_year" id="cal_year">  <!-- 연도 선택 -->
               <option value="2021">2021</option>
               <option value="2022">2022</option>
               <option value="2020">2023</option>
            </select>
            <select name="cal_month" id="cal_month"> <!-- 달 선택 -->
               <option value="01">Jan</option>
               <option value="02">Feb</option>
               <option value="03">Mar</option>
               <option value="04">Apr</option>
               <option value="05">May</option>
               <option value="06">Jun</option>
               <option value="07">Jul</option>
               <option value="08">Aug</option>
               <option value="09">Sep</option>
               <option value="10">Oct</option>
               <option value="11">Nov</option>
               <option value="12">Dec</option>
            </select>
            <select name="cal_day" id="cal_day"> <!-- 날짜 선택 -->
               <option value="01">1</option>
               <option value="02">2</option>
               <option value="03">3</option>
               <option value="04">4</option>
               <option value="05">5</option>
               <option value="06">6</option>
               <option value="07">7</option>
               <option value="08">8</option>
               <option value="09">9</option>
               <option value="10">10</option>
               <option value="11">11</option>
               <option value="12">12</option>
               <option value="13">13</option>
               <option value="14">14</option>
               <option value="15">15</option>
               <option value="16">16</option>
               <option value="17">17</option>
               <option value="18">18</option>
               <option value="19">19</option>
               <option value="20">20</option>
               <option value="21">21</option>
               <option value="22">22</option>
               <option value="23">23</option>
               <option value="24">24</option>
               <option value="25">25</option>
               <option value="26">26</option>
               <option value="27">27</option>
               <option value="28">28</option>
               <option value="29">29</option>
               <option value="30">30</option>
               <option value="31">31</option>
            </select>
             <br>
             <div style="pull-right; padding-left: 100px;">
             <button class="closeBtnc" type="submit" style="display: inline-block;">입력</button>
            <button class="closeBtnc2" type="button" style="display: inline-block;">닫기</button>
             </div>
            
         </form>
      </div>
   </div>
   <!-- /.modal -->
   
   <!--================ Start Header Menu Area =================-->
   <header class="header_area">
      <div class="main_menu">
         <nav class="navbar navbar-expand-lg navbar-light">
            <div class="container">
               <a class="navbar-brand logo_h" href="/carshop/index"><img src="/resources/img/logo3.png" alt="로고" style= "width: 70px; height: 70px;"></a>

               <!-- yun.hj 2020.01.07 logo img change & 규격이 상이해서 style 추가 함 -->
               <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
               </button>
               <div class="collapse navbar-collapse offset" id="navbarSupportedContent">
                  <ul class="nav navbar-nav menu_nav ml-auto mr-auto">
                     <li class="nav-item"><a class="nav-link" href="/carshop/index">Home</a></li>
                     <li class="nav-item"><a class="nav-link" href="/carshop/productList">Shop</a></li>
                       <li class="nav-item submenu dropdown">
<% 
   if("admin".equals(sessId)){
%>
                            <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                           aria-expanded="false">Admin</a>
<%
   }
%>
                     <ul class="dropdown-menu">
                           <li class="nav-item"><a class="nav-link" href="/carshop/blacklist">Black List</a></li>
                           <li class="nav-item"><a class="nav-link" href="/carshop/annclist">Announcement</a></li>
                    </ul>      
                     
                     <!--  컨탠츠랑 mypage 위치 수정 2021.01.11 -->
<%
   if(sessId != null){
%>                     
                     <li class="nav-item"><a class="nav-link" href="/carshop/mypage">Mypage</a></li>
<%
}else {
%>
                     <li class="nav-item"><a class="nav-link" href="login">Mypage</a></li>
<%
}
%>
                  
                  </ul>

                  <div class="nav-right">
                     <ul class="nav-shop">
                        <li class="nav-item"><a href="/carshop/cart"><button><i class="ti-shopping-cart"></i><span class="nav-shop__circle"></span></button></a></li>
                     </ul><!-- yun.hj 2020/01/07 장바구니 경로 설정 -->
                        <!-- uin.hj 2020/01/08 mypage, home, shop, contact 경로 설정 -->
                        <!-- 결로 버그 수정 2021.01.11 hyejeong -->
                     <div class="nav-log">
                        <div class="nav-login" style="position:relative; visibility:hidden"><a class="button button-header" href="/carshop/login" >login</a></div>
                        <div class="nav-logout" style="position:relative; left : 0px; top:-50px;"><a class="button button-header"  href="/carshop/logout" >logout</a></div>
                     </div>
                  </div>
               </div>
            </div>
         </nav>
      </div>
   </header>

   <!-- ================ start banner area ================= -->
   <section class="blog-banner-area" id="blog">
   <img class="img-fluid" src="/resources/img/cart/title.png" alt="배너"
      style="position: absolute; top: 0; left: 0; width: 100%; height: 100%" />
      <div class="container h-100">
         <div class="blog-banner">
            <div class="text-center">
               <h1>My Page</h1>
               <nav aria-label="breadcrumb" class="banner-breadcrumb">
                  <ol class="breadcrumb">
                     <li class="breadcrumb-item"><a href="#">마이 페이지</a></li>
                  </ol>
               </nav>
            </div>
         </div>
      </div>
   </section>
   <!-- ================ end banner area ================= -->


   <!--================Blog Categorie Area =================-->
   <section class="blog_categorie_area">
      <div class="container">
         <div class="row">
            <div class="col-sm-6 col-lg-4 mb-4 mb-lg-0">
               <div class="categories_post">
                  <img class="card-img rounded-0"
                     src="/resources/img/blog/cat-post/cat-post-3.jpg" alt="post">
                     <!-- 셀러인 경우 또는 유저인 경우 -성연 2021.01.07 -->
                  <c:choose>
                     <c:when test="${status == 'seller' }">  
                        <div class="categories_details" onclick="location.href='/carshop/bsnspage'">
                           <div class="categories_text">
                              <h5>My Business</h5>
                              <div class="border_line"></div>
                              <p>내 사업정보 관리하기</p>
                           </div>
                        </div>
                     </c:when>
                     <c:when test="${status == 'user' }">
                        <div class="categories_details" onclick="location.href='/carshop/mycar'">
                           <div class="categories_text">
                              <h5>My Car</h5>
                              <div class="border_line"></div>
                              <p>내 차 정보 관리하기</p>
                           </div>
                        </div>
                     </c:when>
                  </c:choose>
               </div>
            </div>
            <div class="col-sm-6 col-lg-4 mb-4 mb-lg-0">
               <div class="categories_post">
                  <img class="card-img rounded-0"
                     src="/resources/img/blog/cat-post/cat-post-2.jpg" alt="post">
                  <c:choose>
                     <c:when test="${status == 'seller' }">
                        <div class="categories_details" onclick="location.href='/carshop/salelist'">
                           <div class="categories_text">
                              <h5>내 판매 목록</h5>
                              <div class="border_line"></div>
                              <p>판매목록 관리하기</p>
                           </div>
                        </div>
                     </c:when>
                     <c:when test="${status == 'user' }">
                        <div class="categories_details" onclick="location.href='/carshop/cart'">
                           <div class="categories_text">
                              <h5>장바구니</h5>
                              <div class="border_line"></div>
                              <p>장바구니 관리하기</p>
                           </div>
                        </div>
                     </c:when>
                  </c:choose>
               </div>
            </div>
            <div class="col-sm-6 col-lg-4 mb-4 mb-lg-0">
               <div class="categories_post">
                  <img class="card-img rounded-0"
                     src="/resources/img/blog/cat-post/cat-post-1.jpg" alt="post">
                  <c:choose>
                     <c:when test="${status == 'seller' }">
                        <div class="categories_details" onclick="location.href='/carshop/return_end'">
                           <div class="categories_text">
                              <h5>교환반품</h5>
                              <div class="border_line"></div>
                              <p>교환반품 관리</p>
                           </div>
                        </div>
                     </c:when>
                     <c:when test="${status == 'user' }">
                        <div class="categories_details" onclick="location.href='/carshop/confirmation'">
                           <div class="categories_text">
                              <h5>주문 이력</h5>
                              <div class="border_line"></div>
                              <p>교환/반품하기</p>
                           </div>
                        </div>
                     </c:when>
                  </c:choose>
               </div>
            </div>
         </div>
      </div>
   </section>
   <!--================Blog Categorie Area =================-->

   <!--================Blog Area =================-->
   <section class="blog_area">
      <div class="container">
         <div class="row">
            <div class="col-lg-8">
               <div class="blog_left_sidebar">
                  <div id='calendar'></div>
                  <!-- 달력생성 -->
                  
                  
                  <article class="row blog_item">
                     <!-- 이곳에 문의 목록 출력 -성연 2021.01.07 -->
                     <div class="askhere">
                        <h3 class="widget_title"
                           style="padding-top: 20px; padding-bottom: 20px">문의 내역</h3><div class="br"></div>
                        <div class="br"></div>
                     </div>
                     
                  </article>
                  <div class="ask_list_page pull-right" style="float : right"> <!-- showing page numbers -SungYeon 20.12.23 -->
                     </div>
               </div>
               
            </div>
            <div class="col-lg-4">
               <div class="blog_right_sidebar">
                  <aside class="single_sidebar_widget author_widget">
                     <!-- 회원프로필 -->
                       <!-- 셀러/일반유저 아이콘 표시 -성연 2021.01.07 -->
                     <c:choose>
                        <c:when test="${status == 'seller' }"><img class="author_img rounded-circle"  
                        src="/resources/img/sellericon.png" alt="" style="width: 200px; height: 200px"></c:when>
                           <c:when test="${status == 'user' }"><img class="author_img rounded-circle"  
                        src="/resources/img/buyericon.png" alt="" style="width: 200px; height: 200px"></c:when>
                     </c:choose>
                     <h4 class='username'><c:out value="${userinfo.name }"></c:out> </h4>  <!-- 유저 이름 표시 -->
                     <p class='userstatus'>
                     <!-- 판매회원은 상호명 같이 표시 -성연 2021.01.07 -->
                        <c:choose>
                           <c:when test="${status == 'seller' }">판매회원+<c:out value="${userinfo.b_name }" /></c:when> 
                           <c:when test="${status == 'user' }">일반회원</c:when>
                        </c:choose> </p>
                     <div class="social_icon">
                        <a href="/carshop/userupdateform"> <i class="fas fa-user"></i> 계정정보 수정하기
                        </a> 
                        <c:choose>
                           <c:when test="${status == 'seller' }">
                              <a href="/carshop/productForm"> <i class="fas fa-sticky-note"></i> 판매글쓰기
                        </a>
                           </c:when>
                           <c:when test="${status == 'user' }">
                              <a href="/carshop/like"> <i class="fas fa-heart"></i> 찜
                           목록
                        </a>
                           </c:when>
                        </c:choose>
                        
                     </div>
                     <div class="br"></div>
                  </aside>
                  <aside class="single_sidebar_widget popular_post_widget">
                     <!-- best상품 창 -->
                     <h3 class="widget_title">베스트조회수 상품</h3>
                     <c:forEach items="${bestpord }" var="best">  <!-- 조회수 순으로 4개 뽑아온 상품목록 반복문으로 출력 -성연 2021.01.07 -->
                        <div class="media post_item">
                           <img src="/resources/img/upload/${best.img1 }" alt="post" style="width: 100px; height: 60px">
                           <div class="media-body">
                              <a href="/carshop/product/details?p_no=${best.p_no }">
                                 <h3><c:out value="${best.p_name }" /></h3>
                              </a>
                              <br>
                              <p>클릭 수: <c:out value="${best.hit }" /></p>
                           </div>
                        </div>
                     </c:forEach>
                     <div class="br"></div>
                  </aside>
               </div>
            </div>
         </div>
      </div>
   </section>
   <!--================Blog Area =================-->

   <!--================Instagram Area =================-->
   <section class="instagram_area">
      <div class="container box_1620">
         <div class="insta_btn">
            <a class="btn theme_btn" href="#"></a>
         </div>
         <div class="instagram_image row m0">
            <br><br><br><br><br><br>
         </div>
      </div>
   </section>
   <!--================End Instagram Area =================-->



   <!-- 불필요한 플러그인, api사용을 방지하기 위한 include폴더에 있는 footer.jsp로부터 독립적인 footer구역입니다. include/footer.jsp의 내용이 갱신됐을 때
            성연이에게 알려주세요 -Monica 2020.12.31 -->
   <!--================ Start footer Area  =================-->
   <footer class="footer">
   <div class="footer-area">
      <div class="container">
         <div class="row section_gap">
            <div class="col-lg-3 col-md-6 col-sm-6">
               <div class="single-footer-widget tp_widgets">
                  <h4 class="footer_title large_title">집콕코딩단</h4>
                  <p>Green Academy 출신, 7명의 수석 개린이들이 창단한 집콕코딩단. 창의적인 아이디어와 실력을
                     겸비하여 '저리카SHOP' 기획, 개발했다.</p>

               </div>
            </div>
            <div class="offset-lg-1 col-lg-2 col-md-6 col-sm-6">
               <div class="single-footer-widget tp_widgets">
                  <h4 class="footer_title">Quick Links</h4>
                  <ul class="list">
                     <li><a href="index">Home</a></li>
                     <li><a href="productList">Shop</a></li>
                     <li><a href="mypage">MyPage</a></li>
                     <li><a href="#">Contact</a></li>
                  <!-- 2020/01/08 yun.hj 경로설정 -->
                  </ul>
               </div>
            </div>
            <div class="col-lg-2 col-md-6 col-sm-6">
               <div class="single-footer-widget instafeed">
                  <h4 class="footer_title">member</h4>
                  <ul class="list instafeed d-flex flex-wrap">
                     <li>신승원</li>
                     <li>박재원</li>
                     <li>김보군</li>
                     <li>박성연</li>
                     <li>이보미</li>
                     <li>노가빈</li>
                     <li>윤혜정</li>
                  </ul>
               </div>
            </div>
            <div class="offset-lg-1 col-lg-3 col-md-6 col-sm-6">
               <div class="single-footer-widget tp_widgets">
                  <h4 class="footer_title">Contact Us</h4>
                  <div class="ml-40">
                     <p class="sm-head">
                        <span class="fa fa-location-arrow"></span> Head Office
                     </p>
                     <p>경기도 성남시 JIP.CO.K codingdan company 2층</p>

                     <p class="sm-head">
                        <span class="fa fa-phone"></span> INSTAGRAM
                     </p>
                     <p>
                        @jipcok <br>  Fax.0504-093-7765
                     </p>

                     <p class="sm-head">
                        <span class="fa fa-envelope"></span> Email
                     </p>
                     <p>
                        findme0@naver.com <br> www.jipcokcodingdan.com
                     </p>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>

   <div class="footer-bottom">
      <div class="container">
         <div class="row d-flex">
            <p class="col-lg-12 footer-text text-center">
               <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
               Copyright &copy;
               <script>
                  document.write(new Date().getFullYear());
               </script>
               All rights reserved | This template is made with by JIPCOK 
               <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
            </p>
         </div>
      </div>
   </div>
</footer>
<!--================ End footer Area  =================-->



<script src="/resources/vendors/jquery/jquery-3.2.1.min.js"></script>
<script src="/resources/vendors/bootstrap/bootstrap.bundle.min.js"></script>
<script src="/resources/vendors/skrollr.min.js"></script>
<script src="/resources/vendors/owl-carousel/owl.carousel.min.js"></script>
<script src="/resources/vendors/jquery.ajaxchimp.min.js"></script>
<script src="/resources/vendors/mail-script.js"></script>
<script src="/resources/js/main.js"></script>
</body>
</html>