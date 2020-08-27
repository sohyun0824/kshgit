<%@page import="shop.member.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
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

</head>
<body class="goods-goods_list">
<div id="wrap" class="">
	<div id="pos_scroll"></div>
	<div id="container">
		<jsp:include page="../main/layout/header.jsp"></jsp:include>
		
		<div id="main">
			<div id="content">
				<jsp:include page="../main/layout/quick_nav.jsp"></jsp:include>
								
				<div class="page_aticle page_search">
					<div class="head_section head_search">
						<h2 class="tit">상품검색</h2>
						<p class="desc">신선한 컬리의 상품을 검색해보세요.</p>
					</div>
					<form name="frmList" onsubmit="goods_search.do">
						<div class="search_box">
							<div class="tit">
								<label for="sword">검색 조건</label>
							</div>
							<div class="desc">
								<input type="text" name="sword" id="sword" class="inp" value="${ sword }">
								<input type="submit" class="styled-button btn_search" value="검색하기">
							</div>
						</div>
					</form>
					<div id="goodsList" class="page_section section_goodslist">
						<p class="search_result">
							<strong class="emph">총 <span>${ goodsListView.goodsTotalCount }</span> 개</strong>의 상품이 검색되었습니다.
						</p> 
						<div class="list_goods">
							<div class="inner_listgoods">
								<ul class="list">
									<c:forEach items="${ goodsListView.goodsList }" var="dto">
										<li>
											<div class="item">
												<div class="thumb">
													<a class="img" style="background-image: url(../..${ dto.main_img });">
														<img src="../..${ dto.main_img }" alt="상품 한줄 설명" width="308" height="396">
													</a>
													<c:if test="${ dto.discount ne 0 }">
													<span class="ico">
														<img src="../data/my_icon/icon_save_${ dto.discount }.png" alt="SAVE 아이콘">
													</span>
													</c:if>
													<div class="group_btn">
														<button type="button" class="btn btn_cart">
															<span class="screen_out">${ dto.group_no }</span>
														</button>
													</div>
												</div>
												<a href="goods_view.do?group_no=${ dto.group_no }" class="info">
													<span class="name"> ${ dto.name }</span>
													<span class="cost">
													<c:if test="${ dto.discount ne 0 }">
														<span class="dc"><fmt:formatNumber type="currency" value ="${ dto.price }" pattern="#,##0" />원</span> 
														<span class="emph">→</span> 
														<span class="price"><fmt:formatNumber type="currency" value ="${ dto.price * ((100-dto.discount)/100) }" pattern="#,##0" />원</span>
													</c:if>
													<c:if test="${ dto.discount eq 0 }">											
														<span class="price"><fmt:setLocale value="ko_KR" /><fmt:formatNumber type="currency" value ="${ dto.price }" pattern="#,##0" />원</span>
													</c:if>
													</span>
													<span class="desc">${ dto.line_discript }</span>
												</a> 
												<span class="tag">
													<!-- kurly only 상품인 경우 -->
													<c:if test="${ dto.kurly_only eq 1 }">
														<span class="ico limit">Kurly only</span>
													</c:if>
													<!-- 한정수량 상품인 경우 -->
													<c:if test="${ dto.limited eq 1 }">
														<span class="ico limit">한정수량</span>
													</c:if>
													<!-- 건강기능 상품인 경우 -->
													<c:if test="${ dto.healthy eq 1 }">
														<span class="ico limit">건강기능</span>
													</c:if>
												</span>
											</div>
										</li>
									</c:forEach>
								</ul>
							</div>
						</div>
						
						<!-- 페이징처리 -->
						<div class="layout-pagination">
							<div class="pagediv">
								<a href="../goods/goods_search.do?sword=${ sword }&page=1" class="layout-pagination-button layout-pagination-first-page">맨 처음 페이지로 가기</a> 
								<a href="../goods/goods_search.do?sword=${ sword }&page=${ goodsListView.currentPage-1 == 0 ? 1 : goodsListView.currentPage-1 }" class="layout-pagination-button layout-pagination-prev-page">이전 페이지로 가기</a>
								<c:forEach var="num" begin="1" end="${ goodsListView.pageTotal }" step="1">
									<span>
										<c:if test="${ num eq goodsListView.currentPage }">
											<strong class="layout-pagination-button layout-pagination-number __active">${ num }</strong>
										</c:if>
										<c:if test="${ num ne goodsListView.currentPage }">
											<a class="layout-pagination-button layout-pagination-number" href="../goods/goods_search.do?sword=${ sword }&page=${ num }">${ num }</a>
										</c:if>
									</span>
								</c:forEach>
								<a href="../goods/goods_search.do?sword=${ sword }&page=${ goodsListView.currentPage+1 > goodsListView.pageTotal ? goodsListView.pageTotal : goodsListView.currentPage+1 }" class="layout-pagination-button layout-pagination-next-page">다음 페이지로 가기</a> 
								<a href="../goods/goods_search.do?sword=${ sword }&page=${ goodsListView.pageTotal }" class="layout-pagination-button layout-pagination-last-page">맨 끝 페이지로 가기</a>
							</div>
						</div>
						
					</div>
				</div>
				
				<div class="bg_loading" id="bgLoading" style="display: none;">
					<div class="loading_show"></div>
				</div>
			</div>
		</div>
		
		<jsp:include page="../main/layout/layerDSR.jsp"></jsp:include>
		<jsp:include page="../main/layout/footer.jsp"></jsp:include>

	</div>
</div>

<!-- 장바구니 담기  -->
<div id="cartPut">
	<div class="cart_option cart_type3" style="display: none;" >
		<strong class="layer_name">상품 선택</strong> 
		<div class="inner_option">
			<button type="button" class="btn_close1 off">레이어닫기</button>
			<strong class="tit_cart">그룹명</strong> 
			
			<div class="in_option">
				<div class="list_goods">
					<!-- 단일상품인 경우 list_nopackage 클래스 붙음 -->
					<!-- <ul class="list list_nopackage"> -->
					<ul class="list">
						<!-- 해당 그룹의 상품목록 반복 -->
						<!-- 
						<li class="on">
							<span class="btn_position">
									<button type="button" class="btn_del">
										<span class="txt">삭제하기</span>
									</button>
							</span> 
							<span class="name" data="상품번호">상품명</span> 
							<div class="option">
								<span class="count">
									<button type="button" class="btn down">수량내리기</button> 
									<input type="number" readonly="readonly" onfocus="this.blur()" class="inp">
									<button type="button" class="btn up">수량올리기</button>
								</span>
								<span class="price">
								 	-- 로그인O + 할인O
									<span class="original_price">원가</span>
									<span class="dc_price">할인가</span>
									-- 로그인X or 로그인O + 할인X
									<span class="dc_price">원가</span>
								</span>
				  			</div>
			  			</li>
			  			-- 품절인 경우 상품리스트
			  			<li class="on sold_out">
			  				<span class="btn_position">
			  					<button type="button" class="btn_del">
			  						<span class="txt">삭제하기</span>
			  					</button>
			  				</span> 
			  				<span class="name">
			  					<span span="">(품절)</span>[간편 샐러드] 손질 양상추 60g
			  				</span> 
			  				<div class="option"> 
			  					<span class="price">
			  						<span class="dc_price">1,850원</span>
			  					</span>
			  				</div>
			  			</li>
			  			-->
			  			
			  		</ul>
			  	</div> 
				<div class="total">
					<div class="price">
						<strong class="tit">합계</strong> 
				 		<span class="sum">
				 			<span class="num">0</span> 
				 			<span class="won">원</span>
				 		</span>
					</div> 
					<p class="txt_point">
						<span class="ico">적립</span> 
						<c:if test="${ member.m_id eq null }">
						<span class="no_login">
							<span>로그인 후, 적립혜택 제공</span>
						</span>
						</c:if>
						<c:if test="${ member.m_id ne null }">
						<!-- 회원등급에 따라 적립율 다름.. -->
						<!-- 일반회원 0.5  프렌즈 1  화이트 3  라벤더 5  퍼플 7  더퍼플 7 -->
						<span class="point">구매 시 
							<strong class="emph">0원 적립</strong>
						</span>
						</c:if>
					</p>
				</div>
			</div> 
			
			<div class="group_btn off layer_btn2">
				<span class="btn_type2">
					<button type="button" class="txt_type">취소</button>
				</span> 
				<span class="btn_type1">
					<button type="button" class="txt_type">장바구니 담기</button>
				</span> 
			</div>
		</div>
	</div> 

</div>

<script>
	$(".btn_cart").on("click", function() {	
		$("#bgLoading").css("display", "block");
		$("#cartPut .cart_type3").css("display", "block");
		
		var group_no = $(this).find(".screen_out").text();
		
		$.ajax({
			url : "../proc/cartPutList.jsp",
			type : "GET",
			data : {
				"group_no": group_no
			},
			dataType : 'json',
			cache : false,
			success : function(data) {
				//console.log(data.goodsList);
				$("#cartPut .tit_cart").attr("data", group_no).text(data.name);
				var target = $("#cartPut .inner_option ul.list");
				target.empty();
				var goodsList = data.goodsList;
				// goods_no, name, price, soldout, stock, group_no
				var discount = data.discount;
				for (var i = 0; i < goodsList.length; i++) {
					var price = goodsList[i].price;
					var soldout = goodsList[i].soldout;
					
					var btn_del = $("<button/>").addClass("btn_del").attr("type", "button").append($("<span/>").addClass("txt").text("삭제하기"));
					var span_btn = $("<span/>").addClass("btn_position").append(btn_del);
					
					var span_name = $("<span/>").addClass("name").attr("data",goodsList[i].goods_no);
					if(soldout == 1){
						span_name.append($("<span/>").attr("span","").text("(품절)"));
					}
					span_name.append(goodsList[i].name);
					
					var span_count = $("<span/>").addClass("count")
												.append($("<button/>").addClass("btn down").text("수량내리기"))
												.append($("<input/>").addClass("inp").attr("type","number").attr("readonly","readonly").attr("onfocus","this.blur()").val("0"))
												.append($("<button/>").addClass("btn up").text("수량올리기"));
					var span_price = $("<span/>").addClass("price");
					if('${ member.m_id }' != "" && '${ member.m_id }' != null && discount != 0){
						var salePrice = price*((100-discount)/100);
						span_price.append($("<span/>").addClass("original_price").text(price.toLocaleString() + "원"))
							.append($("<span/>").addClass("dc_price").text(salePrice.toLocaleString() + "원"));
					} else{
						span_price.append($("<span/>").addClass("dc_price").text(price.toLocaleString() + "원"));
					}
					var div_option = $("<div/>").addClass("option");
					if(soldout == 0){
						div_option.append(span_count);
					}
					div_option.append(span_price);
					
					var li = $("<li/>").addClass("on").append(span_btn).append(span_name).append(div_option);
					if(soldout == 1){
						li.addClass("sold_out");
					}
					target.append(li);
				}
				load();
			},
			fail : function() {
				alert("일시적인 장애가 발생하였습니다.\n잠시후 다시 시도해주세요");
			}
		});

	});
	
	// 창 닫기
	$("#cartPut .btn_close1").on("click", function() {
		$("#cartPut .cart_type3").css("display", "none");
		$("#bgLoading").css("display", "none");
		$("#cartPut .total .num").text("0");
		$("#cartPut .point .emph").text("0원 적립");
	});
	$("#cartPut .inner_option .off button").on("click", function() {
		$("#cartPut .cart_type3").css("display", "none");
		$("#bgLoading").css("display", "none");
		$("#cartPut .total .num").text("0");
		$("#cartPut .point .emph").text("0원 적립");
	});

	function load() {		
		var percent = <%= percent %>;
		//console.log(percent);
		
		//수량올리기 클릭
		$("#cartPut .up").on("click", function() {
			var cnt = $(this).siblings(".inp").val();
			cnt++;
			$(this).siblings(".inp").val(cnt);
			
			// 합계 입력
			var price = $(this).parents(".option").find(".dc_price").text();
			price = Number(price.substr(0, price.length-1).replace(",", ""));
			var total = Number($("#cartPut .total .num").text().replace(",", ""));
			total += price;
			//console.log(total);
			$("#cartPut .total .num").text(total.toLocaleString());
			
			// 로그인 - 적립금액 안내
			if('${ member.m_id }' != null && '${ member.m_id }' != ""){
				var point = total * percent;
				point = Math.round(point);
				$("#cartPut .point .emph").text(point.toLocaleString() + "원 적립");
			}
		});
		
		// 수량내리기 클릭
		$("#cartPut .down").on("click", function() {
			var cnt = $(this).siblings(".inp").val();
			// 처음 수량이 0이 아닌 경우만 실행
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
	}
	
	// 장바구니 담기
	$("#cartPut .btn_type1 button").on("click", function() {
		if(!<%= login %>){
			// 로그인X
			alert("로그인하셔야 본 서비스를 이용하실 수 있습니다.\n로그인 화면으로 이동합니다.");
			location.href="../member/login.do?return_url=/kurlyPro/shop/goods/goods_search.do?sword=<%= request.getParameter("sword") %>";
		} else{
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