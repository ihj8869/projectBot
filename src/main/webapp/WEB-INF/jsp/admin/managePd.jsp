<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 관리</title>
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
${list}
	<h2 class="ui block header"><i id="sidebar" class="sidebar icon" style="zoom: 0.5; cursor: pointer;"></i>관리자 페이지</h2>

	<div class="ui left demo vertical inverted sidebar labeled icon menu">
		<a href="index.jsp" class="item"> 
			<i class="home icon"></i> Home
		</a>
		<a href="manageMember.do" class="item"> 
			<i class="users icon"></i> 회원관리
		</a> 
		<a href="managePd.do" class="item"> 
			<i class="shop icon"></i> 상품관리
		</a>
		<a class="item"> 
			<i class="shipping icon"></i> 배송관리
		</a>
	</div>
	
	<table class="ui celled table">
  <thead>
  	<tr>
    	<th>NAME</th>
    	<th>PRICE</th>
    	<th>INFO</th>
  	</tr>
  </thead>
  <tbody>
  	<c:choose>
  		<c:when test="${fn:length(list) > 0}">
  			<c:forEach items="${list}" var="row">
  				<tr>
  					<td>
  						${row.NAME}
  					</td>
  					<td>
  						${row.PRICE}
  					</td>
  					<td>
  						${row.INFO}
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
  
  <tfoot>
    <tr><th colspan="3">
      <div class="ui right floated pagination menu">
        <a class="icon item">
          <i class="left chevron icon"></i>
        </a>
        <a class="item">1</a>
        <a class="item">2</a>
        <a class="item">3</a>
        <a class="item">4</a>
        <a class="icon item">
          <i class="right chevron icon"></i>
        </a>
      </div>
    </th>
  </tr></tfoot>
</table>
	
</body>
</html>