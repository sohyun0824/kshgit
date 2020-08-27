<%@page import="shop.member.model.MemberDTO"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%
	String group_no = request.getParameter("group_no");
	Date now = new Date();
	
	MemberDTO member = (MemberDTO)session.getAttribute("member");
	boolean login = false;
	if(member != null){
		login = true;
	}
	double percent = session.getAttribute("percent") == null ? 0 : (double)session.getAttribute("percent");
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

<!-- jquery slider -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>

<script>
	// 최근 본 상품의 group_no, time(화면을 띄웠을 당시 시간) -> json객체로 localstorage에 저장..
	var goodsRecent = JSON.parse(localStorage.getItem("goodsRecent"));
	if(goodsRecent == null){
		goodsRecent = [];
		goodsRecent.push({"group_no":"<%= group_no %>", "time":<%= now.getTime() %>});
	} else{
		var last_no = goodsRecent[goodsRecent.length-1].group_no;
		// 연속으로 같은 상품이 아닌 경우에만 push
		if(last_no != "<%= group_no %>"){
			goodsRecent.push({"group_no":"<%= group_no %>", "time":<%= now.getTime() %>});
		}
	}
	localStorage.setItem("goodsRecent", JSON.stringify(goodsRecent));
</script>

</head>
<body class="goods-goods_view" style="">

<div id="wrap" class="">
	<div id="pos_scroll"></div>
	<div id="container">
		<jsp:include page="../main/layout/header.jsp"></jsp:include>
		
		<div id="main">
			<div id="content">
				<jsp:include page="../main/layout/quick_nav.jsp"></jsp:include>

				<!-- goodsview -->
				<!-- 상품 정보 -->
				<div class="section_view">
					<div id="sectionView">
						<div class="inner_view">
							<div class="thumb" style="background-image: url('../..${ goods.main_img }');">
								<img src="https://res.kurly.com/mobile/service/goodsview/1910/bg_375x482.png" alt="상품 대표 이미지" class="bg">
							</div> 
							<p class="goods_name">
								<span class="btn_share">
									<button id="btnShare">공유하기</button>
								</span> 
								<strong class="name">${ goods.group_name }</strong> 
								<span class="short_desc">${ goods.line_discript }</span>
							</p> 
							<c:if test="${ goods.discount ne 0 }">
							<p class="goods_dcinfo">회원할인가</p>
							</c:if>
							<p class="goods_price">
								<span class="position">
									<c:if test="${ goods.discount eq 0 }">
									<span class="dc">
										<span class="dc_price"><fmt:formatNumber value="${ goods.price }" pattern="#,###"/><span class="won">원</span></span> 
									</span>
									</c:if>
									<c:if test="${ goods.discount ne 0 }">
									<span class="dc">		
										<span class="dc_price"><fmt:formatNumber value="${ goods.price * ((100-goods.discount)/100) }" pattern="#,###"/><span class="won">원</span></span> 
										<span class="dc_percent">${ goods.discount }<span class="per">%</span></span>
									</span>
									<a class="original_price">
										<span class="price"><fmt:formatNumber value="${ goods.price }" pattern="#,###"/><span class="won">원</span></span>
									</a> 
									</c:if>
								</span> 
								<c:if test="${ empty member }">
								<span class="not_login"><span>로그인 후, 회원할인가와 적립혜택이 제공됩니다.</span></span>
								</c:if>
								<c:if test="${ not empty member }">
								<span class="txt_benefit">
									<span class="ico_grade grade0">${ member.grade } ${ percent*100 }%</span>
									<c:if test="${ goods.discount eq 0 }">   
									<span class="point">개당 <strong class="emph"><fmt:formatNumber value="${ goods.price * percent }" pattern="0"/>원 적립</strong></span>
									</c:if>				
									<c:if test="${ goods.discount ne 0 }">			
									<span class="point">개당 <strong class="emph"><fmt:formatNumber value="${ goods.price * ((100-goods.discount)/100) * percent }" pattern="0"/>원 적립</strong></span>
									</c:if> 
								</span> 
								</c:if>
							</p> 
							<div class="goods_info">
								<c:forEach items="${ goodsinfo }" var="dto" >
								<dl class="list">
									<dt class="tit">${dto.title}</dt> 
									<dd class="desc">${dto.content}
									<c:if test="${ dto.title eq '포장타입' }">
										<strong class="emph"> 택배배송은 에코포장이 스티로폼으로 대체됩니다.</strong>
									</c:if>
									</dd>
								</dl> 
								</c:forEach>
							</div> 
						</div>
					</div>
				
					<!--
						장바구니 담기
						1. 상품 상세정보에서 담기(cart_option cart_type2)  [goods_view.jsp]
						2. 밑에 상품선택 버튼 누르면 slideup되는 따라다니는 탭(?)으로 담기(cart_option cart_type1)	[goods_view.jsp]   
						3. 상품 목록에서 바로 담기(cart_option cart_type3) [goods_list.jsp]
					-->
					
					<div id="cartPut">
					
						<!-- 기본 장바구니 담기 -->
						<div class="cart_option cart_type2">
							 <div class="inner_option">
							 	<strong class="tit_cart" data="${ goods.group_no }">${ goods.group_name }</strong> 
							 	<div class="in_option">
							 		<div class="list_goods">
							 		
							 			<!-- 단일상품인 경우 -->
							 			<c:if test="${ goods.goodsList.size() eq 1 }">
							 			<ul class="list list_nopackage">
							 				<li class="on">
							 					<span class="btn_position">
							 						<button type="button" class="btn_del">
							 							<span class="txt">삭제하기</span>
							 						</button>
							 					</span> 
							 					<span class="name" data="${ goods.goodsList[0].goods_no }">${ goods.goodsList[0].goods_name }</span> 
							 					<span class="tit_item">구매수량</span> 
							 					<div class="option">
							 						<span class="count">
							 							<button type="button" class="btn down">수량내리기</button> 
							 							<input type="number" value="${ goods.moomin }" readonly="readonly" onfocus="this.blur()" class="inp"> 
							 							<button type="button" class="btn up">수량올리기</button>
							 						</span> 
							 						<span class="price">
							 							<!-- 로그인O + 할인O -->
							 							<c:if test="${ not empty member and discount ne 0 }">
							 							<span class="original_price"><fmt:formatNumber value="${ goods.price }" pattern="#,###"/>원</span>
							 							<span class="dc_price"><fmt:formatNumber value="${ goods.price * ((100-goods.discount)/100) }" pattern="#,###"/>원</span>
							 							</c:if>
							 							<c:if test="${ empty member }">
							 							<span class="dc_price"><fmt:formatNumber value="${ goods.price }" pattern="#,###"/>원</span>
							 							</c:if> 
							 						</span>
							 					</div>
							 				</li>
							 			</ul>
							 			</c:if>
							 			
							 			<!-- 다중상품인경우 -->
							 			<c:if test="${ goods.goodsList.size() gt 1 }">
							 			
							 			<div class="box_select">
							 				<strong class="name">상품 선택</strong> 
							 				<div class="inner_select">
							 					<!-- 상품선택 누르면 open 클래스 추가, ul태그 block -->
							 					<a href="#none" class="txt_select">상품 선택</a> 
							 					<ul class="select_item" style="display: none">
							 						<c:forEach items="${ goods.goodsList }" var="dto">	
							 						<!-- 품절 아닌 경우 -->
							 						<c:if test="${ dto.soldout eq 0 }">
							 						<li class="">
							 							<a href="#none" class="">
							 								<span class="item_name" data="${ dto.goods_no }">${ dto.goods_name }</span> 
							 								<span class="price">
							 									<!-- 로그인O + 할인O -->
									 							<c:if test="${ not empty member and discount ne 0 }">
									 							<span class="original_price"><fmt:formatNumber value="${ dto.price }" pattern="#,###"/>원</span>
									 							<span class="dc_price"><fmt:formatNumber value="${ dto.price * ((100-goods.discount)/100) }" pattern="#,###"/>원</span>
									 							</c:if>
									 							<c:if test="${ empty member }">
							 									<span class="dc_price"><fmt:formatNumber value="${ dto.price }" pattern="#,###"/>원</span>
							 									</c:if>
							 								</span>
							 							</a>
							 						</li>
							 						</c:if>
						 							<!-- 품절상품인 경우 sold_out -->
							 						<c:if test="${ dto.soldout eq 1 }">
							 						<li class="">
							 							<a href="#none" class="sold_out">
							 								<span class="item_name">
							 									<span>(품절) </span>${ dto.goods_name }
							 								</span> 
							 								<span class="price">
							 									<!-- 로그인O + 할인O -->
									 							<c:if test="${ not empty member and discount ne 0 }">
									 							<span class="original_price"><fmt:formatNumber value="${ dto.price }" pattern="#,###"/>원</span>
									 							<span class="dc_price"><fmt:formatNumber value="${ dto.price * ((100-goods.discount)/100) }" pattern="#,###"/>원</span>
									 							</c:if>
									 							<c:if test="${ empty member }">
							 									<span class="dc_price"><fmt:formatNumber value="${ dto.price }" pattern="#,###"/>원</span>
							 									</c:if>
															</span>
							 							</a>
							 						</li>
							 						</c:if>
										 			</c:forEach>
							 					</ul>
							 				</div>
							 			</div>
							 			
							 			<ul class="list">
							 				<c:forEach items="${ goods.goodsList }" var="dto">
							 				<!-- 상품 선택되면 off -> on으로 바뀜 / 품절상품에는 sold_out클래스 추가 -->
							 				<c:if test="${ dto.soldout eq 1 }">
							 				<li class="off sold_out">
							 				</c:if>
							 				<c:if test="${ dto.soldout eq 0 }">
							 				<li class="off">
							 				</c:if>
							 					<span class="btn_position on">
							 						<button type="button" class="btn_del">
							 							<span class="txt">삭제하기</span>
							 						</button>
							 					</span> 
							 					<span class="name" data="${ dto.goods_no }">${ dto.goods_name }</span>
							 					<div class="option">
							 						<span class="count">
							 							<button type="button" class="btn down">수량내리기</button> 
							 							<input type="number" readonly="readonly" onfocus="this.blur()" class="inp"> 
							 							<button type="button" class="btn up">수량올리기</button>
							 						</span> 
							 						<span class="price">
							 							<!-- 로그인O + 할인O -->
							 							<c:if test="${ not empty member and discount ne 0 }">
							 							<span class="original_price"><fmt:formatNumber value="${ dto.price }" pattern="#,###"/>원</span>
							 							<span class="dc_price"><fmt:formatNumber value="${ dto.price * ((100-goods.discount)/100) }" pattern="#,###"/>원</span>
							 							</c:if>
							 							<c:if test="${ empty member }">
					 									<span class="dc_price"><fmt:formatNumber value="${ dto.price }" pattern="#,###"/>원</span>
					 									</c:if>
							 						</span>
							 					</div>
							 				</li>
							 				</c:forEach>
							 			</ul>
							 			</c:if>
							 			
							 		</div> 
							 		<div class="total">
							 			<div class="price">
							 				<strong class="tit">총 상품금액 :</strong> 
							 				<span class="sum">
							 					<span class="num">0</span> 
							 					<span class="won">원</span>
							 				</span>
							 			</div> 
							 			<p class="txt_point">
							 				<span class="ico">적립</span> 
							 				<c:if test="${ empty member }">
							 				<span class="no_login"><span>로그인 후, 회원할인가와 적립혜택 제공</span></span>
							 				</c:if>
							 				<c:if test="${ not empty member }">
							 				<span class="point"> 구매 시 <strong class="emph">0원 적립</strong></span>
							 				</c:if>
							 			</p>
							 		</div>
							 		
							 		<c:if test="${ goods.goodsList.size() eq 1 }">
							 		<script>
							 			var price = $("#cartPut .list .dc_price").text();
							 			price = Number(price.substr(0, price.length-1).replace(",", ""));
						 				$("#cartPut .total .num").text(price.toLocaleString());
						 				if(<%= login %>){
						 					var point = price * <%= percent %>;
						 					point = Math.round(point);
							 				$("#cartPut .cart_type2 .total .emph").text(point.toLocaleString() + "원 적립");							 					
						 				}
							 		</script>
							 		</c:if>
							 		
							 	</div> 
							 	<div class="group_btn off">
							 		<div class="view_function">
							 			<!-- 클릭하면 on 클래스 추가 -->
							 			<button type="button" class="btn btn_save">늘 사는 것</button> 
							 			<button type="button" class="btn btn_alarm off">재입고 알림</button>
							 		</div> 
							 		<span class="btn_type1">
							 			<button type="button" class="txt_type">장바구니 담기</button>
							 		</span> 
							 	</div>
							 </div>
						</div> 
						
						<!-- 아래에 고정된 장바구니 -->
						<!-- 
						<div class="cart_option cart_type1">
							 <div class="inner_option">
							 	<strong class="tit_cart">상품명</strong> 
							 	<div class="in_option">
							 		<div class="list_goods">
							 			<div class="bar_open">
							 				<button type="button" class="btn_close">
							 					<span class="ico">상품 선택</span>
							 				</button>
							 			</div> 
							 		</div> 
							 	</div> 
							 	<div class="group_btn off">
							 		<div class="view_function">
							 			<button type="button" class="btn btn_save">늘 사는 것</button> 
							 			<button type="button" class="btn btn_alarm off">재입고 알림</button>
							 		</div> 
							 		<span class="btn_type1">
							 			<button type="button" class="txt_type">장바구니 담기</button>
							 		</span> 
							 	</div>
							 </div>
						</div>
						 -->
					</div>
					
					<script>
						$(function () {
							var percent = <%= percent %>;
							//console.log(percent);
							
							// 상품선택 클릭
							$("#cartPut .box_select .txt_select").on("click", function() {
								$("#cartPut .box_select .select_item").toggle();
							});
							
							// 품절아닌 상품선택
							$("#cartPut .select_item a:not(.sold_out)").on("click", function() {
								//alert("클릭");
								var goods_no = $(this).find(".item_name").attr("data");
								var target = $("#cartPut .list .name[data=" + goods_no + "]");
								target.siblings(".option").find(".inp").val("1");
								target.parent("li").removeClass("off").addClass("on");
								$(this).parents(".select_item").hide();
								
								// 합계 변경
								var price = target.siblings(".option").find(".dc_price").text();
								price = Number(price.substr(0, price.length-1).replace(",", ""));
								var total = Number($("#cartPut .total .num").text().replace(",", ""));
								total += price;
								$("#cartPut .total .num").text(total.toLocaleString());
								
								// 로그인 - 적립금 변경
								if('${ member.m_id }' != null && '${ member.m_id }' != ""){
									var point = total * percent;
									point = Math.round(point);
									$("#cartPut .point .emph").text(point.toLocaleString() + "원 적립");
								}
							});
							
							// 상품선택 취소버튼 클릭
							$("#cartPut .list .btn_del").on("click", function() {
								//alert("클릭");
								
								// 합계 변경
								var cnt = $(this).parent(".btn_position").siblings(".option").find(".inp").val();
								var price = $(this).parent(".btn_position").siblings(".option").find(".dc_price").text();
								price = Number(price.substr(0, price.length-1).replace(",", ""));
								price = price * cnt;
								var total = Number($("#cartPut .total .num").text().replace(",", ""));
								total -= price;
								$("#cartPut .total .num").text(total.toLocaleString());
								
								// 로그인 - 적립금 변경
								if('${ member.m_id }' != null && '${ member.m_id }' != ""){
									var point = total * percent;
									point = Math.round(point);
									$("#cartPut .point .emph").text(point.toLocaleString() + "원 적립");
								}
								
								$(this).parents("li").removeClass("on").addClass("off");
							});
							
							// 수량올리기 클릭
							$("#cartPut .up").on("click", function() {
								var cnt = $(this).siblings(".inp").val();
								cnt++;
								$(this).siblings(".inp").val(cnt);
								
								// 합계 변경
								var price = $(this).parents(".option").find(".dc_price").text();
								price = Number(price.substr(0, price.length-1).replace(",", ""));
								var total = Number($("#cartPut .total .num").text().replace(",", ""));
								total += price;
								//console.log(total);
								$("#cartPut .total .num").text(total.toLocaleString());
								
								// 로그인 - 적립금 변경
								if('${ member.m_id }' != null && '${ member.m_id }' != ""){
									var point = total * percent;
									point = Math.round(point);
									$("#cartPut .point .emph").text(point.toLocaleString() + "원 적립");
								}
							});
							
							// 수량내리기 클릭
							$("#cartPut .down").on("click", function() {
								var cnt = $(this).siblings(".inp").val();
								if(cnt != 0){
									cnt--;
									$(this).siblings(".inp").val(cnt);
									
									// 합계 입력
									var price = $(this).parents(".option").find(".dc_price").text();
									price = Number(price.substr(0, price.length-1).replace(",", ""));
									var total = Number($("#cartPut .total .num").text().replace(",", ""));
									total -= price;
									//console.log(total);
									$("#cartPut .total .num").text(total.toLocaleString());
									
									// 로그인 - 적립금액 안내
									if('${ member.m_id }' != null && '${ member.m_id }' != ""){
										var point = total * percent;
										point = Math.round(point);
										$("#cartPut .point .emph").text(point.toLocaleString() + "원 적립");
									}
								}
							});
							
							// 장바구니 담기 클릭
							$("#cartPut .btn_type1 button").on("click", function() {
								if(!<%= login %>){
									// 로그인X
									alert("로그인하셔야 본 서비스를 이용하실 수 있습니다.\n로그인 화면으로 이동합니다.");
									location.href="../member/login.do?return_url=/kurlyPro/shop/goods/goods_view.do?group_no=<%= group_no %>";
								} else{
									//alert("장바구니담기");
									// 로그인O
									var group_no = $("#cartPut .tit_cart").attr("data");
									// $("#cartPut .inp").val() 이 0이 아닌 모든 상품의 번호와 수량을 차례로 저장..
									var goods_noArr = [];
									var cntArr = [];
									var priceArr = [];
									var nameArr = [];
									$("#cartPut .inp").each(function(i, el) {
										var cnt = $(el).val();
										if(cnt != 0){
											var goods_no = $(el).parents(".option").siblings(".name").attr("data");
											var price = $(el).parents(".option").find(".dc_price").text();
											var name = $(el).parents(".option").siblings(".name").text();
											price = price.substr(0, price.length-1).replace(",", "");
											goods_noArr.push(goods_no);
											cntArr.push(cnt);
											priceArr.push(price);
											nameArr.push(name);
										}
									});
									//console.log(goods_noArr);
									//console.log(cntArr);
									//console.log(nameArr);
									
									if(goods_noArr.length > 0){
										// 로그인O			
										// ajax로 장바구니에 담기 후 헤더에 메시지 띄우기..
										// 아이디m_id, 상품코드goods_no, 상품금액price, 수량cnt
										$.ajax({
											url : "../proc/cartPut.jsp",
											type : "GET",
											data : {
												"goods_noArr" : goods_noArr,
												"cntArr" : cntArr,
												"priceArr" : priceArr
											},
											dataType : 'json',
											cache : false,
											traditional : true,		// 배열 넘기려면 필요한 설정
											success : function(data) {
												//console.log(data.result);
												if(data.result == goods_noArr.length){
													//alert("장바구니에 담기 성공");
													// 장바구니에 다 담기 성공~ 여러 상품 담을 때는 첫순서 상품명 외 n종이라고 나옴..
													var target = $("#gnb .cart_count #addMsgCart");
													target.find("img").attr("src","../data/goods/" + group_no + ".jpg");
													var txt = nameArr[0];
													if(goods_noArr.length > 1){
														target.find(".tit").text(nameArr[0] + " 외 " + nameArr.length-1 + "종");
														txt += " 외 " + (goods_noArr.length -1) + "종"; 
													}
													target.find(".tit").text(txt);
													
													target.show(1000);
													setTimeout(function() {
														target.hide(1000);									
													},2000);
												}
												cartItemCount();
											},
											fail : function() {
												alert("일시적인 장애가 발생하였습니다.\n잠시후 다시 시도해주세요");
											}
										});	
									} else{
										alert("장바구니에 담으실 상품을 선택해주세요.");
									}
								}

							});
						});
							
					</script>

					<script>
						$(function() {
							// 늘사는것 클릭
							$("#cartPut .btn_save").on("click", function() {
								if(!<%= login %>){
									alert("로그인하셔야 본 서비스를 이용하실 수 있습니다.\n로그인 화면으로 이동합니다.");
									location.href="../member/login.do?return_url=/kurlyPro/shop/goods/goods_view.do?group_no=<%= group_no %>";
								} else{
									// 다중상품에서 구성품을 변경하고 넣으려해도 이미 등록됐다고 나옴.. 그룹코드로만 판단하는듯.. 우린 상품코드로 판단해서 그룹이 중복이어도 넣자ㅎㅎ

									var group_no = $("#cartPut .tit_cart").attr("data");
									// $("#cartPut .inp").val() 이 0이 아닌 모든 상품의 번호와 수량을 차례로 저장..
									var goods_noArr = [];
									$("#cartPut .inp").each(function(i, el) {
										var cnt = $(el).val();
										if(cnt != 0){
											var goods_no = $(el).parents(".option").siblings(".name").attr("data");
											goods_noArr.push(goods_no);
										}
									});
									
									if(goods_noArr.length > 0){
										// insert wishlist - id, goods_no
										$.ajax({
											url : "../proc/chkWishlist.jsp",
											type : "GET",
											data : {
												"goods_noArr" : goods_noArr
											},
											dataType : 'json',
											cache : false,
											traditional : true,		// 배열 넘기려면 필요한 설정
											success : function(data) {
												//console.log(data.result);
												if(data.result == 0){
													alert("이미 늘 사는 리스트에 존재하는 상품입니다.");
												}else{
													alert("늘 사는 리스트에 추가되었습니다.");
												}
												$("#cartPut .btn_save").addClass("on");
											},
											fail : function() {
												alert("일시적인 장애가 발생하였습니다.\n잠시후 다시 시도해주세요");
											}
										});	
									} else{
										// 다중상품에서 선택한 상품이 없는경우
										alert("하나 이상의 패키지 구성품을 선택하셔야됩니다.");
									}
									
									
								}
							});
							
						});
					</script>
					
				</div>
				
				<div class="layout-wrapper goods-view-area">
					
					<!-- 관련상품 슬라이더 -->
					<div class="goods-add-product">
						<h3 class="goods-add-product-title">RELATED PRODUCT</h3>
						<div class="goods-add-product-wrapper __slide-wrapper">
							<div class="goods-add-product-list-wrapper" style="height:320px">
								<ul class="goods-add-product-list __slide-mover">
								<!--관련상품 반복 뿌리기  -->
								<c:forEach items="${ relatedgoods }" var="dto" >
									<li class="goods-add-product-item __slide-item">
										<div class="goods-add-product-item-figure">
											<a href="goods_view.do?group_no=${ dto.group_no }" target="_blank" ><img src='../..${ dto.main_img }'></a>
										</div>
										<div class="goods-add-product-item-content">
											<div class="goods-add-product-item-content-wrapper">
												<p class="goods-add-product-item-name" >${ dto.group_name }</p>
												<p class="goods-add-product-item-price"> ${ dto.price }원</p>
											</div>
										</div>
									</li>
								</c:forEach>
								</ul>
							</div>
						</div>
					</div>
					<script>	
						// 관련상품 슬라이더
						$(function () {
							$(".goods-add-product-list").bxSlider({
								mode: "horizontal",
								infiniteLoop : true,
								speed: 500,
								pager: false,
								slideWidth : $(".goods-add-product-list li:eq(0)").width(), 
								moveSlides: 5,
								minSlides: 5,
								maxSlides: 5,
								slideMargin: 9,
								auto: false,
								pause : 0,
								stopAutoOnClick : true,
								autoHover: true,
								controls: true,
								autoControls  : false,
								hideControlOnEnd : true,
								easing : "swing",
								touchEnabled : false	// touch swipe 동작 허용여부, 기본 true
							});
							
							$(".bx-controls-direction .bx-prev").addClass("goods-add-product-move goods-add-product-move-left");
							$(".bx-controls-direction .bx-next").addClass("goods-add-product-move goods-add-product-move-right");
							$(".bx-wrapper").css("height","320px");
							$(".bx-viewport").css("height","320px");
						
						});
					</script>
					
					<!--goodsdetail  -->
					<!--5가지 탭(상품설명/상품이미지/상세정보/고객후기/상품문의) id(#XXX) 클릭하면 해당 탭 보여주기
							지금은 상품설명 active되는 경우
					 -->
					<div class="goods-view-infomation detail_wrap_outer" id="goods-view-infomation">
					
						<!-- 중간중간에 있는 탭 - 상품설명 active -->
						<ul class="goods-view-infomation-tab-group">
							<li class="goods-view-infomation-tab">
								<a href="#goods-description" class="goods-view-infomation-tab-anchor __active">상품설명</a>
							</li>
							<li class="goods-view-infomation-tab">
								<a href="#goods-image" class="goods-view-infomation-tab-anchor">상품이미지</a>
							</li> 
							<li class="goods-view-infomation-tab">
								<a href="#goods-infomation" class="goods-view-infomation-tab-anchor">상세정보</a>
							</li>
							<li class="goods-view-infomation-tab">
								<a href="#goods-review" class="goods-view-infomation-tab-anchor">고객후기 
									<span class="count_review">(${ goods.reviewCnt })</span>
								</a>
							</li>
							<li class="goods-view-infomation-tab qna-show">
								<a href="#goods-qna" class="goods-view-infomation-tab-anchor">상품문의 
									<span>(${ goods.qnaCnt })</span>
								</a>
							</li>
						</ul>
						<!-- 상품 설명 - content -->
						<div id="">${ goods.content }</div>
							
						<!--상품이미지 active되는 경우  -->
						<ul class="goods-view-infomation-tab-group">
							<li class="goods-view-infomation-tab">
								<a href="#goods-description" class="goods-view-infomation-tab-anchor ">상품설명</a>
							</li>
							<li class="goods-view-infomation-tab">
								<a href="#goods-image" class="goods-view-infomation-tab-anchor __active">상품이미지</a>
							</li> 
							<li class="goods-view-infomation-tab">
								<a href="#goods-infomation" class="goods-view-infomation-tab-anchor">상세정보</a>
							</li>
							<li class="goods-view-infomation-tab">
								<a href="#goods-review" class="goods-view-infomation-tab-anchor">고객후기 
									<span class="count_review">(${ goods.reviewCnt })</span>
								</a>
							</li>
							<li class="goods-view-infomation-tab qna-show">
								<a href="#goods-qna" class="goods-view-infomation-tab-anchor">상품문의 
									<span>(${ goods.qnaCnt })</span>
								</a>
							</li>
						</ul>
						<!--상품이미지  -->
						<div class="goods-view-infomation-content" id="goods-image">
							<div id="goods_pi">
								<p class="pic">
									<img src="${ goods.img }">
								</p>
							</div>
						</div>
							
						<!--상세정보 active되는 경우  -->
						<ul class="goods-view-infomation-tab-group">
							<li class="goods-view-infomation-tab">
								<a href="#goods-description" class="goods-view-infomation-tab-anchor ">상품설명</a>
							</li>
							<li class="goods-view-infomation-tab">
								<a href="#goods-image" class="goods-view-infomation-tab-anchor">상품이미지</a>
							</li> 
							<li class="goods-view-infomation-tab">
								<a href="#goods-infomation" class="goods-view-infomation-tab-anchor __active">상세정보</a>
							</li>
							<li class="goods-view-infomation-tab">
								<a href="#goods-review" class="goods-view-infomation-tab-anchor">고객후기 
									<span class="count_review">(${ goods.reviewCnt })</span>
								</a>
							</li>
							<li class="goods-view-infomation-tab qna-show">
								<a href="#goods-qna" class="goods-view-infomation-tab-anchor">상품문의 
									<span>(${ goods.qnaCnt })</span>
								</a>
							</li>
						</ul> 
						<!--상세정보  -->
						<div class="goods-view-infomation-content" id="goods-infomation">
							<table width="100%" border="0" cellpadding="0" cellspacing="1" class="extra-information">
								<tbody>
								<c:forEach items="${ goodsdetail }" var="dto">
									<tr>
										<th scope="row" class="goods-view-form-table-heading">${ dto.title }</th>
										<td>${ dto.content }</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
							
							<!-- WHY KURLY -->
							<div class="whykurly_area">
								<div class="row">
									<strong class="tit_whykurly">WHY KURLY</strong>
									<div id="why_kurly" class="txt_area">
										<div class="why-kurly">
											<div class="col">
												<div class="icon">
													<img src="https://res.kurly.com/pc/ico/1910/01_check.svg">
												</div> 
												<div class="info">
													<div class="title">깐깐한 상품위원회</div> 
													<div class="desc">
														<p>나와 내 가족이 먹고 쓸 상품을 고르는<br>
														      마음으로 매주 상품을 직접 먹어보고,<br>      
														      경험해보고 성분, 맛, 안정성 등 다각도의<br>      
														      기준을 통과한 상품만을 판매합니다.</p> 
													</div>
												</div>
											</div>
											<div class="col">
												<div class="icon">
													<img src="https://res.kurly.com/pc/ico/1910/02_only.svg">
												</div> 
												<div class="info">
													<div class="title">차별화된 Kurly Only 상품</div> 
													<div class="desc">
														<p>전국 각지와 해외의 훌륭한 생산자가<br>      
														믿고 선택하는 파트너, 마켓컬리.<br>      
														2천여 개가 넘는 컬리 단독 브랜드, 스펙의<br>      
														Kurly Only 상품을 믿고 만나보세요.</p> 
														<span class="etc">(온라인 기준 / 자사몰, 직구 제외)</span>
													</div>
												</div>
											</div>
											<div class="col">
												<div class="icon">
													<img src="https://res.kurly.com/pc/ico/1910/03_cold.svg">
												</div> 
												<div class="info">
													<div class="title">신선한 풀콜드체인 배송</div> 
													<div class="desc">
														<p>온라인 업계 최초로 산지에서 문 앞까지<br>      
														상온, 냉장, 냉동 상품을 분리 포장 후<br>      
														최적의 온도를 유지하는 냉장 배송 시스템,<br>      
														풀콜드체인으로 상품을 신선하게 전해드립니다.</p> 
														<span class="etc">(샛별배송에 한함)</span>
													</div>
												</div>
											</div>
											<div class="col">
												<div class="icon">
													<img src="https://res.kurly.com/pc/ico/1910/04_price.svg">
												</div> 
												<div class="info">
													<div class="title">고객, 생산자를 위한 최선의 가격</div> 
													<div class="desc">
														<p>매주 대형 마트와 주요 온라인 마트의 가격<br>      
														변동 상황을 확인해 신선식품은 품질을<br>      
														타협하지 않는 선에서 최선의 가격으로,<br>      
														가공식품은 언제나 합리적인 가격으로<br>      
														정기 조정합니다.</p> 
													</div>
												</div>
											</div>
											<div class="col">
												<div class="icon">
													<img src="https://res.kurly.com/pc/ico/1910/05_eco.svg">
												</div> 
												<div class="info">
													<div class="title">환경을 생각하는 지속 가능한 유통</div> 
													<div class="desc">
														<p>친환경 포장재부터 생산자가 상품에만<br>      
														집중할 수 있는 직매입 유통구조까지,<br>      
														지속 가능한 유통을 고민하며 컬리를 있게<br>      
														하는 모든 환경(생산자, 커뮤니티, 직원)이<br>      
														더 나아질 수 있도록 노력합니다.</p> 
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						
							<!--고객행복센터  -->
							<div class="happy_center fst">
								<div class="happy">
									<h4 class="tit">고객행복센터</h4>
									<p class="sub">
										<span class="emph">궁금하신 점이나 서비스 이용에 불편한 점이 있으신가요?</span>
										<span class="bar"></span>
										문제가 되는 부분을 사진으로 찍어<span class="bar"></span>
										아래 중 편하신 방법으로 접수해 주시면<span class="bar"></span>
										빠르게 도와드리겠습니다.
									</p>
								</div>
								<ul class="list">
									<li>
										<div class="tit">전화 문의 1644-1107</div>
										<div class="sub">오전 7시~오후 7시 (연중무휴)</div>
									</li>
									<li>
										<div class="tit">카카오톡 문의</div>
										<div class="sub">오전 7시~오후 7시 (연중무휴)</div>
										<div class="expend">
											카카오톡에서 ’마켓컬리’를 검색 후<br>
											대화창에 문의 및 불편사항을<br>
											남겨주세요.
										</div>
									</li>
									<li>
										<div class="tit">홈페이지 문의</div>
										<div class="sub">
											24시간 접수 가능<br>
											로그인 ; 마이컬리 ; 1:1 문의
										</div>
										<div class="expend">
											고객센터 운영 시간에 순차적으로 답변해드리겠습니다.
										</div>
									</li>
								</ul>
							</div>
							<div class="happy_center order">
							   <div class="happy unfold">
							      <h4 class="tit">주문 취소 안내</h4>
							      <ul class="sub">
							         <li>
							            <strong class="emph">[입금 확인] 단계</strong>
							            마이컬리 &gt; 주문 내역 상세페이지에서 직접 취소하실 수 있습니다.
							         </li>
							         <li>
							            <strong class="emph">[입금 확인] 이후 단계</strong>
							            고객행복센터로 문의해주세요.
							         </li>
							         <li>
							            <strong class="emph">결제 승인 취소 / 환불</strong>
							            결제 수단에 따라 영업일 기준 3~7일 내에 처리해드립니다.
							         </li>
							      </ul>
							      <a data-child-id="orderCancel" href="#none" class="asked">
							         <span class="txt" data-open="자세히 보기" data-close="닫기">자세히 보기</span>
							         <img src="https://res.kurly.com/pc/ico/2001/pc_arrow_open@2x.png" alt="아이콘" class="ico">
							      </a>
							   </div>
							   <div class="happy_faq">
							      <div id="orderCancel" class="questions hide">
							         <strong class="subject">주문 취소 관련</strong>
							         <ul class="list_questions">
								         <li>[상품 준비 중] 이후 단계에는 취소가 제한되는 점 고객님의 양해 부탁드립니다.</li>
								         <li>비회원은 모바일 App / Web &gt; 마이컬리 &gt; 비회원 주문 조회 페이지에서 주문을 취소하실 수 있습니다.</li>
								         <li>일부 예약 상품은 배송 3~4일 전에만 취소하실 수 있습니다. </li>
								         <li>주문 상품의 부분 취소는 불가능합니다. 전체 주문 취소 후 재구매해 주세요. </li>
							         </ul>
							         <strong class="subject">결제 승인 취소 / 환불 관련</strong>
							         <ul class="list_questions">
							            <li>카드 환불은 카드사 정책에 따르며, 자세한 사항은 카드사에 문의해주세요.</li>
							            <li>결제 취소 시, 사용하신 적립금과 쿠폰도 모두 복원됩니다.</li>
							         </ul>
							      </div>
							   </div>
							</div>
							<div class="happy_center lst">
							   <div class="happy unfold">
							      <h4 class="tit">교환 및 환불 안내</h4>
							      <p class="sub">고객님의 단순 변심으로 인한 반품은 어려울 수 있으니 양해 부탁드립니다.</p>
							      <a data-child-id="refund" href="#none" class="asked">
							         <span class="txt" data-open="자세히 보기" data-close="닫기">자세히 보기</span>
							         <img src="https://res.kurly.com/pc/ico/2001/pc_arrow_open@2x.png" alt="아이콘" class="ico">
							      </a>
							   </div>
							   <div class="happy_faq">
							      <span class="item">01. 받으신 상품에 문제가 있는 경우</span>
							      <div id="refund1" class="questions hide">
							         <p class="desc">상품이 표시·광고 내용과 다르거나 부패한 경우 등  상품에 문제가 있는 정도에 따라 <span class="bar_pc"></span>재배송, 일부 환불, 전액 환불해드립니다.</p>
							         <strong class="subject">신선 / 냉장 / 냉동 식품</strong>
							         <p class="desc">상품을 받은 날부터 2일 이내에 상품 상태를 확인할 수 있는 사진을 첨부해 1:1 문의 게시판에 남겨주세요. </p>
							         <strong class="subject">유통기한 30일 이상 식품<span class="bar"></span>(신선 / 냉장 / 냉동 제외) &amp; 기타 상품</strong>
							         <p class="desc">상품을 받은 날부터 3개월 이내 또는 문제가 있다는 사실을 알았거나 알 수 있었던 날부터 30일 이내에 <span class="bar_pc"></span>상품의 상태를 확인할 수 있는 사진을 첨부해 1:1 문의 게시판에 남겨주세요.</p>
							         <p class="noti">※ 상품에 문제가 있는 것으로 확인되면 배송비는 컬리가 부담합니다.</p>
							      </div>
							   </div>
							   <div class="happy_faq">
							      <span class="item">02. 단순 변심, 주문 착오의 경우</span>
							      <div id="refund2" class="questions hide">
							         <strong class="subject no_padding">신선 / 냉장 / 냉동 식품</strong>
							         <p class="desc">재판매가 불가한 상품의 특성상, 단순 변심, 주문 착오 시 교환 및 반품이 어려운 점 양해 부탁드립니다. <span class="bar_pc"></span>상품에 따라 조금씩 맛이 다를 수 있으며, 개인의 기호에 따라 같은 상품도 다르게 느끼실 수 있습니다.</p>
							         <strong class="subject">유통기한 30일 이상 식품<span class="bar"></span>(신선 / 냉장 / 냉동 제외) &amp; 기타 상품</strong>
							         <p class="desc">상품을 받은 날부터 7일 이내에 1:1 문의 게시판에 남겨주세요.</p>
							         <p class="noti">※ 단순 변심으로 인한 교환 또는 환불의 경우 고객님께서 배송비 6,000원을 부담하셔야 합니다. <span class="bar_pc"></span>(주문 건 배송비를 결제하셨을 경우 3,000원)</p>
							      </div>
							   </div>
							   <div class="happy_faq">
							      <span class="item">03. 교환·반품이 불가한 경우</span>
							      <div id="refund3" class="questions hide">
							         <p class="desc">다음에 해당하는 교환·반품 신청은 처리가 어려울 수 있으니 양해 부탁드립니다.</p>
							         <ul class="list_questions">
							            <li>소비자에게 책임 있는 사유로 상품이 멸실 또는 훼손된 경우 <span class="bar_pc"></span>(포장지 훼손으로 인해 재판매가 불가능한 상품의 경우, 단순 변심에 의한 반품이 어렵습니다.)</li>
							            <li>일부 예약 상품은 배송 3~4일 전에만 취소하실 수 있습니다.</li>
							            <li>소비자의 주문에 따라 개별적으로 생산되는 상품이 이미 제작 진행된 경우</li>
							         </ul>
							      </div>
							   </div>
							</div>
							
							<script>
								$(function(){
									
									// 고객센터 자세히보기 스크립트
									$(".happy_center .txt").click(function(){
										var targetParent = $(this).closest('.happy_center');
									    var targetText = $(this);
										if(targetParent.hasClass('on')){
											targetParent.removeClass('on');
											targetText.text("자세히보기");
										}else{
											targetParent.addClass('on');
											targetText.text("닫기");
										}
									});
								  
								});
							</script>		

						</div>	
					
						<!--고객후기 active되는 경우  -->
						<ul class="goods-view-infomation-tab-group">
							<li class="goods-view-infomation-tab">
								<a href="#goods-description" class="goods-view-infomation-tab-anchor ">상품설명</a>
							</li>
							<li class="goods-view-infomation-tab">
								<a href="#goods-image" class="goods-view-infomation-tab-anchor">상품이미지</a>
							</li> 
							<li class="goods-view-infomation-tab">
								<a href="#goods-infomation" class="goods-view-infomation-tab-anchor">상세정보</a>
							</li>
							<li class="goods-view-infomation-tab">
								<a href="#goods-review" class="goods-view-infomation-tab-anchor __active">고객후기 
								<span class="count_review">(${ goods.reviewCnt })</span>
								</a>
							</li>
					
							<li class="goods-view-infomation-tab qna-show">
								<a href="#goods-qna" class="goods-view-infomation-tab-anchor">상품문의 
									<span>(${ goods.qnaCnt })</span>
								</a>
							</li>
						</ul>
						<!-- 고객후기 페이지 -->
						<div class="goods-view-infomation-content" id="goods-review" data-load="0">
							<jsp:include page="reviewboard_list.jsp"></jsp:include>
						</div>
							
						<!--상품문의 active되는 경우  -->
						<ul class="goods-view-infomation-tab-group">
							<li class="goods-view-infomation-tab">
								<a href="#goods-description" class="goods-view-infomation-tab-anchor ">상품설명</a>
							</li>
							<li class="goods-view-infomation-tab">
								<a href="#goods-image" class="goods-view-infomation-tab-anchor">상품이미지</a>
							</li> 
							<li class="goods-view-infomation-tab">
								<a href="#goods-infomation" class="goods-view-infomation-tab-anchor">상세정보</a>
							</li>
							<li class="goods-view-infomation-tab">
								<a href="#goods-review" class="goods-view-infomation-tab-anchor">고객후기 
									<span class="count_review">(${ goods.reviewCnt })</span>
								</a>
							</li>
							<li class="goods-view-infomation-tab qna-show">
								<a href="#goods-qna" class="goods-view-infomation-tab-anchor __active">상품문의 
								<span>(${ goods.qnaCnt })</span>
								</a>
							</li>
						</ul>
						<!-- 상품문의 페이지 -->
						<div class="goods-view-infomation-content" id="goods-qna" data-load="0">
							<jsp:include page="goods_qna_list.jsp"></jsp:include>
						</div>
					
					</div>
					
				</div>

				<div class="bg_loading" id="bgLoading" style="display: none;">
					<div class="loading_show"></div>
				</div>
				
			</div>
		</div>
		
		<script>
		// 상품상세상단호출
		/* 	var sectionViewDefault = {
				    'login' : false,
				    'no' : '7327',
				    'type' : 'pc'
			}
			sectionViewDefault.login = true;
			sectionView.userInfoGet(sectionViewDefault);
				 */
			function cartPutLayerTypeShow(){
				    var winTop = 0, scrollCheckTop = 0;
				    var $target = $('#cartPut .cart_type1');
				    $(window).on('scroll', function(){
				        scrollCheckTop = Number( $('#goods-view-infomation').offset().top ); // 패키지상품치 위치가 바뀌므로 매번 체크
				        winTop = Number( $(this).scrollTop() );
				        if(winTop >=scrollCheckTop){
				            $target.addClass('on');
				        }else{
				            $target.removeClass('on');
				            if($target.find('.btn_close .ico').hasClass('open')){
				                $target.find('.btn_close').trigger('click');
				            }
				        }
				    }).scroll();
			}
			cartPutLayerTypeShow();
			
		</script>
		<!-- <script src="https://res.kurly.com/js/lib/jquery.inview.js"></script> -->
	
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