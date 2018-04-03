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
		
		document.location.href="product.do?strdate=&enddate=&workgb=";
		
	});
	
	$("#save").click(function(){
		
		var ll = $("#listlength").val();
		var aa = "TOTAL_QTY";
		var bb = "QTY_ST02";
		var cc = "QTY_ST01";
		var dd = "PRO_GB";
		var ee = "KOR_NAME";
		
		
		
		
		for(var i = 0 ; i < ll ; i++){
			if(parseInt($("input[name='"+aa+"']")[i].value) != parseInt($("input[name='"+bb+"']")[i].value)+parseInt($("input[name='"+cc+"']")[i].value)){
				alert($("input[name='"+dd+"']")[i].value+"-"+$("input[name='"+ee+"']")[i].value+" 작업수량이 맞지않습니다.");
				return;
			}
			
		}
		$('form').submit();
	})

});


function infoPopup(no){ //jquery 바깥에 선언해야함 <script> 안으로 빼기
	var cw = 800; //창넓이
	var ch = 700; //창높이
	var sw = screen.availWidth;
	var sh = screen.availHeight;
	var px=(sw-cw)/2;
	var py=(sh-ch)/2;
	
	window.open('memberInfo.do?no='+no, '', 'left='+px+',top='+py+',width='+cw+',height='+ch+', location=no, status=no, resizable=no, fullscreen=no, channelmode=no');
}

function modification(offer_no,work_gb,insert_gb,magam_gb){ //jquery 바깥에 선언해야함 <script> 안으로 빼기
	if(magam_gb == 'Y'){
		alert("마감된작업은 수정이 불가능합니다.")
	}else{ 
	location.href="product_detail_jego.do?offer_no="+offer_no+"&work_gb="+work_gb+"&insert_gb="+insert_gb;
	}
	return;
}

function product_delete(offer_no,work_gb,magam_gb){ //jquery 바깥에 선언해야함 <script> 안으로 빼기
	if(magam_gb == 'Y'){
		alert("마감된작업은 삭제가 불가능합니다.")
	}else{
		var con = confirm("데이터를 삭제하시겠습니까? *복구 불가능합니다.");
		if(con){
			 location.href="product_delete.do?offer_no="+offer_no+"&work_gb="+work_gb;
		}
	}
	return;
}

function checkQTY(name,line){
		var linecheck = line-1;
		
		var Paa = "PRE_TOTAL_QTY";
		var Pbb = "PRE_QTY_ST02";
		var Pcc = "PRE_QTY_ST01";
		
		var Waa = "TOTAL_QTY_WK03";
		var Wbb = "QTY_ST02_WK03";
		var Wcc = "QTY_ST01_WK03";
	
		var Eaa = "END_TOTAL_QTY";
		var Ebb = "END_QTY_ST02";
		var Ecc = "END_QTY_ST01";
		
		var aa = "TOTAL_QTY";
		var bb = "QTY_ST02";
		var cc = "QTY_ST01";
				
		if(name==Waa){
			if($("input[name='"+Waa+"']")[linecheck].value>-1&&$("input[name='"+Waa+"']")[linecheck].value<1000000){
				if(parseInt($("input[name='"+Waa+"']")[linecheck].value) < parseInt($("input[name='"+Wbb+"']")[linecheck].value)+parseInt($("input[name='"+Wcc+"']")[linecheck].value)){
					alert("판매총수량이 창고,진열 작업수량보다 적습니다.");
					$("input[name='"+Waa+"']")[linecheck].value = "0";
					return;
				}
				$("input[name='"+aa+"']")[linecheck].value = (parseInt($("input[name='"+Waa+"']")[linecheck].value)+parseInt($("input[name='"+Eaa+"']")[linecheck].value))-parseInt($("input[name='"+Paa+"']")[linecheck].value);
			}else if($("input[name='"+Waa+"']")[linecheck].value<1000000){
				alert("판매수량은 마이너스(-) 될수 없습니다.");
				$("input[name='"+Waa+"']")[linecheck].value = "0";
			}else{
				alert("숫자만 입력해주세요");
				$("input[name='"+Waa+"']")[linecheck].value = "0";
			}
		}else if(name==Wbb){
			if($("input[name='"+Wbb+"']")[linecheck].value>-1&&$("input[name='"+Wbb+"']")[linecheck].value<1000000){
			if(parseInt($("input[name='"+Waa+"']")[linecheck].value) < parseInt($("input[name='"+Wbb+"']")[linecheck].value)){
				alert("작업총수량보다 큽니다.");
				$("input[name='"+Wbb+"']")[linecheck].value = "";
				return;
			}
			$("input[name='"+Wcc+"']")[linecheck].value = parseInt($("input[name='"+Waa+"']")[linecheck].value)-parseInt($("input[name='"+Wbb+"']")[linecheck].value);
			$("input[name='"+bb+"']")[linecheck].value = (parseInt($("input[name='"+Wbb+"']")[linecheck].value)+parseInt($("input[name='"+Ebb+"']")[linecheck].value))-parseInt($("input[name='"+Pbb+"']")[linecheck].value);
			$("input[name='"+cc+"']")[linecheck].value = (parseInt($("input[name='"+Wcc+"']")[linecheck].value)+parseInt($("input[name='"+Ecc+"']")[linecheck].value))-parseInt($("input[name='"+Pcc+"']")[linecheck].value);
			}else if($("input[name='"+Wbb+"']")[linecheck].value<1000000){
				alert("판매수량은 마이너스(-)가 될수 없습니다.");
				$("input[name='"+Wbb+"']")[linecheck].value = "0";
			}else{
				alert("숫자만 입력해주세요");
				$("input[name='"+Wbb+"']")[linecheck].value = "0";
			}
		}else if(name==Wcc){
			if($("input[name='"+Wcc+"']")[linecheck].value>-1&&$("input[name='"+Wcc+"']")[linecheck].value<1000000){
			if(parseInt($("input[name='"+Waa+"']")[linecheck].value) < parseInt($("input[name='"+Wcc+"']")[linecheck].value)){
				alert("작업총수량보다 큽니다.");
				$("input[name='"+Wcc+"']")[linecheck].value = "";
				return;
			}
			$("input[name='"+Wbb+"']")[linecheck].value = parseInt($("input[name='"+Waa+"']")[linecheck].value)-parseInt($("input[name='"+Wcc+"']")[linecheck].value);
			$("input[name='"+bb+"']")[linecheck].value = (parseInt($("input[name='"+Wbb+"']")[linecheck].value)+parseInt($("input[name='"+Ebb+"']")[linecheck].value))-parseInt($("input[name='"+Pbb+"']")[linecheck].value);
			$("input[name='"+cc+"']")[linecheck].value = (parseInt($("input[name='"+Wcc+"']")[linecheck].value)+parseInt($("input[name='"+Ecc+"']")[linecheck].value))-parseInt($("input[name='"+Pcc+"']")[linecheck].value);
			}else if($("input[name='"+Wcc+"']")[linecheck].value<1000000){
				alert("판매수량은 마이너스(-) 될수 없습니다.");
				$("input[name='"+Wcc+"']")[linecheck].value = "0";
			}else{
				alert("숫자만 입력해주세요");
				$("input[name='"+Wcc+"']")[linecheck].value = "0";
			}
			
			
			
		}else if(name==Eaa){
			if($("input[name='"+Eaa+"']")[linecheck].value>-1000000&&$("input[name='"+Waa+"']")[linecheck].value<1000000){
			if(parseInt($("input[name='"+Eaa+"']")[linecheck].value) < parseInt($("input[name='"+Ebb+"']")[linecheck].value)+parseInt($("input[name='"+Ecc+"']")[linecheck].value)){
				alert("재고총수량이 창고,진열 작업수량보다 적습니다.");
				$("input[name='"+Eaa+"']")[linecheck].value = "";
				return;
			}
			$("input[name='"+aa+"']")[linecheck].value = (parseInt($("input[name='"+Waa+"']")[linecheck].value)+parseInt($("input[name='"+Eaa+"']")[linecheck].value))-parseInt($("input[name='"+Paa+"']")[linecheck].value);
			}else{
				alert("숫자만 입력해주세요");
				$("input[name='"+Eaa+"']")[linecheck].value = "0";
			}
		}else if(name==Ebb){
			if($("input[name='"+Ebb+"']")[linecheck].value>-1000000&&$("input[name='"+Waa+"']")[linecheck].value<1000000){
			if(parseInt($("input[name='"+Eaa+"']")[linecheck].value) < parseInt($("input[name='"+Ebb+"']")[linecheck].value)){
				alert("작업총수량보다 큽니다.");
				$("input[name='"+Ebb+"']")[linecheck].value = "";
				return;
			}
			$("input[name='"+Ecc+"']")[linecheck].value = parseInt($("input[name='"+Eaa+"']")[linecheck].value)-parseInt($("input[name='"+Ebb+"']")[linecheck].value);
			$("input[name='"+bb+"']")[linecheck].value = (parseInt($("input[name='"+Wbb+"']")[linecheck].value)+parseInt($("input[name='"+Ebb+"']")[linecheck].value))-parseInt($("input[name='"+Pbb+"']")[linecheck].value);
			$("input[name='"+cc+"']")[linecheck].value = (parseInt($("input[name='"+Wcc+"']")[linecheck].value)+parseInt($("input[name='"+Ecc+"']")[linecheck].value))-parseInt($("input[name='"+Pcc+"']")[linecheck].value);
			}else{
				alert("숫자만 입력해주세요");
				$("input[name='"+Ebb+"']")[linecheck].value = "0";
			}
		}else if(name==Ecc){
			if($("input[name='"+Ecc+"']")[linecheck].value>-1000000&&$("input[name='"+Waa+"']")[linecheck].value<1000000){
			if(parseInt($("input[name='"+Eaa+"']")[linecheck].value) < parseInt($("input[name='"+Ecc+"']")[linecheck].value)){
				alert("작업총수량보다 큽니다.");
				$("input[name='"+Ecc+"']")[linecheck].value = "";
				return;
			}
			$("input[name='"+Wbb+"']")[linecheck].value = parseInt($("input[name='"+Waa+"']")[linecheck].value)-parseInt($("input[name='"+Wcc+"']")[linecheck].value);
			$("input[name='"+bb+"']")[linecheck].value = (parseInt($("input[name='"+Wbb+"']")[linecheck].value)+parseInt($("input[name='"+Ebb+"']")[linecheck].value))-parseInt($("input[name='"+Pbb+"']")[linecheck].value);
			$("input[name='"+cc+"']")[linecheck].value = (parseInt($("input[name='"+Wcc+"']")[linecheck].value)+parseInt($("input[name='"+Ecc+"']")[linecheck].value))-parseInt($("input[name='"+Pcc+"']")[linecheck].value);
			}else{
				alert("숫자만 입력해주세요");
				$("input[name='"+Ecc+"']")[linecheck].value = "0";
			}
		}else{
			return;
		}
	}
	
function atset(ls){
	var Paa = "PRE_TOTAL_QTY";
	var Pbb = "PRE_QTY_ST02";
	var Pcc = "PRE_QTY_ST01";
	
	var Waa = "TOTAL_QTY_WK03";
	var Wbb = "QTY_ST02_WK03";
	var Wcc = "QTY_ST01_WK03";

	var Eaa = "END_TOTAL_QTY";
	var Ebb = "END_QTY_ST02";
	var Ecc = "END_QTY_ST01";
	
	var aa = "TOTAL_QTY";
	var bb = "QTY_ST02";
	var cc = "QTY_ST01";

	var dd = "PRO_GB";
	var ee = "KOR_NAME";
	
	for(var i=0;i<ls;i++){
		if(parseInt($("input[name='"+Waa+"']")[i].value) != parseInt($("input[name='"+Wbb+"']")[i].value)+parseInt($("input[name='"+Wcc+"']")[i].value)){
			alert($("input[name='"+dd+"']")[i].value+"-"+$("input[name='"+ee+"']")[i].value+" 작업수량이 맞지않습니다.");
			return;
		}
	}
	
	for(var i=0;i<ls;i++){
		$("input[name='"+Eaa+"']")[i].value = parseInt($("input[name='"+Paa+"']")[i].value)-parseInt($("input[name='"+Waa+"']")[i].value);
		$("input[name='"+Ebb+"']")[i].value = parseInt($("input[name='"+Pbb+"']")[i].value)-parseInt($("input[name='"+Wbb+"']")[i].value);
		$("input[name='"+Ecc+"']")[i].value = parseInt($("input[name='"+Pcc+"']")[i].value)-parseInt($("input[name='"+Wcc+"']")[i].value);
		
		$("input[name='"+aa+"']")[i].value = (parseInt($("input[name='"+Waa+"']")[i].value)+parseInt($("input[name='"+Eaa+"']")[i].value))-parseInt($("input[name='"+Paa+"']")[i].value);
		$("input[name='"+bb+"']")[i].value = (parseInt($("input[name='"+Wbb+"']")[i].value)+parseInt($("input[name='"+Ebb+"']")[i].value))-parseInt($("input[name='"+Pbb+"']")[i].value);
		$("input[name='"+cc+"']")[i].value = (parseInt($("input[name='"+Wcc+"']")[i].value)+parseInt($("input[name='"+Ecc+"']")[i].value))-parseInt($("input[name='"+Pcc+"']")[i].value);
		
	}
	
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
    <h1><b>${work_nm}작업 상세보기</b></h1>
 
 <form action="jegoinsert.do" id="form" name="form" method="post">
 	<input type="hidden" name="OFFER_NO" class="ui celled table" value="${map.offer_no}" style="text-align:right;background-color:transparent; border-style:none" readonly>
 	<input type="hidden" name="insert_gb" value="${map.insert_gb}">
 	<input type="hidden" name="upornew" value="${map.upornew}">
 	<input type="hidden" id="listlength" value="${fn:length(jego_pre)}">
	<div style="padding-top: 50px; padding-left: 50px; padding-right: 50px; padding-bottom: 50px;">
		<table class="ui fixed single line celled table" style="width: 55%;" align="right">
			<tr>
				<td style="width:14%;">작업번호</td>
				<td style="width:18%;">
					${map.offer_no}
					
				</td>
				<td style="width:14%;">작업날짜</td>
				<td style="width:24%;">
					${map.date_nm}
					
				</td>
				<td style="width:14%;">작업구분</td>
				<td style="width:16%;">
					${work_nm}작업
				</td>
			</tr>
			
		</table>
			<c:choose>
				<c:when test="${map.insert_gb  eq 'V' }">
					<button id="returnpage" class="ui button" type="button" >목록으로</button>
					<button id="dateupdate" class="ui button" type="button" onclick="modification('${map.offer_no}','${map.work_gb}','I','${info[0].MAGAM_GB}')">작업수정</button>
					<button id="dateupdate" class="ui button" type="button" onclick="product_delete('${map.offer_no}','${map.work_gb}','${info[0].MAGAM_GB}')">작업삭제</button>
				</c:when>
				<c:when test="${map.insert_gb  eq 'I'}">
					<button id="returnpage" class="ui button" type="button" >목록으로</button>
					<button id="save" class="ui button" type="button" onclick="test">작업저장</button>
					<button id="autosetting" class="ui button" type="button" onclick="atset('${fn:length(jego_pre)}')">재고수량자동세팅</button>
					<input type="hidden" id="listsize" value= '${fn:length(jego_pre)}'>
				</c:when>
			</c:choose>
		<table class="ui celled table">
			<thead>
				<tr>
					<th style="width:7%;text-align:center;" rowspan="2" >품목<br>코드</th>
					<th style="width:21%;text-align:center;" rowspan="2" >품목명</th>
					<th style="width:18%;text-align:center;" colspan="3">${work_nm}작업전 수량</th>
					<th style="width:18%;text-align:center;" colspan="3">판매 수량</th>
					<th style="width:18%;text-align:center;" colspan="3">${work_nm} 수량</th>
					<th style="width:18%;text-align:center;" colspan="3">${work_nm}작업후 차이</th>
				</tr>
				<tr >
					<th style="width:6%;text-align:center;">합계</th>
					<th style="width:6%;text-align:center;">창고</th>
					<th style="width:6%;text-align:center;">진열</th>
					<th style="width:6%;text-align:center;">합계</th>
					<th style="width:6%;text-align:center;">창고</th>
					<th style="width:6%;text-align:center;">진열</th>
					<th style="width:6%;text-align:center;">합계</th>
					<th style="width:6%;text-align:center;">창고</th>
					<th style="width:6%;text-align:center;">진열</th>
					<th style="width:6%;text-align:center;">합계</th>
					<th style="width:6%;text-align:center;">창고</th>
					<th style="width:6%;text-align:center;">진열</th>
				</tr>
			</thead>
			<tbody >
				
				<c:choose>
					<c:when test="${fn:length(jego_pre) > 0}">
						<c:forEach items="${jego_pre}" var="row" varStatus="statu">
						<c:choose>
							<c:when test="${map.upornew eq 'up'}">
								<c:set var="ETQ" value="${row.PRE_TOTAL_QTY+jego_wk03[statu.index].TOTAL_QTY+jego_wk02[statu.index].TOTAL_QTY}"/>
								<c:set var="ETS02" value="${row.PRE_QTY_ST02+jego_wk03[statu.index].QTY_ST02+jego_wk02[statu.index].QTY_ST02}"/>
								<c:set var="ETS01" value="${row.PRE_QTY_ST01+jego_wk03[statu.index].QTY_ST01+jego_wk02[statu.index].QTY_ST01}"/>
							</c:when>
							<c:when test="${map.upornew eq 'new'}">
								<c:set var="ETQ" value="0"/>
								<c:set var="ETS02" value="0"/>
								<c:set var="ETS01" value="0"/>
							</c:when>
						</c:choose>
						
							<tr>
								<td>
									<input type="text" name="PRO_GB" class="ui celled table" value="${row.PRO_GB}" style="text-align:center;background-color:transparent; border-style:none" readonly>
								</td>
								<td><input type="text" name="KOR_NAME" class="ui celled table" value="${row.KOR_NAME}" style="text-align:left;background-color:transparent; border-style:none" readonly></td>
								<td style="background-color:#F2F2F2;text-align:right;">
									<input type="text" name="PRE_TOTAL_QTY" class="ui celled table" value="${row.PRE_TOTAL_QTY}" style="text-align:right;background-color:transparent; border-style:none" readonly>
								</td>
								<td style="background-color:#F2F2F2;text-align:right;">
									<input type="text" name="PRE_QTY_ST02" class="ui celled table" value="${row.PRE_QTY_ST02}" style="text-align:right;background-color:transparent; border-style:none" readonly>
								</td>
								<td style="background-color:#F2F2F2;text-align:right;">
									<input type="text" name="PRE_QTY_ST01" class="ui celled table" value="${row.PRE_QTY_ST01}" style="text-align:right;background-color:transparent; border-style:none" readonly>
								</td>
								
								<td style="text-align:right;">
									<c:choose>
										<c:when test="${map.insert_gb  eq 'I' }">
											<input id="TOTAL_QTY_${statu.count}" name="TOTAL_QTY_WK03" type="text" class="ui celled table" value="${-jego_wk03[statu.index].TOTAL_QTY}" style="text-align:right;" onchange="checkQTY('TOTAL_QTY_WK03','${statu.count}')" >
										</c:when>
										<c:when test="${map.insert_gb  eq 'V' }">
											<input  type="text" class="ui celled table" value="${-jego_wk03[statu.index].TOTAL_QTY}" style="text-align:right;background-color:transparent; border-style:none" readonly>
										</c:when>
									</c:choose>
								</td>
								<td style="text-align:right;">
									<c:choose>
										<c:when test="${map.insert_gb  eq 'I' }">
											<input id="QTY_ST02_${statu.count}" name="QTY_ST02_WK03" type="text" class="ui celled table"  value="${-jego_wk03[statu.index].QTY_ST02}" style="text-align:right;" onchange="checkQTY('QTY_ST02_WK03','${statu.count}')" >
										</c:when>
										<c:when test="${map.insert_gb  eq 'V' }">
											<input type="text" class="ui celled table" value="${-jego_wk03[statu.index].QTY_ST02}" style="text-align:right;background-color:transparent; border-style:none" readonly>
										</c:when>
									</c:choose>
								</td>
								<td style="text-align:right;">
									<c:choose>
										<c:when test="${map.insert_gb  eq 'I' }">
											<input id="QTY_ST01_${statu.count}" name="QTY_ST01_WK03" type="text" class="ui celled table" value="${-jego_wk03[statu.index].QTY_ST01}" style="text-align:right;" onchange="checkQTY('QTY_ST01_WK03','${statu.count}')" >
										</c:when>
										<c:when test="${map.insert_gb  eq 'V' }">
											<input type="text" class="ui celled table" value="${-jego_wk03[statu.index].QTY_ST01}" style="text-align:right;background-color:transparent; border-style:none" readonly>
										</c:when>
									</c:choose>
								</td>
								<td style="background-color: #F2F2F2;text-align:right;">
									<c:choose>
										<c:when test="${map.insert_gb  eq 'I' }">
											<input type="text" name="END_TOTAL_QTY" class="ui celled table" value="${ETQ}" onchange="checkQTY('END_TOTAL_QTY','${statu.count}')" style="text-align:right;background-color: #F2F2F2;">
									</c:when>
										<c:when test="${map.insert_gb  eq 'V' }">
											<input  type="text" class="ui celled table" value="${row.PRE_TOTAL_QTY+jego_wk03[statu.index].TOTAL_QTY+jego_wk02[statu.index].TOTAL_QTY}" style="text-align:right;background-color:transparent; border-style:none" readonly>
										</c:when>
									</c:choose>
								</td>
								<td style="background-color: #F2F2F2;text-align:right;">
									<c:choose>
										<c:when test="${map.insert_gb  eq 'I' }">
											<input type="text" name="END_QTY_ST02" class="ui celled table" value="${ETS02}" onchange="checkQTY('END_QTY_ST02','${statu.count}')" style="text-align:right;background-color: #F2F2F2;">
									</c:when>
										<c:when test="${map.insert_gb  eq 'V' }">
											<input  type="text" class="ui celled table" value="${row.PRE_QTY_ST02+jego_wk03[statu.index].QTY_ST02+jego_wk02[statu.index].QTY_ST02}" style="text-align:right;background-color:transparent; border-style:none" readonly>
										</c:when>
									</c:choose>
								</td>
								<td style="background-color: #F2F2F2;text-align:right;">
									<c:choose>
										<c:when test="${map.insert_gb  eq 'I' }">
											<input type="text" name="END_QTY_ST01" class="ui celled table" value="${ETS01}" onchange="checkQTY('END_QTY_ST01','${statu.count}')" style="text-align:right;background-color: #F2F2F2;">
									</c:when>
										<c:when test="${map.insert_gb  eq 'V' }">
											<input  type="text" class="ui celled table" value="${row.PRE_QTY_ST01+jego_wk03[statu.index].QTY_ST01+jego_wk02[statu.index].QTY_ST01}" style="text-align:right;background-color:transparent; border-style:none" readonly>
										</c:when>
									</c:choose>
								</td>
								
								<td style="text-align:right;">
										<input  id="TOTAL_QTY_${statu.count}" name="TOTAL_QTY" type="text" class="ui celled table" value="${jego_wk02[statu.index].TOTAL_QTY}" style="text-align:right;background-color:transparent; border-style:none"  readonly>
								</td>
								<td style="text-align:right;">
										<input  id="QTY_ST02_${statu.count}" name="QTY_ST02" type="text" class="ui celled table"  value="${jego_wk02[statu.index].QTY_ST02}" style="text-align:right;background-color:transparent; border-style:none"  readonly>
								</td>
								<td style="text-align:right;">
										<input  id="QTY_ST01_${statu.count}" name="QTY_ST01" type="text" class="ui celled table" value="${jego_wk02[statu.index].QTY_ST01}" style="text-align:right;background-color:transparent; border-style:none" readonly>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="10">조회된 결과가 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
			
		</table>
	</div>
</form>


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
