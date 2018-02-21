<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	//컨트롤러에서 updateUser를 탔을경우, 창을 닫음
	String errMsg = (String)request.getAttribute("errMsg");
	if(!"".equals(errMsg)){
%>
	<script>
	
	alert("<%=errMsg%>");
	self.close();
	</script>
	<%
		}
	%>

</body>
</html>