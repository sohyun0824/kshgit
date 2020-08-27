// LNB (PC, Mobile) 
Vue.component('lnb-menu',{
  props:['getCategoryNum', 'item', 'idx', 'lengthCheck', 'type', 'originalCategoryName', 'lnbChecked', 'exceptionsType'],
  template:'\
    <li>\
        <a @click="clickEvent(item, idx)" :class="{on : item.checked}">{{ item.name }}</a>\
    </li>\
    '
  ,mounted: function () {
    if(this.idx == this.lengthCheck-1){ // 컴퍼넌트 모두 적용된후 라이브러리실행
      lnbMenu.menuScroll();
    }
  }
  ,methods:{
    clickEvent:function(item, idx){
      if(item.checked) return;

      // ga
      var textGet = this.originalCategoryName;
      textGet = textGet.replace(/(<([^>]+)>)/ig,"");
      var locationCheck = location.href;
      locationCheck = locationCheck.split('?');
      ga('set', 'location',  locationCheck[0] + '?category=' + item.no);
      ga('send', 'event', 'product', 'category_select', textGet + ' || ' + item.name);
      // end ga

      // KM-1483 Amplitude
      var i, len = this.exceptionsType.length, is_exceptionsType = false;
      for(i = 0; i < len; i++){
        if(this.exceptionsType[i].no === item.no){
          is_exceptionsType = true;
          KurlyTracker.setAction(this.exceptionsType[i].event_name)
          .setEventInfo('/m2/goods/list.php?category=' + item.no + '&view=mainSnb')
          .sendData();
        }
      }

      if(this.lengthCheck > 1 && !is_exceptionsType){
        var _actionData = {
          primary_category_id: this.getCategoryNum.substr( 0, 3),
          primary_category_name: this.originalCategoryName,
          secondary_category_id: item.no,
          secondary_category_name: item.name
        }
        KurlyTracker.setAction('select_category_subtab', _actionData).setEventInfo(_actionData.secondary_category_id).sendData();
      }
      // END : KM-1483 Amplitude

      sessionStorage.gListCategoryNo = item.no;
      this.$emit('lnb-checked', idx, item.no);
    }
  }
});

var lnbMenu = new Vue({
  el:'#lnbMenu',
  data:{
    getData : [],  // 데이터담기
    categoryMenu:[],
    getCategoryNum : null, // 카테고리번호 삽입
    pageType : null, // 상품목록 API URL변경시 사용됨.
    categoryName : null,
    originalCategoryName : null,
    sendCategoryNo : null, // 상품목록에 카테고리넘버 전달하기
    getSearch : false,
    pcDefaultTopPos : false, // 하단 라인 위치체크
    mainType : false, // 메인탭으로 진입시 파라미터 체크값
    referrer : false, // 전 페이지 위치 확인
    exceptionsType : [
      {
        name : '컬리추천',
        no : '1',
        checked : false,
        event_name : 'select_recommendation_subtab',
        browse_event_info : '',
      },
      {
        name : '신상품',
        no : '038',
        checked : false,
        event_name : 'select_new_product_subtab',
        browse_event_info : '',
      },
      {
        name : '베스트',
        no : '029',
        checked : false,
        event_name : 'select_popular_product_subtab',
        browse_event_info : '',
      },
      {
        name : '알뜰쇼핑',
        no : '015',
        checked : false,
        event_name : 'select_bargain_subtab',
        browse_event_info : '',
      },
      {
        name : '이벤트',
        no : '2',
        checked : false,
        event_name : 'select_event_list_subtab',
        browse_event_info : '',
      }
    ], // 예외처리 - mw main 노출
    type:'pc'
  },
  mounted:function(){
    // this.update(); 카테고리번호를 가져온후 API 호출 적용
  },
  methods:{
    update:function(){
      if(this.pageType === 'often'){
        this.categoryName = '<span class="tit">자주 사는 상품</span>';
        this.originalCategoryName = '자주 사는 상품';
        this.logoChange(0);
        goodsList.update();
        return;
      }else if(this.pageType === 'search'){
        this.categoryName = '<span class="tit">' + this.getSearch + '의 검색결과</span>';
        this.originalCategoryName = this.getSearch;
        this.logoChange();
        goodsList.update();
        return;
      }else if(this.pageType === 'sale'){
        this.getCategoryNum = '015';
      }

      var checked = null;

      kurlyApi({
        method:'get',
        url:'/v1/category/' + this.getCategoryNum
      }).then(function(response){
        if(response.status != 200) return;

        this.getData = response.data.data.root_category;

        if(this.type === 'mobile'){
          this.originalCategoryName = this.getData.name.replace(/\//gi,'·');
          this.categoryName = '<span class="tit">' + this.originalCategoryName + '</span>';
          if(this.getCategoryNum === '886' || this.getCategoryNum === '887' || this.getCategoryNum === '888'){
            this.categoryName = '<span class="tit">2020 상반기 결산</span>';
            this.originalCategoryName = '2020 상반기 결산';
          }
        }else{
          this.originalCategoryName = this.getData.name.replace(/\//gi,'·');
          this.categoryName = this.originalCategoryName;
          if(this.getCategoryNum === '886' || this.getCategoryNum === '887' || this.getCategoryNum === '888'){
            this.categoryName = '2020 상반기 결산';
            this.originalCategoryName = '2020 상반기 결산';
          }
        }

        // mw 메인탭메뉴 처리
        if(this.type === 'mobile' && (this.getCategoryNum == '029' || this.getCategoryNum == '038' || this.getCategoryNum == '015' || (this.getCategoryNum == '919' && this.mainType === true) ) ){
          var checkExceptions = 0; // 로고변경을 위한 체크값
          for(var i = 0; i < this.exceptionsType.length ; i++){
            if(this.getCategoryNum ===  this.exceptionsType[i].no){
              this.categoryMenu = [];
              this.$set(this.exceptionsType[i], "checked", true);
              this.categoryMenu = this.exceptionsType;
              this.sendCategoryNo = this.getCategoryNum;
              checkExceptions++;
            }
          }
          this.logoChange(checkExceptions);
        }else{
          if(this.getData.show_all_flag){
            if(this.getData.no === this.getCategoryNum){
              this.categoryMenu.push({'name':'전체보기', 'no':this.getData.no}); // 전체보기 담기
              this.$set(this.categoryMenu[0], 'checked', true);
            }else{
              this.categoryMenu.push({'name':'전체보기', 'no':this.getData.no}); // 전체보기 담기
              this.$set(this.categoryMenu[0], 'checked', false);
            }
            this.sendCategoryNo = this.getCategoryNum;
          }
          for(var i = 0; i < this.getData.categories.length; i++){
            this.$set(this.getData.categories[i], "checked", false);
            if((this.getData.categories[i].no) === this.getCategoryNum){
              this.$set(this.getData.categories[i], "checked", true);
            }
            if(this.pageType === 'sale' && this.type === 'pc'){
              return;
            }else{
              this.categoryMenu.push(this.getData.categories[i]);
            }
          }
          if(!this.getData.show_all_flag){
            // 전체보기가 없으며, 체크된값이 없는경우
            for(var i = 0 ; i < this.categoryMenu.length ; i++ ){
              if(this.categoryMenu[i].checked){
                this.categoryMenu[i].checked
                this.sendCategoryNo = this.categoryMenu[i].no;
              }
            }
            if(!this.sendCategoryNo){
              this.$set(this.categoryMenu[0], "checked", true);
              this.sendCategoryNo = this.categoryMenu[0].no;
            }
          }
          if(this.type === 'mobile'){
            this.logoChange(0);
          }
        }

      }.bind(this)).catch(function(e){
        alert('분류페이지에 카테고리가 지정되지 않았습니다.');
        history.back();
        this.errors.push(e);
        alert(this.errors.code + this.errors.message);
      });
    }
    ,menuScroll:function(){
      var snbWidth = 0;
      var $self = this;
      var num = 0;
      $('#lnbMenu li a').each(function(){
        snbWidth += parseInt($(this).parent().width());
        $(this).parent().attr('data-start',snbWidth - $(this).width() - 8);
        $(this).parent().attr('data-end',snbWidth + 8);
        if($(this).hasClass('on')){
          num = $(this).parent().index();
        }
      });
      if($self.type === 'mobile'){
        $('#lnbMenu ul').width(snbWidth+16);
      }
      $self.checkedAction(num, $self.sendCategoryNo);
    }
    ,lnbChecked:function(no, cateno){
      var $self = this;

      if($self.categoryMenu[no].checked == true) return;
      for(var i = 0 ; i < $self.categoryMenu.length ; i++ ){
        if(no == i){
          $self.categoryMenu[i].checked = true;
        }else{
          $self.categoryMenu[i].checked = false;
        }
      }
      setTimeout(function(){
        $self.checkedAction(no, cateno);
      });
    }
    ,checkedAction:function(no, categoryNo){
      var $self = this;
      var target = $('#lnbMenu li').eq(no);

      if(this.type === 'pc'){
        var checkTop = parseInt(target.position().top) + parseInt(target.height());
        if(this.pcDefaultTopPos === false){
          this.pcDefaultTopPos = checkTop;
        }else{
          if(this.pcDefaultTopPos != checkTop){
            this.pcDefaultTopPos = checkTop;
            $('#lnbMenu .bg').css({opacity : 0});
          }
        }
        $('#lnbMenu .bg').css({
          top : checkTop
        }).animate({
          width : target.width(),
          left : target.position().left
        },300,function(){
          $('#lnbMenu .bg').animate({
            opacity: 1
          });
          goodsList.update('lnb', categoryNo);
        });
      }else{
        var bgWidth = 0;
        var bgLeft = 0;
        if(this.mainType){
          bgWidth = target.find('a').parent().width();
          bgLeft = target.position().left;
        }else{
          bgWidth = target.find('a').width();
          bgLeft = target.position().left+16;
        }
        $('#lnbMenu .bg').animate({
          width : bgWidth,
          left : bgLeft
        },300,function(){
          if(categoryNo === '1'){
            location.href = '/m2/';
          }else if(categoryNo === '2'){
            location.href = '/m2/event.php';
          }else{
            goodsList.update('lnb', categoryNo, $self.mainType);
          }
          $('#lnbMenu .inner_lnb').scroll();
          setTimeout(function(){
            window.scrollTo(0, 0);
          },300);
        });
      }
      $('.lnb_paging span').eq(no).trigger('click');

      if($('#lnbMenu .list').width() > $(window).width()){
        var targetPos = target.position().left - $(window).width()/2 + target.width()/2 + 10 ;
        if(targetPos <= 0){
          targetPos = 0;
        }
        $('.inner_lnb').animate({
          scrollLeft :targetPos
        },300);
      }
    }
    ,logoChange:function(count){
      if(this.pageType === 'search'){
        if(this.type === 'mobile'){
          $('#header h1').html('<span class="tit">검색결과</span>');
        }
        $('#lnbMenu .list').append('<li><a class="on result">' + "'" + this.getSearch + "'" + '의 검색결과</a>');
      }else{
        if(count === 0){
          $('#header h1').html(this.categoryName);
        }else if(count > 0){
          this.mainType = true;
          $('#lnbMenu').addClass('lnb_menu_main');
        }

      }
    }
  }
});
// // Mobie LNB


// ###############################################################################################


// Sort (Pc, Mobie)
Vue.component('view-sort',{
  props:['sortData', 'sortDelivery', 'sortRegist', 'pageType' ,'type', 'deliveryCheck', 'sortUserCheck', 'sortLayerView'],
  template:'\
    <div :class="{blank_space : pageType === \'often\'}">\
        <div class="select_type delivery" :class="{checked : deliveryCheck }" v-if="pageType !== \'often\' && type === \'mobile\' ">\
            <a class="name_select" @click="layerOpen(deliveryCheck, \'delivery\')" v-if="sortDelivery != 1" >샛별지역상품</a>\
            <a class="name_select" @click="layerOpen(deliveryCheck, \'delivery\')" v-if="sortDelivery == 1" >택배지역상품</a>\
            <ul class="list">\
                <li><a @click="updateChange(\'0\', \'delivery\', \'샛별지역상품\')" :class="{on : sortDelivery == 0}">샛별지역상품</a></li>\
                <li><a @click="updateChange(\'1\', \'delivery\', \'택배지역상품\')" :class="{on : sortDelivery == 1}">택배지역상품</a></li>\
            </ul>\
        </div>\
        <div class="select_type user_sort" :class="{checked : sortUserCheck }"  v-if="pageType !== \'often\' && pageType !== \'search\'">\
            <a class="name_select" @click="layerOpen(sortUserCheck, \'sortUser\')" v-for="item in sortData" v-if="item.checked" >{{ item.name }}</a>\
            <ul class="list">\
                <li v-for="item in sortData"><a @click="updateChange(item.type, \'sort\', item.name)" :class="{on : item.checked}">{{ item.name }}</a></li>\
            </ul>\
        </div>\
    </div>\
    '
  ,methods:{
    layerOpen:function(obj, type){
      obj ? obj = false : obj = true;
      this.$emit('sort-layer-view', obj, type);
    }
    ,updateChange:function(itemType, type, name){
      var gaAction = '';
      var typeName = '';
      if(type === 'delivery'){
        gaAction = 'delivery_filter_change';
        typeName = 'sortDelivery';
      }else{
        gaAction = 'sort_order_change';
        typeName = 'sortUser';

        // Amplitude 연동 (2020-06, KM-2714)
        KurlyTracker.setAction('select_sort_type', {sort_type: name}).sendData();
      }
      ga('send', 'event', 'product', gaAction, name);
      this.$emit('sort-regist', typeName, itemType, 'lnb', name);
    }
  }
});


// Category Banner(Mobie)
Vue.component('category-banner',{
  props:['categoryBannerUrl', 'categoryBannerLink', 'getCategoryNum'],
  template:'\
    <div>\
        <div class="bnr_category" v-if="categoryBannerLink != \'\'"><a :href="categoryBannerLink"><img :src="categoryBannerUrl" alt="카테고리 배너"></a></div>\
        <div class="bnr_category" v-if="categoryBannerLink == \'\'"><img :src="categoryBannerUrl" alt="카테고리 배너"></div>\
    </div>\
    '
});


// 상품목록(PC, Mobile)
Vue.component('list-goods',{
  props:['item', 'tagName', 'tagType', 'getCategoryNum', 'sortDelivery', 'sortUser', 'type', 'idx', 'pageType', 'loginCheck', 'pageCount', 'tracking'],
  template:'\
    <li>\
        <div class="item">\
            <div class="thumb">\
                <a @click="clickAction(event, item, idx+pageCount)" class="img" :style="{ \'background-image\': \'url(\' + item.thumbnail_image_url + \')\'}">\
                    <img v-if="type === \'mobile\'" src="https://res.kurly.com/mobile/service/goods/1910/bg_172x221.png" :alt="item.shortdesc">\
                    <img v-if="type === \'pc\'" :src="item.thumbnail_image_url" :alt="item.shortdesc" onerror="this.src=\'https://res.kurly.com/mobile/img/1808/img_none_x2.png\'" width="308" height="396">\
                </a>\
                <span class="ico" v-if="item.sticker_image_url">\
                    <img :src="item.sticker_image_url" alt="SAVE 아이콘">\
                </span>\
                <a @click="clickAction(event, item, idx+pageCount)" class="sold_out" :class="{txt_sub : item.sold_out_content}" v-if="item.sold_out">\
                    <span class="inner_soldout">\
                        {{ item.sold_out_title }}\
                        <span class="sub_soldout" v-if="item.sold_out_content">{{ item.sold_out_content }}</span>\
                    </span>\
                </a>\
                <div class="group_btn">\
                    <button class="btn btn_cart" type="button" @click="cartPutCall(item, idx+pageCount)" v-if="!item.sold_out && !item.buy_now"><span class="screen_out">{{ item.no }}</span></button>\
                    <button class="btn btn_alarm" @click="systemPop(type, item, idx+pageCount)" type="button" data-goods-action="stocknoti" :data-goodsno="item.no" v-if="item.use_stocked_noti && (item.package_soldout || item.sold_out)"><span class="screen_out">재고알림 신청</span></button>\
                </div>\
            </div>\
            <a @click="clickAction(event, item, idx+pageCount)" class="info">\
                <span class="name">\
                    {{ item.name }}\
                </span>\
                <span class="cost">\
                    <span class="dc" v-if="item.original_price != item.price">{{ item.original_price | commaFilter }}원</span>\
                    <span class="emph" v-if="item.original_price != item.price && type === \'pc\'">→</span>\
                    <span class="price">{{ item.price | commaFilter }}원</span>\
                </span>\
                <span class="desc" v-if="type === \'pc\'">{{ item.shortdesc }}</span>\
            </a>\
            <span class="tag">\
                <span class="ico limit" v-for="(tName, idx) in tagName" v-if="tName != \'false\'" :class="{tag_type2 : tagType[idx] == \'pet\'}">{{ tName }}</span>\
            </span>\
        </div>\
    </li>\
    '
  ,methods:{
    clickAction :function(event, item, count){
      var url = this.type === 'mobile' ? '/m2/goods/view.php?goodsno=' + item.no : '/shop/goods/goods_view.php?&goodsno=' + item.no;
      this.saveSession(item);

      // GA
      ga('send', 'event', 'product', 'product_select', this.getCategoryNum + ' || ' + item.name);

      // KM-1483 Amplitude
      this.trackerAmplitude(item, count, 'select_product');

      if(this.pageType === 'search'){
        // KM-1048 fusionSignal
        if(fusionSignalList('view', item, count)){
          this.$options.filters.locationFilter(event, url);
        }
      }else{
        this.$options.filters.locationFilter(event, url);
      }
    }
    , systemPop:function(type, item, count){
      if(type === 'mobile'){
        // KM-1483 Amplitude
        this.trackerAmplitude(item, count, 'select_product_shortcut');

        // KM-1483 Amplitude
        item.referrer_event = 'select_product_shortcut';
        KurlyTracker.setScreenName('product_selection');
        KurlyTracker.setAction('view_product_selection', item).sendData();
        // END : KM-1483 Amplitude

        return;
      }else{
        // KM-1483 Amplitude
        this.trackerAmplitude(item, count, 'select_product_shortcut');

        if(!this.loginCheck){
          if(confirm('회원 전용 서비스 입니다. 로그인/회원가입 페이지로 이동하시겠습니까?')){
            this.saveSession(item);
            sessionStorage.goodsListReferrer = 'goodsView'; // 로그인후 클릭위치이동
            location.href = '/shop/member/login.php?return_url=' + encodeURIComponent(location.href);
          }
        }else{
          window.open('./popup_request_stocked_noti.php?goodsno='+item.no,360,230, 'scrollbars=yes');
        }
      }
    }
    , cartPutCall : function(item, count){
      /**
       * _footer.htm 에 해당 함수 있음.
       * 장바구니 담기 레이어 노출용.
       */
      cartLayerOpenAction(item.no);

      // KM-1048 fusionSignal
      fusionSignalList('cart', item, count)

      // KM-1483 Amplitude
      this.trackerAmplitude(item, count, 'select_product_shortcut');
      item.referrer_event = 'select_product_shortcut';
      KurlyTracker.setScreenName('product_selection');
      KurlyTracker.setAction('view_product_selection', item).sendData();
      // END : KM-1483 Amplitude
    }
    , trackerAmplitude : function(item, count, _event_name){
      // KM-1483 Amplitude
      var that = this;
      var actionData = item;
      actionData.position = count;
      actionData.default_sort_type = that.tracking.sortDefault;
      actionData.selection_sort_type = that.tracking.sortSelect;
      KurlyTracker.setAction(_event_name, actionData).sendData();
    }
    , saveSession : function(item){
      sessionStorage.gListCategoryNo = this.getCategoryNum;
      sessionStorage.gListCheckPageNo = item.page;
      sessionStorage.gListScrolltop = window.pageYOffset;
      sessionStorage.gListSortDelivery = this.sortDelivery;
      sessionStorage.gListSortUser = this.sortUser;
    }
  }
});

// PC 페이징
Vue.component('list-goods-paging',{
  props:['idx', 'pageCount', 'totalPageCount'],
  template:'\
        <span>\
            <a v-if="pageCount != idx+totalPageCount" class="layout-pagination-button layout-pagination-number" @click="$emit(\'on-move-list\', idx+totalPageCount)">{{ idx+totalPageCount }}</a>\
            <strong v-if="pageCount == idx+totalPageCount" class="layout-pagination-button layout-pagination-number __active">{{ idx+totalPageCount }}</strong>\
        </span>\
    '
});

var goodsList = new Vue({
  el: '#goodsList',
  data: {
    eventStop : false, // 이벤트 정지
    getData : [],  // 데이터담기
    getProducts : [], // products 담기
    goodsItem : [], // 상품별아이템 담기
    sortData : [], // 정렬값받기(신상품, 인기상품, 낮은가격, 높은가격)
    deliveryCheck : false, // 정렬레이어노출유무
    sortUserCheck : false, // 정렬레이어노출유무
    getCategoryNum : 0, // 만약 파라메터 값이 있는경우
    categoryBannerUrl : false, // 카테고리배너URL
    categoryBannerLink : false, // 카테고리배너Link
    bnrCategoryNum : null, // PC 카테고리 : 노출범위
    bnrCategoryThumb : null, // PC 카테고리 : 이미지주소
    bnrCategoryLink : [], // PC 카테고리 : 버튼링크
    bnrCategoryLinkStyle : [], // PC 카테고리 : 버튼스타일
    totalPaging : 0, // 전체페이지수
    endPagingFst : 0, // PC 페이징앞자리(10,20,30 등)
    endPagingLst : 0, // PC 마지막페이징 갯수
    totalPageCount:0, // PC 전체페이지 카운트
    allPaging : 0, // 전체페이지카운트(pc,mw)
    pagingCountArray : [], // PC에서 페이징 갯수노출(배열화필요)
    pageCount : 1, // 현재 페이지 카운터
    pageLimit : 10, // 한번에 노출되어야 하는 갯수
    backCheck : true, // 상세에서 목록올때 체크
    backCheckPageNo : false, // 상세에서 목록올때 현재페이지 값을 저장
    backScrollTop : false, // 상세에서 목록올때 높이 값을 저장
    getSearch : false,
    noData : false,
    errors: [],
    pageType : null, // 상품목록 API URL변경시 사용됨.
    sortDelivery : 0, // 샛별배송,택배배송 정렬보기
    sortUser : '', // 사용자선택값 노출 정렬보기
    eventCheckCount : 0,
    scrollCheck : false,
    referrer : false,
    fusionSignalCheck : 0, // 검색결과페이지에서만 1을 가져오며, 딱한번만 분기처리를위해 0, 1, 2 의 값을 가져야함
    fusionSignalResult : null, // 쿠키에 값을 담기 위해서 사용
    fusionSignalSeqCount : 0, // 하나의 결과값에 몇번을 클릭을 하는지 카운트
    tracking: { // Amplitude 용 데이터는 여기에 담기
      sortCountType: 'update', // update, stop, change
      sortDefault: '',  // 상품정렬 기본값 // Amplitude 연동 (2020-06, KM-2714)
      sortSelect: '',  // 상품정렬 변경값 // Amplitude 연동 (2020-06, KM-2714)
    },
    isMainType: false, // lnb가 main부분인지 아닌지를 구분하는 값
    loginCheck : false,
    type: 'mobile'
  },
  mounted: function () {
    // this.update('load'); 카테고리 가져오기위해 html에서 호출
  },
  methods:{
    update:function(type, no, isMain){
      if(typeof isMain !== 'undefined' && isMain){
        this.isMainType = true;
      }else{
        this.isMainType = false;
      }

      $('.bg_loading').show();

      var pageNo = this.pageCount; // data에 값을 넣기위해 사용되는 변수
      var checked = false;
      var recommendFilter = false;

      // LNB, 샛별, 택배, 신상품 등등 업데이트시에 초기화 필요
      if(no){
        this.getCategoryNum = no;
      }
      if(type === 'lnb' && this.eventCheckCount !== 0){
        this.goodsItem = [];
        this.pageCount = 1;
        this.eventStop = false;
        this.backCheckPageNo = 1;
        this.sortUserCheck = false;
        this.deliveryCheck = false;

        // Amplitude 연동 (2020-06, KM-2714)
        if(this.tracking.sortCountType === 'change'){
          this.tracking.sortCountType = 'update';
        }
      }

      // referrer 가 있는 경우만 적용
      if(this.referrer === true){
        this.backCheckPageNo = sessionStorage.gListCheckPageNo;
        this.backScrollTop = sessionStorage.gListScrolltop;
        this.sortDelivery =  sessionStorage.gListSortDelivery;
        this.sortUser = sessionStorage.gListSortUser;
        this.referrer = false;
        this.eventCheckCount = 1;
        sessionStorage.goodsListReferrer = true;
      }else{
        if(sessionStorage.goodsListReferrer === true){
          this.getCategoryNum = sessionStorage.gListCategoryNo;
        }

        // KM-149 장차석 : 검색결과 재검색할시 배송지역유지
        if(this.pageType === 'search' && sessionStorage.gListSortDelivery != undefined){
          this.sortDelivery = sessionStorage.gListSortDelivery;
        }
      }

      if(this.getCategoryNum === '038'){
        this.pageType = 'new';
        if(sessionStorage.gListSortUser38){
          this.sortUser = sessionStorage.gListSortUser38;
        }else{
          this.sortUser = '';
        }
      }else if(this.getCategoryNum === '015' || (no == null && !this.getCategoryNum)){
        if(this.pageType !== 'often' && this.pageType !== 'search'){
          this.pageType = 'sale';
          if(sessionStorage.gListSortUser15){
            this.sortUser = sessionStorage.gListSortUser15;
          }else{
            this.sortUser = '';
          }
        }
      }else{
        if(this.getCategoryNum === '029'){
          if(sessionStorage.gListSortUser29){
            this.sortUser = sessionStorage.gListSortUser29;
          }else{
            this.sortUser = '';
          }
        }
        this.pageType = 'list';
      }

      if(this.type === 'pc'){
        this.pageLimit = 99;
        if(this.eventCheckCount === 0){
          this.sortDelivery = 0;
        }
      }else{
        this.pageLimit = 20;
        if(this.eventCheckCount === 0 && sessionStorage.gListSortDelivery != undefined){
          this.sortDelivery = sessionStorage.gListSortDelivery;
        }
      }

      var apiUrl = null;
      if(this.pageType === 'often'){
        apiUrl = '/v1/mypage/order/often-buy-product?page_limit=' + this.pageLimit + '&page_no=' + this.pageCount;
      }else if(this.pageType === 'sale'){
        apiUrl = '/v1/home/timesale?page_limit=' + this.pageLimit + '&page_no=' + this.pageCount + '&delivery_type=' + this.sortDelivery + '&sort_type=' + this.sortUser;
      }else if(this.pageType === 'new'){
        apiUrl = '/v1/home/newproducts?page_limit=' + this.pageLimit + '&page_no=' + this.pageCount + '&delivery_type=' + this.sortDelivery + '&sort_type=' + this.sortUser;            }else if(this.pageType === 'search'){
        if(this.eventCheckCount === 0){
          apiUrl = '/v1/search?keyword=' + this.getSearch + '&sort_type=-1&page_limit=' + this.pageLimit + '&page_no=' + this.pageCount + '&delivery_type=' + this.sortDelivery;
        }else{
          apiUrl = '/v1/search?keyword=' + this.getSearch + '&sort_type=-1&page_limit=' + this.pageLimit + '&page_no=' + this.pageCount + '&delivery_type=' + this.sortDelivery;
        }
      }else if(this.pageType === 'list'){
        apiUrl = '/v1/categories/' + this.getCategoryNum + '?page_limit=' + this.pageLimit + '&page_no=' + this.pageCount + '&delivery_type=' + this.sortDelivery + '&sort_type=' + this.sortUser;
      }

      // fusionSignal
      var fusionSignalCheckResult = {}
      if(this.fusionSignalCheck !== 0 && this.fusionSignalCheck !== 1){
        fusionSignalCheckResult = {'X-Kurly-Session-Id' : this.fusionSignalCheck}
      }

      var d = new Date();
      kurlyApi({
        method : 'get',
        url : apiUrl +  '&ver=' + d.getTime(),
        headers : fusionSignalCheckResult
      }).then(function(response){
        if(response.status != 200) return;
        // fusionSignal
        if(this.fusionSignalCheck !== 0 && this.fusionSignalCheck !== 1){
          this.fusionSignalResult = JSON.parse(sessionStorage.getItem("FusionSignal")); // 값컨트롤용이 하도록 옮겨담기
          this.fusionSignalResult[0].params.fusion_query_id = response.data.fusion_query_id;
          if(typeof response.data.fusion_query_id === 'undefined'){
            this.fusionSignalResult[0].params.fusion_query_id = 'test' + new Date().getTime();
          }
          this.fusionSignalCheck = 1;
          sessionStorage.FusionSignal = JSON.stringify(this.fusionSignalResult);
          fusionSignalPut(); // cartput_v1.js 에서처리 => 검색결과 페이지도달(request)
        }

        this.getData = response.data.data;

        if(this.pageType !== 'often' && this.pageType !== 'search'){
          // 정렬값넣기
          if(this.getData.available_sort.length <= 0){
            this.sortData = false;
          }else{
            this.sortData = [];
            for(var i = 0; i < this.getData.available_sort.length; i++){
              if(this.getData.available_sort[i].type === this.getData.current_sort){
                this.getData.available_sort[i].checked = true;
                this.sortUser = this.getData.available_sort[i].type;
                recommendFilter = true;

                // Amplitude 연동 (2020-06, KM-2714)
                if(this.tracking.sortCountType === 'update' || this.isMainType){ // 상품목록 호출 할때 한번만.
                  this.tracking.sortDefault = this.getData.available_sort[i].name;
                  this.tracking.sortCountType = 'stop';
                }
              }
              this.sortData.push(this.getData.available_sort[i]);
            }
            // Amplitude 연동 (2020-06, KM-2714)
            if(this.tracking.sortSelect === '' || this.isMainType){
              this.tracking.sortSelect = this.tracking.sortDefault;
            }

            // 추천순을 지원하지 않는 상품목록
            if(!recommendFilter){
              this.sortData[0].checked = true;
            }
          }
          // 카테고리배너넣기
          if(this.getData.category_banner === null){
            this.categoryBannerUrl = false;
            this.categoryBannerLink = false;
            if(this.type === 'pc'){
              this.categoryBannerViewPc(false);
            }
          }else{
            if(this.type === 'pc'){
              this.categoryBannerUrl = this.getData.category_banner.pc_image_url;
              this.categoryBannerLink = this.getData.category_banner.pc_url;
              if(this.categoryBannerUrl === ''){
                this.categoryBannerViewPc(false);
              }else{
                this.categoryBannerViewPc(true);
              }
            }else{
              this.categoryBannerUrl = this.getData.category_banner.image_url;
              this.categoryBannerLink = this.getData.category_banner.url;
            }
          }
        }

        // 상품넣기
        this.getProducts = this.getData.products;

        if(this.getProducts.length === 0 && this.eventCheckCount === 0){
          this.noData = true;
        }else{
          this.noData = false;

          if(this.type === 'pc'){
            this.goodsItem = [];
            if(type !== 'false'){
              if(this.pageType == 'search' && response.data.paging.total){
                this.allPaging = response.data.paging.total;
              }
              if(response.data.paging == undefined || response.data.paging.total <= this.pageLimit){
                this.totalPaging = 0;
                this.pagingUpdate('one');
              }else{
                this.totalPaging = Math.ceil(response.data.paging.total / this.pageLimit);
                this.endPagingFst = Math.floor(this.totalPaging / 10) * 10;
                this.endPagingLst = this.totalPaging % 10;
                this.pagingUpdate();
                this.onMoveList(this.backCheckPageNo, 'false');
              }
              if(this.backCheckPageNo != 0 && this.backCheck){
                var self = this;
                setTimeout(function(){
                  window.scrollTo(0, self.backScrollTop);
                }, 300);
              }
              this.backCheck = false;
            }
          }else{
            if(response.data.paging == undefined){
              this.eventStop = true;
            }else{
              this.eventStop = false;
              this.allPaging = response.data.paging.total;
              this.totalPaging = Math.ceil(this.allPaging/this.pageLimit);
            }
          }
          for(var i = 0; i< this.getProducts.length ;i++){
            this.getProducts[i].page = pageNo;
            // 태그처리
            if(this.getProducts[i].tags.names.length == 0){
              this.getProducts[i].tags.names[0] = 'false';
            }else{
              var tagCheckName = [];
              var tagCheckType = [];
              for(var m = 0; m < this.getProducts[i].tags.types.length; m++){
                for(var n = 0; n < this.getProducts[i].tags.types[m].names.length; n++){
                  tagCheckName.push(this.getProducts[i].tags.types[m].names[n]);
                  tagCheckType.push(this.getProducts[i].tags.types[m].type);
                }
              }
              this.getProducts[i].tags.tagType = [];
              for(var m = 0; m < this.getProducts[i].tags.names.length; m++){
                for(var n = 0; n < tagCheckName.length; n++){
                  if(this.getProducts[i].tags.names[m] === tagCheckName[n]){
                    this.getProducts[i].tags.tagType.push(tagCheckType[n]);
                  }
                }
              }
            }
            this.goodsItem.push(this.getProducts[i]);
          }
        }

        // 해시테그가 있는 경우만 적용
        if(this.backCheck && this.type === 'mobile'){
          if(this.pageCount >= this.backCheckPageNo){
            var self = this;
            setTimeout(function(){
              window.scrollTo(0, self.backScrollTop);
            }, 300);
            this.backCheck = false;
          }else{
            this.moreShow();
          }
        }

        // KM-1483 Amplitude
        trackingListScreenName();

        this.eventCheckCount = 1;
        $('.bg_loading').hide();
      }.bind(this)).catch(function(e){
        $('.bg_loading').hide();
        this.errors.push(e);
        alert(this.errors.code + this.errors.message);
      });
    }
    ,moreShow:function(){ // 더보기(Mobile 페이징기능)
      if(this.eventStop) return false;
      var last = this.totalPaging - this.pageCount;
      this.pageCount++;
      if(last > 0){
        this.update();
      }
    }
    ,onMoveList:function(num, type){ // 페이징클릭시(PC)
      if(typeof num === "boolean"){
        num = 0;
      }
      if(num <= 0 || num > this.totalPaging){
        return;
      }

      this.pageCount = num;
      if(this.backCheckPageNo != 0){
        this.backCheckPageNo = num;
      }
      this.totalPageCount = (Math.ceil(this.pageCount/10)-1)*10;

      if(this.pageCount == this.totalPaging){
        this.update('false');
      }else{
        this.update(type);
      }
      window.scrollTo(0, $('#main').offset().top - 50);
      this.pagingUpdate();
    }
    ,pagingUpdate:function(type){ // 페이징 업데이트(PC)
      this.pagingCountArray=[];
      if(type === 'one'){
        var checkCount = 1;
      }else{
        if(this.pageCount <= this.endPagingFst){
          var checkCount = 10;
        }else{
          var checkCount = this.endPagingLst;
        }
      }
      for(var i=0;i< checkCount;i++){
        this.pagingCountArray.push(i);
      }
    }
    ,sortRegist:function(name, value, update, sortName){
      if(name === 'sortDelivery'){
        this.sortDelivery = value;
        sessionStorage.gListSortDelivery = this.sortDelivery;
      }
      if(name === 'sortUser'){
        this.sortUser = value;

        // 메인이라면 정열정보저장
        if(this.getCategoryNum === '038'){
          sessionStorage.gListSortUser38 = value;
        }else if(this.getCategoryNum === '029'){
          sessionStorage.gListSortUser29 = value;
        }else if(this.getCategoryNum === '015'){
          sessionStorage.gListSortUser15 = value;
        }
      }
      if(update){
        this.update(update);

        // Amplitude 연동 (2020-06, KM-2714)
        this.tracking.sortCountType = 'change';
        this.tracking.sortDefault = this.tracking.sortSelect;
        this.tracking.sortSelect = sortName;
      }
    }
    ,sortLayerView : function(obj, type){
      if(type === 'delivery'){
        this.deliveryCheck = obj;
        this.sortUserCheck = false;
      }else{
        this.deliveryCheck = false;
        this.sortUserCheck = obj;
      }
    },pageTop : function(target, result){ // mw 페이지TOP
      if(result === 'hide'){
        if(target.css('display') === 'none') return;
        target.fadeOut(300);
      }else{
        if(target.css('display') === 'inline') return;
        target.fadeIn(300);
      }
    }
    ,categoryBannerViewPc : function(data){ // PC용 카테고리배너처리
      if(data){
        if(this.categoryBannerUrl){
          $('#bnrCategory img').attr('src', this.categoryBannerUrl);
        }else{
          $('#bnrCategory img').attr('src', 'https://res.kurly.com/images/common/bg_1_1.gif');
        }
        if(this.categoryBannerLink){
          $('#bnrCategory a').attr('href', this.categoryBannerLink);
        }else{
          $('#bnrCategory a').remove();
        }
        $('#bnrCategory').slideDown(300);
      }else{
        $('#bnrCategory').slideUp(300);
      }
    }
  },
  updated : function(){
    this.$nextTick(function (){
      var $self = this;
      if($self.scrollCheck) return; // 스크롤 이벤트를 1회만 주기위해
      $self.scrollCheck = true;

      if($self.type === 'mobile'){
        var throttleCheck = false;
        $(window).scroll(_.throttle(function(){
          if(throttleCheck && $(window).scrollTop() + $(window).height() > $(document).height() - 100){
            $self.moreShow(); // vue 스크립트 호출
          }
          throttleCheck = true;
          if($(window).scrollTop() < $(window).height()){
            $self.pageTop($('#pageTop'), 'hide');
          }else{
            $self.pageTop($('#pageTop'), 'show');
          }
        },300));
      }
    })
  }
});


// KM-1048 fusionSignal
function fusionSignalList(actionType, item, count){
  if(goodsList.fusionSignalCheck !== 1){
    if(typeof sessionStorage.FusionSignal !== 'undefined'){
      sessionStorage.removeItem("FusionSignal");
    }
    return;
  }
  if(typeof sessionStorage.fusionSignalView !== 'undefined'){
    sessionStorage.removeItem("fusionSignalView");
  }

  var $self = goodsList;
  var $result = $self.fusionSignalResult[0];

  $self.fusionSignalSeqCount++;
  var actionTypeResult = 'click_product';
  if(actionType === 'cart'){
    actionTypeResult = 'click_select';
  }
  var viewCountCheck = ($self.pageCount -1) * $self.pageLimit;
  $result.timestamp = + new Date();
  $result.type = actionTypeResult;
  // 필수필드
  $result.params.res_offset = viewCountCheck; // 페이지 넘버 * 페이지당 아이템 수 (page =1이면, offest = 0) → 이전 페이지까지의 아이템 수(?)
  $result.params.res_pos = count + 1; // 해당 페이지에서 몇번째 아이템인지. (전체 노출 순서 = res_offset+res_pos). 추후 페이지 관련 파라미터에 대한 디테일한 논의
  if($self.type === 'mobile'){
    var mResOffset =  Math.floor(count / $self.pageLimit) * $self.pageLimit;
    var mResPos =  (count + 1) % $self.pageLimit;
    if(mResPos === 0) mResPos = $self.pageLimit;
    $result.params.res_offset = mResOffset;
    $result.params.res_pos = mResPos; // 해당 페이지에서 몇번째 아이템인지. (전체 노출 순서 = res_offset+res_pos). 추후 페이지 관련 파라미터에 대한 디테일한 논의
  }
  // 선택적필드
  $result.params.doc_id = item.no;
  $result.params.label = item.name;
  $result.params.click_seq = $self.fusionSignalSeqCount;
  sessionStorage.FusionSignal = JSON.stringify($self.fusionSignalResult);
  if(actionTypeResult === 'click_select'){
    fusionSignalPut(); // cartput_v1.js 에서처리 => 검색결과 Action (actionTypeResult)
  }
  return true;
}


/**
 * KM-1483 Amplitude : screen_name & tab_name
 */
var listPrevBucket = {};
function trackingListScreenName(){
  var $self = goodsList, _screen_name;
  if($self.pageType === 'new'){
    // 신상품
    _screen_name = 'new_product';
    KurlyTracker.setTabName('home');
  }else if($self.getCategoryNum === '029'){
    // 베스트
    _screen_name = 'popular_product';
    KurlyTracker.setTabName('home');
  }else if($self.pageType === 'sale'){
    // 알뜰쇼핑
    _screen_name = 'bargain';
    KurlyTracker.setTabName('home');
  }else if($self.pageType === 'search'){ // 검색결과
    _screen_name = 'search_product_list';
    KurlyTracker.setTabName('search');
  }else if($self.pageType === 'often'){ // 자주사는 상품목록
    _screen_name = 'product_list';
    // _screen_name = 'frequently_purchase_product_history';
  }else{
    listPrevBucket = KurlyTracker.getBucket();
    if(listPrevBucket.browse_tab_name === 'category'){ // 카테고리 목록
      _screen_name = 'category_product_list';
    }else{ // 일반 상품목록(구분할 수 있는 값이 필요함)
      _screen_name = 'product_list';
    }
  }
  KurlyTracker.setScreenName(_screen_name);
}