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
		var strdate = $("#date_from").val();
		var enddate = $("#date_to").val();
		var workgb = $("#workgb").val();
		
		document.location.href="product.do?workgb="+workgb+"&strdate="+strdate+"&enddate="+enddate;
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

function detail_ipgo(offer_no,work_gb,vi){
	if(vi=='I'){
		var con = confirm("신규입력시 이전에 작업은 확정이되어 수정이 불가능합니다. 진행하시겠습니까?");
		if(con){
			if(offer_no == '0000000000'){
				 location.href="product_detail_ipgo.do?offer_no="+offer_no+"&work_gb="+work_gb+"&insert_gb=I";
			}
		}
	}else{
		location.href="product_detail_ipgo.do?offer_no="+offer_no+"&work_gb="+work_gb+"&insert_gb=V";
	}
	
}

function detail_jego(offer_no,work_gb,vi){
	if(vi=='I'){
		var con = confirm("신규입력시 이전에 작업은 확정이되어 수정이 불가능합니다. 진행하시겠습니까?");
		if(con){
			if(offer_no == '0000000000'){
				 location.href="product_detail_jego.do?offer_no="+offer_no+"&work_gb="+work_gb+"&insert_gb=I";
			}
		}
	}else{
		location.href="product_detail_jego.do?offer_no="+offer_no+"&work_gb="+work_gb+"&insert_gb=V";
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
    <h1><b>입고재고관리</b></h1>
    
<div style="padding-top: 50px; padding-left: 50px; padding-right: 50px; padding-bottom: 50px;">
		<table class="ui fixed single line celled table" style="width: 70%;" align="right">
			<tr>
				<td>작업날짜</td>
				<td>
					<div class="ui input" >
						<input id="date_from" name="date_from" type="text">
					</div> ~ 
					<div class="ui input" >
						<input id="date_to" name="date_to" type="text">
					</div>
				</td>
				
				<td>작업구분</td>
				<td>
					<div class="ui input">
						<select id="workgb" name="workgb">
							<option value="%"></option>
							<option value="WK01">입고작업</option>
							<option value="WK02">재고작업</option>
							<option value="WK03">판매작업</option>
						</select>
					</div>
				</td>
				<td><i id="search" class="search icon" style="cursor: pointer;"></i></td>
			</tr>
		</table>
				<button id="detail" class="ui button" type="button" onclick="detail_ipgo('0000000000','WK01','I')">신규입고작업</button>
				<button id="delete" class="ui button" type="button" onclick="detail_jego('0000000000','WK02','I')">신규재고작업</button>
		<table class="ui celled table">
			<thead>
				<tr>
					<th style="width:13%;">작업날짜</th>
					<th style="width:13%;">작업순서</th>
					<th style="width:13%;">작업번호</th>
					<th style="width:31%;">작업구분</th>
					<th style="width:10%;">마감여부</th>
					<th style="width:20%;">작업내용확인</th>
				</tr>
			</thead>
			<tbody id="memberTb">
				<c:choose>
					<c:when test="${fn:length(list) > 0}">
						<c:forEach items="${list}" var="row">
							<tr>
								<td>${row.WORK_DATE}</td>
								<td>${row.WORK_NUM}번</td>
								<td>${row.OFFER_NO}</td>
								<td>${row.WORK_KOR}작업</td>
								<td>${row.MAGAM_GB}</td>
								<c:choose>
									<c:when test="${row.WORK_GB  eq 'WK01'}">
									<td><button id="detail" class="ui button" type="button" onclick="detail_ipgo('${row.OFFER_NO}','${row.WORK_GB}','V')">${row.WORK_KOR} 작업내용확인</button></td>
									</c:when>
									<c:when test="${row.WORK_GB  eq 'WK02'}">
									<td><button id="detail" class="ui button" type="button" onclick="detail_jego('${row.OFFER_NO}','${row.WORK_GB}','V')">${row.WORK_KOR} 작업내용확인</button></td>
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
									<a class="item" href="product.do?strdate=&enddate=&workgb=&page=1"><i class="angle double left icon"></i></a>
								</c:when>
								<c:otherwise>
									<a class="icon item" href="product.do?strdate=&enddate=&workgb=&page=1"><i class="angle double left icon"></i></a>
								</c:otherwise>
							</c:choose>
							
							<c:choose>
								<c:when test="${map.currentBlock > 1}">
									<c:choose>
										<c:when test="${map.name != null || map.id != null}">
											<a class="item" href="product.do?strdate=&enddate=&workgb=&page=${map.startPage-1}"><i class="angle left icon"></i></a>
										</c:when>
										<c:otherwise>
											<a class="icon item" href="product.do?strdate=&enddate=&workgb=&page=${map.startPage-1}"><i class="angle left icon"></i></a>
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
												<a class="item" href="product.do?strdate=&enddate=&workgb=&page=${i}">${i}</a>
											</c:when>
											<c:otherwise>
												<a class="item" href="product.do?strdate=&enddate=&workgb=&page=${i}">${i}</a>
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
											<a class="item" href="product.do?strdate=&enddate=&workgb=&page=${map.endPage+1}"><i class="angle right icon"></i></a>
										</c:when>
										<c:otherwise>
											<a class="icon item" href="product.do?strdate=&enddate=&workgb=&page=${map.endPage+1}"><i class="angle right icon"></i></a>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<a class="icon item" href="#"><i class="angle right icon"></i></a>
								</c:otherwise>
							</c:choose>

							<c:choose>
								<c:when test="${map.name != null || map.id != null}">
									<a class="item" href="product.do?strdate=&enddate=&workgb=&page=${map.totalPage}"><i class="angle double right icon"></i></a>
								</c:when>
								<c:otherwise>
									<a class="icon item" href="product.do?strdate=&enddate=&workgb=&page=${map.totalPage}"><i class="angle double right icon"></i></a>
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
