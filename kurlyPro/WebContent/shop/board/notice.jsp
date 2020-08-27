<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

<style>
.search_bt select{
	margin:0 2px 0 10px;
	width:120px;
	border:1px solid #bfbfbf;
	line-height:34px;
	height:34px;
	vertical-align:middle;
	padding-bottom:5px;
	float:right}
	
.notice .layout-pagination {
	margin: 0
}

.eng2 {
	color: #939393
}

.xans-board-listheader {
	font-size: 12px
}
</style>

</head>
<body class="board-list">
<div id="wrap" class="">
	<div id="pos_scroll"></div>
	<div id="container">
		<jsp:include page="../main/layout/header.jsp"></jsp:include>
		
		<div id="main">
			<div id="content">
				<jsp:include page="../main/layout/quick_nav.jsp"></jsp:include>
				
				<div class="page_aticle aticle_type2">
					<div id="snb" class="snb_cc">
						<h2 class="tit_snb">고객센터</h2>
						<div class="inner_snb">
							<ul class="list_menu">
								<li class="on"><a href="../board/notice.do">공지사항</a></li>
								<li><a href="../service/faq.do">자주하는질문</a></li>
								<li><a href="../mypage/mypage_qna.do">1:1 문의</a></li>
								<c:if test="${ not empty member }">
								<li><a href="">대량주문 문의</a></li>
								</c:if>
								<li><a href="">상품 제안</a></li>
								<li><a href="">에코포장 피드백</a></li>
							</ul>
						</div>
						<!-- 1:1문의하기 제작 후 링크 연결필요!!! -->
						<a href=""	class="link_inquire">
							<span class="emph">도움이 필요하신가요 ?</span>1:1 문의하기
						</a>
					</div>
					<div class="page_section">
						<div class="head_aticle">
							<h2 class="tit">공지사항
								<span class="tit_sub">컬리의 새로운 소식들과 유용한 정보들을 한곳에서 확인하세요.</span>
							</h2>
						</div>
						<form name="frmList" action="notice.do" onsubmit="return chkFormList(this)">
							<input type="hidden" name="id" value="notice">

							<table width="100%" align="center" cellpadding="0" cellspacing="0">
								<tbody>
									<tr>
										<td>
											<div class="xans-element- xans-myshop xans-myshop-couponserial ">
												<table width="100%" class="xans-board-listheader jh" cellpadding="0" cellspacing="0">
													<tbody>
														<tr>
															<th>번호</th>
															<th>제목</th>
															<th>작성자</th>
															<th>작성일</th>
															<th>조회</th>
														</tr>
														<!-- 공지사항 게시글 반복 -->
														<c:forEach items="${viewData.noticeList }" var ="dto">
														<tr>
															<td width="50" nowrap="" align="center">공지</td>
															<td style="padding-left: 10px; text-align: left; color: #999">
																<a href="view.do?notice=${dto.seq}&page=${viewData.currentPageNumber }"><b>${dto.title}</b></a>
															</td>
															<td width="100" nowrap="" align="center">MarketKurly</td>
															<td width="100" nowrap="" align="center" class="eng2">${dto.write_date}</td>
															<td width="30" nowrap="" align="center" class="eng2">${dto.readed}</td>
														</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
		
							<!-- *** 페이징 처리 필요 ***  -->
							<!-- layout-pagination common.css 링크태그  -->
							<div class="layout-pagination">
								<div class="pagediv">
									<a href="notice.do?page=1" class="layout-pagination-button layout-pagination-first-page">맨 처음 페이지로 가기</a>
									<a href="notie.do?page=${ viewData.currentPageNumber - 1 == 0 ? 1 : viewData.currentPageNumber - 1 }&searchCondition=${searchCondition}&searchWord=${searchWord}" class="layout-pagination-button layout-pagination-prev-page">이전 페이지로 가기</a>
									<c:forEach var="pageNum" begin="1" end="${ viewData.pageTotalCount }">
										<c:if test="${ pageNum eq viewData.currentPageNumber }">
											<strong	class="layout-pagination-button layout-pagination-number __active">${ pageNum }</strong>
										</c:if>
										<c:if test="${ pageNum ne viewData.currentPageNumber }">
											<a href="notice.do?page=${ pageNum }&searchCondition=${searchCondition}&searchWord=${searchWord}" class="layout-pagination-button layout-pagination-number">${ pageNum }</a>
										</c:if>
									</c:forEach>
									<a href="notice.do?page=${ viewData.currentPageNumber + 1 == viewData.pageTotalCount+1 ?  viewData.pageTotalCount : viewData.currentPageNumber + 1 }&searchCondition=${searchCondition}&searchWord=${searchWord}" class="layout-pagination-button layout-pagination-next-page">다음페이지로 가기</a>
									<a href="notice.do?page=${ viewData.pageTotalCount }&searchCondition=${searchCondition}&searchWord=${searchWord}" class="layout-pagination-button layout-pagination-last-page">맨 끝 페이지로 가기</a>
								</div>
							</div>

<!-- 						
							<a href="list.php?id=notice&amp;page=2" class="layout-pagination-button layout-pagination-number">2</a>
							<a href="list.php?id=notice&amp;page=3" class="layout-pagination-button layout-pagination-number">3</a>
							<a href="list.php?id=notice&amp;page=4" class="layout-pagination-button layout-pagination-number">4</a>
							<a href="list.php?id=notice&amp;page=5" class="layout-pagination-button layout-pagination-number">5</a>
							<a href="list.php?id=notice&amp;page=6" class="layout-pagination-button layout-pagination-number">6</a>
							<a href="list.php?id=notice&amp;page=7" class="layout-pagination-button layout-pagination-number">7</a>
							<a href="list.php?id=notice&amp;page=8" class="layout-pagination-button layout-pagination-number">8</a>
							<a href="list.php?id=notice&amp;page=9" class="layout-pagination-button layout-pagination-number">9</a>
							<a href="list.php?id=notice&amp;page=10" class="layout-pagination-button layout-pagination-number">10</a>
-->
							<table class="xans-board-search xans-board-search2">
								<tbody>
									<tr>
										<td class="input_txt">&nbsp;</td>
										<td>
										<!--  검색조건  -->
										<select name="searchCondition" id="searchCondition" >
											<option value="1" selected="selected">선택</option>
											<option value="2" >제목</option>
											<option value="3" >내용</option>
											<option value="4" >제목+내용</option>
										</select>
										<script>
											$("#searchCondition").val('${ searchCondition }');
										</script>
										<!--
										   $("select.list").on("change", function() {
											      var select = $(this).children(":selected").text();
											      $(this).prev().text(select);
											   });
									  	-->
										</td>
										<td>
											<!-- 검색버튼 클릭 -> 검색  -->
											<!-- search_bt로 section1.css 링크태그에 입력 -->
											<div class="search_bt">
												<!-- 수정필요 !!!  -->
												<a href="notice.do?searchCondition=${searchCondition}&searchWord=${searchWord}" id="searchLink">
													<img src="../data/skin/designgj/img/common/faq_search.png" align="absmiddle">
												</a> 
												<input type="text"name="searchWord" id="searchWord" value="${searchWord}" required="" >
											</div>
											<script>
												// 검색 마크 눌렀을 때 검색 이벤트 실행
												$("#searchLink").click(function()
														{
													searchBtnClick();
																//이벤트가 실행되는거를 방지
																//event.preventDefault();
																//var searchCondition = $("#searchCondition").val();
																//var searchWord = $("#searchWord").val();
																//location.href="/kurlyPro/shop/board/notice.do?searchCondition="+searchCondition+"&searchWord="	+searchWord	
														 });
												function searchBtnClick(){
													//이벤트가 실행되는거를 방지
													event.preventDefault();
													var searchCondition = $("#searchCondition").val();
													var searchWord = $("#searchWord").val();
													location.href="notice.do?searchCondition="+searchCondition+"&searchWord="	+searchWord	
												};
												
												// 엔터키 눌렀을 때 검색 이벤트 실행
												
											</script>
										</td>
									</tr>
								</tbody>
							</table>
						</form>
					</div>
				</div>
				
			</div>
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