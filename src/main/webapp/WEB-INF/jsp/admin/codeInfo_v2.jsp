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
		
		var result = confirm("상위코드를 수정하면 하위코드도 동일하게 수정됩니다. 진행하시겠습니까? 예) 상위코드를 사용정지시 하위코드도 사용정지됩니다.");

		//제약사항
		if($("#update_yn").val()=='N'){
			alert("코드사용이 중지되어 수정할 수 없습니다.")
			return;
		}
		if($("#up_code").val()=='000000'){
			alert("상위코드를 선택해주세요")
			return;
		}
		
		if(result == true){
			$("#updateForm").submit();
		}else{
			return;
		}
		
	});
	
	$("#cancel").click(function(){
		window.close();
	});
});

</script>
</head>

<body>
 <input type="hidden" id="id" value="${id}">
	<form action="codeIU_v2.do" method="post" id="updateForm">
		<input type="hidden" name="update_id" value="${id}">
		<input type="hidden" id="state_gb" name="state_gb" value="${map.USE_YN}">
		<input type="hidden" id="update_yn" name="update_yn" value="${map.UPDATE_YN}">
		<input type="hidden" id="up_code_nm" name="up_code_nm" value="">
		<input type="hidden" id="insert_gb" name="insert_gb" value="${insert_gb}">
		<input type="hidden" id="code_gb" name="code_gb" value="${code_gb}">
		
		<table class="ui unstackable table" style="margin: 20px; width: 92%">
		<thead>
			<tr>
				<c:if test="${insert_gb eq 'I' }">
					<c:set var="code" value="${new_code}"></c:set>
				</c:if>
				<c:if test="${insert_gb eq 'U' }">
					<c:set var="code" value="${map.CODE}"></c:set>
				</c:if>
				<th style="width: 30%">코드</th>
				<td><div class="ui input"><input type="text" name="code" value="${code}" style="background-color:transparent; border-style:none" readonly></div></td>
			</tr>
			<tr>
				<th>코드명</th>
				<td><div class="ui input"><input type="text" name="code_nm" value="${map.CODE_NM}"></div></td>
			</tr>
			<tr>
				<th>상위코드</th>
				<td>
					<c:if test="${insert_gb eq 'I' }">
						<select id='up_code' name='up_code'>
							<c:choose>
								<c:when test="${fn:length(list) > 0}">
									<c:forEach items="${list}" var="row">
										<option value='${row.CODE}'>(${row.CODE}) ${row.CODE_NM} </option>
									</c:forEach>
								</c:when>
								<c:otherwise>
										<option value=''>최상위코드입니다. </option>
								</c:otherwise>
							</c:choose>
						</select>
					</c:if>
					<c:if test="${insert_gb eq 'U' }">
						<input type="hidden" name="up_code" value="${map.UP_CODE}">${map.UP_CODE}
					</c:if>
				
				</td>
			</tr>
			<tr>
				<th>상위코드명</th>
				<td>${map.UP_CODE_NM}</td>
			</tr>
			<tr>
				<th>코드 생성 날짜</th>
				<td>${fn:substring(map.STAR_DATE,0,4)}년 ${fn:substring(map.STAR_DATE,5,6)}월 ${fn:substring(map.STAR_DATE,7,8)}일</td>
			</tr>
			<tr>
				<th>코드 중지 날짜</th>
				<td>${fn:substring(map.END_DATE,0,4)}년 ${fn:substring(map.END_DATE,5,6)}월 ${fn:substring(map.END_DATE,7,8)}일</td>
			</tr>
			<tr>
				<th>상태</th>
				<td>
					<div class="ui buttons">
						<c:if test="${map.USE_YN == 'Y'}">
							<button class="ui button active" name="active_Y" type="button">사용</button>
							<button class="ui button" name="active_N" type="button">정지</button>
						</c:if>
						<c:if test="${map.USE_YN == 'N'}">
							<button class="ui button" name="active_Y" type="button">사용</button>
							<button class="ui button active" name="active_N" type="button">정지</button>
						</c:if>
					</div>
				</td>
			</tr>
			<tr>
				<th>비고</th>
				<td><div class="ui input"><input type="text" name="bigo" value="${map.BIGO}"></div></td>
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