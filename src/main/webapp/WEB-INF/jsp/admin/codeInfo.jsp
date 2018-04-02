<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Member Information</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/1.11.8/semantic.min.css"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/1.11.8/semantic.min.js"></script>
    
<script type="text/javascript">
$(document).ready(function() {
	if($("#id").val()==''){
		alert('세션이 종료되었습니다. 다시 로그인해주세요.');
		self.close();
	}
	
	$("#updatePw").click(function(){
		$("#password").attr('value','0000');
		$("#password").attr('type','text');
		alert('비밀번호가 '+$("#password").val()+'으로 초기화되었습니다.');
	});
	
	//다음주에 섬밋하기
	$("button[name=active_N]").click(function(){ //정지버튼 클릭
		if($(this).attr('class')=='ui button'){
			$(this).attr('class','ui button active');
			$("button[name=active_Y]").attr('class','ui button');
			$("#state_gb").val('N');
		}
	});
	$("button[name=active_Y]").click(function(){ //활성버튼 클릭
		if($(this).attr('class')=='ui button'){
			$(this).attr('class','ui button active');
			$("button[name=active_N]").attr('class','ui button');
			$("#state_gb").val('Y');
		}
	});
	
	$("#update").click(function(){
		//제약사항
		$("#updateForm").submit();
	});
	
	$("#cancel").click(function(){
		window.close();
	});
});

</script>
</head>

<body>
 <input type="hidden" id="id" value="${id}">
	<form action="codeIU.do" method="post" id="updateForm">
		
		<input type="hidden" name="update_id" value="${id}">
		<input type="hidden" id="state_gb" name="state_gb" value="${map.USE_GB}">
		<input type="hidden" id="insert_gb" name="insert_gb" value="${insert_gb}">
		
		<table class="ui unstackable table" style="margin: 20px; width: 92%">
		<thead>
			<tr>
				<c:if test="${insert_gb eq 'I' }">
					<c:set var="code" value="${new_code}"></c:set>
				</c:if>
				<c:if test="${insert_gb eq 'U' }">
					<c:set var="code" value="${map.MINOR_CD}"></c:set>
				</c:if>
				<th style="width: 30%">품목코드</th>
				<td><div class="ui input"><input type="text" name="minor_cd" value="${code}" style="background-color:transparent; border-style:none" readonly></div></td>
				<input type="hidden" name="code_cd" value="${code}">
			</tr>
			<tr>
				<th>품목명</th>
				<td><div class="ui input"><input type="text" name="kor_name" value="${map.KOR_NAME}"></div></td>
			</tr>
			<tr>
				<th>업데이트날짜</th>
				<td>${map.UPDATE_DATE}</td>
			</tr>
			<tr>
				<th>업데이트ID</th>
				<td>${map.UPDATE_MAN}</td>
			</tr>
			<tr>
				<th>상태</th>
				<td>
					<div class="ui buttons">
						<c:if test="${map.USE_GB == 'Y'}">
							<button class="ui button active" name="active_Y" type="button">사용</button>
							<button class="ui button" name="active_N" type="button">정지</button>
						</c:if>
						<c:if test="${map.USE_GB == 'N'}">
							<button class="ui button" name="active_Y" type="button">사용</button>
							<button class="ui button active" name="active_N" type="button">정지</button>
						</c:if>
					</div>
				</td>
			</tr>
			<tr>
				<th>코드 정지 날짜</th>
				<td>${fn:substring(map.END_DATE,0,4)}년 ${fn:substring(map.END_DATE,5,6)}월 ${fn:substring(map.END_DATE,7,8)}일</td>
			</tr>
		</thead>
		</table>
	</form>
	<span style="float:right; margin: 15px; margin-top: -10px;">
	
		<c:if test="${insert_gb eq 'I' }">
			<button id="update" class="ui button">신규입력</button>
		</c:if>
		<c:if test="${insert_gb eq 'U' }">
			<button id="update" class="ui button">수정</button>
		</c:if>
		
		<button id="cancel" class="ui button">취소</button>
	</span>
	
</body>
</html>