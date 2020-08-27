<%@page import="shop.order.model.CouponDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.goods.model.GoodsCartListDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
	
	Map<String, String[]> map = request.getParameterMap();
	Set<String> set = map.keySet();
	Iterator<String> ir = set.iterator();

	while(ir.hasNext()){
		String key = ir.next();
		for(int i=0; i<map.get(key).length; i++){
			pageContext.setAttribute(key, map.get(key));
		}
	}
	pageContext.setAttribute("length", request.getParameterValues("goods_no").length);
		
	
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

<script type="text/javascript">
history.back = function() {
    var step = (document.location.protocol == 'https:' ? 2 : 1) * -1;
    history.go( step );
}
</script>

<!-- 마켓컬리 아이콘이미지들 -->
<link rel="icon" type="image/png" sizes="32x32" href="https://res.kurly.com/images/marketkurly/logo/ico_32.png">
<link rel="icon" type="image/png" sizes="192x192" href="https://res.kurly.com/images/marketkurly/logo/ico_192.png">
<link rel="icon" type="image/png" sizes="16x16" href="https://res.kurly.com/images/marketkurly/logo/ico_16.png">

<!-- 외부 css파일 -->
<link rel="styleSheet" href="../data/skin/designgj/normalize.css?ver=1.14.7">
<link rel="styleSheet" href="../data/skin/designgj/section1.css?ver=1.14.7">
<link rel="styleSheet" href="../data/skin/designgj/common.css?ver=1.14.7">


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

<script>
$(function(){
	orderAddressLoad();

    $("#paper_delivery2").text(comma($("#paper_delivery").text())+" 원");
    $("#special_discount_amount").text(comma($("#paper_sale").text()));
	calcu_settle();
	
	// 알림메세지 닫기나 확인 누르면 닫힘
	$(".ask-alert-close-button, .styled-button").on("click", function(){
		$(this).closest(".ask-layer-wrapper").css("display", "none");		
	});
	
	// 배송지 입력 또는 변경 버튼 눌렀을 때
	$(document).on("click", "#btnUpdateAddress", function(){
		var win = window.open('order_address.do', '_blank', 'width=440, height=700');
		win.onbeforeunload = function(){
			$(".order_address").load(location + " .order_address");
			orderAddressLoad();
		};
	});
	
	function orderAddressLoad(){
		var div = $(".order_address .section_full");
		// 선택된 배송지가 있으면 선택된 배송지 출력
		if($("#addressBookNo").val()!=''){
			$.ajax({
				url: "order_address_select.jsp"
				, type: "get"
				, cache: false
				, data: "delivery_code="+$("#addressBookNo").val()
				, dataType: "json"
				, success: function(data){
					var badge = $("#addrBadge");
					badge.text(data.delivery_type);
					$("#deliPoli").val(data.delivery_type);
					if(data.delivery_type=='샛별배송') badge.removeClass("regular").addClass("star");
					else if(data.delivery_type=='택배배송') badge.removeClass("star").addClass("regular");
					if(data.is_basic==1) badge.next().addClass("default").text("기본배송지");
					else badge.next().removeClass("default").empty();
					$("#addrInfo").text(data.address);
					$("#receiverInfo").text(data.receiver + ", " + data.receiver_tel);
				}
				, error: function(request, status, error){
					alert("배송지 선택에 실패했습니다.");
				}
			});
		}else if($("#basicDeliveryNo").val()!=''){	// 기본배송지가 있으면 기본배송지 출력
			$.ajax({
				url: "order_address_select.jsp"
				, type: "get"
				, cache: false
				, data: "delivery_code="+$("#basicDeliveryNo").val()
				, dataType: "json"
				, success: function(data){
					var badge = $("#addrBadge");
					badge.text(data.delivery_type);
					$("#deliPoli").val(data.delivery_type);
					if(data.delivery_type=='샛별배송') badge.removeClass("regular").addClass("star");
					else if(data.delivery_type=='택배배송') badge.removeClass("star").addClass("regular");
					if(data.is_basic==1) badge.next().addClass("default").text("기본배송지");
					else badge.next().removeClass("default").empty();
					$("#addrInfo").text(data.address);
					$("#addressBookNo").val($("#basicDeliveryNo").val());
					$("#receiverInfo").text(data.receiver + ", " + data.receiver_tel);
				}
				, error: function(request, status, error){
					alert("배송지 선택에 실패했습니다.");
				}
			});
		}else{	// 배송지가 아예 없으면 no_address 
			$(".section_full").empty();
			div.append('<span class="no_address" id="noAddress">배송지를 입력해주세요</span>');
			div.append('<button type="button" id="btnUpdateAddress" class="btn active">입력</button>');
		}
	}
	
	function deliveryInfoSuccess(data){
		$("#addrBadge").text(data.delivery_type);
		if(data.delivery_type=='샛별배송') {
			$("#addrBadge").addClass("star");
			$("#deliPoli").val('샛별배송');
		}
		else if(data.delivery_type=='택배배송') {
			$("#addrBadge").addClass("regular");
			$("#deliPoli").val('택배배송');
		}
		if(data.is_basic==1) $("#addrBadge").after('<span class="badge default">기본배송지</span>');
		$("#addrInfo").text(data.address);
		$("#receiverInfo").text(data.receiver + ", " + data.receiver_tel);
	}
	
	// 샛별배송 종이포장 안내 
	$("#bnrOrder").on("click", function(event) {
		event.preventDefault();
		$(".view_layer").show();
		$(".bg_dim").show();
		$(".layer_agree").show();
		$(".view_layer button").on("click", function() {
			$(".layer_agree").hide();
			$(".view_layer").hide();
			$(".bg_dim").hide();
		});
	});
	
	// 개인정보 수집/이용 동의 약관확인 
	$(".link_terms").on("click", function(event) {
		event.preventDefault();
		$(".view_terms").show();
		$(".bg_dim").show();
		$(".layer_agree").show();
		$(".view_layer").hide();
		$(".view_terms button").on("click", function() {
			$(".view_terms").hide();
			$(".layer_agree").hide();
			$(".bg_dim").hide();
		});
	});
	
	// 카드결제 선택 시 선택한 카드 이름 고정되도록
	$("select.list").on("change", function() {
		var select = $(this).children(":selected").text();
		$(this).prev().text(select);
	});

	// 결제종류 라디오버튼 선택
	$(".label_radio").has("[name=settlekind]").on("click", function() {
		$(".label_radio").has("[name=settlekind]").removeClass("checked");
		$(this).addClass("checked");
		$("[name=settlekind_option]").val($(this).find('input').val());
		if($(this).find('input').val()=='1'){
			$(".card_detail").show();
		}else{
			$(".card_detail").hide();			
		}
	});
	$(".label_radio").has("[name=undeliver_way]").on("click", function() {
		$(".label_radio").has("[name=undeliver_way]").removeClass("checked");
		$(this).addClass("checked");
	});
	
	// 개인정보 수집/제공 동의 체크박스 
	$(".label_check input").on("click", function() {
		$(this).parent("label").toggleClass("checked");
	});

	 // 결제금액 박스 스크롤 따라 움직이기
	 var $obj_sticky = $('#sticky');
	    var $stickyLimit = parseInt($('.data_method').height()+$('.data_payment').height() - $obj_sticky.height());
	    $(window).on('load scroll', function(){
	      var $scrollTop = parseInt($(this).scrollTop());
	      var $checkTop = parseInt($('.data_payment').offset().top);
	      if($checkTop < $scrollTop){
	        $obj_sticky.css({top:$scrollTop - $checkTop});
	        if($stickyLimit < parseInt($obj_sticky.css('top'))){
	          $obj_sticky.css({top:$stickyLimit});
	        }
	      }else if($scrollTop < $checkTop){
	        $obj_sticky.css({top:0});
	      }
	    });
	
	// 주문상품 상세보기 누르면 상품 정보 출력
	$(".btn_show").on("click", function() {
		$(".show_tbl").hide();
		$("#orderGoodsList").show();
	});
	
	// 쿠폰종류 셀렉트박스
	$("#popselboxView").on("click", function() {
		$("#popSelbox").toggle();
	});
	
	// 사용할 수 없는 쿠폰
	$(".coupon_na").each(function(i, element) {
		$(this).parent().next(".item_td").children("span").each(function() {
			$(this).addClass("coupon_na");
		});
	});
	
	// 쿠폰 선택했을 때
	$("#addpopSelList li").on("click", function() {
		// 쿠폰 셀렉트박스 숨기기
		$("#popSelbox").hide();
		// 선택된 쿠폰 외 다른 li 태그에 checked 클래스 삭제, 선택된 쿠폰에 checked 추가 
		$("#addpopSelList li").removeClass("checked");
		$(this).addClass("checked");
		// 셀렉트박스에 선택한 쿠폰 이름으로 고정
		$("#popselboxView").text($(this).find(".txt_tit").text());
		// input 히든태그에 쿠폰 금액 설정
		var c_price = $(this).find(".txt_apr").text()==''? 0:uncomma($(this).find(".txt_apr").text());
		var coupon_price = $("input[name=coupon]").val(c_price);
		$("#apr_coupon_data").text(comma(coupon_price.val()) + " 원");
		// 선택한 쿠폰 코드 히든태그에 설정
		$("input[name=couponCode]").val($("#selectCoupon").val());
		
		calcu_settle();
	});
	
     // 적립금 모두사용 체크박스 클릭했을 때
	 $(".emoney_chkbox input").on('click', function(e) {
	      e.preventDefault();
	      if($(this).parent().hasClass('disabled')) return false;
	      if($(this).parent().hasClass('checked')){
	        var all_emoney =  $("[name=checkEmoney]").val();
	        $("#emoney").val(all_emoney);
	      }else{
	        $("#emoney").val(0);
	      }
	        chk_emoney($("#emoney"));
	        calcu_settle();
	    });
     
     // 결제하기 클릭했을 때
	//$("#form").on("submit", function(e){
	$(".btn_payment").on("click", function(){
   		// 결제 진행 필수 동의 체크 안 했을 때
	   	if(!$(".reg_agree .inp_check.label_check").hasClass("checked")){
	    	$(".ask-layer-wrapper").show();
			$(".ask-alert-message").text("결제를 진행을 위해 결제 진행 필수 동의에 체크해주세요.");
			return false;
	   	}
   		// 주문자정보 테이블에 주문자정보 insert
   		var user_no = '';
   		var id='${ member.m_id }';
   		var w1 = $.ajax({
				url: "order_user_in.jsp"
				, type: "get"
				, cache: false
				, data: {
					name:$("input[name=nameOrder]").val(), 
					tel:$("input[name=mobileOrder]").val(), 
					email:$("input[name=email]").val(), 
					m_id:id
				}
				, dataType: "json"
				, success: function(data){
					user_no = data.user_no;
					$("[name=user_no]").val(data.user_no);
				}
				, error: function(request, status, error){
					alert("order_user_insert error");
				}
			});
   		// 결제정보 테이블에 결제정보 insert
   		var pay_code = '';
   		var w2 = $.ajax({
				url: "order_pay_in.jsp"
				, type: "get"
				, cache: false
				, data: {
					pay_amount: $("[name=settlement_price]").val(),
					del_fee: uncomma($("#paper_delivery").text()),
					use_point: $("[name=usePoint]").val(),
					use_coupon: $("[name=coupon]").val(),
					add_point: uncomma($("#expectAmount").text()),
					discount: uncomma($("#special_discount_amount").text()),
					payment_no: $("[name=settlekind_option]").val()
					}
				, dataType: "json"
				, success: function(data){
					pay_code = data.pay_code;
					$("[name=pay_code]").val(data.pay_code);
				}
				, error: function(request, status, error){
					alert("order_pay_insert error");
				}
			});
   		
   		$.when(w1).done(function(data){
   			$.when(w2).done(function(data){
   		   		// 그 후 submit 
   		   		$("#form").submit();
   			});
   		});
     });
     
});

function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}


function cutting(emoney)
{
  var chk_emoney = new String(emoney);
  reg = /()$/g;
  if (emoney && !chk_emoney.match(reg)){
    emoney = Math.floor(emoney/1) * 1;
  }
  $('.number_only').on("keyup", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") )});
  return emoney;
}
function chk_emoney(obj)
{
  var form = document.frmOrder;
  var my_emoney = $("[name=checkEmoney]").val();
  var max = '0';
  var min = '0';
  var hold = '0';
  var limit = '';

  var delivery	= uncomma(document.getElementById('paper_delivery').innerHTML);
  var goodsprice = uncomma(document.getElementById('paper_goodsprice').innerHTML);
  var erangeprice = goodsprice + delivery;			//  상품금액 + 배송비

  // 상품할인금액
  var special_discount_amount= ($('#special_discount_amount')) ? uncomma($('#special_discount_amount').text()) : 0;
  // 최대할인금액 = 상품금액+배송비 - 쿠폰금액 - 상품할인금액
  var max_base = erangeprice - uncomma(document.getElementsByName('coupon')[0].value) - special_discount_amount;
  max_base		= max_base > 0 ? max_base : 0;
  var coupon = coupon_emoney = 0;
  if( form.coupon ){
    coupon = uncomma(form.coupon.value);
  }
  if( form.coupon_emoney ){
    coupon_emoney = uncomma(form.coupon_emoney.value);
  }
  /* 
  max = getDcprice(max_base,max,1);
  min = parseInt(min);

  if (max > max_base)  max = max_base;
  if( $('#print_emoney_max') && $('#print_emoney_max').innerHTML != comma(max)  )
	  $('#print_emoney_max').innerHTML = comma(max);
 */
// 사용하려는 적립금 금액이 가지고 있는 적립금보다 많으면 사용하려는 적립금을 가지고 있는 적립금 만큼으로 바꾸기 
  var emoney = uncomma(obj.value);
  if (emoney>my_emoney){
    if(my_emoney < 0){
      emoney = 0;
    }else{	
      emoney = my_emoney;
    }
  }

  obj.value = comma(cutting(emoney));
  calcu_settle();
}
	// 결제금액 계산
  function calcu_settle()
  {
	  var my_emoney = $("[name=checkEmoney]").val();
    var dc=0;		// 쿠폰 사용 금액 + 적립금 사용 금액
    var special_discount_amount = $('#special_discount_amount')? parseInt(uncomma($('#special_discount_amount').text())) : 0;
    var coupon = 0;
    var goodsprice	= parseInt(uncomma(document.getElementById('paper_goodsprice').innerHTML));
    var delivery	= parseInt(uncomma(document.getElementById('paper_delivery').innerHTML));
    var emoney = (document.frmOrder.emoney) ? parseInt(uncomma(document.frmOrder.emoney.value)) : 0;
    
    if (document.frmOrder.coupon){
      // 적립금 + 무료배송쿠폰처리
      // 쿠폰 사용 금액
      coupon =  parseInt($('input[name=coupon]').val());
      // 쿠폰 사용 금액이 결제하려는 금액보다 크면 쿠폰금액은 결제금액
      if (coupon >= (goodsprice + delivery - dc - special_discount_amount)) 
    	  coupon = goodsprice + delivery - dc - special_discount_amount;

      // 무료배송쿠폰이 있으면 무료배송쿠폰 금액은 쿠폰 사용 금액
      var freeDeliveryCoupon = 0;
      if($('[name=free_delivery]').val() === '1') freeDeliveryCoupon = coupon;

      // 총 결제금액..계산
      if (goodsprice + delivery - dc - coupon - special_discount_amount - emoney + freeDeliveryCoupon < 0){
        emoney = goodsprice + delivery - dc - coupon - special_discount_amount + freeDeliveryCoupon;
        document.frmOrder.emoney.value = comma(cutting(emoney));
      }
      // 할인금액은 쿠폰 사용 금액 + 적립금 사용 금액
      dc = coupon + emoney;
      // end
    }
    if(document.frmOrder.free_delivery.value == 1) {
      dc -= delivery_default; // 배송비 무료쿠폰 사용시 그 금액을 제거함.
      if(dc < 0) dc = 0;
    }
    // 총 결제금액 = 상품금액 + 배송비 - 할인금액 - 상품할인금액
    var settlement = (goodsprice + delivery - dc - special_discount_amount);
    // 총 할인금액 = 할인금액(쿠폰+적립금) + 상품할인금액
    var saleAll = (dc + special_discount_amount);
		
        document.frmOrder.settlement_price.value = settlement;
        $("#paper_settlement").text(comma(settlement));

        //  settlement 값이 바뀔때마다 업데이트됨 + 약관노출.
        $('#pgTerms').hide();
        if(settlement != 0){
          $('[name=settlekind]').each(function(){
            if($(this).is(':checked')){
              if($(this).val() === 'c'){
                $('#pgTerms').show();
              }
            }
          });
        }
 		// 적립금 사용 금액 출력
        if(uncomma(document.frmOrder.emoney.value) == 0){
          $('#paper_reserves').text(comma(document.frmOrder.emoney.value)+' 원');
        }else if(uncomma(document.frmOrder.emoney.value) > 0){
          $('#paper_reserves').text('- '+comma(document.frmOrder.emoney.value)+' 원');
        }
        $('input[name=usePoint]').val(uncomma(document.frmOrder.emoney.value));
		
 		// 원래 가격 = 결제 금액 + 적립금 금액
        var origin_settlement = settlement + uncomma(document.frmOrder.emoney.value);
 		// 사용할 적립금이 음수거나 가지고 있는 적립금이 없을때
        if(emoney <= 0 || !my_emoney){
        $('.emoney_chkbox').removeClass('checked');
      }
        // 적립금 사용 금액 입력하고 포커스 해제될 때 
        $(document.frmOrder.emoney).on('blur', function () {
       		// 사용하려는 적립금 금액이 구매금액보다 크면 모두적용 체크박스 선택
          if(uncomma(document.frmOrder.emoney.value) >= (origin_settlement)){
            $('.emoney_chkbox').addClass('checked');
          }else{
        	 // 구매금액보다 사용하려는 적립금 금액이 작으면서, 사용하려는 적립금액과 보유중인 적립금액이 같으면 모두적용 체크박스 선택 아니면 선택해제
            if(origin_settlement >= uncomma(document.frmOrder.emoney.value) &&  uncomma(document.frmOrder.emoney.value) == my_emoney){
              $('.emoney_chkbox').addClass('checked');
            }else{
              $('.emoney_chkbox').removeClass('checked');
            }
          }
        });

        // 배송비
        if(delivery == 0){
          $('.delivery_area .pm_sign').hide();
          if($('#paper_delivery2').css('display') != 'none'){
            if(parseInt($('#paper_delivery2').text()) != 0){
              $('.delivery_area .pm_sign').show();
            }
          }
        }else{
          $('.delivery_area .pm_sign').show();
        }
        // 쿠폰
        if(coupon == 0){
          $('.coupon_area .pm_sign').hide();
        }else{
          $('.coupon_area .pm_sign').show();
        }
        // 상품할인
        if(special_discount_amount == 0){
          $('.sales_area .pm_sign').hide();
        }else{
          $('.sales_area .pm_sign').show();
        }

        // 등급별 적립율
        var percent = $("#point_percent").val();
        $("#expectAmount").text(Math.round(settlement * percent));
        $("input[name=add_point]").val(Math.round(settlement * percent));
      }

</script>

<style type="text/css">
#gnb.gnb_stop {
	position: static
}
/* 기존에 있던 style */
/* 쿠폰적용 */
.order-disc-tbl.coupon_area>tbody>tr>th {
	position: relative;
	padding: 0;
	text-align: left
}

.order-disc-tbl.coupon_area>tbody>tr>th:after {
	content: ":";
	display: inline-block;
	position: absolute;
	top:;
	right: 26px;
	vertical-align: middle
}

.order-disc-tbl.coupon_area>tbody>tr>td {
	padding: 0
}

.order-disc-tbl.coupon_area {
	margin: 10px 0 8px 0
}

.order-disc-tbl.coupon_area td input[type="text"] {
	vertical-align: middle
}

.coupon_search {
	overflow: hidden;
	width: 100%
}

.coupon_search .btn_coupon {
	float: left;
	margin-right: 8px
}
/* 개인정보수집및제공 */
.reg_agree .check .inp_check {
	display: block;
	overflow: hidden;
	padding: 0 5px 4px
}

.reg_agree .inp_check input {
	float: left;
	margin: 4px 0 0
}

.reg_agree .inp_check .txt_checkbox {
	float: left;
	padding-left: 4px;
	font-size: 12px;
	color: #202020
}

.reg_agree .desc {
	overflow: auto;
	height: 110px;
	padding: 20px;
	margin-bottom: 10px;
	background-color: #fff;
	border: 1px solid #bfbfbf;
	line-height: 20px
}

/* 주문서_공통 */
.user_form * {
	font-family: 'Noto Sans';
	font-weight: 400;
	color: #000;
	letter-spacing: -0.3px
}

.user_form .bhs_button.action {
	color: #fff
}

.user_form .bhs_button.action:hover {
	background-color: #56297a
}

.user_form .bhs_button.yb2 {
	color: #795b8f
}

.user_form .bhs_button.yb2:hover {
	background-color: #56297a;
	color: #fff
}

#popselboxView, .user_form input[type="text"] {
	height: 33px;
	padding: 0 8px;
	border: 1px solid #ddd;
	background-color: #fff;
	font-size: 12px;
	line-height: 33px;
	color: #000;
	letter-spacing: -0.2px;
	vertical-align: top
}

.user_form input[type="radio"], .user_form input[type="checkbox"] {
	position: relative;
	z-index: -1;
	vertical-align: 0
}

.user_form .bar {
	display: inline-block;
	position: relative;
	width: 13px;
	height: 33px;
	vertical-align: top
}

.user_form .bar span {
	position: absolute;
	left: 3px;
	top: 17px;
	width: 8px;
	height: 1px;
	background-color: #d8d8d8
}

.user_form .txt_guide .txt {
	display: block;
	font-size: 12px;
	line-height: 21px;
	color: #514859
}
/* 공통_라디오버튼 */
.user_form .label_radio {
	display: inline-block;
	padding: 0 18px 0 6px;
	background: #fff
		url(https://res.kurly.com/pc/service/order/1908/ico_radio_off.png)
		no-repeat 0 1px;
	font-size: 14px;
	color: #000;
	line-height: 18px;
	cursor: pointer;
	white-space: nowrap
}

.user_form .label_radio.checked {
	background: #fff
		url(https://res.kurly.com/pc/service/order/1908/ico_radio_on.png)
		no-repeat 0 1px
}

.user_form .label_radio.disabled {
	background: #fff
		url(https://res.kurly.com/pc/service/order/1908/ico_radio_disabled.png)
		no-repeat 0 1px
}

.user_form .label_radio .info {
	display: none;
	color: #666;
	font-size: 12px;
	line-height: 18px;
	width: 543px;
	margin: 11px 0 0 16px;
	white-space: normal
}

.user_form .label_radio .bubble {
	margin-left: 7px
}

.user_form .label_radio.checked .info {
	display: block;
}

@media only screen and (-webkit-min-device-pixel-ratio: 1.5) , only screen and
		(min-device-pixel-ratio: 1.5) , only screen and (min-resolution:
	1.5dppx) {
	.user_form .label_radio {
		background: #fff
			url(https://res.kurly.com/pc/service/order/1908/ico_radio_off_x2.png)
			no-repeat 0 1px;
		background-size: 16px 17px
	}
	.user_form .label_radio.checked {
		background: #fff
			url(https://res.kurly.com/pc/service/order/1908/ico_radio_on_x2.png)
			no-repeat 0 1px;
		background-size: 16px 17px
	}
	.user_form .label_radio.disabled {
		background: #fff
			url(https://res.kurly.com/pc/service/order/1908/ico_radio_disabled_x2.png)
			no-repeat 0 1px;
		background-size: 16px 17px
	}
}
/* 공통_테이블 */
.goodsinfo_table {
	border-top: 1px solid #333;
	border-bottom: 1px solid #ddd
}

.goodsinfo_table th {
	width: 190px;
	padding: 22px 0 0 20px;
	font-size: 14px;
	font-family: 'Noto Sans';
	font-weight: 700;
	vertical-align: top
}

.goodsinfo_table .fst th {
	padding-top: 26px
}

.goodsinfo_table td {
	position: relative;
	padding: 16px 0 0 0;
	vertical-align: top
}

.goodsinfo_table .fst td {
	padding-top: 20px
}

/* 레이어타입_리스트타입 */
.layer_typelist {
	display: none;
	position: absolute;
	left: 0;
	top: 32px;
	width: 600px;
	background-color: #fff;
	border: 1px solid #949296
}

.layer_typelist li {
	padding: 9px 30px 9px 37px;
	border-top: 1px solid #949296;
	font-size: 12px;
	line-height: 18px;
	letter-spacing: -0.2px
}

.layer_typelist li.fst {
	border-top: 0 none
}

.layer_typelist li.checked {
	background:
		url(https://res.kurly.com/pc/service/order/1908/ico_check_16x10.png)
		no-repeat 10px 16px
}

.layer_typelist li:hover {
	background-color: #fafafa;
	cursor: pointer
}

.layer_typelist span {
	display: none
}

.layer_coupon {
	display: none;
	position: absolute;
	z-index: 1;
	left: 8px;
	top: 54px;
	width: 546px;
	background-color: #fff;
	border: 1px solid #949296
}

.layer_coupon li {
	padding: 14px 30px 14px 37px;
	border-top: 1px solid #949296;
	font-size: 12px;
	line-height: 18px;
	letter-spacing: -0.2px
}

.layer_coupon li.fst {
	border-top: 0 none
}

.layer_coupon li.checked {
	background:
		url(https://res.kurly.com/pc/service/order/1908/ico_check_16x10.png)
		no-repeat 10px 16px
}

.layer_coupon li:hover {
	background-color: #fafafa;
	cursor: pointer
}

@media only screen and (-webkit-min-device-pixel-ratio: 1.5) , only screen and
		(min-device-pixel-ratio: 1.5) , only screen and (min-resolution:
	1.5dppx) {
	.layer_typelist li.checked {
		background:
			url(https://res.kurly.com/pc/service/order/1908/ico_check_32x20.png)
			no-repeat 10px 16px;
		background-size: 16px 10px
	}
	.layer_coupon li.checked {
		background:
			url(https://res.kurly.com/pc/service/order/1908/ico_check_32x20.png)
			no-repeat 10px 16px;
		background-size: 16px 10px
	}
}

/* 주문자정보 */
.data_orderer {
	border-bottom: 1px solid #ddd
}

.data_orderer .txt_guide {
	padding: 13px 0 19px
}

.data_orderer .goodsinfo_table.tbl_readonly th {
	padding-top: 10px
}

.data_orderer .goodsinfo_table.tbl_readonly .fst th {
	padding-top: 26px
}

.data_orderer .goodsinfo_table.tbl_readonly td {
	padding-top: 4px
}

.data_orderer .goodsinfo_table.tbl_readonly .fst td {
	padding-top: 20px
}

.data_orderer input[type="text"].read_only {
	padding: 0;
	border: 0 none;
	font-size: 14px
}

/* 결제금액 */
.data_payment {
	float: left
}

.data_payment .goodsinfo_table {
	border-bottom: 0 none
}

.data_payment th.coupon_set {
	width: 180px;
	padding-top: 22px
}

.data_payment td.coupon_set {
	padding-top: 22px
}

.data_payment .txt_couponinfo {
	padding: 4px 0 0 1px;
	color: #f00
}

.data_payment .coupon_search .btn_inquire {
	float: left;
	padding: 12px 0 0 6px
}

.tbl_left {
	float: left;
	width: 742px
}

/* 결제수단 */
.data_method {
	clear: both
}

.data_method .goodsinfo_table td {
	padding-top: 23px
}

.data_method .goodsinfo_table .txt_notice {
	padding: 42px 0 0 16px
}

.data_method td img {
	vertical-align: middle
}

.data_method .txt_notice {
	padding-left: 20px;
	color: #4c4c4c
}

.data_method .tbl_nogoods {
	border-top: 0 none;
	border-bottom: 0 none
}

.data_method input[type="radio"] {
	margin-right: 3px
}

/* 주문서 & 쿠폰 */
#addpopSelList .txt_apr, #addpopSelList .txt_is_dc {
	display: inline-block;
	font-weight: 700;
	font-size: 14px;
	line-height: 1.43px;
	color: #000
}

#addpopSelList .txt_apr.coupon_na, #addpopSelList .txt_is_dc.coupon_na,
	#addpopSelList .txt_tit.coupon_na, #addpopSelList .txt_desc.coupon_na,
	#addpopSelList .txt_expire.coupon_na {
	color: #777
}

#addpopSelList .inner_item {
	display: table;
	font-size: 14px
}

#addpopSelList .item_row {
	display: table-row
}

#addpopSelList .item_td.left {
	display: table-cell;
	width: 110px
}

#addpopSelList .item_td {
	display: table-cell
}

#addpopSelList .txt_tit {
	padding-bottom: 6px;
	font-weight: 700
}

#addpopSelList .txt_desc, #addpopSelList .txt_expire {
	font-size: 12px
}

#addpopSelList span {
	display: block
}

#addpopSelList .inner_item . disabled {
	color: #777
}

.coupon_set .txt_ques a {
	display: inline-block;
	margin: 5px 0;
	font-size: 12px;
	color: #795b8f
}

.order-disc-tbl.coupon_area .emoney_td_l {
	width: 188px
}

.order-disc-tbl.coupon_area .emoney_td_l input[type="text"] {
	width: 162px;
	margin-bottom: 4px;
	border: 1px solid #ddd
}

.order-disc-tbl.coupon_area .emoney_td_r {
	padding: 6px;
	font-size: 12px
}

.order-disc-tbl.coupon_area .emoney_noti {
	padding-top: 10px
}

.order-disc-tbl.coupon_area .emoney_noti .txt {
	display: block;
	padding-top: 4px;
	font-size: 12px;
	color: #514859;
	line-height: 18px;
	letter-spacing: -0.2px
}

.order-disc-tbl.coupon_area .no_emoney {
	padding-top: 4px
}

.emoney_chkbox .txt_checkbox {
	font-size: 12px
}

#emoney {
	text-align: right;
	line-height: 0
}

#memberdc {
	display: inline-block
}

.goodsinfo_table .txt_notice li {
	color: #514859
}

.goodsinfo_table .txt_notice li a {
	color: #5f0080
}

#popselboxView {
	display: none;
	width: 100%;
	margin-bottom: 4px;
	background:
		url(https://res.kurly.com/pc/service/order/1711/ico_selectbox_arrow_10x6.png)
		no-repeat 525px 50%;
	cursor: pointer
}

#popselboxView.no_bg {
	background: none;
	cursor: default
}

.pm_sign {
	display: none;
	margin-right: 4px
}

/* 2018-06-19 개인정보처리방침 추가시작 */
.user_form .txt_guide .txt .txt_desc {
	font-weight: 500
}

.user_form .bhs_button.btn_payment {
	width: 200px;
	height: 48px;
	background-color: #5f0080
}

.user_form .bhs_button.action:hover.btn_payment {
	background-color: #401661
}

.user_form .goodsinfo_table {
	border-bottom: 0 none
}

.user_form .goodsinfo_table .check:after {
	content: "";
	display: block;
	clear: both
}

.user_form .goodsinfo_table .check .inp_check {
	float: left;
	padding: 0 5px 6px
}

.user_form .reg_agree {
	position: static
}

.user_form .reg_agree .inp_check .txt_checkbox {
	padding-left: 6px;
	font-size: 14px;
	color: #000;
	line-height: 18px;
	letter-spacing: 0
}

.user_form .goodsinfo_table .reg_agree {
	padding: 16px 20px 8px
}

.user_form .link_terms {
	float: left;
	color: #5f0080
}
/* 팝업 */
.user_form .goodsinfo_table .inner_layer {
	position: relative;
	width: 100%;
	padding: 0 0 30px 0;
	border-radius: 6px;
	box-shadow: none
}

.user_form .goodsinfo_table .inner_layer .tit_layer, .user_form .goodsinfo_table .inner_layer button
	{
	display: none
}

.user_form .goodsinfo_table .layer {
	position: relative;
	z-index: 9999
}

.user_form .goodsinfo_table .layer .choice_agree {
	position: fixed;
	left: 50%;
	top: 50%;
	width: 440px;
	margin: 0 0 0 -220px;
	border-radius: 6px;
	background-color: #fff
}
/*.user_form .goodsinfo_table .layer .view_terms{height:500px}*/
/*.user_form .goodsinfo_table .layer .view_pg{height:512px}*/
.user_form .goodsinfo_table .layer .view_pg .box_tbl {
	height: 272px
}

.user_form .goodsinfo_table .layer .tit_layer {
	display: block;
	height: 132px;
	font-size: 30px;
	font-weight: 700;
	padding: 30px 88px 0 30px;
	line-height: 40px;
	color: #333
}

.user_form .goodsinfo_table .layer .box_tbl {
	overflow: hidden;
	overflow-y: auto;
	padding: 0 30px;
	color: #333
}

.user_form .goodsinfo_table .layer button {
	display: block
}

.user_form .goodsinfo_table .layer .box_tbl th {
	padding: 5px;
	background-color: #f7f5f8;
	border: 1px solid #dddfe1;
	text-align: center
}

.user_form .goodsinfo_table .layer .box_tbl thead th {
	border-bottom: 0 none;
	vertical-align: middle
}

.user_form .goodsinfo_table .layer .box_tbl td {
	padding: 5px
}

.user_form .goodsinfo_table .layer .txt_service {
	color: #333;
	padding: 0 30px
}

.user_form .goodsinfo_table .layer .btn_ok {
	display: block;
	width: 380px;
	height: 54px;
	margin: 30px auto 0;
	border: 0 none;
	background-color: #5f0080;
	font-size: 16px;
	color: #fff;
	line-height: 32px;
	letter-spacing: -0.3px;
	border-radius: 3px
}

.user_form .goodsinfo_table .layer .btn_close {
	position: absolute;
	right: 26px;
	top: 36px;
	width: 32px;
	height: 32px;
	border: 0 none;
	background: url(https://res.kurly.com/pc/ico/1908/ico_layer_close.png)
		no-repeat 0 0
}

.user_form .goodsinfo_table .list_agree {
	overflow: hidden;
	width: 100%;
	clear: both
}

.user_form .goodsinfo_table .list_agree li {
	padding-top: 1px
}

.user_form .goodsinfo_table .list_agree .subject {
	padding: 0 10px 0 24px;
	font-size: 12px;
	color: #000;
	line-height: 16px;
	letter-spacing: 0
}

.user_form .goodsinfo_table .list_agree .subject .emph {
	color: #949296
}

.user_form .goodsinfo_table .list_agree .link_terms {
	float: none;
	padding-right: 11px;
	background:
		url(https://res.kurly.com/pc/service/order/1906/ico_arrow_6x9.png)
		no-repeat 100% 50%
}

.user_form .goodsinfo_table .terms_view {
	margin-top: 20px;
	font-size: 14px;
	color: #514859;
	line-height: 20px
}

.user_form .goodsinfo_table .terms_view .tit_main {
	font-weight: 700;
	font-size: 18px
}

.user_form .goodsinfo_table .terms_view .tit_sub {
	display: block;
	padding: 20px 0 10px
}

.user_form .goodsinfo_table .terms_view .normal {
	font-weight: normal
}

.user_form .goodsinfo_table .terms_view:last-child .tit_sub {
	font-weight: normal
}

.user_form .goodsinfo_table .terms_view:last-child .tit_sub.emph {
	font-weight: bold
}
/* 2018-06-19 개인정보처리방침 추가끝 */

/* 신용카드카드선택 */
.data_method .card_detail td {
	padding-top: 11px
}

#cardSelect .card_select:after {
	content: "";
	display: block;
	overflow: hidden;
	height: 0;
	clear: both
}

#cardSelect .select_box {
	position: relative;
	float: left;
	width: 200px
}

#cardSelect .select_box .tit {
	display: block;
	overflow: hidden;
	width: 190px;
	height: 34px;
	padding: 0 30px 0 9px;
	border: 1px solid #514859;
	background: #fff
		url(https://res.kurly.com/pc/service/order/1711/ico_selectbox_arrow_10x6_active.png)
		no-repeat 170px 50%;
	font-weight: 400;
	font-size: 12px;
	color: #000;
	line-height: 30px;
	letter-spacing: -0.2px
}

#cardSelect .select_box .tit.off {
	border: 1px solid #ddd;
	background: #f8f8f8
		url(https://res.kurly.com/pc/service/order/1711/ico_selectbox_arrow_10x6.png)
		no-repeat 170px 50%;
	color: #949296
}

#cardSelect .select_box .list {
	position: absolute;
	left: 0;
	top: 0;
	width: 190px;
	height: 34px;
	opacity: 0
}

#cardSelect .card_point {
	padding-top: 12px
}

#cardSelect .card_event {
	padding-top: 11px;
	font-weight: bold;
	font-size: 12px;
	color: #514859;
	line-height: 22px;
	letter-spacing: -0.2px
}

#cardSelect .notice {
	padding-top: 11px;
	font-size: 12px;
	color: #514859;
	line-height: 22px;
	letter-spacing: -0.2px
}

#cardSelect .notice.up_event {
	padding-top: 4px
}

#cardSelect .notice .emph {
	padding-right: 9px;
	font-weight: 700
}

#settlekindCard {
	padding-right: 48px
}

@media only screen and (-webkit-min-device-pixel-ratio: 1.5) , only screen and
		(min-device-pixel-ratio: 1.5) , only screen and (min-resolution:
	1.5dppx) {
	#cardSelect .select_box .tit {
		background-image:
			url(https://res.kurly.com/pc/service/order/1711/ico_selectbox_arrow_10x6_x2_active.png);
		background-size: 10px 6px
	}
	#cardSelect .select_box .tit.off {
		background-image:
			url(https://res.kurly.com/pc/service/order/1711/ico_selectbox_arrow_10x6_x2.png);
		background-size: 10px 6px
	}
	.user_form .goodsinfo_table .list_agree .link_terms {
		background:
			url(https://res.kurly.com/pc/service/order/1906/ico_arrow_12x18.png)
			no-repeat 100% 50%;
		background-size: 6px 9px
	}
}

/* 2018-06-19 개인정보처리방침 추가끝 */
.ord_notice li {
	padding-top: 10px;
	font-size: 12px;
	color: #514859;
	line-height: 22px;
	letter-spacing: -0.23px;
	text-align: center
}

.ord_notice .emph {
	font-weight: 700
}

/* ######################  ######################  ######################  ###################### */

/* KM-1179 올페이퍼챌린지 */
.bnr_order {
	display: none;
	padding: 40px 0 0
}

.bnr_order img {
	vertical-align: top
}

.user_form .goodsinfo_table .layer .choice_agree.view_layer {
	overflow: hidden;
	height: 600px;
	margin-top: -300px
}

.in_allpaper {
	overflow: hidden;
	overflow-y: scroll;
	width: 500px;
	height: 496px
}

.in_allpaper img {
	width: 440px
}

/* 공통적용 */
.tit_section {
	padding: 60px 0 15px;
	font-weight: bold;
	font-size: 20px;
	line-height: 29px
}

.tit_section.fst {
	padding-top: 0
}

.tit_section .desc {
	padding-left: 27px;
	font-size: 14px;
	color: #666;
	vertical-align: 3px
}

.order_section {
	overflow: hidden;
	letter-spacing: -0.3px
}

.order_section .btn {
	overflow: hidden;
	height: 34px;
	padding: 6px 0 10px;
	font-weight: bold;
	font-size: 14px;
	line-height: 18px;
	text-align: center
}

.order_section .btn.normal {
	border: 1px solid #999
}

.order_section .btn.default {
	border: 1px solid #5f0080;
	background-color: #fff;
	color: #5f0080
}

.order_section .btn.active {
	border: 1px solid #5f0081;
	border-radius: 3px;
	background-color: #5f0080;
	color: #fff
}

.order_section .badge {
	display: inline-block;
	height: 22px;
	margin-right: 2px;
	padding: 0 7px 4px 6px;
	border-radius: 11px;
	background-color: #fff;
	font-weight: bold;
	font-size: 12px;
	color: #5f0080;
	line-height: 18px;
	vertical-align: top
}

.order_section .badge.default {
	border: 1px solid #f3ebf4;
	background-color: #f3ebf5
}

.order_section .badge.star {
	border: 1px solid #5f0080
}

.order_section .badge.regular {
	border: 1px solid #999;
	color: #999
}

.order_section .badge.none {
	color: #b3130b
}

.order_section .badge.none+.default {
	border: 1px solid #f2f2f1;
	background-color: #f2f2f2;
	color: #999
}

.order_section .section_crux {
	float: left;
	width: 190px;
	padding: 20px 0 0 20px;
	font-weight: bold;
	font-size: 14px;
	color: #000;
	line-height: 33px;
	letter-spacing: -0.3px
}

.order_section .section_full {
	overflow: hidden;
	padding: 26px 20px 20px 0
}

/* 배송정보_배송지 */
.order_address {
	border-top: 1px solid #333;
	border-bottom: 1px solid #ddd
}

.order_address .addr {
	display: block;
	padding-top: 10px;
	font-size: 14px;
	color: #000;
	line-height: 20px
}

.order_address .no_address {
	display: block;
	padding-top: 1px;
	font-size: 14px;
	color: #ccc;
	line-height: 20px
}

.order_address .num {
	white-space: nowrap
}

.order_address .receiving {
	display: block;
	padding-top: 6px;
	font-size: 14px;
	color: #666;
	line-height: 20px
}

.order_address .btn {
	width: 80px;
	margin-top: 20px
}
/* 배송정보_수령장소 */
.order_reception {
	border-bottom: 1px solid #ddd
}

.order_reception .no_place {
	display: block;
	padding-top: 1px;
	font-size: 14px;
	color: #ccc;
	line-height: 20px
}

.order_reception .place {
	display: block;
	font-size: 14px;
	color: #000;
	line-height: 20px
}

.order_reception .way {
	display: block;
	padding-top: 6px;
	font-size: 14px;
	color: #666;
	line-height: 20px
}

.order_reception .way span, .order_reception .place span {
	display: inline-block;
	overflow: hidden;
	max-width: 80%;
	color: #666;
	white-space: nowrap;
	text-overflow: ellipsis;
	vertical-align: top
}

.order_reception .btn {
	width: 80px;
	margin-top: 20px
}
/* 냉동상품 포장*/
.order_pack {
	display: none;
	padding-bottom: 9px;
	border-top: 0 none;
	border-bottom: 1px solid #ddd
}
/* .order_address.invalid .receiving, : KQA-1234 : 이유가 있었는데... */
.order_address.invalid .no_address, .order_reception.invalid .no_place {
	color: #b3130b
}

/* 결제금액_sticky */
.tax_absolute {
	position: relative;
	float: right;
	width: 284px;
	height: 0
}

.tax_absolute .inner_sticky {
	position: absolute;
	right: 0;
	top: 0;
	width: 100%
}

#orderitem_money_info {
	width: 100%;
	padding: 17px 17px 18px 17px;
	background: #fafafa;
	border: 2px solid #f2f2f2
}

#orderitem_money_info .amount {
	overflow: hidden;
	padding-top: 12px;
	letter-spacing: -0.5px
}

#orderitem_money_info .fst {
	padding-top: 0;
	padding-bottom: 4px
}

#orderitem_money_info .lst {
	margin: 17px 0 0 0;
	padding-top: 17px;
	border-top: 1px solid #eee
}

#orderitem_money_info .tit, #orderitem_money_info .lst .price .won,
	#orderitem_money_info .price {
	font: normal 16px/24px 'Noto Sans';
	vertical-align: top
}

#orderitem_money_info .lst .price .won {
	vertical-align: bottom
}

#orderitem_money_info .tit {
	float: left;
	width: 96px
}

#orderitem_money_info .price {
	float: right;
	width: 144px;
	text-align: right
}

#orderitem_money_info .price .emph {
	color: #5f0080
}

#orderitem_money_info .price .small {
	font-size: 12px
}

#orderitem_money_info .sub {
	padding-top: 8px
}

#orderitem_money_info .sub .tit, #orderitem_money_info .price .normal,
	#orderitem_money_info .sub .price {
	font-weight: normal;
	font-size: 14px;
	color: #999;
	line-height: 20px
}

#orderitem_money_info .sub .tit {
	padding-left: 16px;
	background:
		url(https://res.kurly.com/pc/service/common/2004/ico_sub_price_dot.png)
		no-repeat 0 0
}

#orderitem_money_info .lst .price {
	font-weight: bold;
	font-size: 22px;
	line-height: 28px
}

.tax_absolute .reserve {
	padding-top: 9px;
	font-size: 12px;
	color: #666;
	line-height: 16px;
	letter-spacing: 0;
	text-align: right
}

.tax_absolute .reserve .ico {
	display: inline-block;
	width: 30px;
	height: 18px;
	margin-right: 5px;
	border: 1px solid #e8a828;
	border-radius: 9px;
	background-color: #ffbf00;
	font-size: 10px;
	color: #fff;
	line-height: 15px;
	text-align: center;
	vertical-align: top
}

.tax_absolute .reserve .emph, .tax_absolute .reserve .emph span {
	font-weight: 700;
	color: #666
}

@media only screen and (-webkit-min-device-pixel-ratio: 1.5) , only screen and
		(min-device-pixel-ratio: 1.5) , only screen and (min-resolution:
	1.5dppx) {
	#orderitem_money_info .sub .tit {
		background:
			url(https://res.kurly.com/pc/service/common/2004/ico_sub_price_dot_x2.png)
			no-repeat 0 0;
		background-size: 16px 20px
	}
}

/* 주문서 전용 딤드처리 */
.bg_order {
	display: block !important
}
</style>
<style type="text/css">
#orderGoodsList {
	display: none
}

.order_goodslist .show_tbl {
	display: block;
	position: relative;
	height: 94px
}

.order_goodslist .show_tbl .inner_show {
	position: absolute;
	left: 0;
	top: 0;
	width: 100%;
	padding: 20px 0 20px;
	border-top: 1px solid #333;
	border-bottom: 1px solid #ddd;
	font-size: 14px;
	line-height: 20px;
	text-align: center;
	letter-spacing: -0.3px
}

.order_goodslist .show_tbl .name {
	padding-bottom: 14px
}

.order_goodslist .show_tbl .btn_show {
	font-size: 14px;
	line-height: 20px;
	font-family: 'Noto Sans';
	font-weight: 700;
	color: #512772
}

.order_goodslist .show_tbl .btn_show .txt {
	padding-right: 12px
}

.order_goodslist .show_tbl .btn_show .ico {
	width: 14px;
	vertical-align: middle
}
</style>

</head>
<body class="main-index">
<div id="wrap" class="">
	<div id="pos_scroll"></div>
	<div id="container">
		<jsp:include page="../main/layout/header.jsp"></jsp:include>
		
		<div class="layout-wrapper">
			<p class="goods-list-position"></p>
		</div>
		
		<div class="layout-page-header">
			<h2 class="layout-page-title">주문서</h2>
			<div class="pg_sub_desc">
				<p>주문하실 상품명 및 수량을 정확하게 확인해 주세요.</p>
			</div>
		</div>
		
		<div id="main">
			<div id="content">
				<jsp:include page="../main/layout/quick_nav.jsp"></jsp:include>
				<div class="user_form">
					<script id="delivery"></script>
					<div class="layout-wrapper">
						<h2 class="tit_section fst">상품 정보</h2>
				
						<form id="form" name="frmOrder" action="/kurlyPro/shop/order/payment.do"
								method="post" class="order_view" >
							<div class="page_aticle order_goodslist">
								<div class="show_tbl">
									<div class="inner_show">
									<c:if test="${ length ne 1 }">
										<div class="name">${ group_name[0] } 외 ${ length-1 }개 상품을 주문합니다.</div>
									</c:if>
									<c:if test="${ length eq 1 }">
										<div class="name">${ group_name[0] } 상품을 주문합니다.</div>
									</c:if>
										<a class="btn_show" href="#none"><span class="txt">상세보기</span>
										<img class="ico" src="https://res.kurly.com/pc/ico/1803/ico_arrow_open_28x16.png" alt="열기"></a>
									</div>
								</div>
								
								<div id="orderGoodsList">
									<table class="tbl tbl_type1">
										<caption style="display: none">상품 정보 상세보기</caption>
										<colgroup>
											<col style="width: 120px">
											<col style="width: auto">
											<col style="width: 186px">
										</colgroup>
										<thead>
											<tr>
												<th scope="col"><span class="screen_out">상품이미지</span></th>
												<th scope="col" class="th_info">상품 정보</th>
												<th scope="col">상품금액</th>
											</tr>
										</thead>
										<tbody>
										<!-- 상품정보 반복 -->
										<c:forEach var="i" begin="0" end="${ length-1 }">
										<input type="hidden" name="goodsBasketNo" value="${ basket_no[i] }" />
											<tr>
												<td class="thumb">
													<img src="../..${ main_img[i] }" width="150" class="goods-cart-product-image"
														onerror="this.src='http://www.kurly.com/shop/data/skin/designgj/img/common/noimg_300.gif'">
												</td>
												<td class="info">
													<div class="name">${ group_name[i] }</div>
												<c:if test="${ group_name[i] eq goods_name[i] }"> 
														<dt class="screen_out">단일상품</dt>
														<dl>
															<dd> ${ cnt[i] }개 / 개 당 <fmt:formatNumber value="${ g_price[i]-dc_price[i] }"
																				pattern="#,###"></fmt:formatNumber>원
															</dd>
														</dl>
					 								</c:if>
													<c:if test="${ group_name[i] ne goods_name[i] }">
													
														<dl>
														<dt>${ goods_name[i] }</dt>
															<dd> / ${ cnt[i] }개 / 개 당 <fmt:formatNumber value="${ g_price[i]-dc_price[i] }"
																				pattern="#,###"></fmt:formatNumber>원
															</dd>
														</dl>
													</c:if>
												</td>
												<td class="price">
													<fmt:formatNumber value="${ b_price[i]-(dc_price[i]*cnt[i]) }" pattern="#,###"></fmt:formatNumber>원
												</td>
											</tr>
										</c:forEach>
										<!-- 여기까지 -->
										</tbody>
									</table>
								</div>
							</div>
							
							<input type="hidden" value="${ length }" id="itemCount" name="itemCount">
							<input type="hidden" value="${ group_name[0] }" id="itemFstCount" name="itemFstCount">
							<input type="hidden" name="ordno" value="">
							<input type="hidden" name="settlement_price" value="">
							<input type="hidden" name="settlekind_option" value="1">
							<input type="hidden" name="usePoint" value="">
							<input type="hidden" name="user_no" value="">
							<input type="hidden" name="pay_code" value="">
							<input type="hidden" name="add_point" value="">
							<div id="apply_coupon"></div>
							<input type="hidden" name="couponCode" value="">
		
							<h2 class="tit_section" id="titFocusOrderer">주문자 정보</h2>
							<div class="order_section data_orderer">
								<table class="goodsinfo_table">
									<tbody>
										<tr class="fst">
											<th>보내는 분 *</th>
											<td>
												<input type="text" name="nameOrder" value="${ member.name }" class="read_only"
												readonly="readonly" msgr="보내는 분의 이름을 적어주세요" style="width: 162px">
											</td>
										</tr>
										<tr class="field_phone">
											<th>휴대폰 *</th>
											<td>
												<input style="width: 143px;" type="text" name="mobileOrder" value="${ member.tel }" class="read_only"
												size="11" readonly="readonly" maxlength="11" option="regNum" label="주문자 휴대폰번호">
											</td>
										</tr>
										<tr>
											<th>이메일 *</th>
											<td>
												<input style="width: 360px;" type="text" id="emaili" name="email" value="${ member.email }" 
												class="read_only" readonly="readonly" option="regEmail">
												<p class="txt_guide">
													<span class="txt txt_case1">이메일을 통해 주문처리과정을 보내드립니다.</span>
													<span class="txt txt_case2">정보 변경은 <span class="txt_desc">마이컬리 &gt; 개인정보 수정</span> 메뉴에서 가능합니다.</span>
												</p>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
		
							<input type="hidden" name="address" id="address" value="">
							<input type="hidden" name="deliPoli" id="deliPoli" value=""> 
							<input type="hidden" id="means_inp" name="means" value=""> 
							<input type="hidden" id="addressBookNo" name="addressbook_no" value="">
							<input type="hidden" id="basicDeliveryNo" name="basicDeliveryNo" value="${ basicDelivery.delivery_code }">
							<h2 class="tit_section" id="divAddressWrapper">
								배송 정보 
								<span class="desc">*배송 휴무일: 샛별배송 (휴무없음), 택배배송 (일요일)</span>
							</h2>
							<div class="order_section order_address" id="dataDelivery">
								<h3 href="#none" class="section_crux">배송지</h3>
								<div class="section_full">
								
								
									<span class="address" id="divDestination">
										<span class="tag" id="addrTags"> 
											<span class="badge" id="addrBadge"></span>
											<span class="badge"></span>
										</span> 
										<span class="addr" id="addrInfo">
											
										</span>
									</span>
									<div class="receiving" id="receiverInfo">
									</div>
									<button type="button" id="btnUpdateAddress" class="btn active">
										 변경
									</button>
								
								</div>
							</div>
		
							<!-- 종이포장재 자세히 보기 -->
							<div id="bnrOrder" class="bnr_order" style="display:block;">
								<a href="#layerShow" class="btn_layershow">
									<img src="https://res.kurly.com/pc/service/order/2004/bnr_order_allpaper.png" alt="All Paper Challenge">
								</a>
								<p class="screen_out">지구를 위해 모든 포장재를 종이로 새롭게 바뀐 포장재 알아보기</p>
							</div>
		
							<!-- 결제 금액 -->
							<div class="tax_absolute">
								<div class="inner_sticky" id="sticky">
									<h2 class="tit_section">결제 금액</h2>
									<div id="orderitem_money_info">
										<dl class="amount fst">
											<dt class="tit">주문 금액</dt>
											<dd class="price">
												<fmt:formatNumber value="${ param.totalPrice-param.totalDiscount }" pattern="#,###"></fmt:formatNumber> 원
											 </dd>
										</dl>
										<dl class="amount sub">
											<dt class="tit">상품 금액</dt>
											<dd class="price">
												<span class="price" id="paper_goodsprice">
												<fmt:formatNumber value="${ param.totalPrice }" pattern="#,###"></fmt:formatNumber> 원
												</span>
											</dd>
										</dl>
										<dl class="amount sub">
											<dt class="tit">상품 할인</dt>
											<dd class="price sales_area">
												<span class="pm_sign normal" style="display: inline;">-</span>
												<span id="special_discount_amount" class="normal"></span> 원
											</dd>
											<dd id="paper_sale" class="screen_out">${ param.totalDiscount }</dd>
										</dl>
										<dl class="amount">
											<dt class="tit">배송비</dt>
											<dd class="price delivery_area">
												<div id="paper_delivery_msg1" style="display: block;">
													<span class="pm_sign" style="display: inline;">+</span>
													<span id="paper_delivery" class="screen_out">${ param.deliveryFee }
													</span>
													<span id="paper_delivery2" style=""></span>
												</div>
												<div id="paper_delivery_msg2" style="display: none;"></div>
												<div id="paper_delivery_msg_extra" class="small" style="display: none;"></div>
												<span id="free_delivery_coupon_msg" class="screen_out">미적용</span>
												<input type="hidden" name="free_delivery" value="0">
											</dd>
										</dl>
										<dl class="amount">
											<dt class="tit">쿠폰 할인</dt>
											<dd class="price coupon_area">
												<span class="pm_sign" style="display: none;">-</span> 
												<span id="apr_coupon_data">0 원</span>
												<input type="hidden" name="coupon" size="12" value="0" readonly="">
											</dd>
										</dl>
										<dl class="amount">
											<dt class="tit">적립금 사용</dt>
											<dd class="price">
												<span class="num pay_sum" id="paper_reserves">0 원</span>
												<input type="hidden" name="coupon_emoney" size="12" value="0" readonly="">
											</dd>
										</dl>
										<dl class="amount lst">
											<dt class="tit">최종 결제 금액</dt>
											<dd class="price">
												<span id="paper_settlement"></span>
												<span class="won">원</span>
											</dd>
										</dl>
										<p class="reserve">
											<span class="ico">적립</span> 구매 시 
											<span class="emph"><span id="expectAmount"></span>
											원 (
											<fmt:formatNumber pattern="#.#" value="${ percent*100 }"></fmt:formatNumber>
											%)</span>
										</p>
										<input type="hidden" id="point_percent" value="${ percent }" />
									</div>
								</div>
							</div>
		
		
							<div class="data_payment">
								<div class="tbl_left">
									<h2 class="tit_section">쿠폰 / 적립금</h2>
									<table class="goodsinfo_table heights defalut_pos">
										<tbody>
											<tr>
												<th class="coupon_set">쿠폰 적용</th>
												<td class="coupon_set">
													<div class="view_popselbox">
														<div id="popselboxView" style="display: block;">
															적용할 쿠폰을 선택해주세요
														</div>
														<div id="popSelbox" class="layer_coupon">
															<ul id="addpopSelList" class="list">
																<li class="fst checked ">
																	<div class="inner_item">
																		<span class="txt_tit default">쿠폰 적용 안 함</span>
																	</div>
																</li>
																
																
																<!-- 회원이 가지고 있는 쿠폰 : 여기부터 -->
																<c:forEach items="${ coupon }" var="dto">
																<input type="hidden" id="selectCoupon" name="selectCoupon" value="${ dto.coupon_code }" />
																<c:if test="${ param.totalPrice-param.totalDiscount lt dto.limited_price }">
																<li style="pointer-events: none;">
																</c:if>
																<c:if test="${ param.totalPrice-param.totalDiscount ge dto.limited_price }">
																<li>
																</c:if>
																	<div class="inner_item">
																		<div class="item_row">
																			<div class="item_td left">
																			<!-- 주문금액이 쿠폰 limited_price 미만이면 -->
																			<c:if test="${ param.totalPrice-param.totalDiscount lt dto.limited_price }">
																				<span class="txt_apr coupon_na">사용불가</span>
																			</c:if>
																			<c:if test="${ param.totalPrice-param.totalDiscount ge dto.limited_price }">
																				<span class="txt_apr"><fmt:formatNumber value="${ dto.advantage }" pattern="#,###"></fmt:formatNumber></span>
																				<span class="txt_is_dc" style="display: inline;">원 할인</span>
																			</c:if>
																			</div>
																			<div class="item_td">
																				<span class="txt_tit">
																					${ dto.name }
																				</span> 
																				<span class="txt_desc">
																					${ dto.limited_price } 원 이상 주문 시 ${ dto.advantage } 원 ${ dto.type }
																				</span> 
																				<span class="txt_expire">
																					유효기간 ${ dto.expire_date } 까지
																				</span>
																				<%-- <div id="apply_delivery_coupon" class="is_delivery_coupon" style="display: none;">
																					0
																				</div>
																				<div class="txt_apply_coupon" style="display: none;">${ dto.coupon_code }</div> --%>
																			</div>
																		</div>
																	</div>
																</li>
																</c:forEach>
																<!-- 여기까지 반복 -->
																
															</ul>
															<div class="coupon_list_default" style="display: none;">
																<li class="fst checked">
																	<div class="inner_item">
																		<span class="txt_tit default">쿠폰 적용 안 함</span>
																	</div>
																</li>
															</div>
															<div id="listItem" style="display: none">
																<div class="inner_item">
																	<div class="item_row">
																		<div class="item_td left">
																			<span class="txt_apr"></span>
																		</div>
																		<div class="item_td">
																			<span class="txt_tit"></span> <span class="txt_desc"></span>
																			<span class="txt_expire"></span>
																			<div id="apply_delivery_coupon"
																				class="is_delivery_coupon" style="display: none;"></div>
																			<div class="txt_apply_coupon" style="display: none;"></div>
																		</div>
																	</div>
																</div>
															</div>
															<button id="popSelboxCancel" type="button"
																class="btn btn_cancel screen_out">취소</button>
															<button id="popSelboxSelect" type="button"
																class="btn btn_conf screen_out">확인</button>
															<button id="popSelboxClose" type="button"
																class="btn_close screen_out">닫기</button>
														</div>
														<p class="txt">
															(보유쿠폰: <span class="coupon_sum">${ fn:length(coupon) }</span> 개)
														</p>
													</div>
													<div class="txt_notavailable" style="display:none;">
														<p>사용 가능한 쿠폰이 없습니다.</p>
													</div>
													<div>
														<p class="txt_ques">
															<a href="#none" class="btn_link" id="happyTalk">쿠폰사용문의(카카오톡) &gt;</a>
														</p>
													</div>
												</td>
											</tr>
											<tr style="border-top: 1px solid #ddd; border-bottom: 1px solid #ddd;">
												<th>
													적립금 적용 
													<input type="hidden" value="${ member.total_point }" name="checkEmoney">
												</th>
												<td>
													<table class="order-disc-tbl coupon_area" id="ondealCheck">
														<tbody>
															<tr>
																<td class="emoney_td_l">
																	<input type="text" name="emoney" id="emoney" class="number_only"
																		size="12" value="0" onblur="chk_emoney(this);" onkeyup="calcu_settle();"
																		onkeydown="if (event.keyCode == 13) {return false}"> 원
																</td>
																<td class="emoney_td_r">
																	<div class="check">
																		<label class="emoney_chkbox inp_check label_check">
																			<input type="checkbox" name="">
																			<span class="txt_checkbox">모두사용</span>
																		</label>
																	</div>
																</td>
															</tr>
															<tr>
																<td>보유적립금 : ${ member.total_point }원
																	<div class="emoney_noti">
																		<span class="txt">*적립금 내역: 마이컬리 &gt; 적립금</span>
																	</div>
																	<input type="hidden" name="emoney_max" value="${ member.total_point }">
																</td>
															</tr>
														</tbody>
													</table>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
		
		
		
							<div class="data_method">
								<h2 class="tit_section" id="titFocusMethod">결제 수단</h2>
								<input type="hidden" name="escrow" value="N">
								<table class="goodsinfo_table tbl_left">
									<tbody>
										<tr>
											<th>일반결제</th>
											<td class="noline" style="position: relative">
												<label class="label_radio checked" id="settlekindCard"> 
													<input type="radio" name="settlekind" value="1" checked="checked">
														신용카드
												</label>
											</td>
										</tr>
										<tr class="card_detail">
											<th></th>
											<td>
												<div id="cardSelect">
													<div>
														<div class="card_select">
															<div class="select_box">
																<strong class="tit">카드를 선택해주세요</strong>
																<!---->
																<select name="card_code" class="list">
																	<option disabled="disabled" value="">카드를 선택해주세요</option>
																	<option value="61">현대 (무이자)</option>
																	<option value="41">신한</option>
																	<option value="31">비씨</option>
																	<option value="11">KB국민</option>
																	<option value="51">삼성</option>
																	<option value="36">씨티</option>
																	<option value="71">롯데</option>
																	<option value="21">하나(외환)</option>
																	<option value="91">NH채움</option>
																	<option value="33">우리</option>
																	<option value="34">수협</option>
																	<option value="46">광주</option>
																	<option value="35">전북</option>
																	<option value="42">제주</option>
																	<option value="62">신협체크</option>
																	<option value="38">MG새마을체크</option>
																	<option value="39">저축은행체크</option>
																	<option value="37">우체국카드</option>
																	<option value="30">KDB산업은행</option>
																	<option value="15">카카오뱅크</option></select>
															</div>
														</div>
														<!---->
														<!---->
														<!---->
													</div>
												</div>
											</td>
										</tr>
		
										<tr>
											<th>CHAI 결제</th>
											<td>
												<label class="label_radio">
													<input type="radio" name="settlekind" value="2">
													<img src="https://res.kurly.com/pc/service/order/2001/logo_chi_x2.png" height="18" alt="Chai 결제"> 
													<img src="https://res.kurly.com/pc/service/order/2005/bubble_chai.png" height="20" 
														alt="첫결제 시 5천원 즉시할인, 5천원 캐시백" class="bubble">
													<span id="infoChi" class="info"> · 차이로 결제 시, 누구나 상시 2% 캐시백 </span>
												</label>
											</td>
										</tr>
										<tr>
											<th>토스 결제</th>
											<td>
												<label class="label_radio">
													<input type="radio" name="settlekind" value="3"> 
													<img src="http://res.kurly.com/pc/service/order/1912/toss-logo-signature.svg" height="18" alt="토스 결제">
												</label>
											</td>
										</tr>
										<tr>
											<th>네이버페이 결제</th>
											<td class="noline">
												<label class="label_radio">
													<input type="radio" name="settlekind" value="4"> 
													<img src="//res.kurly.com/pc/service/order/1710/ico_naverpay_v3.png" height="20" alt="네이버 페이 로고">
												</label>
											</td>
										</tr>
										<tr>
											<th>PAYCO 결제</th>
											<td>
												<label class="label_radio"> 
													<input type="radio" name="settlekind" value="5">
														<span style="display: inline-block">
															<img src="https://static-bill.nhnent.com/payco/checkout/img/v2/btn_checkout2.png"
																	alt="PAYCO 간편결제" style="border: 0 none; vertical-align: top">
														</span>
												</label>
											</td>
										</tr>
										<tr>
											<th>스마일페이 결제</th>
											<td>
												<label class="label_radio">
													<input type="radio" name="settlekind" value="6"> 
													<img src="//res.kurly.com/pc/service/order/1712/ico_smilepay_v2.png" alt="스마일페이" height="18">
												</label>
											</td>
										</tr>
										<tr>
											<th>휴대폰 결제</th>
											<td>
												<label class="label_radio"> 
													<input type="radio" name="settlekind" value="7"> 휴대폰
												</label>
											</td>
										</tr>
										<tr>
											<td class="txt_notice" colspan="2">
												<ul>
													<li>※ 페이코, 네이버페이, 토스, 차이 결제는 결제 시 결제하신 수단으로만 환불되는 점 양해부탁드립니다.</li>
													<li>※ 고객님은 안전거래를 위해 현금 등으로 결제시 저희 쇼핑몰에서 가입한 LG데이콤의 구매안전(에스크로) 서비스를 이용하실 수 있습니다.</li>
													<li>※ 보안강화로 Internet Explorer 8 미만 사용 시 결제창이 뜨지 않을 수 있습니다.
														<a href="/shop/board/view.php?id=notice&amp;no=207" target="_blank"> 공지 보러가기 &gt;</a>
													</li>
												</ul>
											</td>
										</tr>
									</tbody>
								</table>
								
								<table class="goodsinfo_table tbl_nogoods">
									<tbody>
										<tr>
											<th>미출고 시 조치방법 *</th>
											<td>
												<label for="undeliver_way-2" class="label_radio checked"> 
													<input id="undeliver_way-2" name="undeliver_way" value="결제수단으로 환불" type="radio" checked="checked"> 결제수단으로 환불
												</label> 
												<label for="undeliver_way-1" class="label_radio"> 
													<input id="undeliver_way-1" name="undeliver_way" value="상품 입고 시 배송" type="radio"> 상품 입고 시 배송
												</label>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
								
							<h2 class="tit_section" id="titFocusAgree">개인정보 수집/제공*</h2>
							<table class="goodsinfo_table heights">
								<tbody>
									<tr>
										<td class="reg_agree">
											<div class="bg_dim"></div>
											
											<div class="check">
												<label class="inp_check label_check"> 
													<input type="checkbox" name="ordAgree" value="y" label="결제 진행 필수 동의"
														msgr="결제 진행 필수 동의 내용에 동의하셔야 결제가 가능합니다."> 
													<span class="txt_checkbox">결제 진행 필수 동의</span>
												</label>
												<ul class="list_agree">
													<li>
														<span class="subject">개인정보 수집 · 이용 동의 
															<span class="emph">(필수)</span>
														</span> 
														<a href="#terms" class="link_terms">약관확인</a>
													</li>
												</ul>
												
												<!-- 개인정보 수집 이용 동의 안내창 -->
												<div class="layer layer_agree">
													<div class="choice_agree view_terms" style="display: none; margin-top: -274.5px;">
														<div class="inner_layer">
															<div class="in_layer" id="viewTerms">
																<div class="layer_head">
																	<h3 class="tit_layer">개인정보 수집·이용 동의(필수)</h3>
																</div>
																<div class="layer_body">
																	<div class="box_tbl">
																		<table>
																			<caption class="screen_out">개인정보의 수집 및 이용목적</caption>
																			<colgroup>
																				<col width="30%">
																				<col width="35%">
																				<col width="35%">
																			</colgroup>
																			<thead>
																				<tr>
																					<th scope="row">수집 목적</th>
																					<th scope="row">수집 항목</th>
																					<th scope="row">보유 기간</th>
																				</tr>
																			</thead>
																			<tbody>
																				<tr class="log_in" style="display: table-row;">
																					<td>온라인 쇼핑 구매자에 대한 상품 결제 및 배송</td>
																					<td>결제정보, 수취인명, 휴대전화번호, 수취인 주소</td>
																					<td>업무 목적 달성 후 파기<br>(단, 타 법령에 따라 법령에서 규정한 기간동안 보존)</td>
																				</tr>
																				<tr class="log_out" style="display: none;">
																					<td>온라인 쇼핑 구매자에 대한 상품 결제 및 배송</td>
																					<td>주문자 정보(이름, 휴대폰 번호, 이메일), 결제정보, 수취인 정보(주소, 이름, 휴대폰 번호)</td>
																					<td>업무 목적 달성 후 파기<br>(단, 타 법령에 따라 법령에서 규정한 기간 동안 보존)</td>
																				</tr>
																			</tbody>
																		</table>
																		<p class="txt_service">서비스 제공을 위해서 필요한 최소한의 개인정보이므로 동의를 해 주셔야 서비스를 이용하실 수 있습니다.</p>
																	</div>
																</div>
															</div>
															<button type="button" class="btn_ok">확인</button>
															<button type="button" class="btn_close">
																<span class="screen_out">레이어 닫기</span>
															</button>
														</div>
													</div>
													<!-- 샛별배송 종이포장 관련 안내창 -->
													<div class="choice_agree view_layer">
														<div class="inner_layer">
															<div class="in_layer in_allpaper">
																<img src="https://res.kurly.com/pc/service/order/2004/img_order_allpaper.png"
																	alt="샛별배송 포장재가 종이로 바뀝니다.">
																<div class="screen_out">
																	<p>식품의 신선함은 그대로, 사람에게도 환경에도 이로운 배송을 위해 모든 배송 포장재를 종이로 바꿔 갑니다.</p>
																	<dl>
																		<dt>변경 전</dt>
																		<dd>스티로폼 박스, 비닐 파우치, 지퍼백, 박스 테이프, 비닐 완충 포장재, 젤 아이스팩</dd>
																		<dt>변경 후</dt>
																		<dd>종이 박스, 종이 파우치, 종이 테이프, 종이 완충 포장재, 100% 워터팩</dd>
																	</dl>
																	<p> 
																		<strong>100% 워터팩 폐기 방법</strong> 버려도 환경에 무해한 물이 담겨
																		있습니다. 내용물은 하수구에 버려주시고, 포장재는 분리배출 해주세요.
																	</p>
																</div>
															</div>
															<button type="button" class="btn_ok">확인</button>
														</div>
													</div>
												</div>
												
											</div>
										</td>
									</tr>
								</tbody>
							</table>
							<div style="padding: 30px 0 14px; position: relative;" align="center" class="noline">
								<input type="button" style="float: none" value="결제하기" class="bhs_button btn_payment action">
							</div>
						</form>
						<ul class="ord_notice">
							<li>* 직접 주문취소는 <strong class="emph">‘입금확인’</strong> 상태일 경우에만 가능합니다.</li>
							<li>* 미성년자가 결제 시 법정대리인이 그 거래를 취소할 수 있습니다.</li>
						</ul>
					</div>
					<div id="dynamic"></div>
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