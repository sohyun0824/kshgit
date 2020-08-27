<%@page import="shop.mypage.model.DeliveryInfoDTO"%>
<%@page import="shop.mypage.model.OrderInfoDTO"%>
<%@page import="shop.mypage.model.PayInfoDTO"%>
<%@page import="shop.mypage.model.OrderDetailDTO"%>
<%@page import="java.util.Calendar"%>
<%@page import="shop.mypage.model.OrderListView"%>
<%@page import="shop.mypage.model.ReviewBeforeDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.member.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
	request.setCharacterEncoding("UTF-8");

	// 세션에 담아놓은 변수들 가져오기
	MemberDTO member = (MemberDTO)session.getAttribute("member");

	// 세션 만료되었을 경우 대비, 로그인상태인지 확인
	if(member == null){
		%>
		<script>
			alert("로그인하셔야 본 서비스를 이용하실 수 있습니다.\n로그인 화면으로 이동합니다.");
			location.href="../member/login.do?return_url=/kurlyPro/mypage/mypage_review.do";
		</script>
		<%
	} 
	
	double percent = (double)session.getAttribute("percent");
	String m_id = member.getM_id();
	String m_name = member.getName();
	String grade = member.getGrade();
	int point = member.getTotal_point();
	int coupon = (int)request.getAttribute("coupon"); 
	int kurlypass = (int)request.getAttribute("kurlypass");
	
	request.setCharacterEncoding("UTF-8");
	// 주문내역 관련 정보가 들어있는 list
	ArrayList<OrderDetailDTO> list = (ArrayList<OrderDetailDTO>) request.getAttribute("list");
	// 주문번호에 해당하는 결제내역이 들어있는 pay_dto
	PayInfoDTO pay_dto = (PayInfoDTO)request.getAttribute("pay_dto");
	// 주문번호에 해당하는 주문정보내역이 들어있는 order_dto
	OrderInfoDTO order_dto =  (OrderInfoDTO)request.getAttribute("order_dto");
	// 주문번호에 해당하는 배송정보내역이 들어있는 delivery_dto
	DeliveryInfoDTO delivery_dto = (DeliveryInfoDTO)request.getAttribute("delivery_dto");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 사이트 제목, 설명 -->
<meta name="title" content="마켓컬리 :: 내일의 장보기, 마켓컬리" />
<meta name="description" content="모두가 사랑하는 장보기, 마켓컬리! 당일 수확 채소, 과일, 맛집 음식까지 내일 아침 문 앞에서 만나요!" />
<meta property="og:title" content="마켓컬리 :: 내일의 장보기, 마켓컬리" />
<meta property="og:description" content="모두가 사랑하는 장보기, 마켓컬리! 당일 수확 채소, 과일, 맛집 음식까지 내일 아침 문 앞에서 만나요!" />
<!-- 사이트 대표이미지, 타입(웹사이트), url  -->
<meta property="og:image" content="https://res.kurly.com/images/marketkurly/logo/logo_sns_marketkurly.jpg" />
<meta property="og:url" content="https://www.kurly.com/shop/main/index.php?" />
<meta property="og:type" content="website" />
<meta property="og:site_name" content="www.kurly.com" />
<title>마켓컬리 :: 내일의 장보기, 마켓컬리</title>
<!-- 브라우저 호환 설정, IE=edge(최신버전으로 문서모드 설정) -->
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0" />
<!-- 마켓컬리 아이콘이미지들 -->
<link rel="icon" type="image/png" sizes="32x32" href="https://res.kurly.com/images/marketkurly/logo/ico_32.png">
<link rel="icon" type="image/png" sizes="192x192" href="https://res.kurly.com/images/marketkurly/logo/ico_192.png">
<link rel="icon" type="image/png" sizes="16x16" href="https://res.kurly.com/images/marketkurly/logo/ico_16.png">

<!-- 외부 css파일 -->
<link rel="styleSheet" href="../data/skin/designgj/normalize.css?ver=1.14.7">
<link rel="styleSheet" href="../data/skin/designgj/section1.css?ver=1.14.7">
<link rel="styleSheet" href="../data/skin/designgj/common.css">

<style>.async-hide { opacity: 0 !important} </style>

<!-- 외부 스크립트파일 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="../data/skin/designgj/polify.js?ver=1.16.5"></script>
<script src="../data/skin/designgj/common.js?ver=1.16.5"></script>

<script src="../../common_js/axios.js?ver=1.16.5"></script>
<script src="../../common_js/common_filter.js?ver=1.16.5"></script>
<script src="../../js/lib/moment.min.js"></script>

<!-- quick_nav 관련 스크립트 -->
<script src="../data/skin/designgj/ui_v2.js?ver=1.16.5"></script>

</head>
<body class="mypage-mypage_review">
<div id="wrap" class="">
	<div id="pos_scroll"></div>
	<div id="container">
		<jsp:include page="../main/layout/header.jsp"></jsp:include>
		
		<div id="main">
			<div id="content">
				<jsp:include page="../main/layout/quick_nav.jsp"></jsp:include>
				
				<div id="myPageTop" class="page_aticle mypage_top">
					<h2 class="screen_out">마이페이지</h2>
					<div class="mypagetop_user">
						<div class="inner_mypagetop">
							<div class="grade_user">
								<div class="grade">
									<span class="screen_out">등급</span> 
									<span class="ico_grade class5"> 
										<span class="inner_grade">
											<span class="in_grade"><%=grade %></span>
										</span>
									</span>
									<div class="grade_bnenfit">
										<div class="user">
											<strong class="name"><%=m_name %></strong> <span class="txt">님</span>
										</div>
										<!---->
										<div class="benefit"><%=percent*100%>% 적립 + 쿠폰<%=coupon%>장</div>
									</div>
								</div>
								<div class="next">
									<a href="" class="total_grade">전체등급 보기
									</a> 
									<a href="" class="next_month">다음 달 예상등급 보기</a>
								</div>
							</div>
							<ul class="list_mypage">
								<li class="user_reserve">
									<div class="link">
										<div class="tit">
											적립금
										</div>
										<a href="mypage_emoney.do" class="info"> <%=point %>원 
										<img src="https://res.kurly.com/pc/service/common/1905/ico_arrow_56x56.png"
											alt="자세히 보기"> <span class="date">소멸 예정 0 원</span>
										</a>
									</div>
								</li>
								<li class="user_coupon">
									<div class="link">
										<div class="tit">쿠폰</div>
										<a href="mypage_coupon.do" class="info"><%=coupon%> 개
											<img
											src="https://res.kurly.com/pc/service/common/1905/ico_arrow_56x56.png"
											alt="자세히 보기">
										</a>
									</div>
								</li>
								<li class="user_kurlypass">
									<div class="link">
										<div class="tit">컬리패스</div>
										<a href="" class="info">
											<c:if test="${kurlypass eq 0 }">
												알아보기
											</c:if>
											<c:if test="${kurlypass ne 0 }">
												사용중
											</c:if>
											<img src="https://res.kurly.com/pc/service/common/1905/ico_arrow_56x56.png" alt="자세히 보기">
										</a>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div> 
				
				<div class="bg_loading" id="bgLoading" style="display: none;">
					<div class="loading_show"></div>
				</div>
				
				<div class="page_aticle aticle_type2">
					<div id="snb" class="snb_my">
						<h2 class="tit_snb">마이컬리</h2>
						<div class="inner_snb">
							<ul class="list_menu">
								<li class="on"><a href="mypage_orderlist.do">주문내역</a></li>
								<li><a href="mypage_wishlist.do">늘 사는 것</a></li>
								<li><a href="mypage_review.do">상품후기</a></li>
								<li><a href="mypage_emoney.do">적립금</a></li>
								<li><a href="mypage_coupon.do">쿠폰</a></li>
								<li><a href="myinfo.do">개인 정보 수정</a></li>
							</ul>
						</div>
						<a href="../mypage/mypage_qna.do"
							class="link_inquire"><span class="emph">도움이 필요하신가요 ?</span>
							1:1 문의하기</a>
					</div>
					<div class="page_section section_orderview">
						<div class="head_aticle">
							<h2 class="tit">주문 내역 상세</h2>
						</div>
						<div class="head_section link_type">
							<h3 class="tit">주문번호 ${param.orderno}</h3>
							<span class="link"> 배송 또는 상품에 문제가 있나요? <a
								href="/shop/mypage/mypage_qna_write.do?mode=add_qna&ordno=${param.orderno}">1:1 문의하기</a>
							</span>
						</div>
						<form name="frmOrdView" method="post">
							<input type="hidden" name="mode"> 
							<input type="checkbox" name="include" checked="checked" value="" class="chk_cart">
							<table class="tbl tbl_type1">
								<colgroup>
									<col style="width: 30px;">
									<col style="width: 100px;">
									<col style="width: 100px;">
									<col style="width: 160px;">
									<col style="width: 100px;">
									<col style="width: 100px;">
								</colgroup>
								<tbody>
									<c:forEach items="${ list }" var="dto" varStatus="status">
										<!-- 이전 상품과 그룹명이 같지않다면 그룹명을 나타내고 같다면 나타내지 않는다 -->
										<c:if test="${list[status.index].gr_name != list[status.index-1].gr_name }">
										<tr class="fst tit_package">
											<td colspan="6">
											<a
											href="../goods/goods_view.do?group_no=${dto.group_no }"
											class="name">${ dto.gr_name }</a>
											</td>
										</tr>
										</c:if>
										
										<tr class="package">
										<td class="thumb">
										<a href="../goods/goods_view.do?group_no=${dto.group_no }">
											<img
												src="../..${dto.main_img }"
											></a>
										</td>
										<td class="info" style="width:322px">
											<div class="name">
												<a href="../goods/goods_view.do?group_no=${dto.group_no }"
													class="name">${dto.goods_name }</a>
											</div>
											<div class="desc">

												<span class="screen_out">할인가</span> <span class="price">${ dto.g_price }원</span> 
												<span class="screen_out">판매가</span> <span class="cost">${dto.g_price - dto.g_price*dto.discount }원</span> 
												<span class="ea">${dto.cnt}개 구매</span>
											</div>
										</td>
										<td class="progress ">${dto.status }</td>
										<td class="action">
											<a href="../goods/goods_review_write.do?goodsno=${dto.goods_no }&orderno=${dto.order_no}" onclick="" 
											class="btn btn_after ga_tracking_event">후기쓰기</a>
											
											<!-- 장바구니담기 클릭하면  팝업창 띄우기 -->
											<button type="button" class="btn btn_cart ga_tracking_event" name="${dto.group_no}" >장바구니 담기</button>
			
										</td>
										
									</tr>
									</c:forEach>
									
								</tbody>
							</table>
						</form>
						<div id="orderCancel" class="order_cancel">
							<span class="inner_cancel">
								<button type="button" id="cartPutAll" class="btn btn_cart">전체 상품 다시 담기</button>
								<button type="button" class="btn btn_cancel off">전체 상품 주문 취소</button>
							</span>
							<p class="cancel_notice">
								직접 주문 취소는 <strong class="emph">‘입금확인’</strong> 상태일 경우에만 가능합니다.
							</p>
						</div>
						<div class="head_section">
							<h3 class="tit">결제 정보</h3>
						</div>


						<table class="tbl tbl_type2">
							<colgroup>
								<col style="width: 209px">
								<col style="width: auto">
							</colgroup>
							<tbody>
								<tr>
									<th>총주문금액</th>
									<td><span id="paper_goodsprice">${pay_dto.order_amount }</span>원</td>
								</tr>
								<tr>
									<th>상품할인</th>
									<td>- <span id="paper_goodsDc">${pay_dto.discount }</span>원
									</td>
								</tr>
								<tr>
									<th>쿠폰할인</th>
									<td><span id="paper_coupon">${pay_dto.coupon }</span>원</td>
								</tr>
								<tr>
									<th>적립금 사용</th>
									<td><span id="paper_emoney">${pay_dto.point }</span>원</td>
								</tr>
								<tr>
									<th>배송비</th>
									<td>
										<div id="paper_delivery_msg1">
											<span id="paper_delivery">${pay_dto.del_fee }</span>원
										</div>
										<div id="paper_delivery_msg2"
											style="float: left; margin: 0; display: none"></div>
									</td>
								</tr>
								<tr>
									<th>결제금액</th>
									<td><strong class="emph"><span
											id="paper_settlement">${pay_dto.pay_amount }</span>원</strong></td>
								</tr>
								<tr>
									<th>적립금액</th>
									<td><strong class="emph">${pay_dto.add_point } 원</strong></td>
								</tr>
								<tr>
									<th>결제방법</th>
									<td>${pay_dto.pay_name }</td>
								</tr>
							</tbody>
						</table>
						
						<div class="head_section">
							<h3 class="tit">주문 정보</h3>
						</div>
						
						<table class="tbl tbl_type2">
							<colgroup>
								<col style="width: 209px">
								<col style="width: auto">
							</colgroup>
							<tbody>
								<tr>
									<th>주문 번호</th>
									<td>${ order_dto.order_no }</td>
								</tr>
								<tr>
									<th>주문자명</th>
									<td>${ order_dto.user_name }</td>
								</tr>
								<tr>
									<th>보내는 분</th>
									<td>${ order_dto.user_name }</td>
								</tr>
								<tr>
									<th>결제일시</th>
									<td>${order_dto.pay_date }</td>
								</tr>
								<tr>
									<th>주문 처리상태</th>
									<td>${ order_dto.status }</td>
								</tr>
							</tbody>
						</table>

						<div class="head_section">
							<h3 class="tit">배송 정보</h3>
						</div>
						<table class="tbl tbl_type2">
							<colgroup>
								<col style="width: 209px">
								<col style="width: auto">
							</colgroup>
							<tbody>
								<tr>
									<th>받는 분</th>
									<td>${delivery_dto.receiver }</td>
								</tr>
								<tr>
									<th>받는 분 핸드폰</th>
									<td>${delivery_dto.tel }</td>
								</tr>
								<tr>
									<th>배송방법</th>
									<td>${delivery_dto.type }</td>
								</tr>
								<tr>
									<th>주소</th>
									<td>${delivery_dto.address }</td>
								</tr>
							</tbody>
						</table>
						<div class="head_section">
							<h3 class="tit">받으실 장소</h3>
						</div>
						<table class="tbl tbl_type2">
							<colgroup>
								<col style="width: 209px">
								<col style="width: auto">
							</colgroup>
							<tbody>
								<tr>
									<th>받으실 장소</th>
									<td>${delivery_dto.loc }</td>
								</tr>
								<tr>
									<th>공동현관 출입 방법</th>
									<td>${delivery_dto.front_door }</td>
								</tr>
							</tbody>
						</table>
						<div class="head_section">
							<h2 class="tit">추가 정보</h2>
						</div>
						<table class="tbl tbl_type2">
							<colgroup>
								<col style="width: 200px">
								<col style="width: auto">
							</colgroup>
							<tbody>
								<tr>
									<th>메세지 전송 시점</th>
									<td>${delivery_dto.msg }</td>
								</tr>
								<tr>
									<th>미출시 조치방법</th>
									<td>${order_dto.no_goods }</td>
								</tr>
							</tbody>
						</table>

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