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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/1.11.8/semantic.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	if($("#email").val()==''){
		alert('세션이 종료되었습니다. 다시 로그인해주세요.');
		document.location.href="/index.jsp"
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

<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-white w3-animate-left" style="z-index:3;width:300px;" id="mySidebar"><br>
  <div class="w3-container">
    <a href="#" onclick="w3_close()" class="w3-hide-large w3-right w3-jumbo w3-padding w3-hover-grey" title="close menu">
      <i class="fa fa-remove"></i>
    </a>
    <img src="img/login.jpg" style="width:45%;" class="w3-round"><br><br>
    <h4><b>아름다운가게</b></h4>
    <p class="w3-text-grey">재고관리시스템 </p>
  </div>
  <div class="w3-bar-block">
    <a href="main.do?year=<%=nowyear%>&month=<%=nowmonth %>" onclick="w3_close()" class="w3-bar-item w3-button w3-padding w3-text-teal"><i class="fa fa-th-large fa-fw w3-margin-right"></i>메인 - 월별작업목록</a> 
    <a href="Code.do" onclick="w3_close()" class="w3-bar-item w3-button w3-padding"><i class="fa fa-th-large fa-fw w3-margin-right"></i>코드관리 </a>
    <a href="#about" onclick="w3_close()" class="w3-bar-item w3-button w3-padding"><i class="fa fa-th-large fa-fw w3-margin-right"></i>입고재고관리</a> 
    <a href="#contact" onclick="w3_close()" class="w3-bar-item w3-button w3-padding"><i class="fa fa-th-large fa-fw w3-margin-right"></i>통계관리</a>
    <a href="#contact" onclick="w3_close()" class="w3-bar-item w3-button w3-padding"><i class="fa fa-th-large fa-fw w3-margin-right"></i>사용자관리</a>
     <a href="#contact" onclick="w3_close()" class="w3-bar-item w3-button w3-padding"><i class="fa fa-th-large fa-fw w3-margin-right"></i>로그아웃</a>
  </div>
</nav>

<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:300px">

  <!-- Header -->
  <header id="portfolio">
    <a href="#"><img src="/w3images/avatar_g2.jpg" style="width:65px;" class="w3-circle w3-right w3-margin w3-hide-large w3-hover-opacity"></a>
    <span class="w3-button w3-hide-large w3-xxlarge w3-hover-text-grey" onclick="w3_open()"><i class="fa fa-bars"></i></span>
    <div class="w3-container">
    <h1><b>월별 작업 목록</b></h1>
    
  	<form name="calendarFrm" id="calendarFrm" action="" method="post" align="center">
		<div id="content" style="width:100%;" >

			<!--날짜 네비게이션  -->
			<table width="100%" border="0" cellspacing="1" cellpadding="1" id="KOO">
				<tr>
					<td height="60">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="10"></td>
							</tr>
							<tr>
								<td align="center" style="font-size: 20pt">
								<h2 class="ui dividing header" style="font-weight: 100;">
									<a href="main.do?year=<%=year-1%>&amp;month=<%=month%>" target="_self" class="w3-bar-item w3-button w3-hover-black">««</a>
									<%if(month > 0 ){ %>
										<a href="main.do?year=<%=year%>&amp;month=<%=month-1%>" target="_self"  class="w3-bar-item w3-button w3-hover-black">«</a>
									<%} else {%>
										<a href="main.do?year=<%=year-1%>&amp;month=<%=11%>" target="_self" class="w3-bar-item w3-button w3-hover-black">«</a>
									<%} %>
									&nbsp;&nbsp;
										<%=year%>년
										<%=month+1%>월
									&nbsp;&nbsp;
									<%if(month < 11 ){ %>
									<a href="main.do?year=<%=year%>&amp;month=<%=month+1%>" target="_self" class="w3-bar-item w3-button w3-hover-black">»</a>
									<%}else{%>
										<a href="main.do?year=<%=year+1%>&amp;month=<%=0%>" target="_self" class="w3-bar-item w3-button w3-hover-black">»</a>
									<%} %>
									<a href="main.do?year=<%=year+1%>&amp;month=<%=month%>" target="_self" class="w3-bar-item w3-button w3-hover-black">»»</a>
								</h2>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<br>
			<table border="1" cellspacing="1" cellpadding="1" bgcolor="#FFFFFF" style="border-color: rgba(0,0,0,.05); width:100%; margin-top:-30px;">
				<thead>
				<tr bgcolor="#CECECE">
					<td width='100px'>
						<div align="center"><font color="red">일</font></div>
					</td>
					<td width='100px'>
						<div align="center">월</div>
					</td>
					<td width='100px'>
						<div align="center">화</div>
					</td>
					<td width='100px'>
						<div align="center">수</div>
					</td>
					<td width='100px'>
						<div align="center">목</div>
					</td>
					<td width='100px'>
						<div align="center">금</div>
					</td>
					<td width='100px'>
						<div align="center"><font color="#529dbc">토</font></div>
					</td>
				</tr>
				</thead>
				<tbody>
				<tr>
				<%
					//처음 빈공란 표시
					for(int index = 1; index < start ; index++ ){
						out.println("<td >&nbsp;</td>");
						newLine++;
					}
					for(int index = 1; index <= endDay; index++){
						String color = "";
						if(newLine == 0){
							color = "RED";
						}else if(newLine == 6){
							color = "#529dbc";
						}else{
							color = "BLACK";
						}
						String sUseDate = Integer.toString(year);
						sUseDate += Integer.toString(month+1).length() == 1 ? "0" + Integer.toString(month+1) : Integer.toString(month+1);
						sUseDate += Integer.toString(index).length() == 1 ? "0" + Integer.toString(index) : Integer.toString(index);
						int iUseDate = Integer.parseInt(sUseDate);
						String backColor = "#EFEFEF";
						
						if(iUseDate == intToday ) {
							backColor = "#c9c9c9";
						}
						out.println("<td valign='top' align='left' height='92px' bgcolor='"+backColor+"' nowrap>");
				%>
				<font color='<%=color%>'>
				<%=index %>
				<c:choose>
  				<c:when test="${fn:length(list) > 0}">
  					<c:forEach items="${list}" var="row">
  						<c:set var='iUseDate' value="<%=iUseDate%>"/>
  						<c:if test="${row.WORK_DATE==iUseDate&&row.WORK_GB=='WK02'}">
  						<br>
  						<a href="managePd.do" class="item"> 
							<i class="fa fa-calendar-check-o"></i>  재고작업
						</a>
  						<!-- <i class="shop icon" style="zoom:1.8;"></i>  -->
  						</c:if>
  						<c:if test="${row.WORK_DATE==iUseDate&&row.WORK_GB=='WK01'}">
  						<br>
  						<a href="managePd.do" class="item"> 
							<i class="fa fa-linkedin w3-hover-opacity"></i> 입고작업
						</a>
  						</c:if>
  							
  					</c:forEach>
  				</c:when>
    			</c:choose>
				
				
				
				<%
				
				%>
				</font>
				<%
					out.println("<br>");
					//out.println(iUseDate); //20180101 표기
					out.println("<br>");
					//기능 제거
					out.println("</td>");
					newLine++;
					if(newLine == 7){
						out.println("</tr>");
						
						if(index <= endDay){
							out.println("<tr>");
						}
						newLine=0;
					}
				}
					
				//마지막 공란 LOOP
				while(newLine > 0 && newLine < 7){
					out.println("<td>&nbsp;</td>");
					newLine++;
				}
				%>
				</tr>
				</tbody>
			</table>
		</div>
		
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
