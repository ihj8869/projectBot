<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<title>아름다운가게 재고관리시스넴</title>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/1.11.8/semantic.min.css"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/1.11.8/semantic.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	if($("#id").val()==''){
		alert('세션이 종료되었습니다. 다시 로그인해주세요.');
		document.location.href="/index.jsp"
	}
	$(".isDel").children().next().each(function(){ //삭제된 회원은 빨갛게
		if($(this).val()=='Y'){
			$(this).parent().parent().attr('class','error');
			$(this).parent().next().next().next().next().next().next().children().next().text('복구');
		}
	});
	
	$("#sidebar").click(function(){ //사이드바 클릭시
		$('.ui.labeled.icon.sidebar').sidebar('toggle');
	});
	
	search = function(){ //코드이름으로 검색
		var name = $("#searchName").val();
		var use = $("#searchUse").val();
		
		document.location.href="Code.do?name="+name+"&use="+use;
	};
	
	$("#search").click(function(){ //검색 돋보기 아이콘 클릭시
		search();
	});
	
	$("input[name=search]").keydown(function(key){ //검색 input에서 엔터키(13) 클릭시
		if(key.keyCode == 13){
			search();
		}
	});
	
	$('button[id^="returnpage"]').click(function(){ //버튼 배열 id로 가져오기
		
		document.location.href="product_v2.do?strdate=&enddate=&work_gb=WK02";
		
	});
	
	$("#save").click(function(){
		if($("input[name='cal']")[0].value =="N"){
			alert("수정데이터가 있어 자동계산작업을 완료해야 저장할수 있습니다.");
			return;
		}
		if($("input[name='cal']")[0].value =="I"){
			alert("작업저장전 자동계산이 필요합니다.");
			return;
		}
		
		$('form').submit();
	})
	
	$("#savenext").click(function(){
		if($("input[name='cal']")[0].value =="N"){
			alert("수정데이터가 있어 자동계산작업을 완료해야 저장할수 있습니다.");
			return;
		}
		if($("input[name='cal']")[0].value =="I"){
			alert("작업저장전 자동계산이 필요합니다.");
			return;
		}
		
		$("input[name='savenext']")[0].value = "Y";
		$('form').submit();
	})
	
	setInterval(function(){
		  $(".blink").toggle();
	}, 500);
	
	$("#qtycheck").click(function(){
		$("input[name='cal']")[0].value ="Y";
		
		$("input[name=a_code]").each(function(idx){   
         
        var jinsum = 0;
        
        jinsum =  Math.abs($("input[name=a_qty_a]:eq(" + idx + ")").val()) - (Math.abs($("input[name=a_qty_p]:eq(" + idx + ")").val()) - Math.abs($("input[name=a_qty_d]:eq(" + idx + ")").val()))
        
        if(jinsum<0){
        	jinsum = Math.abs(jinsum);
        	$("input[name=a_bigo_gb]")[idx].value="제거"
        }else if(jinsum==0){
        	$("input[name=a_bigo_gb]")[idx].value=""
        }else{
        	$("input[name=a_bigo_gb]")[idx].value="추가"
        }
        $("input[name=a_bigo_qty]")[idx].value=jinsum;
        
      });
		
	})
	
});

function product_delete(offer_no,work_gb){ 
	var con = confirm("데이터를 삭제하시겠습니까? *복구 불가능합니다.");
	if(con){
		 location.href="product_delete_v2.do?offer_no="+offer_no+"&work_gb="+work_gb;
	}			
}

function calc(){
	$("input[name='cal']")[0].value ="N";
}




</script>
<c:set var="flag" value="${map.insert_gb}"/>
<c:set var="work_gb_kr" value="${map.work_gb}"/>
<%
	Calendar cal = Calendar.getInstance();
	String strYear = request.getParameter("year");
	String strMonth = request.getParameter("month");
	String flag = (String)pageContext.getAttribute("flag");
	String work_gb_kr = (String)pageContext.getAttribute("work_gb_kr");
	String work_nm = "";
	
	if(work_gb_kr.equals("WK01")){
		work_nm = "입고";
	}else if(work_gb_kr.equals("WK02")){
		work_nm = "재고";
	}
	
	pageContext.setAttribute("work_nm", work_nm);
	
	int nowyear = cal.get(Calendar.YEAR);
	int nowmonth = cal.get(Calendar.MONTH);
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH);
	int date = cal.get(Calendar.DATE);
	
	if(strYear != null){
		year = Integer.parseInt(strYear);
		month = Integer.parseInt(strMonth);	
	}else{
		
	}
	
	//년도월 셋팅	
	cal.set(year, month, 1);
	int startDay = cal.getMinimum(java.util.Calendar.DATE);
	int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
	int start = cal.get(java.util.Calendar.DAY_OF_WEEK);
	int newLine = 0;
	
	//오늘 날짜 저장
	Calendar todayCal = Calendar.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyMMdd");
	int intToday = Integer.parseInt(sdf.format(todayCal.getTime()));
%>


<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Raleway", sans-serif}
</style>
<body class="w3-light-grey w3-content" style="max-width:1600px">
<input type="hidden" id="id" value="${id}">

<!-- Sidebar/menu -->
<jsp:include page="../inc/side.jsp"/>

<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:300px">

  <!-- Header -->
  <header id="portfolio">
    <a href="#"><img src="/w3images/avatar_g2.jpg" style="width:65px;" class="w3-circle w3-right w3-margin w3-hide-large w3-hover-opacity"></a>
    <span class="w3-button w3-hide-large w3-xxlarge w3-hover-text-grey" onclick="w3_open()"><i class="fa fa-bars"></i></span>
    <div class="w3-container">
    
	<div style="padding-top: 50px; padding-left: 50px; padding-right: 50px; padding-bottom: 50px;">
	  <h1 class="ui dividing header" style="font-weight: 100;"> ${work_nm}작업 상세보기 </h1>
	  		
	
	</div>  		
			<button id="returnpage" class="ui button" type="button" >목록으로</button>
			<c:forEach items="${work}" var="row_work" varStatus="statu_ipgo">
			
			  <c:choose>
			  	<c:when test="${row_work.MAGAM_GB eq '4'}">
			  		<c:set var ="setting" value="text-align:center;background-color:transparent; border-style:none"></c:set>
			  		<c:set var ="ro_gb" value="readonly"></c:set>
			  	</c:when>
			  	<c:when test="${row_work.MAGAM_GB eq '3'}">
			  		<c:set var ="setting" value=" text-align:center;background-color:transparent"></c:set>
			  	</c:when>
			  </c:choose>
				
				<c:choose>
					<c:when test="${row_work.MAGAM_GB eq '3'}">
						<button id="save" class="ui button" type="button" onclick="test">작업저장</button>
						<button id="savenext" class="ui button" type="button" onclick="test">저장후 작업마감</button>
						<button id="dateupdate" class="ui button" type="button" onclick="product_delete('${row_work.OFFER_NO}','WK02')">작업삭제</button>
					</c:when>
					<c:when test="${row_work.MAGAM_GB eq '4'}">
						<button id="dateupdate" class="ui button" type="button">작업 마감완료 되었습니다.</button>
					</c:when>
				</c:choose> 
			
			
		
		 <form action="jego_v2.do" id="form" name="form" method="post">
		 	<input type="hidden" name="offer_no" value="${row_work.OFFER_NO}">
		 	<input type="hidden" name="work_gb" value="${map.work_gb}">
		 	<input type="hidden" name="insert_gb" value="${map.insert_gb}">
		 	<input type="hidden" name="worklength"  value="${fn:length(work)}">
		 	<input type="hidden" name="ipgolength" value="${fn:length(ipgo)}">
		 	<input type="hidden" name="jinlength" value="${fn:length(jin)}">
		 	<input type="hidden" name="magam_gb" value="${row_work.MAGAM_GB}">
		 	<input type="hidden" name="next_magam_gb" value="${row_work.NEXT_MAGAM_GB}">
		 	<input type="hidden" name="cal" value="I">
		 	<input type="hidden" name="savenext" value="">
		 	
				<table class="ui fixed single line celled table" style="width: 100%;" align="right">
				<thead>
					
					<tr>
						<th style="width:10%;">작업번호</th>
						<td style="width:15%;">
							${row_work.OFFER_NO}
							
						</td>
						<th style="width:10%;">작업날짜</th>
						<td style="width:15%;">
							${fn:substring(row_work.OFFER_DATE,0,4)}년 ${fn:substring(row_work.OFFER_DATE,4,6)}월 ${fn:substring(row_work.OFFER_DATE,6,8)}일
						</td>
						<th style="width:10%;">작업구분</th>
						<td style="width:40%;">
							<c:choose>
								<c:when test="${row_work.MAGAM_GB eq '3'}">
									재고작업입력<span class="blink">→ 재고수량작업중 </span>
								</c:when>
								<c:when test="${row_work.MAGAM_GB eq '4'}">
									재고작업입력 → 재고수량작업중 → <span class="blink">마감</span>
								</c:when>
							</c:choose> 
							
						</td>
					</tr>
					<tr>
						<th  colspan="1"> 작업내용 </th>
						<td  colspan="5"> <input type="text" name="work_bigo" class="ui celled table" value="${row_work.BIGO}"  style="background-color:transparent;" maxlength="30"></td>
					</tr>
					
				</thead>
				</table>
				<table class="ui celled table">
					<thead>
						<tr>
							<th style="width:28%;text-align:center;" colspan="3">시스템 재고 수량</th>
							<th style="width:10%;text-align:center;" colspan="1" rowspan="2">판매수량</th>
							<th style="width:10%;text-align:center;" colspan="1" rowspan="2">가계 재고수량</th>
							<th style="width:52%;text-align:center;" colspan="3">차이 
								<c:choose>
									<c:when test="${row_work.MAGAM_GB eq '3'}">
										&emsp; <button id="qtycheck" class="ui button" type="button" >자동계산</button>
									</c:when>
								</c:choose> 
								<br>* 시스템재고 - ( 판매수량 - 가계재고수량 ) *
							</th>
						</tr>
						</c:forEach>
						<tr>
							<th style="width:5%;text-align:center;">품목<br>코드</th>
							<th style="width:15%;text-align:center;">품목명</th>
							<th style="width:5%;text-align:center;">수량 <br>개</th>
							<th style="width:5%;text-align:center;">수량<br>차이</th>
							<th style="width:5%;text-align:center;">작업</th>
							<th style="width:12%;text-align:center;">비고</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${fn:length(jego) > 0}">
								<c:forEach items="${jego}" var="row_jego" varStatus="statu_ipgo">
									
									<tr>
										<td><input type="text" name="a_code" class="ui celled table" value="${row_jego.CODE}" style="text-align:center;background-color:transparent; border-style:none"  readonly></td>
										<td><input type="text" name="a_code_nm" class="ui celled table" value="${row_jego.CODE_NM}" style="text-align:center;background-color:transparent; border-style:none"  readonly></td>
										<td><input type="text" name="a_qty_p" class="ui celled table" value="${row_jego.QTY_P}" style="text-align:center;background-color:transparent; border-style:none"  readonly></td>
										<td><input type="text" name="a_qty_d" class="ui celled table" value="${row_jego.QTY_D}" style="${setting};" onchange="calc()" ${ro_gb}></td>
										<td><input type="text" name="a_qty_a" class="ui celled table" value="${row_jego.QTY_A}" style="${setting};" onchange="calc()" ${ro_gb}></td>
										<td><input type="text" name="a_bigo_qty" class="ui celled table" value="${row_jego.BIGO_QTY}" style="text-align:center;background-color:transparent; border-style:none;" readonly></td>
										<td><input type="text" name="a_bigo_gb" class="ui celled table" value="${row_jego.BIGO_GB}" style="text-align:center;background-color:transparent; border-style:none;" readonly></td>
										<td><input type="text" name="a_bigo" class="ui celled table" value="${row_jego.BIGO}" style="${setting};" ${ro_gb} maxlength="30"></td>
									</tr>
								
								</c:forEach>
							</c:when>
						</c:choose>
						
					</tbody>
					
					
					
				</table>
				
				
			
				</form>
		</div>


<script>
// Script to open and close sidebar
function w3_open() {
    document.getElementById("mySidebar").style.display = "block";
    document.getElementById("myOverlay").style.display = "block";
}
 
function w3_close() {
    document.getElementById("mySidebar").style.display = "none";
    document.getElementById("myOverlay").style.display = "none";
}
</script>

</body>
</html>
