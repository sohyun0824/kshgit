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

</head>
<body class="board-list">
<div id="wrap" class="">
	<div id="pos_scroll"></div>
	<div id="container">
		<jsp:include page="../main/layout/header.jsp"></jsp:include>
		<div class="layout-wrapper">
			<p class="goods-list-position">
				<a href="마켓컬리 메인페이지">홈</a> &gt; 고객행복센터 &gt; <b>공지사항</b>
			</p>
		</div>
		
		<div id="main">
			<div id="content">
				<jsp:include page="../main/layout/quick_nav.jsp"></jsp:include>
				<div class="page_aticle">
					<div class="page_section">
						<div class="head_aticle">
							<h2 class="tit">
								공지사항 <span class="tit_sub">컬리의 새로운 소식들과 유용한 정보들을 한곳에서 확인하세요.</span>
							</h2>
						</div>
					</div>
				</div>
				<div class="layout-wrapper">
					<div class="xans-element- xans-myshop xans-myshop-couponserial ">
						<table width="100%" align="center" cellpadding="0" cellspacing="0">
							<tbody>
								<tr>
									<td>
										<table width="100%">
											<tbody>
												<tr>
													<td>
														<table class="boardView" width="100%">
															<tbody>
																<tr>
																	<th scope="row" style="border: none;">제목</th>
																	<td>${viewData.title}</td>
																</tr>
																<tr>
																	<th scope="row">작성자</th>
																	<td>MarketKurly</td>
																</tr>
																<tr class="etcArea">
																	<td colspan="2">
																		<ul>
																			<li class="date "><strong class="th">작성일</strong>
																				<span class="td">${viewData.write_date}</span></li>
																			<li class="hit "><strong class="th">조회수</strong> <span
																				class="td">${viewData.readed}</span></li>
																		</ul>
																	</td>
																</tr>
															</tbody>
														</table>
													</td>
												</tr>
												<tr>
													<td align="right" class="eng" style="padding: 5px;"></td>
												</tr>
												<tr>
													<td style="padding: 10px;" height="200" valign="top"
														id="contents">
														<table width="100%" style="table-layout: fixed">
															<tbody>
																<tr>
																	<td class="board_view_content"
																		style="word-wrap: break-word; word-break: break-all"
																		id="contents_717" valign="top">
																		${viewData.content}
																		</td>
																</tr>
															</tbody>
														</table>
													</td>
												</tr>
												<tr>
													<td height="1" bgcolor="#522671"></td>
												</tr>
											</tbody>
										</table>
										<br>
										<table width="100%" style="table-layout: fixed" cellpadding="0"
											cellspacing="0">
											<tbody>
												<tr>
													<td align="center" style="padding-top: 10px;">
														<table width="100%">
															<tbody>
																<tr>
																
																<!-- notice.do?id=notice&page=3 파라미터값을 가져와서  보고있던 페이지 리스트 보여주는 코딩  -->
																	<td align="right">
																		<a href="notice.do?id=notice&page=${currentPage}">
																			<span class="bhs_button yb" style="float: none;">목록</span>
																		</a>
																	</td>
																</tr>
															</tbody>
														</table>
													</td>
												</tr>
											</tbody>
										</table>
										<div
											class="xans-element- xans-board xans-board-movement-1002 xans-board-movement xans-board-1002 ">
											<ul>
											
											<!-- 이전글&다음글  -->
											<!-- 첫번 째 또는 마지막 글 일 경우는 이전글 / 다음글 한가지만 떠야함  (처리완료)-->
											<c:if test="${ viewData.minSeq ne viewData.seq }">
												<li class="prev "><strong>이전글</strong>
													<a href="view.do?notice=${viewData.preSeq}&page=${currentPage }">
														<b>${viewData.preTitle}</b>
													</a>
												</li>
											</c:if>			
											<c:if test="${ viewData.maxSeq ne viewData.seq }">
												<li class="next "><strong>다음글</strong>
													<a href="view.do?notice=${viewData.nextSeq}&page=${currentPage }">
														<b>${viewData.nextTitle}</b>
													</a>
												</li>
											</c:if>
											</ul>
										</div> <br>
									<table width="100%" cellpadding="5" cellspacing="0">
											<colgroup>
												<col width="100" align="right" bgcolor="#f7f7f7"
													style="padding-right: 10px">
												<col style="padding-left: 10px">
											</colgroup>
										</table>
										<p>
											<br>
											<textarea id="examC_717"
												style="display: none; width: 100%; height: 300px">&lt;div style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal; margin: 0px;"&gt;&lt;font color="#222222" face="Font" style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal; margin: 0px;"&gt;고객님, 안녕하세요.&lt;/font&gt;&lt;/div&gt;&lt;div style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal; margin: 0px;"&gt;&lt;font color="#222222" face="Font" style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal; margin: 0px;"&gt;&lt;br&gt;&lt;/font&gt;&lt;/div&gt;&lt;div style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal; margin: 0px;"&gt;&lt;font style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal; margin: 0px;"&gt;&lt;span style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal; margin: 0px;"&gt;&lt;b style="color: rgb(34, 34, 34); font-family: Font;"&gt;"&lt;/b&gt;&lt;/span&gt;&lt;/font&gt;&lt;span style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal; margin: 0px;"&gt;&lt;font color="#222222" face="Font"&gt;&lt;b&gt;[생활공작소] 일회용수세미 60매 브라운 외 5건&lt;/b&gt;&lt;/font&gt;&lt;b style="color: rgb(32, 33, 36); font-family: &amp;quot;Google Sans&amp;quot;, Roboto, RobotoDraft, Helvetica, Arial, sans-serif; font-variant-ligatures: no-contextual;"&gt;"&lt;/b&gt;&lt;/span&gt;&lt;font color="#222222" face="Font"&gt;&amp;nbsp;가격을 조정하게 되어 안내드립니다.&amp;nbsp;&lt;/font&gt;&lt;/div&gt;&lt;div style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal; margin: 0px;"&gt;&lt;font color="#222222" face="Font" style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal; margin: 0px;"&gt;&lt;br style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal; margin: 0px;"&gt;&lt;/font&gt;&lt;/div&gt;&lt;div style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal; margin: 0px;"&gt;&lt;font color="#222222" style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal; margin: 0px;"&gt;&lt;b&gt;# 가격인상 요인&lt;/b&gt;&lt;/font&gt;&lt;/div&gt;&lt;div style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal; margin: 0px;"&gt;&lt;font color="#222222"&gt;&lt;b&gt;1.&amp;nbsp;[생활공작소] 일회용수세미 60매 브라운,&amp;nbsp;[생활공작소] 일회용수세미 60매 그레이 -&amp;nbsp;원단 수급이슈로 일회용 수세미 부자재 가격이 상승&lt;/b&gt;&lt;/font&gt;&lt;/div&gt;&lt;div style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal; margin: 0px;"&gt;&lt;font color="#222222"&gt;&lt;b&gt;&lt;br&gt;&lt;/b&gt;&lt;/font&gt;&lt;/div&gt;&lt;div style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal; margin: 0px;"&gt;&lt;font color="#222222"&gt;&lt;b&gt;2.&amp;nbsp;[선물세트] 잘토 보르도 글래스,&amp;nbsp;[선물세트] 잘토 버건디 글래스,&amp;nbsp;[선물세트] 잘토 유니버셜 글래스,&amp;nbsp;[선물세트] 잘토 샴페인 글래스 -&amp;nbsp;수입원가 인상으로 인한, 판매가 변동 건&lt;/b&gt;&lt;/font&gt;&lt;/div&gt;&lt;div style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal; margin: 0px;"&gt;&lt;br&gt;&lt;/div&gt;&lt;div style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal; margin: 0px;"&gt;&lt;div style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal; margin: 0px;"&gt;위의 사유로 공급가가 상승됨에 따라, 컬리에서도 부득이하게 일정부분 가격조정을 하게 된 점 양해 부탁드립니다.&lt;/div&gt;&lt;/div&gt;&lt;div style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal; margin: 0px;"&gt;&lt;font color="#222222" face="Font" style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal; margin: 0px;"&gt;&lt;br&gt;&lt;/font&gt;&lt;/div&gt;&lt;div&gt;&lt;span style="font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: 700; font-stretch: normal; line-height: normal;"&gt;&lt;font face="Font"&gt;# 가격 조정시점&lt;/font&gt;&lt;/span&gt;&lt;/div&gt;&lt;div&gt;&lt;font face="Font"&gt;&lt;b&gt;&amp;nbsp;-&amp;nbsp;2020년 7월 17일 (금) 오전 11시~&lt;/b&gt;&lt;/font&gt;&lt;/div&gt;&lt;div&gt;&lt;font face="Font"&gt;&lt;b&gt;&lt;br&gt;&lt;/b&gt;&lt;/font&gt;&lt;/div&gt;&lt;div&gt;&lt;img src="//img-cf.kurly.com/shop/data/editor/01389eea9546e539.png"&gt;&lt;br&gt;&lt;/div&gt;&lt;div&gt;&lt;br&gt;&lt;/div&gt;&lt;div&gt;&lt;br&gt;&lt;/div&gt;&lt;div&gt;&lt;span style="font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: 700; font-stretch: normal; line-height: normal;"&gt;&lt;div style="font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: 400; font-stretch: normal; line-height: normal; font-family: Font; margin: 0px;"&gt;좋은 품질, 합리적인 가격으로 만족드릴 수 있도록 항상 최선을 다하겠습니다.&amp;nbsp;&lt;/div&gt;&lt;div style="font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: 400; font-stretch: normal; line-height: normal; font-family: Font; margin: 0px;"&gt;&lt;br&gt;&lt;/div&gt;&lt;div style="font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: 400; font-stretch: normal; line-height: normal; font-family: Font; margin: 0px;"&gt;&lt;div style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal; margin: 0px;"&gt;감사합니다.&lt;/div&gt;&lt;div style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal; margin: 0px;"&gt;&lt;br style="font-stretch: 100%; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: normal; margin: 0px;"&gt;&lt;/div&gt;&lt;div style="font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal; margin: 0px;"&gt;마켓컬리 드림&lt;/div&gt;&lt;/div&gt;&lt;/span&gt;&lt;/div&gt;</textarea>
										</p>
									</td>
								</tr>
							</tbody>
						</table>
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