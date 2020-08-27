<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
    #qnb{position:absolute;z-index:1;right:20px;top:70px;width:80px;font:normal 12px/16px "Noto Sans";color:#333;letter-spacing:-0.3px;transition:top 0.2s}
    .goods-goods_view #qnb{top:20px}
    /* 배너 */
    #qnb .bnr_qnb{padding-bottom:7px}
    #qnb .bnr_qnb .thumb{width:80px;height:120px;vertical-align:top}
    /* 메뉴 */    
    #qnb .side_menu{width:80px;border:1px solid #ddd;border-top:0 none;background-color:#fff}
    #qnb .link_menu{display:block;height:29px;padding-top:5px;border-top:1px solid #ddd;text-align:center}
    #qnb .link_menu:hover,
    #qnb .link_menu.on{color:#5f0080}
    /* 최근본상품 */
    #qnb .side_recent{position:relative;margin-top:6px;border:1px solid #ddd;background-color:#fff}
    #qnb .side_recent .tit{display:block;padding:22px 0 6px;text-align:center}
    #qnb .side_recent .list_goods{overflow:hidden;position:relative;width:60px;margin:0 auto}
    #qnb .side_recent .list{position:absolute;left:0;top:0}
    #qnb .side_recent .link_goods{display:block;overflow:hidden;width:60px;height:80px;padding:1px 0 2px}
    #qnb .side_recent .btn{display:block;overflow:hidden;width:100%;height:17px;border:0 none;font-size:0;line-height:0;text-indent:-9999px}
    
    #qnb .side_recent .btn_up{position:absolute;left:0;top:0;background:url(https://res.kurly.com/pc/service/main/2002/ico_quick_up_hover.png) no-repeat 50% 50%}
    #qnb .side_recent .btn_up.off{background:url(https://res.kurly.com/pc/service/main/2002/ico_quick_up.png) no-repeat 50% 50%}
    #qnb .side_recent .btn_down{background:url(https://res.kurly.com/pc/service/main/2002/ico_quick_down_hover.png) no-repeat 50% 0}
    #qnb .side_recent .btn_down.off{background:url(https://res.kurly.com/pc/service/main/2002/ico_quick_down.png) no-repeat 50% 0}
    
    
    @media
    only screen and (-webkit-min-device-pixel-ratio: 1.5),
    only screen and (min-device-pixel-ratio: 1.5),
    only screen and (min-resolution: 1.5dppx) {
        #qnb .side_recent .btn_up{background-image:url(https://res.kurly.com/pc/service/main/2002/ico_quick_up_hover_x2.png);background-size:12px 18px}
        #qnb .side_recent .btn_down{background-image:url(https://res.kurly.com/pc/service/main/2002/ico_quick_down_hover_x2.png);background-size:12px 18px}
        #qnb .side_recent .btn_up.off{background-image:url(https://res.kurly.com/pc/service/main/2002/ico_quick_up_x2.png);background-size:12px 18px}
        #qnb .side_recent .btn_down.off{background-image:url(https://res.kurly.com/pc/service/main/2002/ico_quick_down_x2.png);background-size:12px 18px}
    }
    @media all and (max-width: 1250px){
        #qnb{display:none}
    }
</style>


<div id="qnb" class="quick-navigation">
	<div class="bnr_qnb" id="brnQuick">
		<a href="" id="brnQuickObj">
			<img class="thumb" src="https://res.kurly.com/pc/service/main/1904/bnr_quick_20190403.png" alt="퀄리티있게 샛별배송" />
		</a>
	</div>
	<!-- 
	<script>
	    var brnQuick = {
	        nowTime : '1594127671437',
	        update : function(){
	            $.ajax({
	                url : campaginUrl + 'pc/service/bnr_quick.html'
	            }).done(function(result){
	                $('#brnQuick').html(result);
	            });    
	        }
	    }
	    brnQuick.update();
	</script>
	 -->
	<div class="side_menu">
		<a href="" class="link_menu">등급별 혜택</a>
		<a href="" class="link_menu">레시피</a>
		<a href="" class="link_menu">베스트 후기</a>
	</div>
	<div class="side_recent" style="display: none">
		<strong class="tit">최근 본 상품</strong>
		<div class="list_goods">
			<ul class="list">
				<!-- 최근에 클릭한 상품정보 뿌리기 -->
				<!-- 
				<li><a href="" class="link_goods">
					<img src="" alt="" />
				</a></li>
				-->
			</ul>
		</div>
		<button type="button" class="btn btn_up off">최근 본 상품 위로 올리기</button>
		<button type="button" class="btn btn_down off">최근 본 상품 아래로 내리기</button>
		<!-- 버튼 활성화에 따라 클래스에 on / off 추가 설정 -->
	</div>
	
	<%
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		//cal.add(Calendar.HOUR, -1);		// 1시간 전
		cal.add(Calendar.DATE, -1);			// 하루 전 날짜
	%>
	
	<script>
		$(function() {
			goodsRecentUpdate();
		});
		
		// 최근 본 상품
		function goodsRecentUpdate() {
			try{
				var goodsRecent = JSON.parse(localStorage.getItem("goodsRecent"));
				
				if(goodsRecent != null){
					if(goodsRecent[goodsRecent.length-1].time < <%= cal.getTimeInMillis() %>){
						// 저장된지 하루 지나면 삭제..
						localStorage.removeItem("goodsRecent");
					} else{
				         for (var i = goodsRecent.length-1; i >= 0; i--) {
							var a_link = $("<a/>").addClass("link_goods").attr("href", "../goods/goods_view.do?group_no=" + goodsRecent[i].group_no);
							a_link.append($("<img/>").attr("src", "../data/goods/" + goodsRecent[i].group_no + ".jpg"));
							var item = $("<li/>").append(a_link);
							$(".side_recent .list").append(item);
						}				            
						$(".side_recent").show();
						var h = 80 * goodsRecent.length > 160 ? 160 : 80 * goodsRecent.length;
						$(".side_recent .list_goods").css("height", h + "px");
						if(goodsRecent.length > 2){
							$(".side_recent .btn_down").removeClass("off");
						}
					}
				}
	        } catch(e){
	            console.log("JSON parse error from the Quick menu goods list!!!", e);
	        }
		}
	</script>
	
</div>