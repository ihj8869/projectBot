<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/1.11.8/semantic.min.js"></script>
<script>

function act() {
window.open('test2.jsp', '', 'left=500, top=200, width=640, height=480, scrollbars=no, status=no, resizable=no, fullscreen=no, channelmode=no');
}
</script>
</head>

<body>
<button onclick="act()">실행</button>

<div>
<span>가나다</span>
</div>
<div class="ui left demo vertical inverted sidebar labeled icon menu">
  <a class="item">
    <i class="home icon"></i>
    Home
  </a>
  <a class="item">
    <i class="block layout icon"></i>
    Topics
  </a>
  <a class="item">
    <i class="smile icon"></i>
    Friends
  </a>
</div>
</body>

</html>