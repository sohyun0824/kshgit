<%@page import="shop.member.model.MemberDTO"%>
<%@page import="shop.goods.model.GoodsCartListDTO"%>
<%@page import="shop.goods.model.GoodsCartDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	MemberDTO member = (MemberDTO)session.getAttribute("member");
	
	if(member == null) {
		%>
		<script>
			alert("로그인하셔야 본 서비스를 이용하실 수 있습니다.\n로그인 화면으로 이동합니다.");
			location.href="../member/login.do?return_url=/kurlyPro/shop/goods/goods_cart.do";
		</script>
		<%
	    //response.sendRedirect("../member/login.do?return_url=/kurlyPro/shop/goods/goods_cart.do");
	 } 
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
<style type="text/css">
/* 장바구니에서만 전용 */
.layout-page-header {
	padding-bottom: 10px
}
</style>

<!-- 외부 스크립트파일 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="../data/skin/designgj/polify.js?ver=1.16.5"></script>
<script src="../data/skin/designgj/common.js?ver=1.16.5"></script>

<script src="../../common_js/axios.js?ver=1.16.5"></script>
<script src="../../common_js/common_filter.js?ver=1.16.5"></script>
<script src="../../js/lib/moment.min.js"></script>

<!-- quick_nav 관련 스크립트 -->
<script src="../data/skin/designgj/ui_v2.js?ver=1.16.5"></script>

<script>
// 체크박스
function count_check() {
	var allCheckCnt = $(".goods_check .label_check").length - $(".goods_check .label_check.disabled").length;
	var checkCnt = $(".goods_check .label_check.checked").length;
	$("span.num_total").text(allCheckCnt);
	$("span.num_count").text(checkCnt);

	if(allCheckCnt == checkCnt) {
		$(".all_select .label_check").addClass("checked");
	} else {
		$(".all_select .label_check").removeClass("checked");
	} 
	calculate();
}
$(function(){

	// 알림메세지 닫기나 확인 누르면 닫힘
	$(".ask-alert-close-button, .styled-button").on("click", function(){
		$(this).closest(".ask-layer-wrapper").css("display", "none");		
	});
	
	 
	 // * 품절된 상품은 품절이라고 표시
	 $("input.soldout").each(function() {
		if($(this).val()==1){
			var basketNo = $(this).closest(".view_goods").attr("id");

			$("#"+basketNo+" .name_goods").addClass("name_soldout");
			$("#"+basketNo+" .tbl_goods").addClass("goods_soldout");
			$("#"+basketNo+" .label_check").addClass("disabled");
			$("#"+basketNo+" .label_check").removeClass("checked");
			$("#"+basketNo+" .label_check .ico_check").prop("checked", false);
			$("#"+basketNo+" .label_check .ico_check").prop("disabled", "disabled");
			
			$("#"+basketNo+" .goods_info a").prepend('<span>(품절) </span>');
			
			$("#"+basketNo+" td[header=thCount]").html('');
			$("#"+basketNo+" td[header=thCost]").html('');
		}
	});
	
	 // * 상품그룹이면 그룹명 표기
	 var prev = null;
	 $(".view_goods").each(function(i, element) {
		 
	 	var groupName = $(this).children("input.group_name").val();
	 	var goodsName = $(this).children("input.goods_name").val();
	 	
	 	if(groupName != goodsName) {
	 		$(this).addClass("view_pakege");

			if (i>0 && prev== groupName) {
				$(this).parent().prev().children(".view_goods").removeClass("lst");
				$(this).addClass("lst");
			} else {
				$(this).addClass("fst").addClass("lst");
		 		$(this).prepend('<div class="name_goods">'+groupName+'</div>');
			}
	 			
			prev = groupName;
	 	}
	 });
	
	// * 한개의 상품 체크 했다가 해제 했다가 하기
	$(".goods_check .label_check .ico_check").on("click", function(){
		$(this).parents("label").toggleClass("checked");
		count_check();
	});
	
	
	// * 수량 감소 / 추가
	$(".btn_reduce").on("click", function() {
		// 현재 cnt == 최소구매수량 이면 
		var min = $(".view_goods .min").val();
		if($(this).next().val() == min) {
			$(".ask-layer-wrapper").show();
			$(".ask-alert-message").text("구매수량은 " + min + " 이상 입력해야 합니다.");
		} else {
			//location.href="goods_cart_up.do?basket_no="+$(this).closest(".view_goods").children("input.basket_no").val()+"&val=-1";
			var goods = $(this).closest(".view_goods");
			var basketNo = goods.attr("id");
			$.ajax({
				url: "goods_cart_up.jsp"
				, type: "get"
				, cache: false
				, data: {"basket_no":basketNo, "val":"-1"}
				, dataType: "json"
				, success: function(data){
					$("#"+basketNo).find(".inp_quantity").val(data.cnt);
					$("#"+basketNo).find(".cnt").val(data.cnt);
					$("#"+basketNo).find(".b_price").val(data.price);
					$("#"+basketNo+" .goods_total").load(location+" #"+basketNo+" .goods_total");
					
					calculate();
				}
				, error: function(request, status, error){
					alert("상품 수량 변경에 실패했습니다.");
				}
			});
		}
	});
	$(".btn_rise").on("click", function() {
		var goods = $(this).closest(".view_goods");
		var basketNo = goods.attr("id");
		$.ajax({
			url: "goods_cart_up.jsp"
			, type: "get"
			, cache: false
			, data: {"basket_no":basketNo, "val":"1"}
			, dataType: "json"
			, success: function(data){
				$("#"+basketNo).find(".inp_quantity").val(data.cnt);
				$("#"+basketNo).find(".cnt").val(data.cnt);
				$("#"+basketNo).find(".b_price").val(data.price);
				$("#"+basketNo+" .goods_total").load(location+" #"+basketNo+" .goods_total");
				
				calculate();
			}
			, error: function(request, status, error){
				alert("상품 수량 변경에 실패했습니다.");
			}
		});
	});
	
	// * 상품 옆에 엑스자 누르면 삭제
	$(".goods_delete .btn_delete").on("click", function(){
		var result = confirm("삭제하시겠습니까?");
		if(result) {
			var goods = $(this).closest(".view_goods");
			var basketNo = goods.attr("id");
			$.ajax({
				url: "goods_cart_del.jsp"
				, type: "get"
				, cache: false
				, data: "basket_no="+basketNo
				, dataType: "json"
				, success: function(data){
					if(data.result==1) $("#"+basketNo).remove();
					count_check();
				}
				, error: function(request, status, error){
					alert("상품 삭제에 실패했습니다.");
				}
			});
		}
	});
	
	// * 장바구니에 상품이 없으면 주문하기 버튼 클릭 불가
	if($(".viewGoods").find(".no_data").length){
		$(".btn_submit").addClass("no_submit");
	} else {
		$(".btn_submit").removeClass("no_submit");
	}

	
	// * 선택상품 삭제 
	$("#select_delete").on("click", function(){
		var result = confirm("선택한 상품을 삭제하시겠습니까?");
		if(result){
			$(".goods_check .label_check.checked").each(function() {
				var goods = $(this).closest(".view_goods");
				var basketNo = goods.attr("id");
				$.ajax({
					url: "goods_cart_del.jsp"
					, type: "get"
					, cache: false
					, data: "basket_no="+basketNo
					, dataType: "json"
					, success: function(data){
						if(data.result==1) $("#"+basketNo).remove();
						count_check();
					}
					, error: function(request, status, error){
						alert("상품 삭제에 실패했습니다.");
					}
				});
			});
		}
	});
	
	// * 품절 상품 삭제
	$("#soldout_delete").on("click", function(){
		var flag = 0;
		$("input.soldout").each(function() {
			if($(this).val()==1)	flag = 1;
		});
		if(flag==0){
			$(".ask-layer-wrapper").show();
			$(".ask-alert-message").text("품절상품이 없습니다.");			
		}else{
			var result = confirm("품절된 상품을 모두 삭제하시겠습니까?");
			if(result){
				$("input.soldout").each(function() {
					if($(this).val()==1) {
						var goods = $(this).closest(".view_goods");
						var basketNo = goods.attr("id");
						$.ajax({
							url: "goods_cart_del.jsp"
							, type: "get"
							, cache: false
							, data: "basket_no="+basketNo
							, dataType: "json"
							, success: function(data){
								if(data.result==1) $("#"+basketNo).remove();
								count_check();
							}
							, error: function(request, status, error){
								alert("상품 삭제에 실패했습니다.");
							}
						});
					}
				});
			}
		}
	});
	
	// * 선택수량과 전체수량 span 태그에 추가하기 
	count_check();
	// * 전체선택 체크박스가 체크 되어있는데 또 클릭하면 전체해제 , 체크 안되어 있는데 클릭하면 전체선택
	$(".all_select .label_check .ico_check").on("click", function(){
		if($(this).parents("label").is(".checked")){
			$(".label_check").removeClass("checked");
		}else{
			$(".label_check").not(".disabled").addClass("checked");
		}
		count_check();
	});
	calculate();

	$("#btnOrder").on("click", function() {
		$(".goods_check .label_check").not(".checked").each(function() {
			$(this).closest(".view_goods").find("input").remove();
		});
		
		$("#viewCart").submit();
	});
	
});	// function

</script>
<script>
// 상품금액, 할인금액, 배송비, 결제예정금액
function calculate(){

	var sumPrice = 0;
	var sumDc = 0;
	var deliveryFee = 0;
	
	// 체크박스 선택되어 있는 상품들만 금액 계산
	$(".goods_check .label_check.checked").each(function() {
		var goods = $(this).closest(".view_goods");
		var basketNo = goods.attr("id");
		sumPrice += parseInt(goods.children(".b_price").val());
		sumDc += parseInt(goods.children(".dc_price").val()) * parseInt(goods.find(".inp_quantity").val());
	});
	
	if(sumPrice > 0 && sumPrice-sumDc < 40000) deliveryFee = 3000;

	$(".amount_total .num").text(sumPrice.toLocaleString());
	$(".totalPrice").val(sumPrice);
	$(".amount_dc .num").text(sumDc.toLocaleString());
	$(".totalDiscount").val(sumDc);
	$(".amount_delivery .num").html(deliveryFee==0? '0':'<span>+</span>' + deliveryFee.toLocaleString());
	$(".deliveryFee").val(deliveryFee);
	$(".amout_result .num").text((sumPrice-sumDc+deliveryFee).toLocaleString());
	
	$(".amount_delivery .result .inner_result .num").html(deliveryFee==0? deliveryFee : '<span>+</span>' + deliveryFee.toLocaleString());
	$(".amount_delivery .result .inner_result .delivery_limit").html(deliveryFee==0? '':(40000-sumPrice+sumDc).toLocaleString() + ' 원 추가주문 시, <strong class="emph">무료배송</strong>');
	$(".amout_result .result .inner_result .txt_point").html('구매시 '+ Math.round((sumPrice-sumDc+deliveryFee)*${ percent }).toLocaleString() +' 원 <strong class="emph">적립예정</strong>');
	
}
</script>

</head>
<body class="goods-goods_list">
<div id="wrap" class="">
	<div id="pos_scroll"></div>
	<div id="container">
		<jsp:include page="../main/layout/header.jsp"></jsp:include>
		<div class="layout-wrapper">
			<p class="goods-list-position"></p>
		</div>
		<div class="layout-page-header">
			<h2 class="layout-page-title">장바구니</h2>
			<div class="pg_sub_desc">
				<p>주문하실 상품명 및 수량을 정확하게 확인해 주세요.</p>
			</div>
		</div>
		<div id="main">
			<div id="content">
				<jsp:include page="../main/layout/quick_nav.jsp"></jsp:include>

				<div class="user_form section_cart">
					<form id="viewCart" name="frmCart" method="post" action="../order/order.do">
						<!-- <input type="hidden" name="mode" value="setOrder"> -->
						<div class="tbl_comm cart_goods">
							<table class="tbl_comm tbl_header">
								<caption>장바구니 목록 제목</caption>
								<colgroup>
									<col style="width: 375px;">
									<col style="width: 432px;">
									<col style="width: 115px;">
									<col style="width: 110px;">
									<col style="width: auto;">
								</colgroup>
								<thead>
									<tr>
										<th id="thSelect">
											<div class="all_select">
												<label class="label_check checked">
													<input type="checkbox" class="ico_check">
												</label> 
												<span class="tit"> 전체선택 (<span class="num_count"></span>/<span class="num_total"></span>)</span>
											</div>
										</th>
										<th id="thInfo">상품 정보</th>
										<th id="thCount">수량</th>
										<th id="thCost">상품금액</th>
										<th id="thDelete"><span class="screen_out">삭제선택</span></th>
									</tr>
								</thead>
							</table>
											<!-- 여기부터 -->

							<div id="viewGoods">
							<c:if test="${ empty list }">
								<div class="no_data">장바구니에 담긴 상품이 없습니다.</div>
							</c:if>

							<c:if test="${ not empty list }">
								<c:forEach items="${ list }" var="dto">
									<div>
										<div class="view_goods" id="${ dto.basket_no }">
											<input type="hidden" name="basket_no" value="${ dto.basket_no }" />
											<input type="hidden" name="goods_no" class="goods_no" value="${ dto.goods_no }" /> 
											<input type="hidden" name="goods_name" class="goods_name" value="${ dto.goods_name }" /> 
											<input type="hidden" name="group_name" class="group_name" value="${ dto.group_name }" /> 
											<input type="hidden" name="min" class="min" value="${ dto.min }" /> 
											<input type="hidden" name="g_price" class="g_price" value="${ dto.g_price }" /> 
											<input type="hidden" name="b_price" class="b_price" value="${ dto.b_price }" />
											<input type="hidden" name="dc_price" class="dc_price" value="${ dto.dc_price }" /> 
											<input type="hidden" name="discount" class="discount" value="${ dto.discount }" />  
											<input type="hidden" name="soldout" class="soldout" value="${ dto.soldout }" />
											<input type="hidden" name="main_img" class="main_img" value="${ dto.main_img }" />
											<input type="hidden" name="cnt" class="cnt" value="${ dto.cnt }" />
											<input type="hidden" name="totalPrice" class="totalPrice" value="" />
											<input type="hidden" name="totalDiscount" class="totalDiscount" value="" />
											<input type="hidden" name="deliveryFee" class="deliveryFee" value="" />
											
											<table class="tbl_goods goods">
												<caption>장바구니 목록 내용</caption>
												<colgroup>
													<col style="width: 76px;">
													<col style="width: 100px;">
													<col style="width: 488px;">
													<col style="width: 112px;">
													<col style="width: 86px;">
													<col style="width: 110px;">
													<col style="width: auto;">
												</colgroup>
												<tbody>
													<tr>
														<td header="thSelect" class="goods_check">
															<label class="label_check checked"> 
																<input type="checkbox" class="ico_check" value="${ dto.basket_no }">
															</label>
														</td>
														<td header="thInfo" class="goods_thumb">
															<a href="goods_view.do?goodsno=${ dto.goods_no }" class="thumb"> 
																<img src="../..${ dto.main_img }" alt="상품이미지"
																	onerror="this.src='https://res.kurly.com/mobile/service/common/bg_1x1.png'">
															</a>
														</td>
														<td header="thInfo" class="goods_info">
															<a href="goods_view.do?goodsno=${ dto.goods_no }" class="name">
																${ dto.goods_name }</a>
															<dl class="goods_cost">
																<dt class="screen_out">판매가격</dt>
																<dd class="selling_price">
																	<span class="num">
																			<fmt:formatNumber value="${ dto.g_price - dto.dc_price }"
																				pattern="#,###"></fmt:formatNumber>
																	</span>
																	<span class="txt"> 원</span>
																</dd>
															<c:if test="${ dto.discount ne 0 }">
																<dt class="screen_out">원가</dt>
																<dd class="cost">
																	<span class="num"> 
																		<fmt:formatNumber value="${ dto.g_price }" pattern="#,###"></fmt:formatNumber>
																	</span> 
																	<span class="txt">원</span>
																</dd>
															</c:if>
															</dl>
															<p class="txt txt_limit"></p>
														</td>
														<td header="thInfo" class="goods_condition">
															<div class="condition"></div>
														</td>
														<td header="thCount">
															<div class="goods_quantity">
																<div class="quantity">
																	<strong class="screen_out">수량</strong>
																	<button type="button" class="btn btn_reduce">
																		<img src="https://res.kurly.com/pc/ico/1801/ico_minus_24x4_777.png" alt="감소">
																	</button>
																	<input type="text" readonly="readonly" class="inp_quantity" value="${ dto.cnt }">
																	<button type="button" class="btn btn_rise">
																		<img src="https://res.kurly.com/pc/ico/1801/ico_plus_24x24_777.png" alt="추가">
																	</button>
																</div>
															</div>
														</td>
														<td header="thCost">
															<dl class="goods_total">
																<dt class="screen_out">합계</dt>
																<dd class="result">
																	<span class="num">
																		<fmt:formatNumber value="${ ( dto.g_price - dto.dc_price ) * dto.cnt }" 
																				pattern="#,###"></fmt:formatNumber>
																	</span> 
																	<span class="txt">원</span>
																</dd>
															</dl>
														</td>
														<td header="thDelete" class="goods_delete">
															<button type="button" class="btn btn_delete">
																<img src="https://res.kurly.com/pc/ico/1801/btn_close_24x24_514859.png" alt="삭제">
															</button>
														</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</c:forEach>
							<!-- 여기까지 장바구니에 있는 상품 반복 -->
							</c:if>
						</div>
						</div>
						<div class="all_select select_option">
							<label class="label_check checked">
								<input type="checkbox" name="allCheck" class="ico_check">
							</label> 
							<span class="tit">
								전체선택 (<span class="num_count"></span>/<span class="num_total"></span>)
							</span>
							<button type="button" class="btn_delete" id="select_delete">선택 삭제</button>
							<button type="button" class="btn_delete" id="soldout_delete">품절 상품 삭제</button>
						</div>
						<div class="cart_result">
							<div class="cart_amount cell_except">
								<div class="amount_detail">
									<dl class="list amount_total">
										<dt class="tit">상품금액</dt>
										<dd class="result">
											<span class="inner_result">
												<span class="num">0</span>
												<span class="txt">원</span>
											</span>
										</dd>
									</dl>
									<div class="deco deco_minus">
										<span class="ico fst"></span> 
										<span class="ico"></span>
									</div>
									<dl class="list amount_dc">
										<dt class="tit">상품할인금액</dt>
										<dd class="result">
											<span class="inner_result">
												<span class="num">0</span> 
												<span class="txt">원</span> 
											</span>
										</dd>
									</dl>
									<dl class="list amout_order" style="display: none;">
										<dt class="tit">주문금액</dt>
										<dd class="result">
											<span class="num"><span class="desc">= </span>0</span> 
											<span class="txt">원</span>
										</dd>
									</dl>
								</div>
								<div class="deco deco_plus">
									<span class="ico fst"></span>
									<span class="ico"></span>
								</div>
								<dl class="list amount_delivery">
									<dt class="tit">배송비</dt>
									<dd class="result">
										<span class="inner_result"> 
										<!-- 컬리패스인 경우 -->
											<!-- <span class="txt pass">무료 (컬리패스)</span> -->
											<span class="num">
													0
											</span> 
											<span class="txt">원</span> 
											<span class="delivery_limit"></span>
										</span>
									</dd>
								</dl>
								<div class="deco deco_equal">
									<span class="ico fst"></span>
									<span class="ico"></span>
								</div>
								<dl class="list amout_result">
									<dt class="tit">결제예정금액</dt>
									<dd class="result">
										<span class="inner_result add">
										<span class="num">0</span>
											<span class="txt">원</span> 
												<span class="txt_point">
												</span>
											</span>
									</dd>
								</dl>
							</div>
							<div class="notice_cart">
							*쿠폰, 적립금은 다음화면인 ‘주문서’에서 확인가능합니다.
							</div>
							<button type="button" id="btnOrder" class="btn_submit">
								주문하기 <span class="price">(0 원)</span>
							</button>
							<!---->
						</div>
						<p class="info_notice">
							‘입금확인’ 상태일 때는 주문내역 상세 페이지에서 직접 주문취소가 가능합니다.<br>
							‘입금확인’ 이후 상태에는 고객행복센터로 문의해주세요.
						</p>
					</form>
				</div>
				
				<div class="bg_loading" id="bgLoading" style="display: none;">
					<div class="loading_show"></div>
				</div>
				
			</div>
		</div>
		
		<!-- 알림메세지 창 띄우기 -->
		<div class="ask-layer-wrapper" style="z-index: 10000; display: none;">
			<div class="ask-alert-window ask-alert-type-message" style="height: 225px;">
				<div class="ask-alert-wrapper">
					<div class="ask-alert-header">알림메세지</div>
					<div class="ask-alert-content">
						<p class="ask-alert-message"></p>
					</div>
					<button class="ask-alert-close-button">이 메세지를 닫기</button>
				</div>
				<div class="ask-alert-footer">
					<button type="button" 	class="styled-button __active">확인</button>
				</div>
			</div>
			<div class="ask-layer-background"></div>
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