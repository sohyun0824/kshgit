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

<script>
	/* 
	var jwtToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJjYXJ0X2lkIjoiNzY3NTNmYmI1YjlhODlkZDdmMGExOWJjMmYxZjhkMDgiLCJpc19ndWVzdCI6dHJ1ZSwidXVpZCI6bnVsbCwic3ViIjpudWxsLCJpc3MiOiJodHRwOi8vbWt3ZWIuYXBpLmt1cmx5LnNlcnZpY2VzL3YxL3VzZXJzL2F1dGgvZ3Vlc3QiLCJpYXQiOjE1OTQxMjc2NzEsImV4cCI6MTU5NDEzMTI3MSwibmJmIjoxNTk0MTI3NjcxLCJqdGkiOiJoVThFYVFqUDFxZUZ0WVUwIn0.IccHp3-YySlnj4NHralA3e8jQyFiwZ2XvroGquvo4Bc';
	var apiDomain = 'https://api.kurly.com';
	var GD_ISMEMBER = !!Number('0');
	var checkIsApp = true;// 해당스크립트관련으로 앱체크공용변수추가 생성.앱에서 불필요한 호출제거
	*/
</script>

<!-- 외부 스크립트파일 -->
<!-- <script type="text/javascript" src="../../js/lib/jquery-1.10.2.min.js"></script> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- <script src="../data/skin/designgj/thefarmers.js?ver=1.16.5"></script> -->
<script src="../data/skin/designgj/polify.js?ver=1.16.5"></script>
<script src="../data/skin/designgj/common.js?ver=1.16.5"></script>

<script src="../../common_js/axios.js?ver=1.16.5"></script>
<script src="../../common_js/common_filter.js?ver=1.16.5"></script>
<script src="../../js/lib/moment.min.js"></script>

<!-- quick_nav 관련 스크립트 -->
<script src="../data/skin/designgj/ui_v2.js?ver=1.16.5"></script>

<!-- #main_notice 관련 외부 스크립트, 현재 팝업창 업뎃중..?? -->
<!-- <script src="../../common_js/main_notice_v1.js?ver=1.16.5"></script> -->

<!-- main 관련 외부 스크립트 -->
<!-- <script src="../../common_js/main_v1.js?ver=1.16.5"></script> -->

<!-- vue 자바스크립트 관련 -->
<!-- 
<script src="../../js/vue/xdomain.min.js" slave="https://api.kurly.com/xdomain?ver=1"></script>
<script src="../../js/vue/es6-promise.min.js"></script>
<script src="../../js/vue/es6-promise.auto.min.js"></script>
<script type="text/javascript" src="../../js/vue/axios.min.js"></script>
<script src="../../js/vue/vue.min.js"></script> 
 -->

<!-- 다음 관련..? -->
<!-- <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js?ver=1.16.5"></script> -->

<!-- 네이버 관련..? -->
<!-- 
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript" src="https://www.kurly.com/shop/lib/js/naverCommonInflowScript.js?Path=main/index.php&amp;Referer=&amp;AccountID=s_4f41b5625072&amp;Inflow=" id="naver-common-inflow-script"></script>
-->

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
								<li><a href="../board/notice.do">공지사항</a></li>
								<li class="on"><a href="../service/faq.do">자주하는질문</a></li>
								<li><a href="../mypage/mypage_qna.do">1:1 문의</a></li>
								<c:if test="${ not empty member }">
								<li><a href="">대량주문 문의</a></li>
								</c:if>
								<li><a href="">상품 제안</a></li>
								<li><a href="">에코포장 피드백</a></li>
							</ul>
						</div>
						<a href="" class="link_inquire">
							<span class="emph">도움이 필요하신가요 ?</span>1:1 문의하기
						</a>
					</div>
					<div class="page_section">
						<div class="head_aticle">
							<h2 class="tit"> 자주하는 질문 
								<span class="tit_sub">고객님들께서 가장 자주하시는 질문을 모두 모았습니다.</span>
							</h2>
						</div>
	
						<div class="xans-element- xans-myshop xans-myshop-couponserial ">
							<!-- 카테고리 목록  -->
							<form name="form" id="form" method="get" action="">
								<table class="xans-board-search xans-board-search2" style="height: 37px; margin: 0; border: none;">
									<tbody>
										<tr>
											<td class="stxt" style="font-size: 12px; padding-bottom: 12px; padding-left: 5px;">
												
												<select name="sitemcd" id="sitemcd" onchange="if(this.value) this.form.submit();">
													<option value="00">전체보기</option>
													<option value="01">회원문의</option>
													<option value="02">주문/결제</option>
													<option value="03">취소/교환/반품</option>
													<option value="04">배송문의</option>
													<option value="05">쿠폰/적립금</option>
													<option value="06">서비스 이용 및 기타</option>
												</select>
												<script>
													$("#sitemcd").val('${ sitemcd }');
												</script>
											
											</td>
										</tr>	
									</tbody>
								</table>
								<table width="100%" class="xans-board-listheader">
									<tbody>
										<tr>
											<th width="70" class="input_txt">번호</th>
											<th width="135" class="input_txt">카테고리</th>
											<th class="input_txt">제목</th>
										</tr>
									</tbody>
								</table>
								<div>
									<!-- 반복 문구   -->
									<c:forEach items="${ viewData.faqList }" var="dto">
										<div>
											<table width="100%" class="table_faq"
												onclick="view_content(this)" id="faq_62">
												<tbody>
													<tr>
														<td width="70" align="center">${dto.seq }</td>
														<td width="135" align="center">${dto.name }</td>
														<td style="cursor: pointer">${dto.title }</td>
													</tr>
												</tbody>
											</table>
											<div
												style="display: none; padding: 30px; border-top: 1px solid #e6e6e6">
												<table cellpadding="0" cellspacing="0" border="0">
													<tbody>
														<tr valign="top">
															<th style="color: #0000bf; width: 40px; padding-top: 1px;">
																<img src="../data/skin/designgj/img/common/faq_a.gif">
															</th>
															<td>${dto.content}</td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
									</c:forEach>
								</div>
	
								<div style="padding: 1px; border-top: 1px solid #e6e6e6"></div>
								<!-- 페이징 처리 -->
								<div class="layout-pagination">
									<div class="pagediv">
										<a href="faq.do?page=1&sitemcd=${sitemcd}" class="layout-pagination-button layout-pagination-first-page">맨 처음 페이지로 가기</a>
										<a href="faq.do?page=${ viewData.currentPageNumber - 1 == 0 ? 1 : viewData.currentPageNumber - 1 }&sitemcd=${sitemcd}&searchWord=${searchWord}" class="layout-pagination-button layout-pagination-prev-page">이전 페이지로 가기</a> 
											<c:forEach var="pageNum" begin="1" end="${ viewData.pageTotalCount }">
												<c:if test="${ pageNum eq viewData.currentPageNumber }">
													<strong class="layout-pagination-button layout-pagination-number __active">${pageNum}</strong>
												</c:if>
												<c:if test="${ pageNum ne viewData.currentPageNumber }">
													<a href="faq.do?page=${ pageNum }&sitemcd=${sitemcd}&searchWord=${searchWord}" class="layout-pagination-button layout-pagination-number">${pageNum}</a>
												</c:if>
											</c:forEach>
										<a href="faq.do?page=${ viewData.currentPageNumber + 1 == viewData.pageTotalCount+1 ?  viewData.pageTotalCount : viewData.currentPageNumber + 1 }&sitemcd=${sitemcd}&searchWord=${searchWord}" class="layout-pagination-button layout-pagination-next-page">다음 페이지로 가기</a>
										<a href="faq.do?page=${ viewData.pageTotalCount }&sitemcd=${sitemcd}&searchWord=${searchWord}" class="layout-pagination-button layout-pagination-last-page">맨 끝 페이지로 가기</a>
										
										<!-- 
										<strong class="layout-pagination-button layout-pagination-number __active">1</strong>
										<a href="/shop/service/faq.jpg?&amp;page=2" class="layout-pagination-button layout-pagination-number">2</a>
										<a href="/shop/service/faq.jpg?&amp;page=3" class="layout-pagination-button layout-pagination-number">3</a>
										<a href="/shop/service/faq.jpg?&amp;page=4" class="layout-pagination-button layout-pagination-number">4</a>
										<a href="/shop/service/faq.jpg?&amp;page=5" class="layout-pagination-button layout-pagination-number">5</a>
										 -->
									</div>
								</div>
								<table class="xans-board-search xans-board-search2">
									<tbody>
										<tr>
											<td class="input_txt">&nbsp;</td>
											<td>
												<div class="search_bt">
													<input type="image" src="../data/skin/designgj/img/common/faq_search.png" align="absmiddle"> 
														<input type="text" name="searchWord"	value="${searchWord}" required="">
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</form>
						</div>
	
					</div>
				</div>
				<script>
					var preContent;
		
					function view_content(obj) {
						var div = obj.parentNode;
		
						for (var i = 1, m = div.childNodes.length; i < m; i++) {
							if (div.childNodes[i].nodeType != 1)
								continue; // text node.
							else if (obj == div.childNodes[i])
								continue;
		
							obj = div.childNodes[i];
							break;
						}
		
						if (preContent && obj != preContent) {
							obj.style.display = "  block";
							preContent.style.display = "none";
						} else if (preContent && obj == preContent)
							preContent.style.display = (preContent.style.display == "none" ? "block"
									: "none");
						else if (preContent == null)
							obj.style.display = "block";
		
						preContent = obj;
					}
		
					{ // 초기출력
						var no = "faq_";
						if (document.getElementById(no))
							view_content(document.getElementById(no));
					}
		
					// KM-1483 Amplitude 연동
					KurlyTracker.setScreenName('frequently_ask_question')
				</script>
				
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