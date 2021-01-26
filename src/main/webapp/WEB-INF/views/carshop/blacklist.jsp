<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../include/header.jsp"%>

<!-- 전체적인 구조는 결제내역 테이블과 같음 -SungYeon 20.12.23-->
	<title>Aroma Shop</title>
	<link rel="stylesheet" href="/resources/vendors/linericon/style.css">
	<link rel="stylesheet" href="/resources/vendors/nouislider/nouislider.min.css">
	
	<!-- ================ start banner area ================= -->	
	<section class="blog-banner-area" id="category">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<h1>블랙리스트</h1>
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">불량판매자를 조회합니다.</a></li>
            </ol>
          </nav>
				</div>
			</div>
    </div>
	</section>
	<!-- ================ end banner area ================= -->
  
  <!--================Order Details Area =================-->
  <section class="order_details section-margin--small">
    <div class="container">
      <p class="text-center billing-alert">불량판매자 블랙리스트</p>

      <div class="order_details_table">
        <h2>상세정보</h2>
        <div class="table-responsive">
          <table class="table">
            <thead>
              <tr>
              	<th scope="col"></th>
                <th scope="col">판매자</th>
                <th scope="col">날짜</th>
                <th scope="col">리스트내리기</th>
                <th scope="col">계정삭제</th>
              </tr>
            </thead>
            <tbody class="blk_list">
               <c:forEach items="${blkcnt}" var ="no">  <!-- making table format (10) using jstl -->
                    <tr class="list_tr" id="${no }"> <!-- will be found by class and id and get s_id in name attr from script -SungYeon 20.12.23-->
                      <td></td>                    
                      <td class="s_id" id="${no }"></td> <!-- will be found by class and id and get <p> from script -SungYeon 20.12.23 -->
                      <td class="date" id="${no }"></td> <!-- will be found by class and id and get <p> from script -SungYeon 20.12.23 -->
                      <td><button id="removebtn" onclick="">내리기</button></td> <!-- btn to call removeblk() -SungYeon 20.12.23 -->
                      <td><button id="deletebtn" onclick="">삭제</button></td> <!-- btn to call deleteblk() -SungYeon 20.12.23 -->
                   </c:forEach> 
            </tbody>
          </table>
        </div>
      </div>
           <div class="blk_list_page pull-right" style="float : right"> <!-- showing page numbers -SungYeon 20.12.23 -->

  	</div>
    </div>

  </section>
  <!--================End Order Details Area =================-->

	
<script src="/resources/vendors/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("title").html("저기 카 | BlackList");
		
		var blklist = $(".blk_list");  //tbl query object to list json data -SungYeon 20.12.23
		
		showList(1); //list 1st page data -SungYeon 20.12.23
		
		function showList(pageNum) { //showing json data my page -SungYeon 20.12.23
			
			ajaxService.getblklist({pageNum: pageNum || 1}, function (blkCnt, list) {  //parameter: pageNum or 1, callback fn
				
 				if(pageNum == -1){ //if pageNum is negative, 
					pageNum = Math.ceil(blkCnt/10.0); //get last page number
					showList(pageNum); //go to last page -SungYeon 20.12.23
					return;
				}
				
				var str = "";
				
				if(list == null || list.length == 0){ 
					$("td.s_id #" + i +"").append($(""));
					$("td.date #" + i +"").append($(""));
					return;
				}
				
 				for(var i = 0; i<10; i++){ //when page changes, reset showing td of s_id and date -SungYeon 20.12.23
					$("td#" + i +".s_id").html(""); //resetting first 
					$("td#" + i +".date").html(""); //resetting first

					$("tr#" + i +".list_tr").attr("name", ""); //resetting first
				}
				
				for(var i = 0, len = list.length || 0; i<len; i++){ //printing black list json data from ajax method result -SungYeon 20.12.23
					$("tr#" + i +".list_tr").attr("name", list[i].s_id); //set name attr of each tr with s_id
					
					$("td#" + i +".s_id").append("<p>" + list[i].s_id + "</p>"); //print s_id
					$("td#" + i +".date").append("<p>" + list[i].date + "</p>"); //print date -SungYeon 20.12.23
					
				}
				
                showBlkPage(blkCnt); //show paging result from ajax result -SungYeon 20.12.23
				
				
			});
		}
		

		
		
		var pageNum = 1;
		var blkpageFooter = $(".blk_list_page"); //footer div that will show page numbers
		function showBlkPage(blkCnt) { //fn to calculate pages depending on total cnt of black list data
			var endNum = Math.ceil(pageNum/10.0)*10; //same concept as book page p.440 -SungYeon 20.12.23
			var startNum = endNum - 9;
			
			var prev = startNum != 1;
			var next = false;
			
			if(endNum*10 >= blkCnt){
				endNum = Math.ceil(blkCnt/10.0);
			}
			if(endNum*10 < blkCnt){
				next = true;
			}
			
			var str = "<ul class='pagination pull-right'>"; //will create ul tag to cover li tags below -SungYeon 20.12.23
			
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
			
			blkpageFooter.html(str);  //print footer page numbers
			
			
		}
		
		blkpageFooter.on("click", "li a", function(e) { //when page number is clicked -SungYeon 20.12.23
			e.preventDefault();
			
			console.log("page click");
			var targetPageNum = $(this).attr("href"); //get number from a tag
			 
			pageNum = targetPageNum;
			
			showList(pageNum); //reset page data with new page number -SungYeon 20.12.23
			
		});
		
   		
   		$(document).on("click", "#removebtn", function() { //when remove btn is clicked -SungYeon 20.12.23
   			var link = $("li.active").text();
   			var link2 = link.substring(4); //get current page number
   			console.log(link2);
			console.log($(this).closest("tr").attr("name"));  
 			var dels_name = $(this).closest("tr").attr("name"); //get closest tr's name, which is s_id -SungYeon 20.12.23
			console.log("dels_name: " + dels_name);
  			ajaxService.remove(dels_name, function(result) { //call ajax with parameter s_id to remove
				console.log(result);
				/* showList(1); */
				showList(link2); //if success, stay on the same page, but refreshed -SungYeon 20.12.23
			});
  			
  			
			
 			return false; //to let other btns can be clicked -SungYeon 20.12.23
		});
   		
   		$(document).on("click", "#deletebtn", function() {  //same and removebtn click event above -SungYeon 20.12.23
   			var link = $("li.active").text();
   			var link2 = link.substring(4);
   			console.log(link2);
			console.log($(this).closest("tr").attr("name")); 
 			var dels_name = $(this).closest("tr").attr("name");
			console.log("dels_name: " + dels_name);
  			ajaxService.blkdelete(dels_name, function(result) {
				console.log(result);
				/* showList(1); */
				showList(link2);
			});
  			
  			
			
 			return false;
		});
		

		
		
		
	}); //end of $(document).ready
	
	var ajaxService = (function() {  //js group of ajax methods to be called -SungYeon 20.12.23
		function getblklist(param, callback, error) {
			var pageNum = param.pageNum || 1;
			
			$.getJSON("/carshop/blacklista.json?pageNum=" + pageNum, //get json data through written url with pageNum -SungYeon 20.12.23
				function(data) {
					if(callback){
						callback(data.blkCnt, data.blklist);  //when success, call callback fn with count no and list of json data -SungYeon 20.12.23
					}
				}).fail(function(xhr, status, err) { //if fail
					if(error){
						error();
					}
				});
		}
		
		function remove(s_id, callback, error) { //remove id from black tbl -SungYeon 20.12.23
			$.ajax({
				type: 'delete',  //restAPI type
				url: '/carshop/blkremove/' + s_id,  //process through this url with s_id -SungYeon 20.12.23
													//특수문자 포함한 아이디도 문제 없이 전달되도록 jsp, 컨트롤러 수정 -성연 20.01.12
				success: function(deleteResult, status, xhr) {
					if(callback){
						callback(deleteResult);
					}
				},
				error: function(xhr, status, er) {
					if(error){
						error(er);
					}
				}
				
			});
		}
		
		function blkdelete(s_id, callback, error) {  //same as remove() above -SungYeon 20.12.23
			$.ajax({
				type: 'delete',
				url: '/carshop/blkdelete/' + s_id,
				success: function(deleteResult, status, xhr) {
					if(callback){
						callback(deleteResult);
					}
				},
				error: function(xhr, status, er) {
					if(error){
						console.log(er);
					}
				}
				
			});
		}
		
		return {
			getblklist: getblklist,
			remove: remove,
			blkdelete: blkdelete};
	})();
</script>
<%@ include file="../include/footer.jsp"%>