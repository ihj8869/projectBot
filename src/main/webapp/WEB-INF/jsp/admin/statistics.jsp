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

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>

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
		var static_gb = $("#static_gb").val();
		var grouping = $("#grouping").val();
		
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
		
		document.location.href="statistics.do?strdate="+strdate+"&enddate="+enddate+"&static_gb="+static_gb+"&grouping="+grouping;
	};
	
	$("#search").click(function(){ //검색 돋보기 아이콘 클릭시
		search();
	});
	
	
	$("input[name=search]").keydown(function(key){ //검색 input에서 엔터키(13) 클릭시
		if(key.keyCode == 13){
			search();
		}
	});
	
	
	
	var categories_name = new Array();
	
	var aJsonArray = new Array();
	
	
	
	
	<c:choose>
	<c:when test="${fn:length(static_get_offer_no) > 0}">
		<c:forEach items="${static_get_offer_no}" var="row">
			categories_name.push("${row.OFFER_NO}");
		</c:forEach>
	</c:when>
	</c:choose>
	
	
	
	
	<c:choose>
		<c:when test="${fn:length(static_get_wk01) > 0}">
			<c:forEach items="${static_get_wk01}" var="row" varStatus="status">
			
			var aJson = new Object();
			var qty = new Array();
			
			aJson.name = "${row.CODE_B_NM}";
			
			
			<c:choose>
				<c:when test="${fn:length(static_get_wk01_qty) > 0}">
					<c:forEach items="${static_get_wk01_qty}" var="rowqty" varStatus="statusqty">
					
					<c:if test="${rowqty.CODE_B eq row.CODE_B}">
						
						qty.push(${rowqty.QTY});
					
					</c:if>
					
					
						
					</c:forEach>
				</c:when>
			</c:choose>	
			
			
			aJson.data = qty;
			
			
			aJsonArray.push(aJson);
			
				
			</c:forEach>
		</c:when>
	</c:choose>
	


	Highcharts.chart('container', {
	    chart: {
	        type: 'line'
	    },
	    title: {
	        text: '매장 통계'
	    },
	    subtitle: {
	        text: 'Programming by Hyunwoo'
	    },
	    xAxis: {
	        categories: categories_name
	    },
	    yAxis: {
	        title: {
	            text: '수량'
	        }
	    },
	    plotOptions: {
	        line: {
	            dataLabels: {
	                enabled: true
	            },
	            enableMouseTracking: false
	        }
	    },
	    series: aJsonArray
	    
	});
	
});

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
	  <h1 class="ui dividing header" style="font-weight: 100;">매장통계</h1>
		<input type="hidden" name="work_gb" id="work_gb" value="${map.work_gb}"> 
		<table class="ui fixed single line celled table" style="width: 100%;" align="right">
			<tr>
				<td style="width:5%;">통계<br>범위</td>
				<td style="width:35%;">
					<div class="ui input" >
						<input  type="date" id="date_from" >
					</div> ~ 
					<div class="ui input" >
						<input type="date" id="date_to" >
					</div>
				</td>
				
				<td style="width:5%;">그룹</td>
				<td style="width:22%;">
					<div class="ui input">
						<select id="grouping" name="grouping">
							<option value="offer_no">작업번호별</option>
						</select>
					</div>
				</td>
				
				<td style="width:5%;">통계</td>
				<td style="width:22%;">
					<div class="ui input">
						<select id="static_gb" name="static_gb">
							<option value="WK01">입고 수량</option>
							<option value="WK02">재고 수량</option>
							<option value="WK04">판매 수량</option>
					</div>
				</td>
				
				<td style="width:6%;"><i id="search" name="search" class="search icon" style="cursor: pointer;"></i></td>
			</tr>
		</table>
		${map.strdate} ~ ${map.enddate} 작업번호별 입고 수량 통계
		
		<div id="container" style="min-width: 310px; height: 550px; margin: 0 auto"></div>
		
		
		
		
		
		<br><br><br><br><br>
		<br><br>
		<br><br><br><br><br>
		<br><br>
		
		
		
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
