<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
<c:set var="side" value="${side}"/>
<%
	Calendar cal = Calendar.getInstance();
	String strYear = request.getParameter("year");
	String strMonth = request.getParameter("month");
	
	String side = (String)pageContext.getAttribute("side");
	
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
<nav class="w3-sidebar w3-collapse w3-white w3-animate-left" style="z-index:3;width:300px; " id="mySidebar"><br>
  <div class="w3-container">
    <a href="#" onclick="w3_close()" class="w3-hide-large w3-right w3-jumbo w3-padding w3-hover-grey" title="close menu">
      <i class="fa fa-remove"></i>
    </a>
    <img src="img/login.jpg" style="width:45%;" class="w3-round"><br><br>
    <h4><b>아름다운가게</b></h4>
    <p class="w3-text-grey">재고관리시스템 </p>
  </div>
  <div class="w3-bar-block">
    <a href="main.do?year=<%=nowyear%>&month=<%=nowmonth %>" onclick="w3_close()"  class="w3-bar-item w3-button w3-padding <%if(side.equals("main")){ %>w3-text-teal<%}%>"><i class="fa fa-th-large fa-fw w3-margin-right"></i>메인 - 월별작업목록</a> 
    <a href="code.do" onclick="w3_close()" class="w3-bar-item w3-button w3-padding  <%if(side.equals("code")){ %>w3-text-teal<%}%>"><i class="fa fa-th-large fa-fw w3-margin-right"></i>코드관리 </a>
    <a href="product.do?strdate=&enddate=&workgb=" onclick="w3_close()" class="w3-bar-item w3-button w3-padding <%if(side.equals("product")){ %>w3-text-teal<%}%>"><i class="fa fa-th-large fa-fw w3-margin-right"></i>입고재고관리</a> 
    <a href="#" onclick="w3_close()" class="w3-bar-item w3-button w3-padding <%if(side.equals("xx")){ %>w3-text-teal<%}%>"><i class="fa fa-th-large fa-fw w3-margin-right"></i>통계관리</a>
    <a href="user.do" onclick="w3_close()" class="w3-bar-item w3-button w3-padding <%if(side.equals("user")){ %>w3-text-teal<%}%>"><i class="fa fa-th-large fa-fw w3-margin-right"></i>사용자관리</a>
    <a href="logout.do" onclick="w3_close()" class="w3-bar-item w3-button w3-padding"><i class="fa fa-th-large fa-fw w3-margin-right"></i>로그아웃</a>
  </div>
</nav>
<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>
    
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
