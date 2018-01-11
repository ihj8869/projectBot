<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1" content="text/html; charset=UTF-8">
<title>아름다운가게 재고관리시스템</title>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/1.11.8/semantic.min.css"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/1.11.8/semantic.min.js"></script>

<style TYPE="text/css">
body {
	scrollbar-face-color: #F6F6F6;
	scrollbar-highlight-color: #bbbbbb;
	scrollbar-3dlight-color: #FFFFFF;
	scrollbar-shadow-color: #bbbbbb;
	scrollbar-darkshadow-color: #FFFFFF;
	scrollbar-track-color: #FFFFFF;
	scrollbar-arrow-color: #bbbbbb;
	margin-left:"0px"; margin-right:"0px"; margin-top:"0px"; margin-bottom:"0px";
}
td {font-family: "돋움"; font-size: 9pt; color:#595959;}
th {font-family: "돋움"; font-size: 9pt; color:#000000;}
select {font-family: "돋움"; font-size: 9pt; color:#595959;}
.divDotText {
	overflow:hidden;
	text-overflow:ellipsis;
}
A:link { font-size:9pt; font-family:"돋움";color:#000000; text-decoration:none; }
A:visited { font-size:9pt; font-family:"돋움";color:#000000; text-decoration:none; }
A:active { font-size:9pt; font-family:"돋움";color:red; text-decoration:none; }
A:hover { font-size:9pt; font-family:"돋움";color:red;text-decoration:none;}
</style>

<%
	Calendar cal = Calendar.getInstance();
	String strYear = request.getParameter("year");
	String strMonth = request.getParameter("month");
	String temp = "20180115"; //테스트 날짜(아이콘 삽입)
	
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

<script type="text/javascript">
$(document).ready(function(){
	$("#sidebar").click(function(){ //사이드바 클릭
		$('.ui.labeled.icon.sidebar').sidebar('toggle');
	});
	
	$("#todayBtn").click(function(){ //오늘 버튼 클릭
		document.location.href="main.do";
	});
});
</script>
</head>

<body>
	<h2 class="ui block header"><i id="sidebar" class="sidebar icon" style="zoom: 0.5; cursor: pointer;"></i>아름다운가게 재고관리시스템</h2>
	<%-- ${email} 님 환영합니다. --%>
	<input type="hidden" id="email" value="${email}">
	<%-- <br>
	${map} --%>
	<div class="ui left demo vertical inverted sidebar labeled icon menu">
		<a href="main.do" class="item"> 
			<i class="home icon"></i> Home
		</a>
		<a href="manageMember.do" class="item"> 
			<i class="barcode icon"></i> 코드관리
		</a> 
		<a href="managePd.do" class="item"> 
			<i class="shop icon"></i> 입고재고관리
		</a>
		<a href="#" class="item"> 
			<i class="bar chart icon"></i> 통계관리
		</a>
		<a href="#" class="item"> 
			<i class="users icon"></i> 사용자관리
		</a>
	</div>

	<form name="calendarFrm" id="calendarFrm" action="" method="post">
		<div id="content" style="width:100%;">
			<table width="100%" border="0" cellspacing="1" cellpadding="1">
				<tr>
					<td align="right">
						<h3>
						<i class="shipping icon" style="zoom:1.8;"></i>입고
						<i class="shop icon" style="zoom:1.8;"></i>재고&nbsp;&nbsp;
						<button class="ui button" id="todayBtn" type="button">오늘</button>&nbsp;&nbsp;
						<!-- type="button"으로 form안에 있는 버튼이 submit 되는걸 방지 -->
						</h3>
					</td>
				</tr>
			</table>
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
									<a href="main.do?year=<%=year-1%>&amp;month=<%=month%>" target="_self">
										<i class="angle double left icon" style="zoom:2.0;"></i><!-- 이전해 -->
									</a>
									<%if(month > 0 ){ %>
									<a href="main.do?year=<%=year%>&amp;month=<%=month-1%>" target="_self">
										<i class="angle left icon" style="zoom:2.0;"></i><!-- 이전달 -->
									</a>
									<%} else {%>
										<a href="#"><i class="angle left icon" style="zoom:2.0;"></i></a>
									<%} %>
									&nbsp;&nbsp;
										<%=year%>년
										<%=month+1%>월
									&nbsp;&nbsp;
									<%if(month < 11 ){ %>
									<a href="main.do?year=<%=year%>&amp;month=<%=month+1%>" target="_self">
										<i class="angle right icon" style="zoom:2.0;"></i><!-- 다음달 -->
									</a>
									<%}else{%>
										<a href="#"><i class="angle right icon" style="zoom:2.0;"></i></a>
									<%} %>
									<a href="main.do?year=<%=year+1%>&amp;month=<%=month%>" target="_self">
										<i class="angle double right icon" style="zoom:2.0;"></i><!-- 다음해 -->
									</a>
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
				<%
				if(index==Integer.parseInt(temp.substring(6, 8))){ //index:1~31, temp:임시날짜 
				%>
				<br><i class="shipping icon" style="zoom:1.8;"></i><i class="shop icon" style="zoom:1.8;"></i>
				<%
				}
				%>
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
</body>
</html>