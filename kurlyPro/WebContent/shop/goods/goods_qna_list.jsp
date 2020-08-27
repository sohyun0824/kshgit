<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<script type="text/javascript" src="/shop/lib/js/jquery-1.10.2.min.js"></script>
<link rel="styleSheet" href="/shop/data/skin/designgj/normalize.css?ver=1.16.17">
<link rel="styleSheet" href="/shop/data/skin/designgj/common.css?ver=1.16.17">
<link rel="styleSheet" href="/shop/data/skin/designgj/section1.css?ver=1.16.17">
<script id="qna_chk"></script>
<script src="/shop/data/skin/designgj/common.js"></script>
<script src="/shop/data/skin/designgj/polify.js"></script>
<script type="text/javascript">
/*
 * 
		 *function dynamicScript(url) {
			var script = document.createElement("script");
			script.type = "text/javascript";
		
			script.onload = script.onreadystatechange = function() {
				if(!script.readyState || script.readyState == "loaded" || script.readyState == "complete"){
					script.onload = script.onreadystatechange = null;
				}
			}
		
			script.src = url;
			document.getElementsByTagName("head")[0].appendChild(script);
		}
		
		 function popup_register( mode, goodsno, sno )
		{
			if ( mode == 'del_qna' ) var win = window.open("goods_qna_del.php?mode=" + mode + "&sno=" + sno,"qna_register","width=400,height=200");
			else parent.location.href = ("goods_qna_register.php?mode=" + mode + "&goodsno=" + goodsno + "&sno=" + sno);
		
		} 
		
		var preContent;
		var IntervarId;
		
		function view_content(sno, type)
		{
			var obj = document.getElementById('content_id_'+sno);
			if(obj.style.display == "none"){
				dynamicScript("./goods_qna_chk.php?mode=view&sno="+sno);
			}else{
				obj.style.display = "none";
			}
			preContent = obj;
			IntervarId = setTimeout( 'resizeFrame();', 100 );
		
			// KM-1483 Amplitude 연동
			if(type === '0'){
				parent.KurlyTracker.setScreenName('product_inquiry_detail');
			}
		}
		
		function popup_pass(sno){
			var win = window.open("goods_qna_pass.php?sno=" + sno,"qna_register","width=400,height=200");
		}
		
		var count = 0
		var beforeWidth = 0
		var beforeHeight = 0
		// 상품문의는 iframe으로 되어 있어 내부 콘텐츠 size에 따라 iframe size 조절 필요.
		// 이미지가 늦게 로딩되는 경우가 있기 때문에 컨텐츠 size를 여러번 체크 
		// 변경될 경우만 iframe resize함
		function resizeFrame() {
			var oBody = document.body;
			var tb_contents = document.getElementById("contents-wrapper");
			var i_height = tb_contents.offsetHeight;
			var i_width = tb_contents.offsetWidth;
		
			if (i_width === 0){
				i_width = 100;
			}   
			if (i_height === 0){
				i_height  = 100;
			}   
		
			if (beforeHeight !== i_height) {
				parent.resizeFrameHeight('inqna',i_height);
				beforeHeight = i_height;
			}
		
			if (beforeWidth !== i_width) {
				parent.resizeFrameWidth('inqna',i_width);
				beforeWidth = i_width;
			}
		
			if (count > 3) {
				count = 0;
				return;
			}
		
			count++;
			setTimeout(resizeFrame, 500);
		}*/
</script>

<style>
	body *{font-family:'Noto Sans';font-weight:400;letter-spacing:0}
	#contents{border-top: 1px solid #e3e3e3}
	.xans-product-additional img{max-width: 600px !important;}
	.subject{cursor:pointer}
</style>

</head>

<body onload="setTimeout('resizeFrame()',1)" style="overflow-y: hidden;">
	<div id="contents-wrapper">
		<div class="xans-element- xans-product xans-product-additional detail_board  ">
			<div class="board">
				<span class="line"></span>
				<div class="title_txt">
				<h2>PRODUCT Q&amp;A</h2>
					<ul class="list_type1 old">
						<li>
							<span class="ico"></span>
							<p class="txt">상품에 대한 문의를 남기는 공간입니다. 해당 게시판의 성격과 다른 글은 사전동의 없이 담당 게시판으로 이동될 수 있습니다.</p>
						</li>
						<li>
							<span class="ico"></span>
							<p class="txt">배송관련, 주문(취소/교환/환불)관련 문의 및 요청사항은 마이컬리 내 
							<a href="#none" onclick="window.parent.location.href = '/shop/mypage/mypage_qna.php'" class="emph">1:1 문의</a>
							에 남겨주세요.
							</p>
						</li>
					</ul>
				</div>
				<table class="xans-board-listheader" width="100%" border="0" cellpadding="0" cellspacing="0">
					<tbody>
						<tr>
							<th width="70" scope="col" class="input_txt">번호</th>
							<th width="134" scope="col" class="input_txt">카테고리</th>
							<th width="631" scope="col" class="input_txt">제목</th>
							<th width="80" scope="col" class="input_txt">작성자</th>
							<th width="80" scope="col" class="input_txt">작성일</th>
						</tr>
					</tbody>
				</table>

				<!--공지 부분  -->
				<div>
					<table width="100%" class="xans-board-listheaderd">
						<tbody>
							<tr onmouseover="this.style.background='#F7F7F7'" onmouseout="this.style.background=''" onclick="view_content('15968', '1');">
								<td width="70" align="center">공지</td>
								<td width="134"></td>
								<td class="image" style="padding:16px 19px 12px; text-align:left;">
									<div style="padding:3px 0px 0px 20px;"><p class="subject">판매 (일시)중단 제품 안내 (20.07.24 업데이트)</p></div>
								</td>
								<td width="80">Marketkurly</td>
								<td width="80" style="color:#939393">2017-02-01</td>
							</tr>
						</tbody>
					</table>
				</div>

				<!--고객 문의글  -->
				<div id="content_id_15968" style="display:none"></div>
				<div>
					<table width="100%" class="xans-board-listheaderd">
						<tbody>
							<tr onmouseover="this.style.background='#F7F7F7'" onmouseout="this.style.background=''" onclick="view_content('302695', '0');">
								<td width="70" align="center">01</td>
								<td width="134"></td>
								<td class="image" style="padding:16px 19px 12px; text-align:left;">
									<div style="padding:3px 0px 0px 20px;">
										<p class="subject">&nbsp;<img src="https://res.kurly.com/mobile/ico/1812/ico_secret.png" class="ico_secret" alt="비밀글">문의</p>
									</div>
								</td>
								<td width="80">테스트</td>
								<td width="80" style="color:#939393">2020-07-31</td>
							</tr>
						</tbody>
					</table>
				</div>

				<!-- 문의글 답글  -->
				<div>
					<table width="100%" class="xans-board-listheaderd">
						<tbody>
							<tr onmouseover="this.style.background='#F7F7F7'" onmouseout="this.style.background=''" onclick="view_content('301748', '0');">
								<td width="70" align="center">02</td>
								<td width="134"></td>
								<td class="image" style="padding:16px 19px 12px; text-align:left">
									<div style="background-image: url(/shop/data/skin/designgj/images/goods/ico_re.gif); background-repeat:no-repeat;background-position:left 3px;padding:3px 0px 0px 27px;">
										<p class="subject">안녕하세요, 마켓컬리입니다.</p>
									</div>
								</td>
								<td width="80">MarketKurly</td>
								<td width="80" style="color:#939393">2020-07-31</td>
							</tr>
						</tbody>
					</table>
				</div>

				<p class="btnArea after">
					<a href="/shop/goods/goods_qna.php?&amp;" target="_parent">
						<span class="bhs_button" style="line-height:30px; width:130px;">전체보기</span>
					</a>
					<a href="javascript:;" onclick="">
						<span class="bhs_button" style="line-height:30px; width:130px;">상품문의</span>
					</a>
				</p>
			</div>
		</div>
		<div style="clear:both;text-align:center;padding-bottom:15px;">
			<a href="/shop/goods/goods_qna_list.php?goodsno=26097&amp;page=1" class="layout-pagination-button layout-pagination-first-page">맨 처음 페이지로 가기</a>
			<a href="/shop/goods/goods_qna_list.php?goodsno=26097&amp;page=1" class="layout-pagination-button layout-pagination-prev-page">이전 페이지로 가기</a>
			<strong class="layout-pagination-button layout-pagination-number __active">1</strong>
			<a href="/shop/goods/goods_qna_list.php?goodsno=26097&amp;page=2" class="layout-pagination-button layout-pagination-next-page">다음 페이지로 가기</a>
			<a href="/shop/goods/goods_qna_list.php?goodsno=26097&amp;page=26" class="layout-pagination-button layout-pagination-last-page">맨 끝 페이지로 가기</a>
		</div>
	</div>
<script src="chrome-extension://hhojmcideegachlhfgfdhailpfhgknjm/web_accessible_resources/index.js"></script>
</body>
</html>