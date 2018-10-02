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
	
	$(".use_gb").each(function(){ //중지회원 빨갛게 표시
		if($(this).val()=='N'){
			$(this).parent().parent().attr('class','error');
		}
	});
	
	search = function(){ //코드이름으로 검색
		var name = $("#searchName").val();
		var use = $("#searchUse").val();
		var code_gb = $("#code_gb").val();
		
		document.location.href="code_v2.do?name="+name+"&use="+use+"&code_gb="+code_gb;
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

function infoPopup(code,insert_gb,code_gb){ //jquery 바깥에 선언해야함 <script> 안으로 빼기
	var cw =500; //창넓이
	var ch = 400; //창높이
	var sw = screen.availWidth;
	var sh = screen.availHeight;
	var px=(sw-cw)/2;
	var py=(sh-ch)/2;
	
	window.open('codeInfo_v2.do?code='+code+'&insert_gb='+insert_gb+'&code_gb='+code_gb , '', 'left='+px+',top='+py+',width='+cw+',height='+ch+', location=no, status=no, resizable=no, fullscreen=no, channelmode=no');
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
body #codeTr:hover{background-color:whitesmoke;}
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
																	<c:when test="${map.code_gb eq 'A'}">
																		재고코드 관리
																	</c:when>
																	<c:when test="${map.code_gb eq 'B'}">
																		입고코드 관리
																	</c:when>
																	<c:when test="${map.code_gb eq 'C'}">
																		진열코드 관리
																	</c:when>
																</c:choose> 
	  															
	  														</h1>	
		<table class="ui fixed single line celled table" style="width: 50%;" align="right">
			<tr>
				<td>품목명</td>
				<td>
					<div class="ui input">
						<input id="searchName" name="search" type="text">
					</div>
				</td>
				<td>사용여부</td>
				<td>
					<div class="ui input">
						<select id="searchUse" name="search">
							<option value=""></option>
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
					</div>
					<input id="code_gb" name="code_gb" type="hidden"  value="${map.code_gb}">
				</td>
				<td><i id="search" class="search icon" style="cursor: pointer;"></i></td>
			</tr>
		</table>
		
		<button id="modify" class="ui button" onclick="infoPopup('0000','I','${map.code_gb}')">신규품목코드 입력</button>
		
		<table class="ui celled table">
			<thead>
				<tr>
					<th style="width:7%;text-align:center;">코드</th>
					<th style="width:19%;text-align:center;">코드명</th>
					<th style="width:9%;text-align:center;">상위코드</th>
					<th style="width:19%;text-align:center;">상위코드명</th>
					<th style="width:13%;text-align:center;">생성날짜</th>
					<th style="width:13%;text-align:center;">중지날짜</th>
					<th style="width:12%;text-align:center;">업데이트<br>날짜</th>
					<th style="width:8%;text-align:center;">사용여부</th>
				</tr>
			</thead>
			<tbody id="memberTb">
				<c:choose>
					<c:when test="${fn:length(list) > 0}">
						<c:forEach items="${list}" var="row">
							<tr id="codeTr" name="codeTr" onclick="infoPopup('${row.CODE}','U','${map.code_gb}')" style="cursor:pointer">
								<td>${row.CODE}</td>
								<td>${row.CODE_NM}</td>
								<td>${row.UP_CODE}</td>
								<td>${row.UP_CODE_NM}</td>
								<td>${fn:substring(row.STAR_DATE,0,4)}년 ${fn:substring(row.STAR_DATE,4,6)}월 ${fn:substring(row.STAR_DATE,6,8)}일</td>
								<td>
									<c:choose>
										<c:when test="${row.END_DATE != null}">
											${fn:substring(row.END_DATE,0,4)}년 ${fn:substring(row.END_DATE,4,6)}월 ${fn:substring(row.END_DATE,6,8)}일
										</c:when>
									</c:choose>
								</td>
								<td>${row.UPDATE_DATE}</td>
								<td>${row.USE_YN}<input type="hidden" class="use_gb" value="${row.USE_GB}"></td>
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
									<a class="item" href="code_v2.do?code_gb=${map.code_gb}&page=1&name=${map.name}&id=${map.id}"><i class="angle double left icon"></i></a>
								</c:when>
								<c:otherwise>
									<a class="icon item" href="code_v2.do?code_gb=${map.code_gb}&page=1"><i class="angle double left icon"></i></a>
								</c:otherwise>
							</c:choose>
							
							<c:choose>
								<c:when test="${map.currentBlock > 1}">
									<c:choose>
										<c:when test="${map.name != null || map.id != null}">
											<a class="item" href="code_v2.do?code_gb=${map.code_gb}&page=${map.startPage-1}&name=${map.name}&id=${map.id}"><i class="angle left icon"></i></a>
										</c:when>
										<c:otherwise>
											<a class="icon item" href="code_v2.do?code_gb=${map.code_gb}&page=${map.startPage-1}"><i class="angle left icon"></i></a>
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
												<a class="item" href="code_v2.do?code_gb=${map.code_gb}&page=${i}&name=${map.name}&id=${map.id}">${i}</a>
											</c:when>
											<c:otherwise>
												<a class="item" href="code_v2.do?code_gb=${map.code_gb}&page=${i}">${i}</a>
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
											<a class="item" href="code_v2.do?code_gb=${map.code_gb}&page=${map.endPage+1}&name=${map.name}&id=${map.id}"><i class="angle right icon"></i></a>
										</c:when>
										<c:otherwise>
											<a class="icon item" href="code_v2.do?code_gb=${map.code_gb}&page=${map.endPage+1}"><i class="angle right icon"></i></a>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<a class="icon item" href="#"><i class="angle right icon"></i></a>
								</c:otherwise>
							</c:choose>

							<c:choose>
								<c:when test="${map.name != null || map.id != null}">
									<a class="item" href="code_v2.do?code_gb=${map.code_gb}&page=${map.totalPage}&name=${map.name}&id=${map.id}"><i class="angle double right icon"></i></a>
								</c:when>
								<c:otherwise>
									<a class="icon item" href="code_v2.do?code_gb=${map.code_gb}&page=${map.totalPage}"><i class="angle double right icon"></i></a>
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
