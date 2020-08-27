<%@page import="shop.member.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
#headerLogo{position:relative;width:1050px;height:63px;margin:0 auto}
#headerLogo .bnr_delivery{position:absolute;left:17px;top:-28px;margin:auto;height:22px}
#headerLogo .bnr_delivery img{width:163px;height:22px}
#headerLogo .logo{position:absolute;left:50%;bottom:6px;width:200px;height:79px;margin-left:-100px}
#headerLogo .logo img{display:block;width:103px;height:79px;margin:0 auto}
#headerLogo .logo #gnbLogoContainer {margin:0 auto}
#gnb.gnb_stop{position:fixed;z-index:300;left:0;top:0;width:100%}
#gnb .gnb_kurly{position:relative;z-index:300;min-width:1050px;background-color:#fff;font-family:'Noto Sans';letter-spacing:-0.3px}
#gnb .gnb_kurly:after{content:"";position:absolute;z-index:299;left:0;top:56px;width:100%;height:9px;background:url(../../pc/service/common/1902/bg_1x9.png) repeat-x 0 100%}
#gnb .inner_gnbkurly{position:relative;width:1050px;height:56px;margin:0 auto}
/* 검색창 */
#gnb .gnb_search{position:absolute;right:45px;top:10px;width:238px}
#gnb .gnb_search .inp_search{width:238px;height:36px;padding:0 50px 0 20px;border:1px solid #f7f7f6;border-radius:18px;background-color:#f7f7f7;font-family: 'Noto Sans';font-weight:400;font-size:12px;color:#666;line-height:16px;outline:none}
#gnb .gnb_search .inp_search.focus{background-color:#fff;color:#333}
#gnb .gnb_search .btn_search{position:absolute;right:10px;top:3px;width:30px;height:30px}
/* 장바구니 */
#gnb .cart_count{position:absolute;right:-6px;top:10px}
#gnb .cart_count .inner_cartcount{text-align:center;font-weight:400}
#gnb .cart_count .num{display:none;position:absolute;left:19px;top:-1px;min-width:20px;height:20px;padding:0 5px;border:2px solid #fff;border-radius:10px;background-color:#5f0080;font-size:9px;color:#fff;line-height:15px;text-align:center;white-space:nowrap}
#gnb .cart_count img{display:block;width:36px;height:36px;margin:0 auto}
#gnb .cart_count .msg_cart{display:none;position:absolute;right:-7px;top:61px;width:348px;height:102px;border:1px solid #ddd;background-color:#fff;}
#gnb .cart_count .inner_msgcart{display:block;overflow:hidden;padding:20px 0 0 20px}
#gnb .cart_count .msg_cart .thumb{float:left;width:46px;height:60px}
#gnb .cart_count .msg_cart .desc{float:left;width:240px;padding:8px 0 0 20px;font-weight:700;font-size:14px;line-height:21px}
#gnb .cart_count .msg_cart .tit{display:block;overflow:hidden;width:100%;color:#999;white-space:nowrap;text-overflow:ellipsis}
#gnb .cart_count .msg_cart .name{overflow:hidden;float:left;max-width:178px;text-overflow:ellipsis}
#gnb .cart_count .msg_cart .txt{display:block;padding-top:3px;color:#333}
#gnb .cart_count .msg_cart .point{position:absolute;right:13px;top:-14px;width:20px;height:14px;background:url(../../pc/ico/1903/ico_layer_point.png) no-repeat 0 0}
/* GNB메인 */
#gnb .gnb_main{overflow:hidden;width:1050px;margin:0 auto}
#gnb .gnb_main .gnb{float:left;width:100%}
#gnb .gnb_main .gnb li{float:left;background:url(../../pc/service/common/1902/line_1x11_c_ccc.png) no-repeat 100% 23px}
#gnb .gnb_main .gnb .lst{background:none}
#gnb .gnb_main .gnb a{overflow:hidden;float:left;height:55px;padding:16px 50px 0 48px;font-size:16px;color:#333;line-height:20px}
#gnb .gnb_main .gnb a .txt{font-weight:700}
#gnb .gnb_main .gnb a:hover,
#gnb .gnb_main .gnb a.on{font-weight:700;color:#5f0080}
#gnb .gnb_main .gnb a:hover .txt{border-bottom:1px solid #5f0080}
#gnb .gnb_main .menu1 a{padding-left:19px}
#gnb .gnb_main .menu1 .ico{float:left;width:16px;height:14px;margin:4px 14px 0 0;background:url(../../pc/service/common/1908/ico_gnb_all_off.png) no-repeat}
#gnb .gnb_main .menu1 a.on .ico,
#gnb .gnb_main .menu1 a:hover .ico{background:url(../../pc/service/common/1908/ico_gnb_all.png) no-repeat 0 0}
#gnb .gnb_main .menu1 a.on .txt,
#gnb .gnb_main .menu1 a:hover .txt,
#gnb .gnb_main .menu1 .txt{float:left;font-weight:700;border-bottom:0}
/* GNB서브 */
#gnb .gnb_sub{display:none;overflow:hidden;position:absolute;z-index:301;left:0;top:55px;width:213px;padding-top:1px}
#gnb .gnb_sub .inner_sub{width:100%;border:1px solid #ddd;background:url(../../pc/service/common/1908/bg_gnb_sub_v3.png) repeat-y 0 0}
#gnb .size_over{overflow-x:hidden;overflow-y:auto}
#gnb .gnb_sub .gnb_menu{width:219px}
#gnb .gnb_sub .gnb_menu li{width:100%;text-align:left}
#gnb .gnb_sub .gnb_menu li:first-child{padding-top:0}
#gnb .gnb_sub .menu{display:block;overflow:hidden;width:100%;height:40px;padding:8px 0 0 14px;cursor:pointer}
#gnb .gnb_sub .gnb_menu li:first-child .menu{height:39px;padding-top:7px}
#gnb .gnb_sub .current .menu{background:#f7f7f7}
#gnb .gnb_sub .current .txt,
#gnb .gnb_sub .menu.on.off:hover .txt,
#gnb .gnb_sub .menu.on .txt{font-weight:700;color:#5f0080}
#gnb .gnb_sub .ico{float:left;width:24px;height:24px}
#gnb .gnb_sub .ico img{width:24px;height:24px}
#gnb .gnb_sub .ico .ico_off{display:block}
#gnb .gnb_sub .ico .ico_on{display:none}
#gnb .gnb_sub .current .ico_off,
#gnb .gnb_sub .menu.on .ico_off,
#gnb .gnb_sub .menu:hover .ico_off{display:none}
#gnb .gnb_sub .current .ico_on,
#gnb .gnb_sub .menu.on .ico_on,
#gnb .gnb_sub .menu:hover .ico_on{display:block}
#gnb .gnb_sub .ico_arrow{display:none;float:right;width:16px;height:17px;padding:6px 9px 0 0}
#gnb .gnb_sub .ico_arrow img{width:7px;height:11px}
#gnb .gnb_sub .current .ico_arrow{display:block}
#gnb .gnb_sub .txt{float:left;padding:0 4px 0 10px;font-weight:400;font-size:14px;color:#333;line-height:22px;white-space:nowrap}
#gnb .gnb_sub .ico_new{overflow:hidden;float:left;width:14px;height:14px;margin-top:5px;background-position:50% 50%;background-repeat:no-repeat;background-size:14px 14px;font-size:0;line-height:0;text-indent:-9999px}
#gnb .gnb_sub .sub_menu{position:absolute;z-index:0;left:200px;top:0;width:248px;height:100%;padding:0 0 0 20px;background:url(https://res.kurly.com/images/common/bg_1_1.gif) repeat 0 0;opacity:0;transition:opacity 0.2s}
#gnb .gnb_sub .current .sub_menu{z-index:1;opacity:1;transition:opacity 0.5s}
#gnb .gnb_sub .sub_menu li:first-child{padding-top:11px}
#gnb .gnb_sub .sub_menu .sub{display:block;overflow:hidden;height:40px;padding-left:20px;font-size:14px;color:#333;line-height:18px;cursor:pointer}
#gnb .gnb_sub .sub_menu .sub:hover .name{border-bottom:1px solid #5f0080;font-weight:700;color:#5f0080}
#gnb .gnb_sub .sub_menu .sub.on{font-weight:700;color:#5f0080}
#gnb .gnb_sub .recommend{overflow:hidden;width:529px;padding:21px 0 0 40px}
#gnb .gnb_sub .recommend li{float:left;width:120px;height:130px;padding:0 10px 0 0}
#gnb .gnb_sub .recommend li:first-child{padding-top:0}
#gnb .gnb_sub .recommend .sub{display:block;overflow:hidden;width:120px;height:130px;padding:0;cursor:pointer}
#gnb .gnb_sub .recommend .thumb{display:block;width:110px;height:83.4px;margin-bottom:8px;background-position:50% 50%;background-repeat:no-repeat;background-size:cover}
#gnb .gnb_sub .recommend .thumb img{width:110px;height:84px}
#gnb .gnb_sub .recommend .name{font-size:14px;line-height:18px}
@media
only screen and (-webkit-min-device-pixel-ratio: 1.5),
only screen and (min-device-pixel-ratio: 1.5),
only screen and (min-resolution: 1.5dppx) {
    #gnb .gnb_sub .ico_new{background:url(../../pc/ico/1808/ico_new_gnb_16x16.png) no-repeat 0 0;background-size:8px 8px}
    #gnb .cart_count .msg_cart .point{background:url(../../pc/ico/1903/ico_layer_point_x2.png) no-repeat 0 0;background-size:20px 14px}
    #gnb .gnb_main .menu1 .ico{background:url(../../pc/service/common/1908/ico_gnb_all_off_x2.png) no-repeat 0 0;background-size:16px 14px}
    #gnb .gnb_main .menu1 a.on .ico,
    #gnb .gnb_main .menu1 a:hover .ico{background:url(../../pc/service/common/1908/ico_gnb_all_x2.png) no-repeat 0 0;background-size:16px 14px}
} 
</style>

<div id="header">
	
	<!-- 로그인X -->
	<c:if test="${ member.m_id eq null }">
		<div class="bnr_header" id="top-message">
			<a href="#" id="eventLanding">
			지금 가입하고 인기상품 <b>100원</b>에 받아가세요!<img src="../../pc/ico/1908/ico_arrow_fff_84x84.png" class="bnr_arr">
				<div class="bnr_top">
					<div class="inner_top_close">
						<button id="top-message-close" class="btn_top_bnr">가입하고 혜택받기</button>
					</div>
				</div>
			</a>
		</div>
	</c:if>
	<!-- 로그인O -->
	<c:if test="${ member.m_id ne null }">
		<div class="bnr_header bnr_top_friend" id="top-message">
			<a href="#" id="eventLanding">
			친구 초대하면 친구도 나도 적립금 <b>5천원!</b><img src="../../pc/ico/1908/ico_arrow_fff_84x84.png" class="bnr_arr">
				<div class="bnr_top">
					<div class="inner_top_close">
						<button id="top-message-close" class="btn_top_bnr">가입하고 혜택받기</button>
					</div>
				</div>
			</a>
		</div>
	</c:if>
	
	<script type="text/javascript">
		$(document).ready(function() {
			// 가입하고 혜택받기 이벤트창 닫기하면 쿠키에 저장, 숨기기
			$("#top-message-close").on("click", function() {
				setCookie('top_msg_banner2', 'set_cookie', -1)
			});
			if (getCookie('top_msg_banner2') == 'set_cookie') {
				$("#top-message").hide()
			} else {
				$("#top-message").show();
			}
		});
		
		function setCookie(cookieName, value, exdays) {
			var exdate = new Date();
			exdate.setDate(exdate.getDate() + exdays);
			var cookieValue = escape(value)
					+ ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
			document.cookie = cookieName + "=" + cookieValue + "; path=/;"
		}
	
		function getCookie(cookieName) {
			cookieName = cookieName + '=';
			var cookieData = document.cookie;
			var start = cookieData.indexOf(cookieName);
			var cookieValue = '';
			if (start != -1) {
				start += cookieName.length;
				var end = cookieData.indexOf(';', start);
				if (end == -1)
					end = cookieData.length;
				cookieValue = cookieData.substring(start, end);
			}
			return unescape(cookieValue);
		}
	</script>
	
	<div id="userMenu">
		<ul class="list_menu">
			<!-- 로그인X -->
			<c:if test="${ member.m_id eq null }">
				<li class="menu none_sub menu_join">
					<a href="../member/join.do" class="link_menu">회원가입</a>
				</li>
				<li class="menu none_sub">
					<a href="../member/login.do" class="link_menu">로그인</a>
				</li>
			</c:if>
			<!-- 로그인O -->
			<c:if test="${ member.m_id ne null }">
				<li class="menu menu_user">
					<a class="link_menu grade_comm">
						<!-- 등급별 아이콘(grade0), 등급명 -->
						<span class="ico_grade grade0">${ member.grade }</span> 
						<span class="txt">
							<span class="name">${ member.name }</span><span class="sir">님</span>
						</span>
					</a>
					<ul class="sub">
						<li><a href="../mypage/mypage_orderlist.do">주문 내역</a></li>
						<li><a href="../mypage/mypage_wishlist.do">늘 사는 것</a></li>
						<li><a href="../mypage/mypage_review.do">상품후기</a></li>
						<li><a href="../mypage/mypage_emoney.do">적립금</a></li>
						<li><a href="">쿠폰</a></li>
						<li><a href="">개인 정보 수정</a></li>
						<li><a href="../member/logout.jsp">로그아웃</a></li>
					</ul>
				</li>
			</c:if>

			<li class="menu">
				<a href="../board/notice.do" class="link_menu">고객센터</a>
				<ul class="sub">
					<li><a href="../board/notice.do">공지사항</a></li>
					<li><a href="../service/faq.do">자주하는 질문</a></li>
					<li><a href="../mypage/mypage_qna.do">1:1 문의</a></li>
					<!-- 로그인O -->
					<c:if test="${ member.m_id ne null }">
						<li><a href="">대량주문 문의</a></li>
					 </c:if>
					<li><a href="#">상품 제안</a></li>
					<li><a href="#">에코포장 피드백</a></li>
				</ul>
			</li>
			<li class="menu lst">
				<a href="#none" onclick="popup('../proc/popup_address2.jsp',530,500)" class="link_menu">배송지역 검색</a>
			</li>
		</ul>
	</div>
	
	<div id="headerLogo" class="layout-wrapper">
		<h1 class="logo">
			<a href="../main/index.do" class="link_main">
				<span id="gnbLogoContainer"></span>
				<img src="../../images/marketkurly/logo/logo_x2.png" alt="마켓컬리 로고">
			</a>
		</h1>
		<a href="" onclick="" class="bnr_delivery">
			<img src="../../pc/service/common/1908/delivery_190819.gif" alt="서울, 경기, 인천 샛별배송, 수도권 이외 지역 택배배송">
		</a>
	</div>
	
	<div id="gnb">
		<h2 class="screen_out">메뉴</h2>
		<div id="gnbMenu" class="gnb_kurly">
			<div class="inner_gnbkurly">
				<div class="gnb_main">
					<!-- 전체 카테고리 hover시 동작하는 스크립트는 어딨을까.. -->
					<ul class="gnb">
						<!-- menu1에 마우스 올리면 a태그에 class on 추가 -->
						<li class="menu1"><a href=""><span class="ico"></span><span class="txt">전체 카테고리</span></a></li>
						<li><a class="link new " href="../goods/goods_list.do?category=new"><span class="txt">신상품</span></a></li>
						<li><a class="link best " href="../goods/goods_list.do?category=best"><span class="txt">베스트</span></a></li>
						<li><a class="link bargain " href="../goods/goods_list.do?category=sale"><span class="txt">알뜰쇼핑</span></a></li>
						<li class="lst"><a class="link event " href=""><span class="txt">이벤트</span></a></li>
					</ul>
					<div id="side_search" class="gnb_search">
						<!-- 검색창 form태그 -->
						<form action="../goods/goods_search.do">
							<input type="text" name="sword"  id="sword" class="inp_search" placeholder="검색어를 입력하세요" required label="검색어">
							<input type=image src="../../pc/service/common/1908/ico_search_x2.png" class="btn_search" onclick="search_submit()">
						</form>
					</div>
					
					<script>
						function search_submit() {
							$("form:eq(0)").submit();
						}
					</script>
					
					<div class="cart_count">
						<div class="inner_cartcount">
							<a href="../goods/goods_cart.do" class="btn_cart">
								<img src="../../pc/ico/1908/ico_cart_x2_v2.png" alt="장바구니">
								<!-- 장바구니에 물건있으면 display:inline; text(개수) -->
								<span id="cart_item_count" class="num realtime_cartcount" style="display: none;"></span> 
							</a>
						</div>
						<!-- 장바구니에 담을 때 잠시 display:block 됐다가 none으로 바뀜 -->
						<div id="addMsgCart" class="msg_cart" style="display: none;">
							<span class="point"></span>
							<div class="inner_msgcart">
								<!-- 장바구니에 담는 상품이미지 src에 추가 -->
								<img alt="" class="thumb">
								<p class="desc">
								<span class="tit">장바구니에 담는 상품명</span>
								<span class="txt">장바구니에 담겼습니다.</span>
								</p>
							</div>
						</div>
					</div>
				</div>
				
				<script>
					$(function() {
						if('${ member.m_id }' != null && '${ member.m_id }' != ""){
							cartItemCount();							
						}
					});
					
					// 회원마다 장바구니에 담긴 상품목록 개수
					function cartItemCount() {
						$.ajax({
							url : "../proc/cartItemCount.jsp",
							type : "GET",
							dataType: "json",
							cache: false,
							success: function(data) {
								if(data.cnt > 0){
									$("#cart_item_count").text(data.cnt).css("display","inline");
								} else{
									$("#cart_item_count").text(data.cnt).css("display","none");
								}
							}
						});
					}
				</script>
				
				<!-- menu1 a태그에 class on 추가될 때 display: block -->
				<div class="gnb_sub" style="display: none; width: 219px;">
					<div class="inner_sub">
						<ul class="gnb_menu" style="height: auto;">
							<c:forEach items="${ p_categoryList }" var="dto1">
							<li> <!-- 마우스 올리면 class="current" 추가 -->
								<a class="menu" href="../goods/goods_list.do?category=${ dto1.parent_seq }">
									<span class="ico">
										<img src="../data/category/icon_off_${ dto1.parent_seq }.png" alt="카테고리 아이콘" class="ico_off" />
										<img src="../data/category/icon_on_${ dto1.parent_seq }.png" alt="카테고리 아이콘" class="ico_on" />
									</span>
									<span class="tit">
										<span class="txt">${ dto1.pc_name }</span>
									</span>
								</a>
								<ul class="sub_menu" >
									<c:forEach items="${ c_categoryList }" var="dto2">
										<c:if test="${ dto2.parent_seq eq dto1.parent_seq }">
										<li> <!-- 마우스 올리면 class="current" 추가 -->
											<a class="sub" href="../goods/goods_list.do?category=${ dto2.child_seq }">
												<span class="name">${ dto2.cc_name }</span>
											</a>
										</li>
										</c:if>
									</c:forEach>
								</ul>
							</li>
							</c:forEach>
							
							<!-- 컬리의 추천.. 나중에 시간 남으면 하자.. 안남을듯 ㅎ
							<li>
								<a href="" class="menu">
									<span class="ico">
										<img src="https://res.kurly.com/pc/service/common/1908/ico_recommend_v2.png" alt="카테고리 아이콘" class="ico_off" />
										<img src="https://res.kurly.com/pc/service/common/1908/ico_recommend_on_v2.png" alt="카테고리 아이콘" class="ico_on" />
									</span>
									<span class="tit">
										<span class="txt">컬리의 추천</span>
									</span>
								</a>
								<ul class="sub_menu recommend">
									<li>
										<a class="sub">
											<span class="thumb" style="background-image: url('https://img-cf.kurly.com/shop/data/category/Thum_1TABLE.1592456275.jpg');">
												<img src="https://res.kurly.com/pc/img/1810/bg_blink_236x179.png" alt="" />
											</span>
											<span class="name">1% Table</span>
										</a>
									</li>
								</ul>
							</li>
							 -->
						</ul>
					</div>
				</div>
			</div>

			
			
			<script>
				var s = {
						categoryOpen : $('#gnb .menu1 a'),	// 전체카테고리
		                gnbSub : $('#gnb .gnb_sub'),				// 카테고리목록창
		                gnbSubMenu : $('#gnb .gnb_sub li'),	// 상위카테고리 or 하위카테고리
		                subMenu : $('#gnb .gnb_sub .sub_menu li')	// 하위 카테고리
				}
			
				s.categoryOpen.hover(function() {
					s.gnbSub.show();
					s.categoryOpen.addClass("on");
					s.gnbSub.css({width : "219px"});
				}, function() {
					s.gnbSub.hide();
					s.categoryOpen.removeClass("on");
					s.gnbSub.hover(function() {
						s.gnbSub.show();
						s.categoryOpen.addClass("on");
					}, function() {
						s.gnbSub.hide();
						s.categoryOpen.removeClass("on");
					})
				});
				
				// data-default="219" data-min="219" data-max="731"
				s.gnbSubMenu.hover(function() {
					$("#gnb .gnb_sub .current").removeClass("current");
					$(this).addClass("current");
					s.gnbSub.stop().animate({width : "438px"});
				}, function() {
					$(this).removeClass("current");
					s.subMenu.hover(function() {
						$(this).parent().parent().addClass("current");
					});
				});
			</script>

		</div>
	</div>
	
</div>
