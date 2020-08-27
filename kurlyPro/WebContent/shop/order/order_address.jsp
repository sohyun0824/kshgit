<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="user-scalable=no,initial-scale=1,maximum-scale=1,minimum-scale=1,width=device-width,height=device-height,viewport-fit=cover">
<title>Market Kurly</title>
<link rel="stylesheet" href="https://www.kurly.com/shop/data/skin_mobileV2/designgj/common.css?ver=1">
<link rel="stylesheet" href="https://www.kurly.com/app/order/static/css/main.7a83f82e.chunk.css">
<!-- <script src="https://www.kurly.com/appProxy/appData.php"></script>
<script src="https://www.kurly.com/common_js/kurlytracker/kurlytracker.js"></script> -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- <script type="text/javascript" src="postcode.js"></script> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
function unhyphen(num) {
	return num.replace(/[^0-9]/g, '');
}

function hyphen(num) {
	return num.replace(/[^0-9]/g, '').replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,'$1-$2-$3').replace('--', '-');
}

$(function(){
	if(!$("#root1 .list").children().length){
		$("#root2").show();
		$("#root1").hide();
	}
	
	// 새 배송지 추가 버튼 눌렀을 때
	$(".btn_new").on("click", function() {
		$("#root2").show();
		$("#root1").hide();
	});
	
	$("#receptionAreaInfo").on("click", function() {
		$("#root3").show();
		$("#root2").hide();		
		$("#root1").hide();		
	});
	
	// * 주소검색 버튼 누르면 주소 검색하는 창 보여짐
	$("#addressInfo").on("click", function(){
		$("#formReceiverInfo").hide();
		$("#popAddress").show();
		
		openAddressPopup();
	});
	
	// 닫기 버튼 눌렀을 때
	$(".close .btn").on("click", function() {
		$("#formReceiverInfo").show();
		$("#popAddress").hide();
		$("#popAddressSub").hide();
	});
	
	
	// 주문자 정보와 동일 버튼 누르면 주문자 정보의 이름/휴대폰번호 입력
	$(".label_block.same").on("click", function(){
		if($(this).children('input').prop('checked')) {
			$(this).children('input').prop('checked', false);
			$("#receiverName").val('');
			$("#receiverPhoneNumber").val('');
		}else{
			$(this).children('input').prop('checked', true);
			$("#receiverName").val('${member.name}');
			$("#receiverPhoneNumber").val(unhyphen('${member.tel}'));
		}
	});
	

	// 샛별배송 지역 중 배송 불가 장소 안내 자세히 보기 클릭할 때 
	$(".no_delivery .btn").on("click", function(){
		$(this).toggleClass("on");
		$("ul.list").toggleClass("on");
	});
	
	$(".address .tag").find(".badge:first").each(function() {
		if($(this).text() == '샛별배송'){
			$(this).addClass("star");
		}else{
			$(this).addClass("regular");
		}
	});
	
	$(".default").parents("label").find("input[type=radio]").prop("checked", "checked");

	// 배송기사 요청사항 50자 까지만
	$("#memo").on("keyup", function(e) {
		var length = $(this).val().length;
		if(length>50) e.preventDefault();
		$(this).next().text(length + '자 / 50자');
	});
	

	// 상세 주소 입력할 때마다 글자수 세기 100자 까지만 
	$("#addrSub").on("keyup", function(e) {
		var addr = $("#addrBaseType")=='J'? $("#addr").val() : $("#addrRoad").val();
		var length = addr.length + 8 + $(this).val().length;
		if(length>100) e.preventDefault();
		$(this).next().text(length+'자 / 100자');
	});
	
	// 받으실 장소 라디오 버튼 선택했을 때
	$("input:radio[name=pickUpType]").on("change", function() {
		 var checkVal = $("input:radio[name=pickUpType]:checked").val();
		 var field = '';
		 var obj = '';
		$(".info.layout").hide();
		$(".info.layout .field").remove();
		 
		switch (checkVal) {
		case '3':
			obj = $(".info.deliveryBox");
			field = '<input type="text" id="pickUpDetail" name="pickUpDetail" maxlength="100" placeholder="택배함 위치 / 택배함 번호 · 비밀번호" value="">'
				+ '<p class="notice">지정되지 않은 택배함은 위치만 적어주세요. 배송 완료 후 택배함 번호와 비밀번호를 알려드려요.</p>';
			obj.show().children(':first').after('<div class="field"></div>');
			obj.find('.field').append(field);
		case '1': 
			obj = $(".info.common");
			field = '<label class="label_block"><input type="radio" name="meansType" value="1" checked><span class="ico"></span>공동현관 비밀번호</label>'
				+ '<div class="subRadio"><input type="text" id="means" name="means" maxlength="100" class="inp" placeholder="예: #1234*" value="">'
				+ '<p class="notice">특수문자를 포함한 정확한 비밀번호를 입력해 주세요.</p></div>'
				+'<label class="label_block"><input type="radio"  name="meansType" value="6"><span class="ico"></span>자유 출입 가능</label>'
				+'<label class="label_block"><input type="radio" name="meansType" value="7"><span class="ico"></span>기타</label>'
				+'<div class="notcie_field"><strong class="tit_notice">확인해주세요!</strong><ul class="list_notice"><li>비밀번호가 정확하지 않을 경우, 부득이하게 1층 공동현관 앞 또는 경비실 앞에 배송될 수 있습니다.</li></ul></div>';
			break;
		case '2':
			obj = $(".info.security");
			field = '<textarea id="pickUpDetail" maxlength="100" name="pickUpDetail" placeholder="경비실 위치 등 특이사항이 있을 경우 작성해주세요"></textarea>';
			break;
		case '4':
			obj = $(".info.etc");
			field = '<textarea id="pickUpDetail" maxlength="100" name="pickUpDetail" placeholder="예) 계단 밑, 주택단지 앞 경비초소를 지나 A동 출입구 (배송 시간은 별도로 지정할 수 없습니다)"></textarea>';
			break;
		}
		
		 obj.show().children(':first').after('<div class="field"></div>');
		 obj.find('.field').append(field);
	});
	
	// 공동현관 출입방법 선택했을 때 
	$(document).on("click", "input:radio[name=meansType]", function () {
		var check = $("input:radio[name=meansType]:checked");
		var notice = $(".notcie_field .list_notice");
		$(".subRadio").remove();
		notice.empty();
		check.parent().after('<div class="subRadio"></div>');
		var obj = $(".subRadio");
		
		var objContent = '';
		var noticeContent = '';

		switch (check.val()) {
		case '1':
			objContent += '<input type="text" id="means" name="means" maxlength="100" class="inp" placeholder="예: #1234*" value="">';
			objContent += '<p class="notice">특수문자를 포함한 정확한 비밀번호를 입력해 주세요.</p>';
			noticeContent += '<li>비밀번호가 정확하지 않을 경우, 부득이하게 1층 공동현관 앞 또는 경비실 앞에 배송될 수 있습니다.</li>';
			break;
		case '2':
			noticeContent += '<li>자유출입이 불가능한 경우, 부득이하게 1층 공동현관 앞 또는 경비실 앞에 배송될 수 있습니다.</li>';			
			break;
		case '3':
			objContent += '<textarea id="means" name="means" maxlength="100" placeholder="예: 연락처로 전화, 경비실로 호출  (배송 시간은 별도로 지정할 수 없습니다)"></textarea>';
			noticeContent += '<li>요청하신 방법으로 출입이 어려운 경우, 부득이하게 1층 공동현관 앞 또는 경비실 앞에 배송될 수 있습니다.</li>';			
			noticeContent += '<li>배송 받으실 시간은 별도로 지정하실 수 없으며, 밤 11시까지 주문 시 오전 7시까지 배송이 완료됩니다.</li>';						
			break;
		}
		obj.append(objContent);
		notice.append(noticeContent);
	});

	// 받으실 장소 다 입력하고 저장 눌렀을 때
	$("#btnReceiveSubmit").on("click", function(e) {
		// 문앞 - 공동현관 비밀번호 면 비밀번호 입력해야, 기타 면 기타 내용 입력해야
		// 경비실 - 입력 안 해도 됨
		// 택배함 - 택배함 정보 입력해야
		// 기타 장소 - 기타 장소 세부 사항 내용을 입력해야
		var pickUpType = $("input[name=pickUpType]:checked").val();
		var pickUpTypeString = '';
		switch (pickUpType) {
		case '3':
			pickUpTypeString = '택배함';
			if($("#pickUpDetail").val()==''){
				alert("택배함 정보를 입력해주세요.");
				return false;
			}
		case '1':
			if(pickUpTypeString=='') pickUpTypeString = '문 앞';
			var meansType = $("input[name=meansType]:checked").val();
			if(meansType==1 && $("#means").val()==''){
				alert("공동현관 비밀번호를 입력해주세요.");
				return false;
			}else if(meansType==3 && $("#means").val()==''){
				alert("기타 내용을 입력해주세요.");
				return false;
			}
			break;
		case '2':
			pickUpTypeString = '경비실';
			break;
		case '4':
			pickUpTypeString = '기타 장소'
			if($("#pickUpDetail").val()==''){
				alert("기타 장소 세부 사항 내용을 입력해주세요.");
				return false;
			}
			break;
		}

		$("#root3").hide();
		$("#root2").show();
		
		// 받으실 장소 란에 입력된 값 넣기
		var reception = $("#receptionAreaInfo .reception");
		reception.removeClass("none");
		reception.addClass("on");
		
		// 1 문앞 / 2 경비실 / 3 택배함 / 4 기타
		$("#pickUpType").val(pickUpTypeString);
		
		var meansTypeString = '';
		
		if(pickUpType==1){
			if(meansType==1) meansTypeString = '공동현관 비밀번호';
			else if(meansType==2) meansTypeString = '자유 출입 가능';
			else if(meansType==3) meansTypeString = '기타';
			
			pickUpTypeString += ' (출입방법: '+meansTypeString+')';
			$("#meansTypeDetail").val($("#means").val());
		}else{
			$("#pickUpTypeDetail").val($("#pickUpDetail").val());
		}
		
		$("#meansType").val(meansType);
		
		reception.text(pickUpTypeString);
	});
	
	// 배송지 정보 다 입력하고 저장 눌렀을 때
	$("#formReceiverInfo").on("submit", function(){
		if($("#receiverName").val()==''){
			alert("받는 분 이름을 입력해주세요.");
			return false;
		}
		if($("#receiverPhoneNumber").val()==''){
			alert("휴대폰 번호를 입력해주세요.");
			return false;
		}
		if($("#addressInfo").find(".badge.none").length) {
			alert("안타깝지만 배송 불가 지역입니다. 배송지를 변경해주세요.");
			return false;			
		}
		$("#receiverTel").val(hyphen($("#receiverPhoneNumber").val()));
	});

	// 기본배송지는 삭제 불가능
	$(".badge.default").parents("li").find(".group_btn .btn:first").addClass("disable");
	
	// 배송지 선택에서 확인버튼 (submit) 누를 때
	$(".btn_fixed button").on("click", function(){
		$(this).target = opener;
		
		opener.form.addressBookNo.value = $("input[name=updatingID]:checked").val();
		
		$(this).submit();
		self.close();
	});
	
});

//배송지 삭제
function deleteDeliveryInfo(obj){
	var result = confirm("배송지를 삭제하시겠습니까?");
	if(result){
		var deliveryCode = $(obj).closest("li").find("input[name=updatingID]").val();
		$.ajax({
			url: "order_address_del.jsp"
			, type: "get"
			, cache: false
			, data: "delivery_code="+deliveryCode
			, dataType: "json"
			, success: function(data){
				if(data.result==1) {
					$(obj).closest("li").remove();
					alert("선택한 배송지가 삭제되었습니다.");
				}
			}
			, error: function(request, status, error){
				alert("배송지 삭제에 실패했습니다.");
			}
		});
	}
}

//배송지 수정
function updateDeliveryInfo(obj){
	$("#root1").hide();
	$("#root2").show();
	/* 
		var deliveryCode = $(obj).closest("li").find("input[name=updatingID]").val();
		$.ajax({
			url: "order_address_up.jsp"
			, type: "get"
			, cache: false
			, data: "delivery_code="+deliveryCode
			, dataType: "json"
			, success: function(data){
				
			}
			, error: function(request, status, error){
				alert("배송지 수정에 실패했습니다.");
			}
		});
	 */
}

</script> 
</head>
<body>
	<article id="kurlyWrap" class="page_order">
		<header id="kHead" class="header">
			<h1 class="tit_logo screen_out">
				<img src="https://res.kurly.com/images/marketkurly/logo/logo_purple.png" alt="마켓컬리 로고">
			</h1>
			<h2 class="tit_header screen_out">주문서</h2>
			<a href="#none" class="btn"><span class="screen_out">뒤로가기</span></a>
		</header>
		<section id="kAticle">
			<div id="kMain">
			
				<div id="root1">
					<div id="header" class="header only_pc">
						<h2 class="tit_header">배송지 선택</h2>
						<a id="headerLinkGoBack" href="#none" class="btn ">뒤로가기</a>
					</div>
					<div class="module_address only_pc">
						<button type="button" class="btn_new">
							<span class="ico"></span>새 배송지 추가
						</button>
						<form>
							<ul class="list">
								<!--  여기부터 -->
								<c:forEach items="${ delivery }" var="dto">
								<li>
									<label> 
										<input type="radio" name="updatingID" value="${ dto.delivery_code }">
										<span class="ico"></span>
										<span class="address"> 
											<span class="tag"> 
												<span class="badge">${ dto.delivery_type }</span> 
												<c:if test="${ dto.is_basic eq 1 }">
													<span class="badge default">기본배송지</span>
												</c:if>
											</span> 
											<span class="addr">
												${ dto.address }
											</span>
										</span> 
										<span class="spot">
										<c:if test="${ dto.delivery_type eq '샛별배송' }">
											받으실 장소: ${ dto.loc }
											<c:if test="${ dto.loc eq '문 앞' }">
											(출입방법: ${ dto.front_door })
											</c:if>
										</c:if>
										</span> 
										<span class="contact">${ dto.receiver }, ${ dto.receiver_tel }</span>
									</label>
									<div class="group_btn">
										<button type="button" class="btn" onclick="deleteDeliveryInfo(this);">삭제</button>
										<button type="button" class="btn" onclick="updateDeliveryInfo(this);">수정</button>
									</div>
								</li>
								</c:forEach>
								<!-- 여기까지 반복 -->
							</ul>
							<div class="btn_fixed">
								<button type="button" class="btn active" data-opt="check">확인</button>
							</div>
						</form>
					</div>
				</div>
				
				<div id="root2" style="display:none;">
					<div id="header" class="header only_pc">
						<h2 class="tit_header">배송지 입력</h2>
						<a id="headerLinkGoBack" href="#none" class="btn ">뒤로가기</a>
					</div>
	
					<div class="receive_info only_pc">
						<div id="popAddress" class="pop_address" style="display: none;">
							<span class="close">
								<button class="btn normal">닫기</button>
							</span>
							<div id="innerAddress" class="inner_address" style="height: 466px;">
								
							</div>
							<div id="popAddressSub" class="pop_addresssub">
								<a id="btnAddressSubBack" href="#none" class="header">
									<h2 class="tit_header">주소 재검색</h2> 
									<span class="btn btn_back">뒤로가기</span>
								</a>
								<div class="filed">
									<input type="hidden" id="popAddr" name="popAddr"> 
									<input type="hidden" id="popAddrRoad" name="popAddrRoad"> 
									<input type="hidden" id="popAddrBaseType" name="popAddrBaseType">
									<input class="inp" id="popZonecode" name="popZonecode" type="text" readonly="" value=""> 
									<input class="inp" id="popSubAddressInfo" type="text" readonly=""> 
									<input class="inp" id="popSubAddress" name="popSubAddress" type="text" maxlength="80"
										data-format="text" placeholder="나머지 주소를 입력해주세요." value="">
								</div>
								<div class="filed">
									<button type="button" id="addressSubAdd"
										data-input-id="popSubAddress" class="btn active">주소입력</button>
								</div>
								<div class="no_delivery">
									<div class="inner_no">
										<h3 class="tit">
											<span class="ico">샛별배송 지역 중 배송 불가 장소 안내</span> 
											<span class="desc">관공서/ 학교/ 병원/ 시장/ 공단 지역/ 산간 지역/ 백화점 등</span>
											<button type="button" class="btn ">
												자세히 보기<span class="ico"></span>
											</button>
										</h3>
										<ul class="list ">
											<li>가락동농수산물도매시장</li>
											<li>가락동농수산물시장</li>
											<li>가천대학교</li>
											<li>고려대학교안암캠퍼스</li>
											<li>고매동 일부(일부지역만 배송가능)</li>
											<li>국립중앙박물관</li>
											<li>국민대학교</li>
											<li>덕성여자대학교</li>
											<li>덕양구 신원동 일부(일부지역만 배송가능)</li>
											<li>도내동 일부(원흥지구만 배송가능)</li>
											<li>동덕여자대학교</li>
											<li>반월특수지구</li>
											<li>서경대학교</li>
											<li>서울사이버대학교</li>
											<li>서울시립대학교</li>
											<li>서울여자대학교</li>
											<li>성균관대학교</li>
											<li>성신여자대학교</li>
											<li>세종대학교</li>
											<li>연세대학교</li>
											<li>이화여자대학교</li>
											<li>한국외국어대학교</li>
											<li>홍익대학교</li>
										</ul>
									</div>
								</div>
							</div>
						</div>
		
						<form id="formReceiverInfo" action="order_address.do" method="post" onsubmit="return receiveCheck();">
							<input type="hidden" id="deliveryType" name="deliveryType" value=""> 
							<input type="hidden" id="zonecode" name="zonecode" value=""> 
							<input type="hidden" id="address" name="address" value=""> 
							<input type="hidden" id="addr" name="addr" value=""> 
							<input type="hidden" id="addrRoad" name="addrRoad" value=""> 
							<input type="hidden" id="addrBaseType" name="addrBaseType" value="">
							<input type="hidden" id="pickUpType" name="pickUpType" value="0">
							<input type="hidden" id="pickUpTypeDetail" name="pickUpTypeDetail" value="">
							<input type="hidden" id="meansType" name="meansType" value="0">
							<input type="hidden" id="meansTypeDetail" name="meansTypeDetail" value="">
							<input type="hidden" id="deliveryMessageSendAt" name="deliveryMessageSendAt" value="0"> 
							<input type="hidden" id="receiverTel" name="receiverTel" value=""> 
							<label class="label_block same"> 
								<input name="putUserInfo" id="putUserInfo" type="checkbox" >
								<span class="ico"></span>
								주문자 정보와 동일
							</label>
							
							<div class="info fst">
								<h3 class="tit">
									<label for="receiverName">받는 분 이름*</label>
								</h3>
								<div class="field">
									<input type="text" id="receiverName" name="receiverName"
										data-max-length="20" class="inp" placeholder="이름을 입력해 주세요" value="">
								</div>
							</div>
							
							<div class="info">
								<h3 class="tit">
									<label for="receiverPhoneNumber">받는 분 휴대폰*</label>
								</h3>
								<div class="field">
									<input type="text" id="receiverPhoneNumber"
										name="receiverPhoneNumber" class="inp" maxlength="11" pattern="[0-9]*" inputmode="decimal"
										placeholder="- 없이 입력해 주세요" value="">
								</div>
							</div>
							
							<div class="info info_address">
								<h3 class="tit">
									<label for="address">주소*</label>
								</h3>
								<div class="field">
									<a href="#none" id="addressInfo" class="search">
									주소검색
									</a>
									<!-- 샛별배송이면 -->
									<p id="addressNotice" class="notice" style="display:none;">
										샛별 배송 지역 중 <span class="emph">배송 불가 장소</span>
										:<br>관공서 / 학교 / 병원 / 시장 / 공단지역 / 산간지역 / 백화점 등
									</p>
								</div>
							</div>
							
							<!-- 주소 입력 완료 후 보여야 -->
							<div id="hiddenContainer" class="info_subaddress hide">
								<div class="info">
									<h4 class="tit">
										<label for="addrSub">상세 주소</label>
									</h4>
									<div class="field">
										<input id="addrSub" name="addrSub" class="inp" type="text" placeholder="나머지 주소를 입력해 주세요" value="">
										<span class="count"></span>
									</div>
								</div>
					
								<!-- 샛별배송 인 경우 -->
								<div class="info" id="receptionArea" style="display:none;">
									<h4 class="tit">
										<label for="receptionAreaInfo">받으실 장소*</label>
									</h4>
									<div class="field">
										<div id="receptionAreaInfo">
											<div class="reception none">장소를 입력해주세요</div>
										</div>
									</div>
								</div>
								
								<!-- 택배배송 인 경우 -->
								<div class="info" id="deliveryMemo" style="display:none;">
									<h4 class="tit">
										<label for="memo">배송 기사 요청 사항</label>
									</h4>
									<div class="field">
										<textarea id="memo" name="memo" class="text_field" maxlength="50"
											data-format="text" placeholder="예 : 벨 누르지 말고 전화주세요."></textarea>
										<span class="count">0 자 / 50자</span>
									</div>
								</div>								
								
								<div class="info lst">
									<label class="label_block">
										<input id="isDefault" name="isDefault" type="checkbox">
										<span class="ico"></span>
										기본 배송지로 저장
									</label>
								</div>
								<p class="info_agree">배송 정보 저장에 동의 합니다</p>
							</div>
							
							<div class="submit double">
								<button type="button" class="btn default">취소</button>
								<button id="btnDeliveryInfoSubmit" class="btn active">저장</button>
							</div>
						</form>
					</div>
				</div>
				
				<div id="root3" style="display:none;">
					<div id="header" class="header only_pc">
						<h2 class="tit_header">받으실 장소 입력</h2>
						<a id="headerLinkGoBack" class="btn ">뒤로가기</a>
					</div>
					<div class="receive_info reception_info only_pc">
					<form onsubmit="event.preventDefault();">
						<input type="hidden" id="addressID" name="addressID" value="">
						<div class="info fst">
							<h3 class="tit">
								<label for="pickUpType">받으실 장소*</label>
							</h3>
							<div class="field">
								<label class="label_block">
								<input type="radio" name="pickUpType" value="1" checked>
								<span class="ico"></span>문 앞</label>
							</div>
							<div class="field">
								<label class="label_block">
								<input type="radio" name="pickUpType" value="2">
								<span class="ico"></span>경비실</label>
							</div>
							<div class="field">
								<label class="label_block">
								<input type="radio" name="pickUpType" value="3">
								<span class="ico"></span>택배함</label>
							</div>
							<div class="field">
								<label class="label_block">
								<input type="radio" name="pickUpType" value="4">
								<span class="ico"></span>기타 장소</label>
							</div>
						</div>
			
			
						<div class="info layout deliveryBox" style="display: none;">
							<h3 class="tit">
								<label for="pBoxInfo">택배함 정보*</label>
							</h3>
						</div>
			
						<div class="info layout common">
							<h3 class="tit">
								<label for="">공동현관 출입 방법*</label>
							</h3>
							
							<div class="field">
								<label class="label_block">
									<input type="radio" name="meansType" value="1" checked>
									<span class="ico"></span>공동현관 비밀번호
								</label>
								<div class="subRadio">
									<input type="text" id="means" name="means" maxlength="100"
										class="inp" placeholder="예: #1234*" value="">
									<p class="notice">특수문자를 포함한 정확한 비밀번호를 입력해 주세요.</p>
								</div>
								<label class="label_block">
									<input type="radio"  name="meansType" value="2">
									<span class="ico"></span>자유 출입 가능
								</label>
								<label class="label_block">
									<input type="radio" name="meansType" value="3">
									<span class="ico"></span>기타
								</label>	
								<div class="notcie_field">
									<strong class="tit_notice">확인해주세요!</strong>
									<ul class="list_notice">
										<li>비밀번호가 정확하지 않을 경우, 부득이하게 1층 공동현관 앞 또는 경비실 앞에 배송될 수 있습니다.</li>
									</ul>
								</div>
							</div>
							
						</div>
			
						<div class="info layout security" style="display: none;">
							<h3 class="tit">
								<label for="pickUpDetail">경비실 특이사항</label>
							</h3>
							<div class="notcie_field">
								<strong class="tit_notice">확인해주세요!</strong>
								<ul class="list_notice">
									<li>경비 부재로 출입이 불가능한 경우, 부득이하게 1층 공동현관 앞 또는 경비실 앞에 배송될 수 있습니다.</li>
								</ul>
							</div>
						</div>
			
						<div class="info layout etc" style="display: none;">
							<h3 class="tit">
								<label for="pickUpDetail">기타 장소 세부 사항*</label>
							</h3>
							<div class="notcie_field">
								<strong class="tit_notice">확인해주세요!</strong>
								<ul class="list_notice">
									<li>정확한 배송을 위해 장소의 특징 또는 출입 방법 등을 자세하게 작성해주세요.</li>
									<li>보일러 실, 양수기 함, 소화전 앞 또는 위탁배송은 불가능 합니다.</li>
									<li>요청하신 장소로 배송이 어려운 경우, 부득이하게 1층 공동현관 앞 또는 경비실 앞에 배송될 수 있습니다.</li>
									<li>배송 받으실 시간은 별도로 지정하실 수 없으며, 밤 11시까지 주문 시 오전 7시까지 배송이 완료됩니다.</li>
								</ul>
							</div>
						</div>
			
			
						<div class="info info_msg">
							<h3 class="tit">
								<label for="deliveryMessageSendAt">배송 완료 메시지 전송*</label>
							</h3>
							<div class="field">
								<div class="half">
									<div class="halve">
										<label>
										<input type="radio" name="deliveryMessageSendAt" value="0">
										<span class="ico"></span>배송 직후</label>
									</div>
									<div class="halve">
										<label>
										<input type="radio" name="deliveryMessageSendAt" value="1" checked>
											<span class="ico"></span>오전 7시</label>
									</div>
								</div>
							</div>
						</div>
						<div class="submit double">
							<button type="button" class="btn default">이전화면으로 이동</button>
							<button id="btnReceiveSubmit" class="btn active">저장</button>
						</div>
					</form>
					</div>
				</div>

			</div>
		</section>
		<footer id="kFoot"></footer>
		<div class="bg_loading" id="bgLoading" style="display: none;">
			<div class="loading_show"></div>
		</div>
	</article>
<script type="text/javascript">

/* 
(function() {
    if (typeof window.CustomEvent === 'function')
        return false;
    function CustomEvent(event, params) {
        params = params || {
            bubbles: false,
            cancelable: false,
            detail: undefined
        };
        var evt = document.createEvent('CustomEvent');
        evt.initCustomEvent(event, params.bubbles, params.cancelable, params.detail);
        return evt;
    }
    CustomEvent.prototype = window.Event.prototype;
    window.CustomEvent = CustomEvent;
}
)();
 */
var element_form = document.getElementById('formReceiverInfo');
var element_wrap_parent = document.getElementById('popAddress');
var element_wrap = document.getElementById('innerAddress');
var element_sub = document.getElementById('popAddressSub');

function closeAddressPopup() {
	// 주소입력 완료 후 상세주소 입력하는 창 중에 상세주소 이후 
    $("#hiddenContainer").removeClass("hide");
    // 주소 검색해서 하나 클릭하고 난 뒤 나오는 창
    $("#popAddress").hide();
    // 받는사람 이름 번호 주소 + 상세주소 ~
    $("#formReceiverInfo").show();
    // 우편번호, 주소, 도로명주소, 주소타입 input hidden 태그에 입력
    $("#zipcode").val($("#popZonecode").val());
    $("#zonecode").val($("#popZonecode").val());
    $("#addr").val($("#popAddr").val());
    $("#addrRoad").val($("#popAddrRoad").val());
    $("#addrBaseType").val($("#popAddrBaseType").val());
    $("#addrSub").val($("#popSubAddress").val());
    $("#deliveryType").val(deliveryType);

	if($("#addr").val().indexOf("서울")==0){
		deliveryType=0;
	}else if($("#addr").val().indexOf("제주")==0){
		deliveryType=2;
	}else{
		deliveryType=1;
	}
	
	$("#deliveryType").val(deliveryType==0? '샛별배송': deliveryType==1? '택배배송':'배송불가');
	deliveryTypeConfirm(deliveryType);
} 
function deliveryTypeConfirm(type){
    	
    	var num = $('<span class="num"></span>').append('['+ $("#popZonecode").val() +']');
    	var addr = $('<span class="addr"></span>')
    						.append($("#popAddrBaseType").val()=='R'?$("#popAddrRoad").val()+" ":$("#popAddr").val()+" ").append(num);
    	var badge = $('<span class="badge"></span>');
    	
    	var msg;
    	switch (type) {
		case 0: badge.addClass("star").append('샛별배송'); msg="샛별배송 지역입니다.";	break;
		case 1: badge.addClass("regular").append('택배배송'); msg="택배배송 지역입니다. [택배사 사정으로 당일택배 배송 가능 지역이 변경될 수 있어요.]"; break;
		case 2: badge.addClass("none").append('배송불가지역'); msg="안타깝지만 배송 불가 지역입니다. 도로명 주소로 검색하셨다면 지번 주소로 다시 검색해보세요."; break;
		default: msg=""; break;
		}
    	
    	var tag = $('<span class="tag"></span>').append(badge);
    	var address = $('<span class="address"></span>').append(tag).append(addr);
    	$("#addressInfo").html(address);
    	
    	$("#address").val(addr.text());
    	
    	if(type==0){
    		$("#addressNotice").show();
    		$("#receptionArea").show();
    		$("#deliveryMemo").hide();
    	}else if(type==1){
    		$("#addressNotice").hide();
    		$("#receptionArea").hide();
    		$("#deliveryMemo").show();
    	}else{
    		$("#addressNotice").hide();
    		$("#receptionArea").hide();
    		$("#deliveryMemo").hide();  
    		$("#isDefault").prop("type", "hidden").next().remove();
    		$("#isDefault").parent().text('');
    	}
    	
    	confirm(msg);
    }
function subAddressLayer(type) {
    if (type === 'on') {
        element_wrap.style.display = 'none';
        element_sub.style.display = 'block';
        window.scrollTo(0, 0);
        document.getElementById('popSubAddress').value = '';
    }
    if (type === 'off' || type === 'finish') {
        element_wrap.style.display = 'block';
        element_sub.style.display = 'none';
        window.scrollTo(0, 0);
    }
    if (type === 'finish') {
        closeAddressPopup();
    }
}
function openAddressPopup() {
    var layer = document.getElementById('__daum__layer_1');
    if (layer) {
        element_wrap.removeChild(layer);
    }
    if (element_sub.style.display === 'block') {
        element_wrap.style.display = 'block';
        element_sub.style.display = 'none';
    }
    element_form.style.display = 'none';
    var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
    new daum.Postcode({
        maxSuggestItems: 5,
        hideMapBtn: true,
        hideEngBtn: true,
        oncomplete: function(data) {
            subAddressLayer('on');
            // 사용자가 도로명주소 선택했으면 도로명주소, 지번주소 선택했으면 지번주소
            var addr = (data.userSelectedType === 'R') ? data.roadAddress : data.jibunAddress;
            var extraAddr = '';
            // 도로명주소
            var fullRoadAddr = data.roadAddress;
            // 지번주소
            var fullJibunAddr = data.jibunAddress || data.autoJibunAddress;
            // 건물명이 있으면 extraAddr에 (건물명) 
            if (data.buildingName !== '') {
                extraAddr = ' (' + data.buildingName + ')';
            }
            // 사용자가 도로명주소 선택했으면 addr에 건물명 추가
            if (data.userSelectedType === 'R') {
                addr += extraAddr;
            }
            // 도로명주소에 건물명 추가
            fullRoadAddr += extraAddr;

            document.getElementById('popZonecode').value = data.zonecode;
            // 
            document.getElementById('popAddr').value = ((fullJibunAddr === '') ? data.address : fullJibunAddr);
            document.getElementById('popAddrRoad').value = fullRoadAddr || '';
            document.getElementById('popAddrBaseType').value = data.userSelectedType;
            document.getElementById('popSubAddressInfo').value = addr;
            /* 
            var evtChkDeliveryInfo;
            try {
                evtChkDeliveryInfo = new Event('chkDeliveryInfo',{
                    bubbles: true,
                    cancelable: true
                });
            } catch (error) {
                evtChkDeliveryInfo = document.createEvent('Event');
                evtChkDeliveryInfo.initEvent('chkDeliveryInfo', true, true);
            }
            document.getElementById('root2').dispatchEvent(evtChkDeliveryInfo);
             */
            var handleChangeAddrSubAdd = document.getElementById('addressSubAdd');
            handleChangeAddrSubAdd.addEventListener("click", function(event) {
                document.body.scrollTop = currentScroll;
                subAddressLayer('finish');
            });
            var handleBackAddrSub = document.getElementById('btnAddressSubBack');
            handleBackAddrSub.addEventListener("click", function(event) {
                event.preventDefault();
                document.body.scrollTop = currentScroll;
                subAddressLayer('off');
            });
        },
        onresize: function(size) {
            element_wrap.style.height = size.height + 'px';
        },
        width: '100%',
        height: '100%'
    }).embed(element_wrap, {
        q: '',
        autoClose: false
    });
    element_wrap_parent.style.display = 'block';
}

</script>
</body>
</html>