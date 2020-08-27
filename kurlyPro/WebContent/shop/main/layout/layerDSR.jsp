<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script src="../data/csj/join.js"></script>

<div id="layerDSR" style="display: none;">
	<div class="bg_dim"></div>
	<div class="in_layer">
		<div class="inner_layer layer_star" style="display: none;">
			<strong class="dsr_result">샛별배송 지역입니다.</strong>
			<div class="ani">
				<img src="../../mobile/img/1908/img_delivery_kurly.png" alt="샛별배송 이미지">
			</div>
			<p class="dsr_desc">
				<strong class="emph">오늘 밤 11시 전</strong>까지 주문시<br> 
				<strong class="emph">다음날 아침 7시</strong> 이전 도착합니다!
			</p>
			<p class="dsr_notice">샛별배송은 휴무 없이 매일 배송 합니다</p>
		</div>
		<div class="inner_layer layer_normal" style="display: none;">
			<strong class="dsr_result">택배배송 지역입니다.</strong>
			<div class="ani">
				<img src="../../mobile/img/1908/img_delivery_car.png" alt="택배배송 이미지">
			</div>
			<p class="dsr_desc">
				<strong class="emph">밤 8시 전</strong>까지 주문시<br> 
				<strong class="emph">다음날</strong> 도착합니다!
			</p>
			<p class="dsr_notice">일요일은 배송 휴무로 토요일에는 주문 불가</p>
		</div>
		<div class="inner_layer layer_none" style="display: none;">
			<strong class="dsr_result">배송 불가 지역입니다.</strong>
			<div class="ani">
				<img src="../../mobile/img/1908/img_delivery_none.png" alt="배송불가 이미지">
			</div>
			<p class="dsr_desc">
				<strong class="emph">도로명 주소</strong>로 검색하셨다면,<br> 
				<strong class="emph">지번 주소(구 주소)</strong>로 다시 시도해 주세요.
			</p>
			<p class="dsr_notice">배송지역을 확장하도록 노력하겠습니다!</p>
		</div>
		<div class="layer_btn1">
			<button type="button" class="btn_close" onclick="$('#layerDSR').hide();$(this).parent().find('.inner_layer').hide();">확인</button>
		</div>
		<button type="button" class="layer_close" onclick="$('#layerDSR').hide();$(this).parent().find('.inner_layer').hide();"></button>
	</div>
</div>