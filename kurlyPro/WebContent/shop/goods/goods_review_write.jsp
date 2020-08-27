<%@page import="shop.member.model.MemberDTO"%>
<%@page import="shop.mypage.model.GoodsInfoDTO"%>
<%@page import="shop.mypage.model.ReviewBeforeDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	//세션에 담아놓은 변수들 가져오기
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

	GoodsInfoDTO dto = (GoodsInfoDTO)request.getAttribute("dto");
	String order_no = request.getParameter("orderno");
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
								<li><a href="../mypage/mypage_orderlist.do">주문내역</a></li>
								<li><a href="../mypage/mypage_wishlist.do">늘 사는 것</a></li>
								<li class="on"><a href="../mypage/mypage_review.do">상품후기</a></li>
								<li><a href="../mypage/mypage_emoney.do">적립금</a></li>
								<li><a href="../mypage/mypage_coupon.do">쿠폰</a></li>
								<li><a href="../mypage/myinfo.do">개인 정보 수정</a></li>
							</ul>
						</div>
						<a href="" class="link_inquire"><span class="emph">도움이 필요하신가요 ?</span> 1:1 문의하기</a>
					</div>
					<div class="page_section section_write">
						<div class="head_aticle">
							<h2 class="tit">후기 작성</h2>
						</div>
						<div class="head_section layer_type">
							<span class="link">
								<a href="#none">작성 시 유의 사항</a>
							</span>
							<div class="layer">
								<h4 class="tit_layer">후기 작성 시 유의사항</h4>
								<p class="desc_layer">마켓컬리는 믿을 수 있는 후기문화를 함께 만들어 가고자<br> 합니다. 따라서 후기 내용이 아래에 해당하는 경우에는 검토 후<br> 비공개 조치될 수 있습니다.</p>
								<ul class="list_layer">
									<li>1. 욕설, 비난 등 업체나 타인에게 불쾌한 내용을 작성한 경우</li>
									<li>2. 해당 상품과 무관한 내용이나 동일 문자의 반복 등 부적합한<br> 내용을 작성한 경우</li>
									<li>3. 상품의 기능이나 효과 등에 오해의 소지가 있는 내용을<br> 작성한 경우</li>
									<li>4. 저작권, 초상권 등 타인의 권리를 침해하는 이미지 사용한<br> 경우</li>
								</ul>
								<button type="button" class="btn_ok">확인</button>
								<button type="button" class="btn_close"><span class="screen_out">레이어 닫기</span></button>
							</div>
						</div>
						
						
						<form name="form_review" action="../goods/goods_review_write_ok.do" id="form_review" method="post" enctype="multipart/form-data">
						
							<input type="hidden" name="mode" value="add_review">
							<input type="hidden" name="goodsno" value="${dto.goods_no }">
							<input type="hidden" name="orderno" value="${dto.order_no }">
							<input type="hidden" name="m_name" value="${ member.name }">
							<input type="hidden" name="m_id" value="${member.m_id }">
							
							<div class="write_board">
								<div class="goods_info">
									<div class="thumb">
										<img src="../..${dto.main_img }" onerror="this.src='/shop/data/skin/designgj/img/common/noimg_100.gif'" alt="상품 이미지">
									</div>
									<div class="desc">
										<div class="inner_desc">
											<div class="name_main">${dto.goods_name }</div>
										</div>
									</div>
								</div>
								<table class="tbl">
									<caption style="display:none">후기 작성 입력상자</caption>
									<colgroup>
										<col style="width:110px;">
										<col style="width:auto">
									</colgroup>
									<tbody>
										<tr>
											<th>제목</th>
											<td>
												<input type="text" name="subject" placeholder="제목을 입력해주세요." class="inp" >
											</td>
										</tr>
										
										<tr>
											<th>후기작성</th>
											<td>
												<div class="field_cmt">
													<textarea id="fieldCmt" name="contents" cols="100" rows="10" placeholder="자세한 후기는 다른 고객의 구매에 많은 도움이 되며,
일반식품의 효능이나 효과 등에 오해의 소지가 있는 내용을 작성 시 검토 후 비공개 조치될 수 있습니다.
반품/환불 문의는 1:1문의로 가능합니다." style="height: 202px;"></textarea>
													<p class="txt_count">
														<span class="num">0</span>자 / 최소 10자
													</p>
												</div>
											</td>
										</tr>
										
										<tr>
											<th>사진등록</th>
											<td>
												<div class="photo_add">
													<div class="inner_photo">
														<div class="item_photo" style="display: block;">
															<span class="photo" style="background-image: url();"></span>
															<button type="button" class="btn_delete"><span class="screen_out">등록된 사진 삭제</span></button>
															<input type="file" name="file[]" class="file_upload" onchange="photoUp($(this))" value="사진등록하기" accept="image/*">
														</div>
													</div>
													<span class="btn_upload">
														<input type="file" name="file[]" class="file_upload" onchange="photoUp($(this))" value="사진등록하기" accept="image/*">
													</span>
												</div>
												<div class="file_count">
													<p class="txt_count">
														<span class="num">0</span>장 / 최대 8장
													</p>
												</div>
												<p class="photo_notice">구매한 상품이 아니거나 캡쳐 사진을 첨부할 경우, 통보없이 삭제 및 적립 혜택이 취소됩니다.</p>
											</td>
										</tr>
									</tbody>
								</table>
								
								<p class="link_inquire"> 
								혹시 상품에 문제가 있으셨나요?<a href="../mypage/mypage_qna_register.do?mode=add_qna&amp;ordno=1592654040937">1:1 문의하기</a>
								</p>
								
								<button type="button" id="btnSubmit" class="btn_reg btn_disabled">등록하기</button>
							
							</div>
						</form>
					</div>
				</div>
				
			</div>
		</div>
		
		<script src="../../common_js/reviewwrite_v1.js?ver=1.16.15"></script>
		<script>
			var review = new reviewWrite();
			review.init('pc', false);
			review.action();
			function photoUp(target){
				review.photoUpload(target);
			}
			
			$("#btnSubmit").on("click", function(){
				//alert("test");
			})
		</script>

		<div class="layer_btn1">
			<button type="button" class="btn_close" onclick="$('#layerDSR').hide();$(this).parent().find('.inner_layer').hide();">확인</button>
		</div>
		<button type="button" class="layer_close" onclick="$('#layerDSR').hide();$(this).parent().find('.inner_layer').hide();"></button>
		
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