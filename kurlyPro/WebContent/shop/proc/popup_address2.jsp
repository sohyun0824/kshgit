<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=0, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, height=device-height">
<script type="text/javascript" src="../../js/lib/jquery-1.10.2.min.js"></script>
<script src="//ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<style type="text/css">
    /* reset */
    body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,textarea,p,blockquote,th,td,input,select,textarea,button {margin:0;padding:0}
    body *{box-sizing:border-box}
    fieldset,img {border:0 none}
    dl,ul,ol,menu,li {list-style:none}
    blockquote, q {quotes:none}
    blockquote:before, blockquote:after,q:before, q:after {content:'';content:none}
    input,select,textarea,button {font-size:100%;vertical-align:middle}
    button {border:0 none;background-color:transparent;cursor:pointer}
    table {border-collapse:collapse;border-spacing:0}
    body {-webkit-text-size-adjust:none}
    input[type='text'],input[type='password'],input[type='submit'],input[type='search'] {-webkit-appearance:none; border-radius:0}
    input:checked[type='checkbox'] {background-color:#666; -webkit-appearance:checkbox}
    button,input[type='button'],input[type='submit'],input[type='reset'],input[type='file'] {-webkit-appearance:button; border-radius:0}
    input[type='search']::-webkit-search-cancel-button {-webkit-appearance:none}
    body {background-color:#fff}
    body,th,td,input,select,textarea,button {font-size:14px;line-height:1.5;font-family:'Malgun Gothic', '맑은 고딕', sans-serif;color:#333}
    a {color:#333;text-decoration:none}
    a:active, a:hover {text-decoration:none}
    address,caption,cite,code,dfn,em,var {font-style:normal;font-weight:normal}
    .screen_out{display:block;overflow:hidden;position:absolute;left:-9999px;width:1px;height:1px;font-size:0;line-height:0;text-indent:-9999px}
    /* ##### */
    /* 폼요소 */
    /* ##### */
    input[type='text']::placeholder{color:#ccc;opacity:1}
    input[type='text']::-webkit-input-placeholder{color:#ccc;opacity:1}
    input[type='text']::-moz-placeholder{color:#ccc;opacity:1}
    input[type='text']:-ms-input-placeholder{color:#ccc;opacity:1}
    input[type='text']{width:100%;height:50px;padding:3px 11px 0;border:1px solid #ccc;border-radius:3px;font-weight:500;font-size:16px;line-height:1.5;color:#333;-webkit-appearance: none;-moz-appearance: none;appearance: none;ime-mode:disabled;outline:0}
    input[type='text']:focus{border:1px solid #333}
    input[type='text'].disabled,
    input[type='text']:disabled{border:1px solid #ddd;background-color:#fff;color:#333}
    /* popup_style */
    .address_search{display:none}
    /* 상단닫기버튼 */
    .header_close{height:28px;background-color:#fff}
    .btn_close1{overflow:hidden;position:absolute;z-index:1;right:0;top:0;width:44px;height:38px;border:0 none;background:url(https://res.kurly.com/mobile/ico/1908/ico_layer_close_88x76.png) no-repeat 50% 50%;background-size:44px 38px;font-size:0;line-height:0;text-indent:-9999px}
    /* 주소재검색 */
    .layer_prev{overflow:hidden;height:44px;border-bottom:1px solid #ccc;background-color:#fff}
    .layer_prev .ico{float:left;width:44px;height:44px}
    .layer_prev .tit{float:left;font-weight:600;font-size:16px;color:#333;line-height:44px}
    
    /* 주소찾기 */
    .filed_address .filed{overflow:hidden;padding:10px 10px 0 10px;background-color:#fff}
    .filed_address .filed_zipcode1 .inp{width:80px;text-align:center}
    .filed_address .filed_zipcode2{display:none}
    .filed_address .filed_zipcode2 .inp{float:left;width:50px;text-align:center;}
    .filed_address .bar{float:left;width:18px;height:46px;padding:24px 0 0 4px;}
    .filed_address .bar .in_bar{float:left;width:10px;height:1px;background-color:#999}
    /* 버튼 */
    .btn_type1{display:block;overflow:hidden;width:100%;height:50px;border:1px solid #5f0081;border-radius:3px;background-color:#5f0080;font-size:0;text-align:center}
    .btn_type1 .txt_type{display:inline-block;height:100%;font-weight:500;font-size:16px;color:#fff;line-height:51px;text-align:center}
    /* 배송불가지역 */
    .no_delivery{overflow:hidden;padding:30px 15px;background-color:#fff}
    .no_delivery .inner_no{padding:14px 10px 16px;background-color:#f4f4f4;text-align:center}
    .no_delivery .tit .ico{display:inline-block;height:18px;padding-left:19px;font-weight:600;font-size:12px;color:#b3130b;line-height:18px;background:url(https://res.kurly.com/mobile/ico/1908/ico_noti_delivery_popup.png) no-repeat 0 50%;background-size:14px 14px}
    .no_delivery .tit .desc{display:block;font-weight:400;font-size:12px;color:#666}
    .no_delivery .btn{height:36px;padding-top:16px;border:0 none;background:none;font-size:12px;color:#999;line-height:20px}
    .no_delivery .btn .ico{display:inline-block;width:20px;height:20px;background:url(https://res.kurly.com/mobile/ico/1908/ico_arrow_999_40x40.png) no-repeat 50% 50%;background-size:20px 20px;vertical-align:-5px}
    .no_delivery .btn.on .ico{-webkit-transform:rotate(-180deg);-ms-transform:rotate(-180deg);-o-transform:rotate(-180deg);transform:rotate(-180deg)}
    .no_delivery .list{display:none;padding-top:30px}
    .no_delivery .list li{font-size:12px;color:#666;line-height:17px}
</style>
</head>
<body>
<div class="header_close"></div>
<div id="wrap"></div>

<script type="text/javascript">
    // 우편번호 찾기 찾기 화면을 넣을 element
    $(document).ready(function(){
        var element_wrap = document.getElementById('wrap');

        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            maxSuggestItems : 5, //목록갯수
            hideMapBtn: true, //지도보기 버튼
            hideEngBtn: true, //영문보기 버튼
            
            // 눌렀을 때의 이벤트
            oncomplete: function(data) {
                $('.address_search').show();
                $('html,body').animate({'scrollTop' : 0}, 300);
                $('#wrap').hide();
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var jibunAddr = data.jibunAddress;
                if(jibunAddr == '') {
                    jibunAddr = data.autoJibunAddress;
                }
                var fullRoadAddr = data.roadAddress; // 최종 도로명 주소 변수
                if(fullRoadAddr == '') {
                    fullRoadAddr = data.autoRoadAddress;
                }

                var fullJibunAddr = jibunAddr; //최종 지번 주소 변수

                var extraAddr = ''; // 조합형 주소 변수

                // 건물명이 있을 경우 추가한다.
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                fullRoadAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                fullJibunAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');

                if(data.userSelectedType === 'R') {
                    $('#s_type').val('road');
                    $(".filed_zipcode1").show();
                    $(".filed_zipcode2").hide();
                } else {
                    if(data.postcode1 == ""){
                        $(".filed_zipcode1").show();
                        $(".filed_zipcode2").hide();
                    }else{
                        $(".filed_zipcode1").hide();
                        $(".filed_zipcode2").show();
                    }
                    $('#s_type').val('zipcode');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $('#zonecode, #zonecode_text').val(data.zonecode);
                $('#zipcode1, #zipcode1_text').val(data.postcode1);
                $('#zipcode2, #zipcode2_text').val(data.postcode2);
                $('#ground_address, #ground_address_text').val(fullJibunAddr);
                $('#road_address').val(fullRoadAddr);

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                //element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap,{q:'',autoClose:false});

        // 배송불가지역
        $('.no_delivery .btn').on('click',function(e){
            $(this).toggleClass('on');
            $('.no_delivery .list').slideToggle('fast');
        });
        
        // 주소 재검색
        $('.layer_prev').on('click',function(e){
            $('.address_search').hide();
            $('#wrap').show();
        });
    });
</script>

<div class="address_search">
	<div class="layer_prev">
		<img src="../../mobile/service/common/1908/ico_prev_333_100x100.png" alt="" class="ico"><span class="tit">주소 재검색</span>
	</div>
	<div class="inner_address">
		<h1 class="screen_out">주소찾기</h1>
		<div class="filed_address">
			<form id="road-address-confirm" name="form-confirm-road" method="post" action="javascript:submit()">
				<input type="hidden" name="gubun" id="gubun" value=""> 
				<input type="hidden" name="s_type" id="s_type" value=""> 
				<input name="road_address" id="road_address" type="hidden"> 
				<input name="ground_address" id="ground_address" type="hidden"> 
				<input name="zipcode1" id="zipcode1" type="hidden"> 
				<input name="zipcode2" id="zipcode2" type="hidden"> 
				<input name="zonecode" id="zonecode" type="hidden">
				<div class="filed filed_zipcode1">
					<input class="inp" type="text" id="zonecode_text" readonly="readonly" disabled="disabled">
				</div>
				<div class="filed filed_zipcode2">
					<input class="inp" type="text" id="zipcode1_text" readonly="readonly" disabled="disabled"> 
					<span class="bar">
						<span class="in_bar"></span>
					</span> 
					<input class="inp" type="text" id="zipcode2_text" readonly="readonly" disabled="disabled">
				</div>
				<div class="filed">
					<input class="inp" type="text" id="ground_address_text" readonly="readonly" disabled="disabled">
				</div>
				<div class="filed">
					<input class="inp" name="address_sub" id="address_sub_text" type="text" placeholder="나머지 주소를 입력해주세요." style="ime-mode: auto;">
				</div>
				<div class="filed">
					<button type="submit" class="btn_type1">
						<span class="txt_type">주소입력</span>
					</button>
				</div>
			</form>
		</div>
		<div class="no_delivery">
			<div class="inner_no">
				<h2 class="tit">
					<span class="ico">샛별배송 지역 중 배송 불가 장소 안내</span> 
					<span class="desc">관공서/ 학교/ 병원/ 시장/ 공단 지역/ 산간 지역/ 백화점 등</span>
					<button type="button" class="btn">자세히 보기<span class="ico"></span>
					</button>
				</h2>
				<ul class="list">
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

<script>
    //$("#road-address-confirm input[type='submit']").on("click",function(){
    function submit() {
    	var loc = $("#ground_address").val().substring(0, 2);
    	var deli;
    	if(loc === '서울'){
    		deli = 0;			// 샛별배송
    	} else if(loc === '제주'){
    		deli = 2;			// 배송불가
    	} else{
    		deli = 1;			// 택배배송
    	}
    	
    	opener.parent.layerAction(deli);
    	window.close();
    	
    }
</script>

</body>
</html>

