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
	if($("#noCheck").val()==""){ //수정 후 memberInfo로 돌아왔을때 no 파라미터가 안넘어올 경우 종료
		//window.close();
	}
	
	$("#modifyPw").click(function(){
		$("#password").attr('value','0000');
		$("#password").attr('type','text');
		alert('비밀번호가 '+$("#password").val()+'으로 초기화되었습니다.');
	});
	
	$("#modify").click(function(){
		//제약사항
		$("#modifyForm").submit();
	});
	
	$("#cancel").click(function(){
		window.close();
	});
});

function act() {
	var thisTxt = $(this).text();
	$('div span', opener.document).text(thisTxt);
	window.close();
} 

</script>
</head>

<body>
  <input type="hidden" id="noCheck" value="${param.no}">
	<form action="updateMember.do" method="post" id="modifyForm">
		<input type="hidden" name="mem_no" value="${map.MEM_NO}">
		
		<table class="ui celled table" style="margin: 20px; width: 95%">
		<thead>
			<tr>
				<th style="width: 30%">이름</th>
				<td><div class="ui input"><input type="text" name="name" value="${map.NAME}"></div></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td>${map.ID}</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<div class="ui input"><input type="hidden" id="password" name="password" value="${map.PASSWORD}" readonly="readonly"></div>
					<button id="modifyPw" type="button" class="ui button">비밀번호 초기화</button>
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td><div class="ui input"><input type="text" name="address" value="${map.ADDRESS}" style="width: 495px"></div></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><div class="ui input"><input type="text" name="phone" value="${map.PHONE}"></div></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><div class="ui input"><input type="text" name="email" value="${map.EMAIL}"></div></td>
			</tr>
			<tr>
				<th>성별</th>
				<td><div class="ui input"><input type="text" name="gender" value="${map.GENDER}"></div></td>
			</tr>
			<tr>
				<th>생일</th>
				<td><div class="ui input"><input type="text" name="birthday" value="${map.BIRTHDAY}"></div></td>
			</tr>
			<tr>
				<th>가입일</th>
				<td>${map.REG_DATE}</td>
			</tr>
			<tr>
				<th>가입아이피</th>
				<td>${map.REG_IP}</td>
			</tr>
			<tr>
				<th>수정자 아이디</th>
				<td>${map.MOD_ID}</td>
			</tr>
			<tr>
				<th>수정자 아이피</th>
				<td>${map.MOD_IP}</td>
			</tr>
			<tr>
				<th>수정일</th>
				<td>${map.MOD_DATE}</td>
			</tr>
			<tr>
				<th>삭제여부</th>
				<td>${map.IS_DEL}</td>
			</tr>
			<tr>
				<th>삭제/복구자 아이디</th>
				<td>${map.DEL_ID}</td>
			</tr>
			<tr>
				<th>삭제/복구자 아이피</th>
				<td>${map.DEL_IP}</td>
			</tr>
			<tr>
				<th>삭제/복구일</th>
				<td>${map.DEL_DATE}</td>
			</tr>
			<tr>
				<th>약관동의내역</th>
				<td>${map.AGREE}</td>
			</tr>
			<tr>
				<th>연동된 SNS</th>
				<td>${map.SNS_TYPE}</td>
			</tr>
			<tr>
				<th>SNS 아이디</th>
				<td>${map.SNS_ID}</td>
			</tr>
			<tr>
				<th>SNS 연동일</th>
				<td>${map.SNS_CONNECT_DATE}</td>
			</tr>
		</thead>
		</table>
	</form>
	<span style="float:right; margin: 15px; margin-top: -10px;">
		<button id="modify" class="ui button">수정</button>
		<button id="cancel" class="ui button">취소</button>
	</span>
	
</body>
</html>