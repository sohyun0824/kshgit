<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="euc-kr">
<meta name="title" content="마켓컬리 :: 내일의 장보기, 마켓컬리">
<meta name="description"
	content="모두가 사랑하는 장보기, 마켓컬리! 당일 수확 채소, 과일, 맛집 음식까지 내일 아침 문 앞에서 만나요!">
<meta property="og:title" content="마켓컬리 :: 내일의 장보기, 마켓컬리">
<meta property="og:description"
	content="모두가 사랑하는 장보기, 마켓컬리! 당일 수확 채소, 과일, 맛집 음식까지 내일 아침 문 앞에서 만나요!">
<meta property="og:image"
	content="https://res.kurly.com/images/marketkurly/logo/logo_sns_marketkurly.jpg">
<meta property="og:url"
	content="https://www.kurly.com/shop/order/order_end.php?card_nm=%B1%B9%B9%CEVISA&amp;ordno=1594132518782">
<meta property="og:type" content="website">
<meta property="og:site_name" content="www.kurly.com">
<meta name="keywords"
	content="다이어트, 식단, 닭가슴살, 요리, 치아바타, 레시피, 요리, 상차림, 다이어트음식, 이유식, 건강이유식">
<title>마켓컬리 :: 내일의 장보기, 마켓컬리</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
<meta name="naver-site-verification"
	content="58ff7c242d41178131208256bfec0c2f93426a1d">
<script
	src="https://connect.facebook.net/signals/config/526625657540055?v=2.9.22&amp;r=stable"
	async=""></script>
<script async="" src="//connect.facebook.net/en_US/fbevents.js"></script>
<script async="" src="https://cdn.branch.io/branch-latest.min.js"></script>
<script type="text/javascript"
	integrity="sha384-vYYnQ3LPdp/RkQjoKBTGSq0X5F73gXU3G2QopHaIfna0Ct1JRWzwrmEz115NzOta"
	crossorigin="anonymous" async=""
	src="https://cdn.amplitude.com/libs/amplitude-5.8.0-min.gz.js"></script>
<script async="" src="//www.google-analytics.com/analytics.js"></script>
<script type="text/javascript"
	src="https://res.kurly.com/js/lib/jquery-1.10.2.min.js"></script>
<link rel="shortcut icon"
	href="https://res.kurly.com/images/marketkurly/logo/favicon_v2.png"
	type="image/x-icon">
<link rel="apple-touch-icon" sizes="57x57"
	href="https://res.kurly.com/images/marketkurly/logo/ico_57.png">
<link rel="apple-touch-icon" sizes="60x60"
	href="https://res.kurly.com/images/marketkurly/logo/ico_60.png">
<link rel="apple-touch-icon" sizes="72x72"
	href="https://res.kurly.com/images/marketkurly/logo/ico_72.png">
<link rel="apple-touch-icon" sizes="76x76"
	href="https://res.kurly.com/images/marketkurly/logo/ico_76.png">
<link rel="apple-touch-icon" sizes="114x114"
	href="https://res.kurly.com/images/marketkurly/logo/ico_114.png">
<link rel="apple-touch-icon" sizes="120x120"
	href="https://res.kurly.com/images/marketkurly/logo/ico_120.png">
<link rel="apple-touch-icon" sizes="144x144"
	href="https://res.kurly.com/images/marketkurly/logo/ico_144.png">
<link rel="apple-touch-icon" sizes="152x152"
	href="https://res.kurly.com/images/marketkurly/logo/ico_152.png">
<link rel="apple-touch-icon" sizes="180x180"
	href="https://res.kurly.com/images/marketkurly/logo/ico_180.png">
<link rel="icon" type="image/png" sizes="32x32"
	href="https://res.kurly.com/images/marketkurly/logo/ico_32.png">
<link rel="icon" type="image/png" sizes="192x192"
	href="https://res.kurly.com/images/marketkurly/logo/ico_192.png">
<link rel="icon" type="image/png" sizes="16x16"
	href="https://res.kurly.com/images/marketkurly/logo/ico_16.png">
<script
	src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js?ver=1.16.5"></script>
<script charset="UTF-8" type="text/javascript"
	src="https://t1.daumcdn.net/postcode/api/core/200421/1587459050284/200421.js"></script>
<script src="../data/skin/designgj/thefarmers.js?ver=1.16.5"></script>
<script src="../data/skin/designgj/common.js?ver=1.16.5"></script>
<script src="../data/skin/designgj/polify.js?ver=1.16.5"></script>
<script src="../data/skin/designgj/ui_v2.js?ver=1.16.5"></script>
<script src="/common_js/axios.js?ver=1.16.5"></script>
<link rel="styleSheet" href="../data/skin/designgj/normalize.css?ver=1.16.5">
<link rel="styleSheet" href="../data/skin/designgj/section1.css?ver=1.16.5">
<link rel="styleSheet" href="../data/skin/designgj/common.css?ver=1.16.5">

<style>
.async-hide {
	opacity: 0 !important
}
</style>
<style type="text/css">
#content {
	margin-bottom: 30px;
	padding-bottom: 0;
	background-color: #f3f2f4
}

#qnb {
	display: none
}
</style>
</head>
<body class="order-order_end" style="">
	<div id="wrap" class="">
		<div id="pos_scroll"></div>
		<div id="container">
			<jsp:include page="../main/layout/header.jsp"></jsp:include>

			<div id="main">
				<div id="content">
					<jsp:include page="../main/layout/quick_nav.jsp"></jsp:include>
					
					<div class="page_aticle section_end">
						<h2 class="screen_out">주문완료</h2>
						<div class="order_result">
							<div class="delivery_check">
								<img src="https://res.kurly.com/mobile/service/order/1909/img_success_order_end.gif" alt="아이콘" class="ico">
								<div class="check">
									<p class="tit">
										<span class="name">${ member.name }님의</span>
										<span class="name">주문이 완료되었습니다.</span>
									</p>
									<strong>
									<c:if test="${ param.delivery_type eq '샛별배송' }">내일</c:if>
									<c:if test="${ param.delivery_type eq '택배배송' }">모레</c:if>									
									</strong>만나요!
								</div>
							</div>
							<div class="amount_money ">
								<strong class="tit">결제금액</strong>
								<div class="money_point">
									<strong class="money">
									<fmt:formatNumber pattern="#,###" value="${ settlement_price }"></fmt:formatNumber>
									<span class="won">원</span></strong>
									<a class="point" href="/shop/main/html.php?htmid=proc/event_kurlyloves.htm">
										<strong class="amount">
										<fmt:formatNumber pattern="#,###" value="${ add_point }"></fmt:formatNumber>
										 원 적립*</strong>
										<span class="grade">(${ member.grade }
										<fmt:formatNumber pattern="#.#" value="${ percent*100 }"></fmt:formatNumber>%)</span>
									</a>
								</div>
								<p class="desc ">* 적립금은 배송당일에 적립됩니다.</p>
								<a class="btn btn_positive" href="../main/index.do">홈으로 이동</a>
								<a href="../mypage/mypage_orderlist.do"
									class="btn btn_orderlist">주문내역 보기</a>
								<p class="txt_cancel">
									<strong class="emph">‘입금확인’</strong> 상태일 때는 주문내역 상세 페이지에서 직접 주문 취소가 가능합니다.
								</p>
							</div>
							<span class="bg"></span> <span class="bg lst"></span>
						</div>
						<a class="take_away" href="/shop/event/kurlyEvent.php?htmid=event/2020/0303/paper">
							<strong class="tit">종이 박스, 컬리가 회수해드려요.</strong>
							<div class="desc">
								다음 주문 시, 펼쳐서 문 앞에 놓아 주세요. (최대 3개)
							</div>
							<span class="link">자세히 보러가기</span>
						</a>
						<div class="inquiry_check">
							주문 / 배송 및 기타 문의가 있을 경우, 1:1문의에 남겨주시면 신속히 해결해드리겠습니다.
						</div>
					</div>

				</div>
			</div>
			
			<jsp:include page="../main/layout/layerDSR.jsp"></jsp:include>
			<jsp:include page="../main/layout/footer.jsp"></jsp:include>
			
		</div>
	</div>
	
<a href="#top" id="pageTop">맨 위로가기</a>
<script>
	$(document).ready(function(){
		var pageTop = {
			$target : $('#pageTop'),
			$targetDefault : 0,
			$scrollTop : 0,
			$window : $(window),
			$windowHeight : 0,
			setTime : 500,
			saveHeight : 0,
			init:function(){
			},
			action:function(){
				var $self = this;
				$self.$windowHeight = parseInt($self.$window.height());
				$self.$window.on('scroll', function(){
					$self.$scrollTop = parseInt($self.$window.scrollTop());
					if($self.$scrollTop >= $self.$windowHeight){
						if(!$self.$target.hasClass('on')){
							$self.position();
							$self.$target.addClass('on');
							$self.showAction();
						}
					}else{
						if($self.$target.hasClass('on')){
							$self.position();
							$self.$target.removeClass('on');
							$self.hideAction();
						}
					}
				});
                
				$self.$target.on('click', function(e){
					e.preventDefault();
					$self.topAction();
				});
			},
			showAction:function(){
				var $self = this;
				$self.$target.stop().animate({
					opacity:1,
					bottom:$self.saveHeight
				}, $self.setTime);
			},
			hideAction:function(){
				var $self = this;
				$self.$target.stop().animate({
					opacity:0,
					bottom:-$self.$target.height()
				}, $self.setTime);
			},
			topAction:function(){
				var $self = this;
				$self.hideAction();
				$('html,body').animate({
					scrollTop:0
				}, $self.setTime);
			},
			position:function(){
				var $self = this;
				$self.saveHeight = 15;
				if($('#sectionView').length > 0){
					$self.saveHeight = 25;
				}
				if($('#branch-banner-iframe').length > 0 && parseInt( $('#branch-banner-iframe').css('bottom') ) > 0){
					$('#footer').addClass('bnr_app');
					$self.saveHeight += $('#branch-banner-iframe').height();
				}
			}
		}
		pageTop.action();
	});
</script>
</body>
</html>