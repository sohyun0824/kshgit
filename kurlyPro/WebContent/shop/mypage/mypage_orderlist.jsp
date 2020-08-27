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
	
	// 주문내역 관련 정보가 들어있는 list
	OrderListView list =  (OrderListView)request.getAttribute("list");
	
	// 현재 연도
	int year = Calendar.getInstance().get(Calendar.YEAR);
	
	// 선택 연도
	String sel_year = request.getParameter("period")==null ? "전체 기간" : request.getParameter("period")+"년";		
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
							class="link_inquire">
						<span class="emph">도움이 필요하신가요 ?</span>
							1:1 문의하기
						</a>
					</div>
					
					<div id="viewOrderList" class="page_section section_orderlist">
						<div class="head_aticle">
							<h2 class="tit">
								주문 내역 
								<span class="tit_sub">지난 3년간의 주문 내역 조회가 가능합니다</span>
							</h2>
						</div>

						<div class="search_date">
							<h3 class="screen_out">기간 선택</h3>
							<a href="#none" class="btn_layer"><%=sel_year %></a>
							<ul class="layer_search">
								<li><a href="mypage_orderlist.do">전체기간</a></li>
								<li><a href="mypage_orderlist.do?period=<%=year %>" data-year="<%=year %>"> 2020년</a></li>
								<li><a href="mypage_orderlist.do?period=<%=year-1 %>" data-year="<%=year-1 %>"> 2019년</a></li>
								<li><a href="mypage_orderlist.do?period=<%=year-2 %>"  data-year="<%=year-2 %>"> 2018년</a></li>
							</ul>
						</div>
						

						<ul class="list_order">
						<c:if test="${ list.orderList eq null }">
							<li class="no_data">
								주문내역이 없습니다.
							</li>
						</c:if>
						
						<c:if test="${list.orderList ne null }">
							<c:forEach items="${ list.orderList }" var="dto" varStatus="status">
								<c:if test="${ list.orderList[status.index].order_no != list.orderList[status.index-1].order_no }">
								<li>
									<div class="date">
										<fmt:formatDate value="${ dto.order_date }" pattern="yyyy.MM.dd"/>
									</div>
									
									<div class="order_goods">
										<div class="name">
											<a href="mypage_orderdetail.do?orderno=${dto.order_no}">${dto.group_name}</a>
										</div>
										
										<div class="order_info">
										<div class="thumb">
											<img src="../data/goods/${dto.group_no }.jpg" alt="해당 주문 대표 상품 이미지">
										</div>
										<div class="desc">
											<dl>
												<dt>주문번호</dt>
												<dd>${dto.order_no }</dd>
											</dl>
											<dl>
												<dt>결제금액</dt>
												<dd>${dto.pay_amount }원</dd>
											</dl>
											<dl>
												<dt>주문상태</dt>
												<dd class="status end">${dto.status }</dd>
											</dl>
										</div>										
									</div>
									
									<div class="order_status">
										<span class="inner_status">
											<a href="mypage_review.do" class="link link_review ga_tracking_event">후기 쓰기</a>
											<a href="mypage_qna.do" class="link ga_tracking_event">1:1 문의</a>
										</span>
									</div>
									</div>
									</c:if>
								</li>
							</c:forEach>
						</c:if>
						
						
						</ul>
						
						<!-- 페이징 처리 -->
						<div class="layout-pagination">
							<div class="pagediv">
								<a href="mypage_orderlist.do?page=1" class="layout-pagination-button layout-pagination-first-page">맨 처음 페이지로 가기</a> 
								<a href="mypage_orderlist.do?period=${ period }&page=${ list.currentPage-1 == 0 ? 1 : list.currentPage-1 }" class="layout-pagination-button layout-pagination-prev-page">이전 페이지로 가기</a>
								<c:forEach var="num" begin="1" end="${ list.pageTotal }" step="1">
									<span>
										<c:if test="${ num eq list.currentPage }">
											<strong class="layout-pagination-button layout-pagination-number __active">${ num }</strong>
										</c:if>
										<c:if test="${ num ne list.currentPage }">
											<a class="layout-pagination-button layout-pagination-number" href="mypage_orderlist.do?period=${ period }&page=${ num }">${ num }</a>
										</c:if>
									</span>
								</c:forEach>
								<a href="mypage_orderlist.do?period=${ period }&page=${ list.currentPage+1 > list.pageTotal ? list.pageTotal : list.currentPage+1 }" class="layout-pagination-button layout-pagination-next-page">다음 페이지로 가기</a> 
								<a href="mypage_orderlist.do?period=${ period }&page=${ list.pageTotal }" class="layout-pagination-button layout-pagination-last-page">맨 끝 페이지로 가기</a>
							</div>
						</div>
														
					</div>
				</div>
				
			</div>
		</div>
	
		<jsp:include page="../main/layout/layerDSR.jsp"></jsp:include>
		<jsp:include page="../main/layout/footer.jsp"></jsp:include>

	</div>
	
	<script>
	//주문내역에서 기간선택하는 부분 (클릭하면 )
	$('.search_date .btn_layer').on('click',function(e){
	    e.preventDefault();
	    $(this).toggleClass('on');
	    $('.search_date .layer_search').slideToggle(100);
	    
	});
	
	</script>
	
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