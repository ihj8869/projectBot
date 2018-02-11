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
	
	$('button[id^="delete"]').click(function(){ //버튼 배열 id로 가져오기
		var no = $(this).val();
		var flag = $(this).text();
		
		if(flag=='삭제'){
			var msg = '회원을 삭제하시겠습니까?';
			flag = 'delete';
			
			if(confirm(msg)!=0){
				document.location.href="deleteMember.do?no="+no+"&flag="+flag;
			}else{
				return;
			}	
		} else if(flag=='복구'){
			var msg = '회원을 복구하시겠습니까?';
			flag = 'restore';
			
			if(confirm(msg)!=0){
				document.location.href="deleteMember.do?no="+no+"&flag="+flag;
			}else{
				return;
			}	
		}
	});
	
	$('button[id^="save"]').click(function(){ //버튼 배열 id로 가져오기
		
		
		alert("test12345");
		alert($("input[name='QTY_ST02']")[0].value);
		alert($("input[name='QTY_ST02']")[1].value);
		alert(parseInt($("input[name='QTY_ST02']")[0].value)+parseInt($("input[name='QTY_ST02']")[1].value));
	});
	
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

function modification(offer_no,work_gb,insert_gb){ //jquery 바깥에 선언해야함 <script> 안으로 빼기
	 location.href="product_detail.do?offer_no="+offer_no+"&work_gb="+work_gb+"&insert_gb="+insert_gb;
}

function checkQTY(name,line){
	var linecheck = line-1;
	var aa = "TOTAL_QTY";
	var bb = "QTY_ST02";
	var cc = "QTY_ST01";
	var Paa = "PRE_TOTAL_QTY";
	var Pbb = "PRE_QTY_ST02";
	var Pcc = "PRE_QTY_ST01";
	var Eaa = "END_TOTAL_QTY";
	var Ebb = "END_QTY_ST02";
	var Ecc = "END_QTY_ST01";
			
	if(name==aa){
		if(parseInt($("input[name='"+aa+"']")[linecheck].value) < parseInt($("input[name='"+bb+"']")[linecheck].value)+parseInt($("input[name='"+cc+"']")[linecheck].value)){
			alert("합계수량이 창고,진열 작업수량보다 적습니다.");
			$("input[name='"+aa+"']")[linecheck].value = "";
			return;
		}
		$("input[name='"+Eaa+"']")[linecheck].value = parseInt($("input[name='"+aa+"']")[linecheck].value)+parseInt($("input[name='"+Paa+"']")[linecheck].value);
	}else if(name==bb){
		if(parseInt($("input[name='"+aa+"']")[linecheck].value) < parseInt($("input[name='"+bb+"']")[linecheck].value)){
			alert("작업총수량보다 큽니다.");
			$("input[name='"+bb+"']")[linecheck].value = "";
			return;
		}
		$("input[name='"+cc+"']")[linecheck].value = parseInt($("input[name='"+aa+"']")[linecheck].value)-parseInt($("input[name='"+bb+"']")[linecheck].value);
		$("input[name='"+Ebb+"']")[linecheck].value = parseInt($("input[name='"+bb+"']")[linecheck].value)+parseInt($("input[name='"+Pbb+"']")[linecheck].value);
		$("input[name='"+Ecc+"']")[linecheck].value = parseInt($("input[name='"+cc+"']")[linecheck].value)+parseInt($("input[name='"+Pcc+"']")[linecheck].value);
	}else if(name==cc){
		if(parseInt($("input[name='"+aa+"']")[linecheck].value) < parseInt($("input[name='"+cc+"']")[linecheck].value)){
			alert("작업총수량보다 큽니다.");
			$("input[name='"+cc+"']")[linecheck].value = "";
			return;
		}
		$("input[name='"+bb+"']")[linecheck].value = parseInt($("input[name='"+aa+"']")[linecheck].value)-parseInt($("input[name='"+cc+"']")[linecheck].value);
		$("input[name='"+Ebb+"']")[linecheck].value = parseInt($("input[name='"+bb+"']")[linecheck].value)+parseInt($("input[name='"+Pbb+"']")[linecheck].value);
		$("input[name='"+Ecc+"']")[linecheck].value = parseInt($("input[name='"+cc+"']")[linecheck].value)+parseInt($("input[name='"+Pcc+"']")[linecheck].value);
	}else{
		return;
	}
}




</script>
<c:set var="flag" value="${flag}"/>
<%
	Calendar cal = Calendar.getInstance();
	String strYear = request.getParameter("year");
	String strMonth = request.getParameter("month");
	String flag = (String)pageContext.getAttribute("flag");
	
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
    <h1><b>작업내용 상세보기</b></h1>
    
<div style="padding-top: 50px; padding-left: 50px; padding-right: 50px; padding-bottom: 50px;">
		<table class="ui fixed single line celled table" style="width: 70%;" align="right">
			<tr>
				<td>작업날짜</td>
				<td>
					
				</td>
				
				<td>작업구분</td>
				<td>
					
				</td>
				<td></td>
			</tr>
			
		</table>
			<c:choose>
				<c:when test="${map.insert_gb  eq 'V' }">
					<button id="modification" class="ui button" type="button" onclick="modification('${map.offer_no}','${map.work_gb}','I')">작업수정</button>
				</c:when>
				<c:when test="${map.insert_gb  eq 'I' }">
					<button id="save" class="ui button" type="button" onclick="test">작업저장</button>
					<button id="modification" class="ui button" type="button" onclick="modification('${map.offer_no}','${map.work_gb}','I')">작업데이터복원</button>
				</c:when>
			</c:choose>
		<table class="ui celled table">
			<thead>
				<tr>
					<th style="width:5%;text-align:center;" rowspan="2" >품목<br>코드</th>
					<th style="width:23%;text-align:center;" rowspan="2" >품목명</th>
					<th style="width:24%;text-align:center;" colspan="3">입고/재고 작업전 수량</th>
					<th style="width:24%;text-align:center;" colspan="3">입고재고  작업수량</th>
					<th style="width:24%;text-align:center;" colspan="3">작업후수량</th>
				</tr>
				<tr >
					<th style="width:8%;text-align:center;">합계</th>
					<th style="width:8%;text-align:center;">창고</th>
					<th style="width:8%;text-align:center;">진열</th>
					<th style="width:8%;text-align:center;">합계</th>
					<th style="width:8%;text-align:center;">창고</th>
					<th style="width:8%;text-align:center;">진열</th>
					<th style="width:8%;text-align:center;">합계</th>
					<th style="width:8%;text-align:center;">창고</th>
					<th style="width:8%;text-align:center;">진열</th>
				</tr>
			</thead>
			<tbody >
				
				<c:choose>
					<c:when test="${fn:length(list) > 0}">
						<c:forEach items="${list}" var="row" varStatus="statu">
							<tr>
								<td>${row.PRO_GB}</td>
								<td>${row.KOR_NAME}</td>
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
											<input id="TOTAL_QTY_${statu.count}" name="TOTAL_QTY" type="text" class="ui celled table" value="${row.TOTAL_QTY}" style="text-align:right;" onchange="checkQTY('TOTAL_QTY','${statu.count}')">
										</c:when>
										<c:when test="${map.insert_gb  eq 'V' }">
											<input  type="text" class="ui celled table" value="${row.TOTAL_QTY}" style="text-align:right;background-color:transparent; border-style:none" readonly>
										</c:when>
									</c:choose>
								</td>
								<td style="text-align:right;">
									<c:choose>
										<c:when test="${map.insert_gb  eq 'I' }">
											<input id="QTY_ST02_${statu.count}" name="QTY_ST02" type="text" class="ui celled table"  value="${row.QTY_ST02}" style="text-align:right;" onchange="checkQTY('QTY_ST02','${statu.count}')">
										</c:when>
										<c:when test="${map.insert_gb  eq 'V' }">
											<input type="text" class="ui celled table" value="${row.QTY_ST02}" style="text-align:right;background-color:transparent; border-style:none" readonly>
										</c:when>
									</c:choose>
								</td>
								<td style="text-align:right;">
									<c:choose>
										<c:when test="${map.insert_gb  eq 'I' }">
											<input id="QTY_ST01_${statu.count}" name="QTY_ST01" type="text" class="ui celled table" value="${row.QTY_ST01}" style="text-align:right;" onchange="checkQTY('QTY_ST01','${statu.count}')">
										</c:when>
										<c:when test="${map.insert_gb  eq 'V' }">
											<input type="text" class="ui celled table" value="${row.QTY_ST01}" style="text-align:right;background-color:transparent; border-style:none" readonly>
										</c:when>
									</c:choose>
								</td>
								<td style="background-color: #F2F2F2;text-align:right;">
									<input type="text" name="END_TOTAL_QTY" class="ui celled table" value="${row.END_TOTAL_QTY}" style="text-align:right;background-color:transparent; border-style:none" readonly>
								</td>
								<td style="background-color: #F2F2F2;text-align:right;">
									<input type="text" name="END_QTY_ST02" class="ui celled table" value="${row.END_QTY_ST02}" style="text-align:right;background-color:transparent; border-style:none" readonly>
								</td>
								<td style="background-color: #F2F2F2;text-align:right;">
									<input type="text" name="END_QTY_ST01" class="ui celled table" value="${row.END_QTY_ST01}" style="text-align:right;background-color:transparent; border-style:none" readonly>
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
