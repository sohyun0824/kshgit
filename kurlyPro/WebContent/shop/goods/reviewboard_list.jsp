<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="styleSheet" href="../data/skin/designgj/normalize.css?ver=1.16.17">
<link rel="styleSheet" href="../data/skin/designgj/common.css?ver=1.16.17">
<link rel="styleSheet" href="../data/skin/designgj/section1.css?ver=1.16.17">
<script type="text/javascript" src="https://www.kurly.com/shop/lib/js/jquery-1.10.2.min.js"></script>
<script src="https://www.kurly.com/shop/data/skin/designgj/common.js?ver=1.16.17"></script>
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript" src="https://www.kurly.com/shop/lib/js/naverCommonInflowScript.js?Path=goods/goods_review_list.php&amp;Referer=https%3A%2F%2Fwww.kurly.com%2Fshop%2Fgoods%2Fgoods_view.php%3F%26goodsno%3D26097&amp;AccountID=s_4f41b5625072&amp;Inflow=" id="naver-common-inflow-script"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
        body *{font-family:'Noto Sans';font-weight:400;letter-spacing:0}
        /* 제목부분 글줄임처리 */
        .goods_board .tbl_newtype1
        .xans-product-additional table.tbl_newtype1 td{padding:20px 3px 22px;line-height:20px}
        .xans-product-additional table.tbl_newtype1 td .snd{display:none}
        .xans-product-additional .on table.tbl_newtype1 td .fst{display:none}
        .xans-product-additional .on table.tbl_newtype1 td .snd{display:block}
        /* 고객후기_제목 */
        .goods_board .tbl_newtype1 .subject{padding-left:50px;text-align:left;}
        .goods_board .tbl_newtype1 .subject .tit_notice{padding-left:20px;background:url(/shop/data/skin/designgj/images/goods/ico_re.gif) no-repeat 0 3px}
        .goods_board .tbl_newtype1 .time{color:#939393}
        /* 고객후기_상세 */
        .goods_board .name_purchase .name{display:block;font-weight:700;font-size:12px;color:#514859;line-height:18px}
        .goods_board .name_purchase .package{padding-top:2px;font-size:14px;color:#000;line-height:20px}
        .goods_board .review_photo{padding-top:30px;line-height:16px}
        .goods_board .review_view{display:none;padding:10px 10px 11px;border-top:1px solid #e3e3e3;}
        .goods_board .review_view .inner_review{width:100%;padding:20px 9px 9px;line-height:25px}
        .goods_board .review_notice .name_purchase{display:none}
        .goods_board .review_notice .review_photo{display:none}
        .goods_board .goods-review-grp-btn .styled-button{height:32px}
        /* 고객후기 없을때 */
        .goods_board .no_data{padding:30px;text-align:center}
        /* 페이징영역 */
        .goods_board .board_pg_area{clear:both;text-align:center;padding-bottom:15px}
</style>
<script>
/*         var GD_ISMEMBER = !!Number('0'); */
    </script>

<script type="text/javascript">

      /*   
      // 회원전용 & 로그인전
        function popup_register(mode,goodsno,sno){
            if ( mode == 'del_review' ){
                var win = window.open("goods_review_del.php?mode=" + mode + "&sno=" + sno,"review_register","width=400,height=200");
            }else if( mode == 'mod_review'){
                parent.location.href = ('/shop/goods/goods_review_register.php?mode=' + mode + '&goodsno=' + goodsno + '&ordno=' + undefined + '&sno=' + sno);
            }else if(mode == 'reply_review'){
                parent.location.href = ('/shop/goods/goods_review_register.php?mode=' + mode + '&goodsno='+ goodsno + '&sno=' + sno);
            }else{
                parent.location.href = ("/shop/mypage/mypage_review.php?write_goodsno="+ goodsno);
            }
            win.focus();
        } */
 
        var preContent;
        var IntervarId;

        function view_content(obj, e, type){
            //===: 값'과 '타입/형식?'이 정확하게 같은지를 판단해서 true/false를 표현
             if(type === 'notice'){
                $('.review_view').addClass('review_notice');    
            }else{
                $('.review_view').removeClass('review_notice');

                 // KM-1483 Amplitude 연동
                trackerReview.reviewAction($(obj).find('tr')); 
            }
            var tagName = e.srcElement ? e.srcElement.tagName : e.target.tagName;

            if ( document.getElementById && ( tagName == 'A' || tagName == 'IMG' ) ) return;
            else if ( !document.getElementById && ( tagName == 'A' || tagName == 'IMG' ) ) return;

            var div = obj.parentNode;

            for (var i=1, m=div.childNodes.length;i<m;i++) {
                if (div.childNodes[i].nodeType != 1) continue;	// text node.
                else if (obj == div.childNodes[ i ]) continue;

                obj = div.childNodes[ i ];
                break;
            }

            if($(obj).find('.review_photo').html() === ''){
                $.ajax({
                    url: "https://www.kurly.com/shop/goods/ajax_review_img.php",
                    type: "POST",
                    data: {sno: $(obj).data("sno")},
                    dataType: "html",
                    success: function (result) {
                        if(result){
                            result += '<br>';
                            $(obj).find('.review_photo').append(result);
                            resizeFrame();
                        }
                    }
                }).done(function() {resizeFrame();});    
            }

            if (preContent && obj!=preContent){
                obj.style.display = "block";
                preContent.style.display = "none";
            }else if (preContent && obj==preContent){
                preContent.style.display = ( preContent.style.display == "none" ? "block" : "none" );
            }else if (preContent == null ){
                obj.style.display = "block";
            }

            if(obj.style.display == 'block'){
                var sno = $(obj).data('sno');
                $(obj).parent().addClass('on').siblings().removeClass('on');
                review_addhit(sno);
            }

            preContent = obj;

            // 2017-12-22 장차석 : 내용이 긴 컨테츠가 닫히면, 페이지 하단에 화면 붙는 이슈 수정
            var objPosition =  $('#inreview', parent.document).offset().top;
            $('html,body', parent.document).scrollTop(objPosition);

            resizeFrame();
        }
        
        function resizeFrame(){
            //var oBody = document.body;
            //var tb_contents = document.getElementById("contents-wrapper");
            var i_height = $('#contents-wrapper').outerHeight();
            //console.log(i_height);
            if ( ! i_height) {
                i_height = $('body').outerHeight();
            }
            //console.log( i_height );

            parent.resizeFrameHeight('inreview',i_height);
            if ( IntervarId ) clearInterval( IntervarId );
        }
        $(resizeFrame);
 
        /**
         // KM-1483 Amplitude
        var trackerReview = (function(){
          
             * 상품정보를 최초 한번만 호출하여 해당 정보값 가지고 있어야함.
             * shop\data\skin_mobileV2\designgj\myp\review.htm 에서 호출
             * trackerReview._goodsViewInfo('26097');
         
            var _goodsViewData = {}

             function _goodsViewInfo(no){
                $.ajax({
                    url: 'https://api.kurly.com' + '/v3/home/products/' + no
                }).done(function(response){
                    _goodsViewData = response.data;
                }).fail(function(e){
                    console.log("ERROR on products API calling!!!", e);
                });
            } 

            function reviewAction($target){
                var _action_data = {};
                _action_data.position = $target.find('[name=index]').val();
                _action_data.thumbnail_image_url = $target.find('[name=image]').val() !== '' ? true : false;
                _action_data.user_grade = $target.find('[name=grade]').val();
                _action_data.pNo = $target.find('[name=pNo]').val();
                _action_data.is_best = $target.find('[name=best]').val() === 'true' ? true : false;
                actionData(_action_data);
            }

            function actionData(data){
                var items, i, len;
                items = _goodsViewData;
                
                data.original_price = items.original_price;
                data.price = items.discounted_price;
                
                if(items.package_products.length > 0){
                    len = items.package_products.length;
                    for(i = 0;i < len; i++){
                        if(data.pNo === items.package_products[i].product_no){
                            data.parent_product_no = items.no;
                            data.parent_product_name = items.name
                            data.product_no = items.package_products[i].no;
                            data.product_name = items.package_products[i].name;
                        }
                    }
                }else{
                    data.product_no = items.no;
                    data.product_name = items.name;
                }
                sendData(data);
            }

             function sendData(data){
                parent.KurlyTracker.setScreenName('product_review_detail');
                parent.KurlyTracker.setAction('view_review_detail', data).sendData();
            } 
            return {
                _goodsViewInfo: _goodsViewInfo,
                reviewAction : reviewAction
            }
        })();
        trackerReview._goodsViewInfo('26097');
         */
    </script>
</head>
<body style="overflow-y: hidden;">
	<div id="contents-wrapper" class="goods_board">
		<div class="xans-element- xans-product xans-product-additional detail_board  ">
			<div class="board">
				<span class="line"></span>
				<form name="frmList">
					<input type="hidden" name="sort" value="">
					<input type="hidden" name="page_num" value="">
					<input type="hidden" name="goodsno" value="26097">
					<div class="title_txt">
						<h2>PRODUCT REVIEW</h2>
						<div class="sort-wrap">
							<ul class="list_type1 old">
								<li>
									<span class="ico"></span>
									<p class="txt">상품에 대한 문의를 남기는 공간입니다. 해당 게시판의 성격과 다른 글은 사전동의 없이 담당 게시판으로 이동될 수 있습니다.</p>
								</li>
								<li>
									<span class="ico"></span>
									<p class="txt">배송관련, 주문(취소/교환/환불)관련 문의 및 요청사항은 마이컬리 내 
										<a href="../mypage/mypage_qna.do'" class="emph">1:1 문의</a>
												에 남겨주세요.
									</p>
								</li>
							</ul>
							<div class="sort" style="bottom:-9px"> 
								<select name="choose" id="choose" >
									<option value="1" <c:if test="${param.choose eq '1'}"> selected='selected' </c:if>>최근등록순</option>
									<option value="2" <c:if test="${param.choose eq '2'}"> selected='selected' </c:if>>좋아요많은순</option>
									<option value="3" <c:if test="${param.choose eq '3'}"> selected='selected' </c:if>>조회많은순</option>
								</select>										
							</div>
						</div>
					</div>

				
					<table class="xans-board-listheader" width="100%" border="0" cellpadding="0" cellspacing="0">
						<caption style="display:none">구매후기 제목</caption>
						<colgroup>
							<col style="width:70px;">
							<col style="width:auto;">
							<col style="width:51px;">
							<col style="width:77px;">
							<col style="width:100px;">
							<col style="width:40px;">
							<col style="width:80px;">
						</colgroup>
						<tbody>
							<tr>
								<th scope="col" class="input_txt">번호</th>
								<th scope="col" class="input_txt">제목</th>
								<th scope="col" class="input_txt">
									<span class="screen_out">회원 등급</span>
								</th>
								<th scope="col" class="input_txt" align="left">작성자</th>
								<th scope="col" class="input_txt">작성일</th>
								<th scope="col" class="input_txt">도움</th>
								<th scope="col" class="input_txt">조회</th>
							</tr>
						</tbody>
					</table>
						
					<script>
						function view_content(obj){
							 $(obj).parent().addClass('on').siblings().removeClass('on');
						 	$(obj).next().toggle(); 
						 	 
						 		/* $("#inreview").scrolling="no";
						         var iHeight =$("#inreview").contents().height();
						         $("#inreview").height( iHeight );
						         alert(iHeight)  */
						};
					</script>
					
					 <c:forEach items="${ noticelist }" var="dto">
					<div class="tr_line">
						<table class="xans-board-listheaderd tbl_newtype1" width="100%" cellpadding="0" cellspacing="0" onclick="view_content(this)">
						<!-- this,event,'notice' -->
							<caption style="display:none">구매후기 내용</caption>
							<colgroup>
								<col style="width:70px;">
								<col style="width:auto;">
								<col style="width:51px;">
								<col style="width:77px;">
								<col style="width:100px;">
								<col style="width:40px;">
								<col style="width:80px;">
							</colgroup>
							<tbody>
								<tr>
									<input type="hidden" name="index" value="0">
									<input type="hidden" name="image" value="">
									<input type="hidden" name="grade" value="0">
									<input type="hidden" name="best" value="false">
									<input type="hidden" name="pNo" value="">

									<td align="center">${dto.reviewed_no}</td>
									<td class="subject">
									<div class="fst">${dto.title}</div>	
								 	<div class="snd">${dto.title}</div>  
									
									</td>
									<td class="user_grade grade_comm"></td>
									<td class="user_grade">${dto.name}</td>
									<td class="time">${dto.write_date}</td>
									<td>
										<span class="review-like-cnt" data-sno="6412546">${dto.helped}</span>
									</td>
									<td>
										<span class="review-hit-cnt" data-sno="6412546">${dto.readed}</span>
									</td>
								</tr>
							</tbody>
						</table>
						
						<div data-sno="6412546" class="review_view">
							<div class="inner_review">
								<div class="name_purchase">
									<strong class="name"></strong>
										<p class="package"></p>
								</div>
								<div class="review_photo"></div>
								${dto.content}
								</div>
							<div class="goods-review-grp-btn"></div>
						</div>
					</div>
					</c:forEach> 
					
					<div id="m_review">
					
					 <c:forEach items="${ reviewBoard.reviewlist }" var="dto">
					<div class='tr_line'>
						<table class='xans-board-listheaderd tbl_newtype1' width='100%' cellpadding='0' cellspacing='0' onclick='view_content(this)'>
						<!-- this,event,'notice' -->
							<caption style='display:none'>구매후기 내용</caption>
							<colgroup>
								<col style='width:70px;'>
								<col style='width:auto;'>
								<col style='width:51px;'>
								<col style='width:77px;'>
								<col style='width:100px;'>
								<col style='width:40px;'>
								<col style='width:80px;'>
							</colgroup>
							<tbody>
								<tr>
									<input type='hidden' name='index' value='0'>
									<input type='hidden' name='image' value=''>
									<input type='hidden' name='grade' value='0'>
									<input type='hidden' name='best' value='false'>
									<input type='hidden' name='pNo' value=''>

									<td align='center'>${dto.reviewed_no}</td>
									<td class='subject'>
									<div class='fst'>${dto.title}</div>	
									<div class='snd'>${dto.title}</div> 
									
									<div class='snd'>${dto.title}</div>
									</td>
									<td class='user_grade grade_comm'></td>
									<td class='user_grade'>${dto.name}</td>
									<td class='time'>${dto.write_date}</td>
									<td>
										<span class='review-like-cnt' data-sno='6412546'>${dto.helped}</span>
									</td>
									<td>
										<span class='review-hit-cnt' data-sno='6412546'>${dto.readed}</span>
									</td>
								</tr>
							</tbody>
						</table>
						
						<div data-sno='6412546' class='review_view'>
							<div class='inner_review'>
								<div class='name_purchase'>
									<strong class='name'></strong>
										<p class='package'></p>
								</div>
								<div class='review_photo'></div>
								${dto.content }
								</div>
							<div class='goods-review-grp-btn'></div>
						</div>
					</div>
						</c:forEach> 
					
					</div>
					
					
					
				</form>
				<p class="btnArea after">
					<a href="/kurlyPro/shop/mypage/mypage_review.do" >
						<span class="bhs_button" style="line-height:30px; width:130px;">후기쓰기</span>
					</a>
				</p>
			</div>
		</div>
		
		<div class="layout-pagination">
			<div class="pagediv">
				<a href="goods_view.do?group_no=${ group_no }&page=1#goods-review" class="layout-pagination-button layout-pagination-first-page">맨 처음 페이지로 가기</a>
				<a href="goods_view.do?group_no=${ group_no }&page=${ reviewBoard.currentPage - 1 == 0 ? 1 : reviewBoard.currentPage - 1 }#goods-review" class="layout-pagination-button layout-pagination-prev-page">이전 페이지로 가기</a>
					
					<c:forEach var="pageNum" begin="1" end="${ reviewBoard.pageTotal }">
						<c:if test="${ pageNum eq reviewBoard.currentPage }">
							<strong	class="layout-pagination-button layout-pagination-number __active">${ pageNum }</strong>
						</c:if>
						<c:if test="${ pageNum ne reviewBoard.currentPage }">
							<a href="goods_view.do?group_no=${ group_no }&page=${ pageNum }#goods-review" class="layout-pagination-button layout-pagination-number">${ pageNum }</a>
						</c:if>
					</c:forEach>
					
				<a href="goods_view.do?group_no=${ group_no }&page=${ reviewBoard.currentPage + 1 == reviewBoard.pageTotal+1 ?  reviewBoard.pageTotal : reviewBoard.currentPage + 1 }#goods-review" class="layout-pagination-button layout-pagination-next-page">다음페이지로 가기</a>
				<a href="goods_view.do?group_no=${ group_no }&page=${ reviewBoard.pageTotal }#goods-review" class="layout-pagination-button layout-pagination-last-page">맨	끝 페이지로 가기</a>
			</div>
		</div>
		
		<script>	
			$(function() {
				function selectReview(page) {
					//여기서 ajax 처리하기
					var choose = $("#choose").val();
					var group_no = '<%= request.getParameter("group_no") %>';
					//alert(goodsno);
					$.ajax({
						url:"goods_view.do",
						type:"POST",
						dataType:"json",
						data: {
							"choose": choose,
							"group_no": group_no,
							"page": page
						},
						cache:false,
						success: function(data){
							//console.log(data);
							
							var target = $("#m_review");
							target.empty();
							var reviewlist=data.reviewlist;
							console.log(data.reviewlist);
							
							$(reviewlist).each(function(index,element) {
								// 반복  element.reviewedsada
								//$("div")		- 있는 div 가져와라
								//$("<div>")  - 새로운 div 생성
								target.append($("<div class='tr_line'>" +
										"<table class='xans-board-listheaderd tbl_newtype1' width='100%' cellpadding='0' cellspacing='0' onclick='view_content(this)'>" +
											"<caption style='display:none'>구매후기 내용</caption>" +
											"<colgroup>" +
												"<col style='width:70px;'>" +
												"<col style='width:auto;'>" +
												"<col style='width:51px;'>" +
												"<col style='width:77px;'>" +
												"<col style='width:100px;'>" +
												"<col style='width:40px;'>" +
												"<col style='width:80px;'>" +
											"</colgroup>" +
											"<tbody>" +
												"<tr>" +
													"<input type='hidden' name='index' value='0'>" +
													"<input type='hidden' name='image' value=''>" +
													"<input type='hidden' name='grade' value='0'>" +
													"<input type='hidden' name='best' value='false'>" +
													"<input type='hidden' name='pNo' value=''>" +

													"<td align='center'>" + element.reviewed_no + "</td>" +
													"<td class='subject'>" +
													"<div class='fst'>" + element.title + "</div>" +	
													"<div class='snd'>" + element.title + "</div>" + 
													
													"</td>" +
													"<td class='user_grade grade_comm'></td>" +
													"<td class='user_grade'>" + element.name + "</td>" +
													"<td class='time'>" + element.write_date + "</td>" +
													"<td>" +
														"<span class='review-like-cnt' data-sno='6412546'>" + element.helped + "</span>" +
													"</td>" +
													"<td>" +
														"<span class='review-hit-cnt' data-sno='6412546'>" + element.readed + "</span>" +
													"</td>" +
												"</tr>" +
											"</tbody>" +
										"</table>" +
										
										"<div data-sno='6412546' class='review_view'>" +
											"<div class='inner_review'>" +
												"<div class='name_purchase'>" +
													"<strong class='name'></strong>" +
														"<p class='package'></p>" +
												"</div>" +
												"<div class='review_photo'></div>" +
												element.content +
												"</div>" +
											"<div class='goods-review-grp-btn'></div>" +
										"</div>" +
									"</div>"));
							})
							
						},
						error:function (){
							alert("error");
						}
						
					});
				}
				//selectReview("1");
				
				$("#choose").change(function () {
					var choose = $(this).val();
					$(this).val(choose);
					var page = $(".layout-pagination .__active").text();
					selectReview(page);
				});
			});
		</script>
		
		<!-- <div class="board_pg_area">
			<a href="/shop/goods/goods_review_list.php?goodsno=26097&amp;page=1" class="layout-pagination-button layout-pagination-first-page">맨 처음 페이지로 가기</a>
			<a href="/shop/goods/goods_review_list.php?goodsno=26097&amp;page=1" class="layout-pagination-button layout-pagination-prev-page">이전 페이지로 가기</a>
			<strong class="layout-pagination-button layout-pagination-number __active">1</strong>
			<a href="/shop/goods/goods_review_list.php?goodsno=26097&amp;page=2" class="layout-pagination-button layout-pagination-number">2</a>
			<a href="/shop/goods/goods_review_list.php?goodsno=26097&amp;page=3" class="layout-pagination-button layout-pagination-number">3</a>
			<a href="/shop/goods/goods_review_list.php?goodsno=26097&amp;page=4" class="layout-pagination-button layout-pagination-number">4</a>
			<a href="/shop/goods/goods_review_list.php?goodsno=26097&amp;page=5" class="layout-pagination-button layout-pagination-number">5</a>
			<a href="/shop/goods/goods_review_list.php?goodsno=26097&amp;page=6" class="layout-pagination-button layout-pagination-number">6</a>
			<a href="/shop/goods/goods_review_list.php?goodsno=26097&amp;page=7" class="layout-pagination-button layout-pagination-number">7</a>
			<a href="/shop/goods/goods_review_list.php?goodsno=26097&amp;page=8" class="layout-pagination-button layout-pagination-number">8</a>
			<a href="/shop/goods/goods_review_list.php?goodsno=26097&amp;page=9" class="layout-pagination-button layout-pagination-number">9</a>
			<a href="/shop/goods/goods_review_list.php?goodsno=26097&amp;page=10" class="layout-pagination-button layout-pagination-number">10</a>
			<a href="/shop/goods/goods_review_list.php?goodsno=26097&amp;page=2" class="layout-pagination-button layout-pagination-next-page">다음 페이지로 가기</a>
			<a href="/shop/goods/goods_review_list.php?goodsno=26097&amp;page=911" class="layout-pagination-button layout-pagination-last-page">맨 끝 페이지로 가기</a>
	</div> -->
</div>
<script src="chrome-extension://hhojmcideegachlhfgfdhailpfhgknjm/web_accessible_resources/index.js"></script>
</body>
</html>