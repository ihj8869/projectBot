<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1" content="text/html; charset=UTF-8">
<title>아름다운가게 재고관리시스템</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="java.util.Calendar"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/1.11.8/semantic.min.css"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/1.11.8/semantic.min.js"></script>
    
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
%>
<script type="text/javascript">
$(document).ready(function() {
	if($("#email").val()==''){
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
	
	search = function(){ //이름 or 아이디로 회원검색
		var name = $("#searchName").val();
		var id = $("#searchId").val();
		
		document.location.href="manageMember.do?name="+name+"&id="+id;
	};
	
	$("#search").click(function(){ //검색 돋보기 아이콘 클릭시
		search();
	});
	
	$("input[name=search]").keydown(function(key){ //검색 input에서 엔터키(13) 클릭시
		if(key.keyCode == 13){
			search();
		}
	});
	
	$("#memberTb i").click(function(){ //회원 강등 or 승격
		var no = $(this).prev().prev().val(); //손가락 이미지인 i태그 이전노드인 input의 밸류(mem_no)
		var name = $(this).parent().next().text();
		
		if($(this).attr('class')=='pointing down icon'){
			var msg = name+'님을 회원으로 강등 시키겠습니까?';
			
			if(confirm(msg)!=0){
				var flag='down';
				document.location.href="updateRating.do?flag="+flag+"&no="+no;
			}else{
				return;
			}
			
		}else if($(this).attr('class')=='pointing up icon'){
			var msg = name+'님을 관리자로 승격 시키겠습니까?';
			
			if(confirm(msg)!=0){
				var flag='up';
				document.location.href="updateRating.do?flag="+flag+"&no="+no;
			}else{
				return;
			}
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
</script>
</head>

<body>	
	<h2 class="ui block header"><i id="sidebar" class="sidebar icon" style="zoom: 0.5; cursor: pointer;"></i>아름다운가게 재고관리시스템</h2>
	<%-- ${email} 님 환영합니다. --%>
	<input type="hidden" id="email" value="${email}">
	<%-- <br>
	${map} --%>
	<div class="ui left demo vertical inverted sidebar labeled icon menu">
		<a href="main.do?year=<%=year%>&month=<%=month%>" class="item"> 
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
	
	<div style="padding-top: 50px; padding-left: 50px; padding-right: 50px; padding-bottom: 50px;">
	  <h2 class="ui dividing header" style="font-weight: 100;">코드관리</h2>
		<table class="ui fixed single line celled table" style="width: 50%;" align="right">
			<tr>
				<td>코드</td>
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
				<td><i id="search" class="search icon" style="cursor: pointer;"></i></td>
			</tr>
		</table>
		<table class="ui celled table">
			<thead>
				<tr>
					<th style="width: 90px;">등급</th>
					<th>이름</th>
					<th>아이디</th>
					<th>이메일</th>
					<th>생년월일</th>
					<th>주소</th>
					<th style="width:180px;"></th>
				</tr>
			</thead>
			<tbody id="memberTb">
				<c:choose>
					<c:when test="${fn:length(list) > 0}">
						<c:forEach items="${list}" var="row">
							<tr>
								<td class="isDel">
								${row.PMS}
									<input type="hidden" value="${row.MEM_NO}">
									<input type="hidden" value="${row.IS_DEL}">
										<c:choose>
											<c:when test="${row.PMS == '관리자'}">
												<i class="pointing down icon" style="cursor: pointer;"></i>
											</c:when>
											<c:when test="${row.PMS == '회원'}">
												<i class="pointing up icon" style="cursor: pointer;"></i>
											</c:when>
										</c:choose>
								</td>
								<td>${row.NAME}</td>
								<td>${row.ID}</td>
								<td>${row.EMAIL}</td>
								<td>${row.BIRTHDAY}</td>
								<td>${row.ADDRESS}</td>
								<td>
								    <button id="modify" class="ui button" onclick="infoPopup(${row.MEM_NO})">수정</button>
								    <button id="delete" class="ui button" type="button" value="${row.MEM_NO}">삭제</button>
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
				<tr>
					<th colspan="10">
						<div class="ui right floated pagination menu">
						
							<c:choose>
								<c:when test="${map.name != null || map.id != null}">
									<a class="item" href="manageMember.do?page=1&name=${map.name}&id=${map.id}"><i class="angle double left icon"></i></a>
								</c:when>
								<c:otherwise>
									<a class="icon item" href="manageMember.do?page=1"><i class="angle double left icon"></i></a>
								</c:otherwise>
							</c:choose>
							
							<c:choose>
								<c:when test="${map.currentBlock > 1}">
									<c:choose>
										<c:when test="${map.name != null || map.id != null}">
											<a class="item" href="manageMember.do?page=${map.startPage-1}&name=${map.name}&id=${map.id}"><i class="angle left icon"></i></a>
										</c:when>
										<c:otherwise>
											<a class="icon item" href="manageMember.do?page=${map.startPage-1}"><i class="angle left icon"></i></a>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<a class="icon item" href="#"><i class="angle left icon"></i></a>
								</c:otherwise>
							</c:choose>
							
							<%-- <c:choose>
								<c:when test="${currentPage > 1}">
									<a class="icon item" href="manageMember.do?page=${currentPage-1}">이전</a>
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
												<a class="item" href="manageMember.do?page=${i}&name=${map.name}&id=${map.id}">${i}</a>
											</c:when>
											<c:otherwise>
												<a class="item" href="manageMember.do?page=${i}">${i}</a>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
							<%-- <c:choose>
								<c:when test="${currentPage < totalPage}">
									<a class="icon item" href="manageMember.do?page=${currentPage+1}">다음</a>
								</c:when>
								<c:otherwise>
									<a class="icon item" href="#">다음</a>
								</c:otherwise>
							</c:choose> --%>
							
							<c:choose>
								<c:when test="${map.totalPage > map.endPage}">
									<c:choose>
										<c:when test="${map.name != null || map.id != null}">
											<a class="item" href="manageMember.do?page=${map.endPage+1}&name=${map.name}&id=${map.id}"><i class="angle right icon"></i></a>
										</c:when>
										<c:otherwise>
											<a class="icon item" href="manageMember.do?page=${map.endPage+1}"><i class="angle right icon"></i></a>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<a class="icon item" href="#"><i class="angle right icon"></i></a>
								</c:otherwise>
							</c:choose>

							<c:choose>
								<c:when test="${map.name != null || map.id != null}">
									<a class="item" href="manageMember.do?page=${map.totalPage}&name=${map.name}&id=${map.id}"><i class="angle double right icon"></i></a>
								</c:when>
								<c:otherwise>
									<a class="icon item" href="manageMember.do?page=${map.totalPage}"><i class="angle double right icon"></i></a>
								</c:otherwise>
							</c:choose>
						
						</div>
					</th>
				</tr>
			</tfoot>
		</table>
	</div>
	
</body>
</html>