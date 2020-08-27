<%@page import="shop.mypage.model.OrderListView"%>
<%@page import="java.util.Calendar"%>
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
	
	// WishlistHandler에서 setAttrubute로 담아놓은 결과값(늘 사는것 목록)을 가져오기
	OrderListView list =  (OrderListView)request.getAttribute("list");
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
				
				<dd class="page_aticle aticle_type2">
					<div id="snb" class="snb_my">
						<h2 class="tit_snb">마이컬리</h2>
						<div class="inner_snb">
							<ul class="list_menu">
								<li><a href="mypage_orderlist.do">주문 내역</a>
								</li>
								<li class="on"><a href="mypage_wishlist.do">늘
										사는 것</a></li>
								<li><a href="mypage_review.do">상품후기</a></li>
								<li><a href="mypage_emoney.do">적립금</a></li>
								<li><a href="mypage_coupon.do">쿠폰</a></li>
								<li><a href="myinfo.do">개인 정보 수정</a></li>
							</ul>
						</div>
						<a href="../mypage/mypage_qna.do"
							class="link_inquire"><span class="emph">도움이 필요하신가요 ?</span>
							1:1 문의하기
						</a>
					</div>
					<div id="section_wishlist" class="page_section section_wishlist">
						<div class="head_aticle">
							<h2 class="tit">
								늘 사는 것 <span class="tit_sub">늘 사는 것으로 등록하신 상품 목록 입니다</span>
							</h2>
						</div>
						<form name="frmWish" method="post">
							<input type="hidden" name="mode">
							<table class="tbl tbl_type1">
								<colgroup>
									<col style="width: 27px;">
									<col style="width: 150px;">
									<col style="width: auto;">
									<col style="width: 165px;">
								</colgroup>
								<thead>
									<tr>
										<th>
											<!-- 
											<label class="label_check "> <input type="checkbox" class="ico_check" name="all_checked">
											</label>
											 -->
										</th>
										<th><span class="screen_out">상품이미지</span></th>
										<th>상품정보</th>
										<th>선택</th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${ empty list.wishList }">
										<tr>
											<td class="no_data" colspan="4">늘 사는 상품 내역이 없습니다.</td>
										</tr>
									</c:if>
									
									<c:if test="${ not empty list.wishList }">
										<c:forEach items="${ list.wishList }" var="dto">
											<tr>
												<td>
													<input type="hidden" name="goodsno[${dto.goods_no }]" value=""> 
													<input type="hidden" name="opt[${dto.goods_no }][]" value=""> 
													<input type="hidden" name="package_data[${dto.goods_no }]" value="">
													<%-- 
													<label class="label_check"> 
														<input id="wishlist-checkbox-${dto.goods_no }" type="checkbox" name="sno[]" value="${dto.goods_no }" class="ico_check">
													</label>
													 --%>
												</td>
												<td class="thumb">
													<a href="../goods/goods_view.do?group_no=${dto.group_no }">
													<img
														src="../data/goods/${dto.group_no }.jpg"
														width="126"
														onerror="this.src='https://www.kurly.com/shop/data/skin/designgj/img/common/noimg_130.gif'">
													</a>
												</td>
												<td class="info">
													<div class="name">
														<a href="../goods/goods_view.do?group_no=${dto.group_no }">${dto.group_name }</a>
													</div>
													<dl>
														<dt class="screen_out">상품가격</dt>
														<dd>${ dto.price }원</dd>
													</dl>
													<dl class="packege">
														<dt class="tit">※ 패키지 구성품</dt>
														<dd>
														${dto.goods_name } / ${ dto.price }원<br>
														</dd>
													</dl>
												</td>
											<td>
												<div class="group_btn">
													<button type="button"
														name="${dto.group_no }" class="btn btn_positive">장바구니 담기</button>
													<button type="button" id="${dto.goods_no }" class="btn btn_negative one">삭제</button>
												</div>
											</td>
										</tr>
										</c:forEach>
									</c:if>

								</tbody>
							</table>
							<div class="group_btn">
								<div class="inner_groupbtn">
									<button type="button" id="wishlist_del_all"
										class="btn btn_negative all">늘 사는 것 비우기</button>
									<span class="space"></span>
									<button type="button" class="btn btn_positive all">전체 주문하기</button>
								</div>
							</div>
						</form>
						
						<!-- 페이징 처리 -->
						<div class="layout-pagination">
							<div class="pagediv">
								<a href="mypage_wishlist.do?page=1" class="layout-pagination-button layout-pagination-first-page">맨 처음 페이지로 가기</a> 
								<a href="mypage_wishlist.do?page=${ list.currentPage-1 == 0 ? 1 : list.currentPage-1 }" class="layout-pagination-button layout-pagination-prev-page">이전 페이지로 가기</a>
								<c:forEach var="num" begin="1" end="${ list.pageTotal }" step="1">
									<span>
										<c:if test="${ num eq list.currentPage }">
											<strong class="layout-pagination-button layout-pagination-number __active">${ num }</strong>
										</c:if>
										<c:if test="${ num ne list.currentPage }">
											<a class="layout-pagination-button layout-pagination-number" href="mypage_wishlist.do?page=${ num }">${ num }</a>
										</c:if>
									</span>
								</c:forEach>
								<a href="mypage_wishlist.do?page=${ list.currentPage+1 > list.pageTotal ? list.pageTotal : list.currentPage+1 }" class="layout-pagination-button layout-pagination-next-page">다음 페이지로 가기</a> 
								<a href="mypage_wishlist.do?page=${ list.pageTotal }" class="layout-pagination-button layout-pagination-last-page">맨 끝 페이지로 가기</a>
							</div>
						</div>
						
					</div>
				</dd>
				
			</div>
			
			<script type="text/javascript">
				function act_all(mode) {
					// if(!$('[name="all_checked"]').parent().hasClass('checked')) $('[name="all_checked"]').parent().trigger('click');
					act(mode);
				}
				function act(mode) {
					var fm = document.frmWish;
					if (isChked('sno[]')) {
						fm.mode.value = mode;
						fm.submit();
					}
				}
				function act_sol(mode, sno) {
					$('[name="sno[]"]').prop("checked", false);
					$('#wishlist-checkbox-' + sno)
							.prop("checked", true);
					act(mode);
				}
			
				// 체크박스
				$(".label_check")
						.on(
								"click",
								function(e) {
									e.preventDefault();
									if (!$(this).find(
											'input[type=checkbox]').is(
											':checked')) {
										$(this).find(
												'input[type=checkbox]')
												.prop('checked',
														'checked');
										$(this).addClass('checked');
									} else {
										$(this).find(
												'input[type=checkbox]')
												.prop('checked', '');
										$(this).removeClass('checked');
										$(
												'.section_wishlist .tbl_type1 th .label_check')
												.removeClass('checked');
										$(
												'.section_wishlist .tbl_type1 th input[name=all_checked]')
												.prop('checked', '');
									}
			
									if ($(this).find('input').attr(
											'name') === "all_checked") {
										var target = $('.section_wishlist .tbl_type1 td input[type=checkbox]');
										if ($(this)
												.find(
														'input[name=all_checked]')
												.is(':checked')) {
											target.prop('checked',
													'checked');
											target
													.parent('label')
													.addClass('checked');
										} else {
											target.prop('checked', '');
											target.parent('label')
													.removeClass(
															'checked');
										}
									}
								});
			</script>
			
			
		</div>
	
		<jsp:include page="../main/layout/layerDSR.jsp"></jsp:include>
		<jsp:include page="../main/layout/footer.jsp"></jsp:include>

	</div>

</div>

<script>
// 늘 사는 것 목록에서 비우기 버튼을 클릭하면
$("#wishlist_del_all").on("click", function(){
	//alert("클릭");
	var m_id = "${member.m_id}";
	
	$.ajax({
		url:"./ajax_group/del_wishList.jsp",
		type:"GET",
		data:{"goods_no" : "*", "m_id" : m_id},
		cache:false,
		dataType:"json",
		success:function(data){	
			if(data.count>=1){
				$(this).parents("tr").remove();
				$("#section_wishlist").load(location.href + " #section_wishlist" );
				//location.reload();
			}else{
				alert("삭제 오류 발생!");
			}
		}
	})
	
});

// 위의 알림창 닫기 (x표, 취소버튼)
$(".ask-alert-close-button, .styled-button.__active").on("click", function(){
	$(".ask-layer-wrapper").css("display", "none");
});


//새로 동적으로 불러온 영역에서도 이벤트가 등록되려면 클릭한 시점의 documnet필요
$(document).on("click", ".btn_negative.one" ,function(){
	var goods_no = $(this).attr("id");
	// alert(goods_no);
	
	var m_id = "${member.m_id}";

	$.ajax({
		url:"./ajax_group/del_wishList.jsp",
		type:"GET",
		data:{"goods_no" : goods_no, "m_id" : m_id},
		cache:false,
		dataType:"json",
		success:function(data){	
			if(data.count==1){
				$(this).parents('tr:last').remove();
				$("#section_wishlist").load(location.href + " #section_wishlist" );
				//location.reload();
			}else{
				alert("삭제 오류 발생!");
			}
		}
	})
})

</script>

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