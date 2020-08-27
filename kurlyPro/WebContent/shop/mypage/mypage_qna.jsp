<%@page import="shop.member.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	MemberDTO member = (MemberDTO)session.getAttribute("member");

	// 세션 만료되었을 경우 대비, 로그인상태인지 확인
	if(member == null){
		%>
		<script>
			alert("로그인하셔야 본 서비스를 이용하실 수 있습니다.\n로그인 화면으로 이동합니다.");
			location.href="../member/login.do?return_url=/kurlyPro/shop/mypage/mypage_qna.do";
		</script>
		<%
	}
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
<body class="mypage-mypage_review">
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
								<li><a href="../service/faq.do">자주하는질문</a></li>
								<li class="on"><a href="../mypage/mypage_qna.do">1:1 문의</a></li>
								<c:if test="${ not empty member }">
								<li><a href="">대량주문 문의</a></li>
								</c:if>
								<li><a href="">상품 제안</a></li>
								<li><a href="">에코포장 피드백</a></li>
							</ul>
						</div>
						<!-- 1:1문의하기 제작 후 링크 연결필요!!! -->
						<a href="../mypage/mypage_qna.do"	class="link_inquire">
							<span class="emph">도움이 필요하신가요 ?</span>1:1 문의하기
						</a>
					</div>
					<div class="page_section section_qna">
						<div class="head_aticle">
							<h2 class="tit">1:1 문의</h2>
						</div>
						<!-- 1:1 문의 리스트 목차  -->
						<table class="xans-board-listheader" width="100%">
							<tbody>
								<tr class="input_txt">
									<th width="8%">번호</th>
									<th width="15%">카테고리</th>
									<th>제목</th>
									<th width="12%">작성자</th>
									<th width="12%">작성일</th>
								</tr>
							</tbody>
						</table>
						<!-- 반복 문구  -->
	 					<c:forEach items="${viewData.qnaList }" var="dto">
						<div class="mypage_wrap" style="float: none; width: 100%">
							<table class="table_faq" width="100%" onclick="view_content(this, event)">
								<tbody>
									<tr>
										<td width="8%" align="center">${dto.pq_code}</td>
										<td width="15%" align="center" class="stxt">
											<b>${dto.name}</b>
										</td>
										<td style="padding-top: 5px; padding-bottom: 5px;">
											${dto.title}
											<span style="color: #007FC8;" class="stxt"><!--  답글할경우 답글 [1] 표시 --> </span>
										</td>
										<td width="12%" align="center">${dto.m_id}</td>
										<td width="12%" align="center">${dto.write_date}</td>
									</tr>
								</tbody>
							</table>
							<!-- 문의 내용 상세보기 -->
							<div	style="display: none; padding: 30px; border-top: 1px solid #e6e6e6">
								<div width="100%" style="padding-left: 55px; padding-bottom: 20px;">
									[주문번호 ${dto.order_no} 문의]
								</div>
								<div width="100%" style="padding-left: 55px;"> 
										<!--  현재 if문이 적용되지 않고 있음  --> 
										<%-- ${  viewData.qnaList.size() }개 --%>
									    <c:if test="${not  empty viewData.qnaList}">
									    	<c:forEach items="${dto.file_list }" var="file">
		                          				 <img src='./qna_file/${file}' alt="첨부파일" />
		                       				</c:forEach>
	                     				</c:if>
	                 				${dto.content}
								</div>
								<div class="goods-review-grp-btn" style="text-align: right;">
									<button type="button" class="styled-button" onclick="popup_register( 'mod_qna', '2387084' );">수정</button>
								</div>
							</div>
						</div>
	 					</c:forEach>
						<!-- 1:1문의 답변, 내용 상세보기 
						<div class="mypage_wrap" style="float: none; width: 100%">
							<table width="100%" class="replayD"
								onclick="view_content(this, event)">
								<tbody>
									<tr>
										<td width="8%" align="center">답변코드</td>
										<td width="15%" align="right"><img src="/kurlyPro/shop/data/skin/designgj/img/common/myqna_answer.gif"></td>
										<td style="padding-top: 5px; padding-bottom: 5px;" class="stxt">답변제목</td>
										<td width="12%" align="center">답변작성자</td>
										<td width="12%" align="center">답변작성날짜</td>
									</tr>
								</tbody>
							</table>
							<div	style="display: none; padding: 30px; border-top: 1px solid #e6e6e6">
								<div width="100%" style="padding-left: 55px;">
									답변내용
								</div>
								<div class="goods-review-grp-btn" style="text-align: right;">
								</div>
							</div>
						</div>
	 					-->
						<!--  글쓰기 처리  -->					
						<div style="position: relative">
							<div style="position: absolute; right: 0; top: 60px;">
								<a href="mypage_qna_write.do";>
									<span class="bhs_buttonsm yb" style="float: none;">글쓰기</span>
								</a>
							</div>
						</div>
						<!--  페이징 처리  -->
						<div class="layout-pagination">
							<div class="pagediv">
								<a href="mypage_qna.do?page=1" class="layout-pagination-button layout-pagination-first-page">맨 처음 페이지로 가기</a>
								<a href="mypage_qna.do?page=${ viewData.currentPageNumber - 1 == 0 ? 1 : viewData.currentPageNumber - 1 }" class="layout-pagination-button layout-pagination-prev-page">이전 페이지로 가기</a> 
									<c:forEach var="pageNum" begin="1" end="${ viewData.pageTotalCount }">
										<c:if test="${ pageNum eq viewData.currentPageNumber }">
											<strong class="layout-pagination-button layout-pagination-number __active">${pageNum}</strong>
										</c:if>
										<c:if test="${ pageNum ne viewData.currentPageNumber }">
											<a href="mypage_qna.do?page=${ pageNum }" class="layout-pagination-button layout-pagination-number">${pageNum}</a>
										</c:if>
									</c:forEach>
								<a href="mypage_qna.do?page=${ viewData.currentPageNumber + 1 == viewData.pageTotalCount+1 ?  viewData.pageTotalCount : viewData.currentPageNumber + 1 }" class="layout-pagination-button layout-pagination-next-page">다음 페이지로 가기</a>
								<a href="mypage_qna.do?page=${ viewData.pageTotalCount }" class="layout-pagination-button layout-pagination-last-page">맨 끝 페이지로 가기</a>
								
							</div>
						</div>
					</div>
				</div>
			
				<!-- 1)
							문의내용,
						    수정,
							답변 내용 display 관련 script
				-->
				<script type="text/javascript">
					function popup_register(mode, sno) {
						if (mode == 'del_qna')
							var win = window.open(
									"../mypage/mypage_qna_del.php?mode=" + mode
											+ "&sno=" + sno, "qna_register",
									"width=400,height=200");
						else
							parent.location.href = ("../mypage/mypage_qna_write.do?mode="	+ mode + "&sno=" + sno);
	
					}
	
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
							obj.style.display = "block";
							preContent.style.display = "none";
							preCheck = false
						} else if (preContent && obj == preContent) {
							preContent.style.display = (preContent.style.display == "none" ? "block" : "none");
						} else if (preContent == null) {
							obj.style.display = "block";
						}	
	
						preContent = obj;
	
						if (preContent.style.display === 'block') {
							KurlyTracker.setScreenName('personal_inquiry_detail');
						} else {
							KurlyTracker.setScreenName('personal_inquiry_history');
						}
					}
	
					// KM-1483 Amplitude 연동
					KurlyTracker.setScreenName('personal_inquiry_history');
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