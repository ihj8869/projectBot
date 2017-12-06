<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script>
$(function() {
$('a').on('click', act);
});

function act() {
var thisTxt = $(this).text();
$('div span', opener.document).text(thisTxt);
window.close();
}
</script>
</head>

<body>
<table>
<thead>
<tr>
<th>번호</th>
<th>이름</th>
</tr>
</thead>
<tbody>
<tr>
<td>1</td>
<td><a href="#">갑돌이</a></td>
</tr>
<tr>
<td>2</td>
<td><a href="#">갑순이</a></td>
</tr>
</tbody>
</table>
</body>

</html>