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
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"/>


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
	
	search = function(){ //코드이름으로 검색
		
		var strdate = $("#date_from").val();
		var enddate = $("#date_to").val();
		var work_gb = $("#work_gb").val();
		var bigo_text = $("#bigo_text").val();
		
		if(strdate != null && strdate!=""){
			strdate = strdate.substring(0,4)+strdate.substring(5,7)+strdate.substring(8,10);
		}else{
			strdate = "00000000"
		}
		
		if(enddate != null && enddate!=""){
			enddate= enddate.substring(0,4)+enddate.substring(5,7)+enddate.substring(8,10);
		}else{
			enddate = "99999999"
		}
		
		if(strdate>enddate){
			alert("조회조건  - 종료날짜는 시작날짜보다 과거일수 없습니다.\n날짜를 수정해주세요.");
			return;
		}
		
		document.location.href="product_v2.do?work_gb="+work_gb+"&strdate="+strdate+"&enddate="+enddate+"&bigo_text="+bigo_text;
	};
	
	$("#search").click(function(){ //검색 돋보기 아이콘 클릭시
		search();
	});
	
	
	$("input[name=search]").keydown(function(key){ //검색 input에서 엔터키(13) 클릭시
		if(key.keyCode == 13){
			search();
		}
	});
	

	
	
});




function detail_ipgo(offer_no,work_gb,vi,magam_gb,code_gb){
	if(vi=='I'){
		if(offer_no == '0000000000'){
			 location.href="product_detail_ipgo_v2.do?offer_no="+offer_no+"&work_gb="+work_gb+"&insert_gb=I&code_gb="+code_gb+"&magam_gb=1";
		}
	}else{
		location.href="product_detail_ipgo_v2.do?offer_no="+offer_no+"&work_gb="+work_gb+"&insert_gb=V&code_gb="+code_gb+"&magam_gb="+magam_gb;
	}
	
}

function detail_jego(offer_no,work_gb,vi,magam_gb,code_gb){
	if(vi=='I'){
		if(offer_no == '0000000000'){
			 location.href="product_detail_jego_v2.do?offer_no="+offer_no+"&work_gb="+work_gb+"&insert_gb=I&code_gb="+code_gb+"&magam_gb=1";
		}
	}else{
		location.href="product_detail_jego_v2.do?offer_no="+offer_no+"&work_gb="+work_gb+"&insert_gb=V&code_gb="+code_gb+"&magam_gb="+magam_gb;
	}
}


</script>

<%
	Calendar cal = Calendar.getInstance();
	String strYear = request.getParameter("year");
	String strMonth = request.getParameter("month");
	
	
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
	  <h1 class="ui dividing header" style="font-weight: 100;">
	 															<c:choose>
																	<c:when test="${map.work_gb eq 'WK01'}">
																		 입고진열 관리 
																	</c:when> 
																	<c:when test="${map.work_gb eq 'WK02'}">
																		재고판매 관리
																	</c:when>
																</c:choose> 
	  															
	  														</h1>
		<input type="hidden" name="work_gb" id="work_gb" value="${map.work_gb}"> 
		<table class="ui fixed single line celled table" style="width: 85%;" align="right">
			<tr>
				<td>작업날짜</td>
				<td>
					<div class="ui input" >
						<input  type="date" id="date_from" >
					</div> ~ 
					<div class="ui input" >
						<input type="date" id="date_to" >
					</div>
				</td>
				
				<td>비고내용</td>
				<td>
					<div class="ui input" >
						<input type="text"  name="bigo_text"  id="bigo_text"  value="">
					</div>
				</td>
				<td><i id="search" name="search" class="search icon" style="cursor: pointer;"></i></td>
			</tr>
		</table>
		
		<c:choose>
			<c:when test="${map.work_gb eq 'WK01'}">
				 <button id="detail" class="ui button" type="button" onclick="detail_ipgo('0000000000','WK01','I','1','B')">신규입고작업</button>
			</c:when>
			<c:when test="${map.work_gb eq 'WK02'}">
				<button id="delete" class="ui button" type="button" onclick="detail_jego('0000000000','WK02','I','1','A')">신규재고작업</button>
			</c:when>
		</c:choose> 
				
				
		<table class="ui celled table">
			<thead>
				<tr>
					<th style="width:13%;">작업날짜</th>
					<th style="width:8%;">작업순서</th>
					<th style="width:10%;">작업번호</th>
					<th style="width:8%;">마감여부</th>
					<th style="width:13%;">마감날짜</th>
					<th style="width:13%;">업데이트날짜</th>
					<th style="width:20%;">비고</th>
					<th style="width:15%;">작업내용확인</th>
				</tr>
			</thead>
			<tbody id="memberTb">
				<c:choose>
					<c:when test="${fn:length(list) > 0}">
						<c:forEach items="${list}" var="row">
							<tr>
								<td>${fn:substring(row.OFFER_DATE,0,4)}년 ${fn:substring(row.OFFER_DATE,4,6)}월 ${fn:substring(row.OFFER_DATE,6,8)}일</td>
								<td>${fn:substring(row.OFFER_NO,9,10)}번</td>
								<td>${row.OFFER_NO}</td>
								<td>
									<c:choose>
										<c:when test="${map.work_gb eq 'WK01'}">
											<c:choose>
												<c:when test="${row.MAGAM_GB eq '1'}">
													입고수량작업중
												</c:when>
												<c:when test="${row.MAGAM_GB eq '2'}">
													진열수량작업중
												</c:when>
												<c:when test="${row.MAGAM_GB eq '3'}">
													마감작업중
												</c:when>
												<c:when test="${row.MAGAM_GB eq '4'}">
													마감
												</c:when>
											</c:choose> 
										</c:when>
										<c:when test="${map.work_gb eq 'WK02'}">
											<c:choose>
												<c:when test="${row.MAGAM_GB eq '3'}">
													재고수량작업중
												</c:when>
												<c:when test="${row.MAGAM_GB eq '4'}">
													마감
												</c:when>
											</c:choose> 
										</c:when>
									</c:choose>
									
								</td>
								<td>${row.MAGAM_DATE}</td>
								<td>${row.UPDATE_DATE}</td>
								<td>${row.BIGO}</td>
								<c:choose>
									<c:when test="${row.WORK_GB  eq 'WK01'}">
									<td><button id="detail" class="ui button" type="button" onclick="detail_ipgo('${row.OFFER_NO}','${row.WORK_GB}','V',${row.MAGAM_GB},'B')">${row.WORK_KOR} 작업내용확인</button></td>
									</c:when>
									<c:when test="${row.WORK_GB  eq 'WK02'}">
									<td><button id="detail" class="ui button" type="button" onclick="detail_jego('${row.OFFER_NO}','${row.WORK_GB}','V',${row.MAGAM_GB},'A')">${row.WORK_KOR} 작업내용확인</button></td>
									</c:when>
								</c:choose>
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
			<tfoot>
				<tr>
					<th colspan="10">
						<div class="ui right floated pagination menu">
						
							<c:choose>
								<c:when test="${map.name != null || map.id != null}">
									<a class="item" href="product_v2.do?strdate=&enddate=&work_gb=${map.work_gb}&page=1"><i class="angle double left icon"></i></a>
								</c:when>
								<c:otherwise>
									<a class="icon item" href="product_v2.do?strdate=&enddate=&work_gb=${map.work_gb}&page=1"><i class="angle double left icon"></i></a>
								</c:otherwise>
							</c:choose>
							
							<c:choose>
								<c:when test="${map.currentBlock > 1}">
									<c:choose>
										<c:when test="${map.name != null || map.id != null}">
											<a class="item" href="product_v2.do?strdate=&enddate=&work_gb=${map.work_gb}&page=${map.startPage-1}"><i class="angle left icon"></i></a>
										</c:when>  
										<c:otherwise>
											<a class="icon item" href="product_v2.do?strdate=&enddate=&work_gb=${map.work_gb}&page=${map.startPage-1}"><i class="angle left icon"></i></a>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<a class="icon item" href="#"><i class="angle left icon"></i></a>
								</c:otherwise>
							</c:choose>
							
							<%-- <c:choose>
								<c:when test="${currentPage > 1}">
									<a class="icon item" href="user.do?page=${currentPage-1}">이전</a>
								</c:when>
								<c:otherwise>
									<a class="icon item" href="#">이전</a>
								</c:otherwise>
							</c:choose> --%>
							
							<c:forEach var="i" begin="${map.startPage}" end="${map.endPage}" step="1">
								<c:choose>
									<c:when test="${map.currentPage == i}">
										<a class="item" href="#" style="background-color: gainsboro;"><font size="3" style="font-weight: bold;">${i}</font></a>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${map.name != null || map.id != null}">
												<a class="item" href="product_v2.do?strdate=&enddate=&work_gb=${map.work_gb}&page=${i}">${i}</a>
											</c:when>
											<c:otherwise>
												<a class="item" href="product_v2.do?strdate=&enddate=&work_gb=${map.work_gb}&page=${i}">${i}</a>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
							<%-- <c:choose>
								<c:when test="${currentPage < totalPage}">
									<a class="icon item" href="user.do?page=${currentPage+1}">다음</a>
								</c:when>
								<c:otherwise>
									<a class="icon item" href="#">다음</a>
								</c:otherwise>
							</c:choose> --%>
							
							<c:choose>
								<c:when test="${map.totalPage > map.endPage}">
									<c:choose>
										<c:when test="${map.name != null || map.id != null}">
											<a class="item" href="product_v2.do?strdate=&enddate=&work_gb=${map.work_gb}&page=${map.endPage+1}"><i class="angle right icon"></i></a>
										</c:when>
										<c:otherwise>
											<a class="icon item" href="product_v2.do?strdate=&enddate=&work_gb=${map.work_gb}&page=${map.endPage+1}"><i class="angle right icon"></i></a>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<a class="icon item" href="#"><i class="angle right icon"></i></a>
								</c:otherwise>
							</c:choose>

							<c:choose>
								<c:when test="${map.name != null || map.id != null}">
									<a class="item" href="product_v2.do?strdate=&enddate=&work_gb=${map.work_gb}&page=${map.totalPage}"><i class="angle double right icon"></i></a>
								</c:when>
								<c:otherwise>
									<a class="icon item" href="product_v2.do?strdate=&enddate=&work_gb=${map.work_gb}&page=${map.totalPage}"><i class="angle double right icon"></i></a>
								</c:otherwise>
							</c:choose>
						
						</div>
					</th>
				</tr>
			</tfoot>
		</table>
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
