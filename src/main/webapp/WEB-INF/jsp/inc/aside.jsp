<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<link type="text/css" rel="stylesheet" href="/css/menu.css">
<script>
    //북마크
    function CreateBookmarkLink(url, title) {
        if (window.sidebar && window.sidebar.addPanel) {   // FF ver 23 이하.
            window.sidebar.addPanel(title, url, '');
        } else {
            if (window.external && ('AddFavorite' in window.external)) {    // IE
                window.external.AddFavorite(url, title);
            } else {    // Others
                alert('확인을 클릭하신 후 주소창에서 <Ctrl+D>를 누르시면 즐겨찾기에 등록됩니다.');
            }
        }
    }
    //좌측영역 레이어 여닫기
    function asideLayer(name) {
        var target = jQuery('#'+name);
        if(target.is(':visible')) {
            target.animate({'right':-271},{'complete':function(){
                target.hide();
            }});
        } else {
            target.show();
            if(name == 'aside_searchform') {
                target.animate({'right':17});
            } else {
                target.animate({'right':0});
            }

        }
    }
    
    //좌측영역 여닫기
    function asideToggle() {
        var aside = jQuery('#aside');
        if(aside.hasClass('is_closed') == false && aside.width() > 0) {
            aside.addClass('is_closed');
        } else {
            aside.removeClass('is_closed');
        }
    }


    
    //스크롤 상하
    function winScroll(stat) {
        var way = 0;
        if(stat != 'top') {
            way = Math.floor( jQuery(document).height() - jQuery(window).height() );
        }
        jQuery('html, body').animate({scrollTop : way}); return false
    }
    function popup_personal() {
        if ('NO' == 'OK') {
            alert("회원 로그인을 해주세요.");
            location.href = "/shop/member.html?type=personal";
        } else {
            window.open("/shop/personal.html","personal","width=607,height=500,scrollbars=yes");
        }
    }
</script>
    
    
      <div id="aside">
        <div class="side_inner">

          <div class="menu">

            <div class="group">
              <a href="#" class="icon_bookmark" onclick="CreateBookmarkLink('http://localhost:8080', '갓섭이 주물럭하는 홈피'); return false;" alt="BOOKMARK+" title="BOOKMARK+"><span class="txt">즐겨찾기</span></a>
            </div>
            <div class="group">
              <a href="#" class="icon_cate" onclick="asideLayer('layer_cate'); return false;"><span class="txt">카테고리</span></a>
            </div>
            <div class="group">
              <a class="icon_search" onclick="asideLayer('aside_searchform'); return false;"><span class="txt">검색</span></a>
              <div id="aside_searchform" class="searchform">
                <form action="http://www.lylon.co.kr/shop/shopbrand.html" method="post" name="search">
                  <span class="layer_close" onclick="asideLayer('aside_searchform');"></span>
                  <div class="box_input">
                    <input type="text" name="search" value="" class="MS_search_word" onfocus="this.style.background='#fff'" onkeydown="CheckKey_search();">
                    <a href="javascript:search_submit();" class="btn_search"><img src="http://www.lylon.co.kr/design/jjh9831/170720_renew/icon/search_btn.gif"></a>
                  </div>
                </form>
              </div>




            </div>
            <div class="group">

              <a href="/shop/basket.html" class="icon_cart"><span class="txt">장바구니</span></a>
            </div>
            <div class="group">
              <a href="http://www.lylon.co.kr/board/board.html?code=jjh9831_board6" class="icon_cs"><span class="txt">고객센터</span></a>
            </div>
          </div>
          <div class="bottom_ui">
            <div class="scroll">
              <span class="btn_scroll top" onclick="winScroll('top');"></span>
              <span class="btn_scroll bottom" onclick="winScroll('bottom');"></span>
            </div>
            <!--	<div class="toggle">
				<div class="close" onclick="asideToggle();">CLOSE</div>
				<div class="open" onclick="asideToggle();">OPEN</div>
			</div> -->
          </div>
        </div>
        <!-- 카테고리 innner -->
        <div id="layer_cate" class="aside_layer">
          <div class="layer_inner">
            <span class="layer_close" onclick="asideLayer('layer_cate'); return false;"><em class="txt_clip"></em></span>
            <a href="/" class="layer_logo"><img src="http://www.lylon.co.kr/design/jjh9831/170720_renew/cate_logo.gif" alt="lylon"></a>

            <h3 class="title">CATEGORY</h3>
            <ul class="list_cate">
              <li><a href="/shop/shopbrand.html?xcode=070&amp;type=Y">NEW 5% DC</a></li>
              <li><a href="/shop/shopbrand.html?xcode=073&amp;type=N&amp;mcode=001">BEST 50</a></li>
              <li><a href="/shop/shopbrand.html?xcode=034&amp;type=Y">TODAY</a></li>

            </ul>
            <ul class="list_cate">
              <li><a href="/shop/shopbrand.html?xcode=053&amp;type=Y">OUTER</a></li>
              <li><a href="/shop/shopbrand.html?xcode=064&amp;type=Y">TOP</a></li>
              <li><a href="/shop/shopbrand.html?xcode=061&amp;type=Y">BOTTOM</a></li>
              <li><a href="/shop/shopbrand.html?xcode=062&amp;type=Y">DRESS</a></li>
              <li><a href="/shop/shopbrand.html?xcode=071&amp;type=Y">SHIRTS</a></li>
              <li><a href="/shop/shopbrand.html?xcode=060&amp;type=Y">TRANING</a></li>
              <li><a href="/shop/shopbrand.html?xcode=059&amp;type=Y">LEGGINGS</a></li>
              <li><a href="/shop/shopbrand.html?xcode=058&amp;type=Y">SHOES</a></li>
              <li><a href="/shop/shopbrand.html?xcode=057&amp;type=Y">BAG</a></li>
              <li><a href="/shop/shopbrand.html?xcode=054&amp;type=Y">ACC</a></li>
              <li><a href="/shop/shopbrand.html?xcode=031&amp;type=X">SALE</a></li>
            </ul>

            <ul class="list_cate">
              <li><a href="/shop/shopbrand.html?xcode=036&amp;type=Y">HOOD&amp;MTM</a></li>
              <li><a href="/shop/shopbrand.html?xcode=035&amp;mcode=001&amp;type=Y">DISNEY</a></li>
              <li><a href="/shop/shopbrand.html?xcode=038&amp;type=Y">BANDING COLLECTION</a></li>
            </ul>
            <h3 class="title">BOARD</h3>
            <ul class="list_cate vision_row thing">
              <li><a href="/board/board.html?code=jjh9831_board1">공지사항</a></li>
              <li><a onclick="javascript:window.open('/html/unpaymentlist.html','','width=540, height=500,statusbar=no,scrollbars=no');" href="#">미확인입금자</a></li>
              <li><a href="/board/board.html?code=jjh9831_board6">Q&amp;A</a></li>
              <li><a href="/shop/shopbrand.html?xcode=011&amp;type=O">개인결제창</a></li>
              <li><a href="/board/board.html?code=jjh9831_board2">상품후기</a></li>
              <li><a href="/shop/shopbrand.html?xcode=013&amp;mcode=001&amp;type=Y">입고지연</a></li>
              <li><a href="/board/board.html?code=jjh9831_image2">이벤트</a></li>
              <li><a href="http://service.epost.go.kr/iservice/trace/Trace.jsp" target="_blank">배송위치조회</a></li>
              <li><a href="javascript:popup_personal();" alt="1:1문의" title="1:1문의">1:1게시판</a></li>
              <li><a href="http://www.lylon.co.kr/board/board.html?code=jjh9831_board6">고객센터</a></li>


            </ul>


            <ul class="list_cate vision_facebook thing">
              <li><a href="https://www.facebook.com/라일론-1565267377134140/?ref=bookmarks" target="_blank"><img src="http://www.lylon.co.kr/design/jjh9831/170720_renew/icon/facebook_icon.gif"></a></li>
              <li><a href="http://story.kakao.com/ch/lylon" target="_blank"><img src="http://www.lylon.co.kr/design/jjh9831/170720_renew/icon/kakao_icon.gif"></a></li>
              <li><a href="https://www.instagram.com/lylon_official" target="_blank"><img src="http://www.lylon.co.kr/design/jjh9831/170720_renew/icon/insta_icon.gif"></a></li>
            </ul>
          </div>
        </div>
        <!-- //카테고리 inner -->

      </div>