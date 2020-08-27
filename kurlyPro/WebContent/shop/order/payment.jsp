<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%
 
 String[] basket = request.getParameterValues("goodsBasketNo");
 pageContext.setAttribute("basket", basket);
 	
 %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="euc-kr">
<meta name="title" content="마켓컬리 :: 내일의 장보기, 마켓컬리">
<meta name="description" content="모두가 사랑하는 장보기, 마켓컬리! 당일 수확 채소, 과일, 맛집 음식까지 내일 아침 문 앞에서 만나요!">
<meta property="og:title" content="마켓컬리 :: 내일의 장보기, 마켓컬리">
<meta property="og:description" content="모두가 사랑하는 장보기, 마켓컬리! 당일 수확 채소, 과일, 맛집 음식까지 내일 아침 문 앞에서 만나요!">
<meta property="og:image" content="https://res.kurly.com/images/marketkurly/logo/logo_sns_marketkurly.jpg">
<meta property="og:type" content="website">
<meta property="og:site_name" content="www.kurly.com">
<meta name="keywords" content="다이어트, 식단, 닭가슴살, 요리, 치아바타, 레시피, 요리, 상차림, 다이어트음식, 이유식, 건강이유식">
<title>마켓컬리 :: 내일의 장보기, 마켓컬리</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
<script async="" src="//www.google-analytics.com/analytics.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel="styleSheet" href="../data/skin/designgj/normalize.css?ver=1.16.19">
<link rel="styleSheet" href="../data/skin/designgj/section1.css?ver=1.16.19">
<link rel="styleSheet" href="../data/skin/designgj/common.css?ver=1.16.19">

</head>
<body class="order-settle">

	<div id="wrap" class="">
		<div id="pos_scroll"></div>
		<div id="container">
			<jsp:include page="../main/layout/header.jsp"></jsp:include>
			<div class="layout-wrapper">
				<p class="goods-list-position"></p>
			</div>

			<div class="layout-page-header">
				<h2 class="layout-page-title">결제하기</h2>
			</div>
		</div>
		<div id="main">
			<div id="content">
				<form name="frmSettle" method="post" action="/kurlyPro/shop/order/order_end.do">
					<input type="hidden" name="delivery_type" value="${ param.deliPoli }">
					<input type="hidden" name="settlement_price" value="${ param.settlement_price }">
					<input type="hidden" name="add_point" value="${ param.add_point }">
					<input type="hidden" name="no_goods" value="${ param.undeliver_way }">
					<input type="hidden" name="user_no" value="${ param.user_no }">
					<input type="hidden" name="delivery_code" value="${ param.addressbook_no }">
					<input type="hidden" name="pay_code" value="${ param.pay_code }">
					<input type="hidden" name="use_point" value="${ param.usePoint }">
					<input type="hidden" name="use_couponcode" value="${ param.couponCode }">
					<input type="hidden" name="length" value="${ param.itemCount }">
					<c:forEach items="${ basket }" var="no">
						<input type="hidden" name="goodsBasketNo" value="${ no }">
					</c:forEach>
						
					<div id="avoidDblPay" class="group_btn">
						<div id="payActingBtn" style="">
							<p class="txt_wait">결제창을 불러오고 있습니다. 잠시만 기다려주세요.</p>
						</div>
					</div>
					<div style="padding:30px 0 30px; position: relative;" align="center" class="noline">
						<input type="reset" style="float:none" value="취소" class="bhs_button btn_payment action" onclick="history.back()">
						<input type="submit" style="float:none" value="완료" class="bhs_button btn_payment action">
					</div>
				</form>
			</div>			
			<jsp:include page="/shop/main/layout/footer.jsp"></jsp:include>
		</div>
	</div>
</body>
</html>