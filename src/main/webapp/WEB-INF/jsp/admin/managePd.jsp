<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1" content="text/html; charset=UTF-8">
<title>아름다운가게 재고관리시스템</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/1.11.8/semantic.min.css"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/1.11.8/semantic.min.js"></script>
    
<script type="text/javascript">
$(document).ready(function() {
	
	$("#sidebar").click(function(){ //사이드바 클릭시
		$('.ui.labeled.icon.sidebar').sidebar('toggle');
	});
	
});

</script>
</head>

<body>
<%-- ${list} --%>
	<h2 class="ui block header"><i id="sidebar" class="sidebar icon" style="zoom: 0.5; cursor: pointer;"></i>아름다운가게 재고관리시스템</h2>

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
	
	<div style="padding-top: 3%; padding-left: 3%; padding-right: 3%; padding-bottom: 3%;">
	  <h2 class="ui dividing header" style="font-weight: 100;">입고재고관리</h2>
	  <table class="ui fixed single line celled table" style="width: 50%;" align="right">
	  	<tr>
			<!-- <td>코드</td>
			<td>
				<div class="ui input">
					<input id="searchName" name="search" type="text">
				</div>
			</td>
			<td>아이디</td>
			<td>
				<div class="ui input">
					<input id="searchId" name="search" type="text">
				</div>
			</td>
			<td><i id="search" class="search icon" style="cursor: pointer;"></i></td> -->
		</tr>
	  </table>
	  <table class="ui unstackable table">
	  	<thead>
  			<tr>
    			<th>상품구분</th>
    			<th>판매수량</th>
    			<th>창고수량</th>
    			<th>재고수량</th>
    			<th>재고확인일</th>
    			<th></th>
  			</tr>
  		</thead>
  		<tbody>
  			<c:choose>
  				<c:when test="${fn:length(list) > 0}">
  					<c:forEach items="${list}" var="row">
  						<tr>
  							<td>${row.NAME}</td>
  							<td>	${row.PRU_NO}</td>
  							<td>${row.BC_CODE}</td>
  							<td>	${row.MC_CODE}</td>
  							<td>${row.INFO}</td>
  							<td>
  								<i class="edit icon" style="zoom:2.0; cursor: pointer;"></i>
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
	
</body>
</html>