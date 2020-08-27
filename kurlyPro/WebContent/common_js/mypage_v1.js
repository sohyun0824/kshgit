// 마이컬리(Mobile)
Vue.component('mypage-top-mw',{
  props:[
    'kurlylovers_benefit_tag',
    'kurlylovers_benefit_badge',
    'memberBenefitsPointType', 'memberBenefitsPointTag', 'memberBenefitsPointVallue',
    'memberBenefitsPointDescription', 'memberBenefitsDeliveryType', 'memberBenefitsDeliveryTag', 'memberBenefitsDeliveryVallue',
    'memberBenefitsDeliveryDescription', 'memberBenefitsSpecialType', 'memberBenefitsSpecialTag', 'memberBenefitsSpecialVallue',
    'memberBenefitsSpecialDescription',
    'userName', 'userGrade', 'userGradeName', 'userGradeInfo', 'accumulatedMoney', 'couponCount', 'kurlyPassExpirationDate', 'type', 'expireDate', 'expirePoint', 'inviteEvent', 'notificationCheck'],
  template:'\
    <div>\
    <div class="mypagetop_user">\
        <div v-if="userGradeName" class="grade_user">\
            <div class="grade">\
                <span class="screen_out">등급</span>\
                <span class="ico_grade"\
                :class="{class0:userGrade == 0,\
                class1:userGrade == 1,\
                class2:userGrade == 2,\
                class3:userGrade == 3,\
                class4:userGrade == 4,\
                class5:userGrade == 5,\
                class6:userGrade == 6,\
                }"><span class="inner_grade"><span class="in_grade">{{ userGradeName }}</span></span></span>\
                <!-- 웰컴투컬리 => 6, 일반 => 0, 화이트 => 1, 라벤더 => 2, 퍼플 => 3, 더퍼플 => 4, 프렌즈 => 5 -->\
                <div class="grade_bnenfit">\
                    <div class="inner">\
                        <div class="user">{{ userName }}님</div>\
                        <div class="special_benefit" v-if="kurlylovers_benefit_tag">{{ kurlylovers_benefit_tag }} <img src="https://res.kurly.com/pc/service/common/1904/ico_new_28x28.png" alt="New" class="ico_new" v-if="kurlylovers_benefit_badge"></div>\
                    </div>\
                </div>\
                <div class="grade_bnenfit2">\
                    <div class="benefit" v-if="memberBenefitsPointType"><strong class="tit">{{memberBenefitsPointTag+(memberBenefitsPointTag?" - ":"")}}</strong>{{memberBenefitsPointDescription}}</div>\
                    <div class="benefit" v-if="memberBenefitsDeliveryType"><strong class="tit">{{memberBenefitsDeliveryTag+(memberBenefitsDeliveryTag?" - ":"")}}</strong>{{memberBenefitsDeliveryDescription}}</div>\
                    <div class="benefit" v-else-if="userGrade===0">최초 1회 무료배송</div>\
                    <div class="benefit" v-if="memberBenefitsSpecialType">{{ memberBenefitsSpecialDescription }}</div>\
                </div>\
            </div>\
            <div class="next">\
                <a href="/m2/event/lovers/lovers.php" class="total_grade">전체등급 보기</a>\
                <a href="/m2/proc/my_benefit.php" class="next_month">다음 달 예상등급 보기</a>\
            </div>\
        </div>\
        <a :href="notificationCheck.myBnrLink" class="bnr_event" :style="{ \'background-image\': \'url(\' + notificationCheck.myBnrUrl + \')\' }" v-if="notificationCheck.myBnrUrl != null">\
            <img src="https://res.kurly.com/mobile/service/common/1904/bnr_375x60.png" alt="할인혜택보러가기">\
        </a>\
        <ul class="list_mypage">\
            <li class="user_reserve">\
                <a href="/m2/myp/emoneylist.php" class="link">\
                    <div class="inner_link">\
                        <div class="tit">적립금 <img src="https://res.kurly.com/pc/service/common/1904/ico_new_28x28.png" alt="New" class="ico_new" v-if="notificationCheck.emoneyBadge"></div>\
                        <div class="info">{{ accumulatedMoney | commaFilter}} 원 <img src="https://res.kurly.com/pc/ico/1803/ico_arrow_16x24.png" alt=""></div>\
                    </div>\
                </a>\
            </li>\
            <li class="user_coupon">\
                <a href="/m2/myp/couponlist.php" class="link">\
                    <div class="inner_link">\
                        <div class="tit">쿠폰 <img src="https://res.kurly.com/pc/service/common/1904/ico_new_28x28.png" alt="New" class="ico_new" v-if="notificationCheck.couponBadge"></div>\
                        <div class="info">{{ couponCount }} 장 <img src="https://res.kurly.com/pc/ico/1803/ico_arrow_16x24.png" alt=""></div>\
                    </div>\
                </a>\
            </li>\
            <li class="user_invite" v-if="inviteEvent">\
                <a @click="clickEvent(\'event\', inviteEvent.url)" class="link">\
                    <div class="inner_link">\
                        <div class="tit">친구초대 <img src="https://res.kurly.com/pc/service/common/1904/ico_new_28x28.png" alt="New" class="ico_new" v-if="notificationCheck.friendsBadge"></div>\
                        <div class="info" v-if="inviteEvent.label != null">{{ inviteEvent.label }} <img src="https://res.kurly.com/pc/ico/1803/ico_arrow_16x24.png" alt=""></div>\
                    </div>\
                </a>\
            </li>\
        </ul>\
    </div>\
    <ul class="list_mypage">\
        <li>\
            <a href="/m2/myp/orderlist.php"><div class="tit">주문 내역</div></a>\
        </li>\
        <li>\
            <a href="/m2/myp/review.php"><div class="tit">상품 후기</div></a>\
        </li>\
        <li>\
            <a href="/m2/myp/wishlist.php?opt=1"><div class="tit">늘 사는 것</div></a>\
        </li>\
        <li>\
            <a @click="clickEvent(\'restock\',\'/m2/myp/restock.php\')"><div class="tit">재입고 알림 내역</div></a>\
        </li>\
    </ul>\
    <ul class="list_mypage">\
        <li>\
            <a href="/m2/myp/qna.php"><div class="tit">1:1 문의</div></a>\
        </li>\
        <li>\
            <a href="/m2/goods/goods_qna_list.php"><div class="tit">상품 문의</div></a>\
        </li>\
        <li>\
            <a href="/m2/html.php?htmid=myp/bulk_order.htm"><div class="tit">대량주문 문의</div></a>\
        </li>\
        <li>\
            <a href="/m2/service/customer.php"><div class="tit">고객센터 및 자주하는 질문</div></a>\
        </li>\
        <li>\
            <a href="/m2/introduce/about_kurly.php"><div class="tit">컬리소개</div></a>\
        </li>\
        <li class="user_kurlypass">\
            <a href="/m2/myp/kurlypass.php" class="link">\
                <div class="inner_link">\
                    <div class="tit">컬리패스</div>\
                    <div class="info" v-if="kurlyPassExpirationDate">사용중 <img src="https://res.kurly.com/pc/ico/1803/ico_arrow_16x24.png" alt=""></div>\
                </div>\
            </a>\
        </li>\
    </ul>\
    </div>\
    '
  ,methods:{
    clickEvent: function(type, url){
      var eventName = '';
      if(type === 'event'){
        eventName = 'select_friend_invitation_button';
      }
      if(type === 'restock'){
        eventName = 'select_stock_notification_history_button';
      }
      KurlyTracker.setAction(eventName).sendData();

      location.href = url;
    }
  }
});

// 마이컬리상단탑(PC)
Vue.component('mypage-top',{
  props:[
    'kurlylovers_benefit_tag',
    'kurlylovers_benefit_badge',
    'memberBenefitsPointType', 'memberBenefitsPointTag', 'memberBenefitsPointVallue',
    'memberBenefitsPointDescription', 'memberBenefitsDeliveryType', 'memberBenefitsDeliveryTag', 'memberBenefitsDeliveryVallue',
    'memberBenefitsDeliveryDescription', 'memberBenefitsSpecialType', 'memberBenefitsSpecialTag', 'memberBenefitsSpecialVallue',
    'memberBenefitsSpecialDescription',
    'notification', 'userName', 'userGrade', 'userGradeName', 'userGradeInfo', 'accumulatedMoney', 'couponCount', 'kurlyPassExpirationDate', 'type', 'expireDate', 'expirePoint', 'notificationCheck'],
  template:'\
    <div class="mypagetop_user">\
        <div class="inner_mypagetop">\
            <div v-if="userGradeName" class="grade_user">\
                <div class="grade">\
                    <span class="screen_out">등급</span>\
                    <span class="ico_grade"\
                    :class="{class0:userGrade == 0,\
                    class1:userGrade == 1,\
                    class2:userGrade == 2,\
                    class3:userGrade == 3,\
                    class4:userGrade == 4,\
                    class5:userGrade == 5,\
                    class6:userGrade == 6,\
                    }"><span class="inner_grade"><span class="in_grade">{{ userGradeName }}</span></span></span>\
                    <!-- 웰컴투컬리 => 6, 일반 => 0, 화이트 => 1, 라벤더 => 2, 퍼플 => 3, 더퍼플 => 4, 프렌즈 => 5 -->\
                    <div class="grade_bnenfit">\
                        <div class="user">\
                            <strong class="name">{{ userName }}</strong>\
                            <span class="txt">님</span>\
                        </div>\
                        <div class="special_benefit" v-if="kurlylovers_benefit_tag">{{ kurlylovers_benefit_tag }} <img src="https://res.kurly.com/pc/service/common/1904/ico_new_28x28.png" alt="New" class="ico_new" v-if="kurlylovers_benefit_badge"></div>\
                        <div class="benefit" v-if="memberBenefitsPointType"><strong class="tit">{{memberBenefitsPointTag+(memberBenefitsPointTag?" - ":"")}}</strong>{{memberBenefitsPointDescription}}</div>\
                        <div class="benefit" v-if="memberBenefitsDeliveryType"><strong class="tit">{{memberBenefitsDeliveryTag+(memberBenefitsDeliveryTag?" - ":"")}}</strong>{{memberBenefitsDeliveryDescription}}</div>\
                        <div class="benefit" v-else-if="userGrade===0">최초 1회 무료배송</div>\
                        <div class="benefit" v-if="memberBenefitsSpecialType">{{ memberBenefitsSpecialDescription }}</div>\
                    </div>\
                </div>\
                <div class="next">\
                    <a href="/shop/event/lovers/lovers.php" class="total_grade">전체등급 보기</a>\
                    <a href="/shop/proc/my_benefit.php?id=benefit" class="next_month">다음 달 예상등급 보기</a>\
                </div>\
            </div>\
            <ul class="list_mypage">\
                <li class="user_reserve">\
                    <div class="link">\
                        <div class="tit">적립금  <img src="https://res.kurly.com/pc/service/common/1904/ico_new_28x28.png" alt="New" class="ico_new" v-if="notificationCheck.emoneyBadge"></div>\
                        <a href="/shop/mypage/mypage_emoney.php" class="info">\
                            {{ accumulatedMoney | commaFilter}} 원 <img src="https://res.kurly.com/pc/service/common/1905/ico_arrow_56x56.png" alt="자세히 보기">\
                            <span class="date">소멸 예정 {{ expirePoint | commaFilter}} 원</span>\
                        </a>\
                    </div>\
                </li>\
                <li class="user_coupon">\
                    <div class="link">\
                        <div class="tit">쿠폰  <img src="https://res.kurly.com/pc/service/common/1904/ico_new_28x28.png" alt="New" class="ico_new" v-if="notificationCheck.couponBadge"></div>\
                        <a href="/shop/mypage/mypage_coupon.php" class="info">{{ couponCount }} 개 <img src="https://res.kurly.com/pc/service/common/1905/ico_arrow_56x56.png" alt="자세히 보기"></a>\
                    </div>\
                </li>\
                <li class="user_kurlypass">\
                    <div class="link">\
                        <div class="tit">컬리패스</div>\
                        <a href="/shop/mypage/kurlypass.php" class="info" v-if="kurlyPassExpirationDate">사용중 <img src="https://res.kurly.com/pc/service/common/1905/ico_arrow_56x56.png" alt="자세히 보기"></a>\
                        <a href="/shop/mypage/kurlypass.php" class="info info_link" v-if="!kurlyPassExpirationDate">\
                            알아보기  <img src="https://res.kurly.com/pc/service/common/1905/ico_arrow_56x56.png" alt="자세히 보기">\
                        </a>\
                    </div>\
                </li>\
            </ul>\
        </div>\
        <a :href="notificationCheck.myBnrLink" class="bnr_event" :style="{ \'background-image\': \'url(\' + notificationCheck.myBnrUrl + \')\' }" v-if="notificationCheck.myBnrUrl != null">\
            <img src="https://res.kurly.com/pc/service/common/1904/bg_1050x60.png" alt="할인혜택보러가기">\
        </a>\
    </div>\
    '
});

var myPageTop = new Vue({
  el: '#myPageTop',
  data: {
    postsData: [], // 데이터불러오기
    coupon_baddge: '',
    emoney_badge: '',
    frends_invite_badge:'',
    member_benefit_policy_badge:'',
    kurlylovers_benefit_tag: '',
    kurlylovers_benefit_badge:'',
    mykurly_banner_image_url:'',
    mykurly_banner_landing_url:'',
    mykurly_banner_badge:'',
    memberBenefitsPointType :'',
    memberBenefitsPointTag :'',
    memberBenefitsPointVallue :'',
    memberBenefitsPointDescription :'',
    memberBenefitsDeliveryType :'',
    memberBenefitsDeliveryTag :'',
    memberBenefitsDeliveryVallue :'',
    memberBenefitsDeliveryDescription :'',
    memberBenefitsSpecialType :'',
    memberBenefitsSpecialTag :'',
    memberBenefitsSpecialVallue :'',
    memberBenefitsSpecialDescription :'',
    on_kurlylovers_benefit_badge: false,
    userName:'', // 이름
    userGrade:'', // 등급
    userGradeName:'', // 등급명
    userGradeInfo:'', // 등급혜택
    accumulatedMoney:0, // 적립금
    expireDate:0,   // 소멸예정일
    expirePoint:0, // 소멸예정포인트
    couponCount:0, // 쿠폰갯수
    kurlyPassExpirationDate:false, // 사용할 경우에만 리턴해줌(없으면 키 자체가 없음)
    inviteEvent:false,
    notificationCheck : [],
    errors: [],
    type: 'pc'
  },
  mounted: function() {
    // kurlyApi({
    //   method:'post',
    //   url:'/v1/mypage/notification/read',
    //   data:{
    //     'badge_type':['kurlylovers_benefit']
    //   }
    // }).then(function(response){
    //   console.log(response.data.data)
    // }.bind(this)).catch(function(err){
    //   console.error(err)
    // }.bind(this));
  },
  created: function(){
    kurlyApi({
      method:'get',
      url: '/v1/mypage/notification'
    }).then(function(response){
      var data = response.data.data;
      this.coupon_baddge= data.coupon_badge;
      this.emoney_badge= data.emoney_badge;
      this.frends_invite_badge=data.friends_invite_badge;
      this.member_benefit_policy_badge=data.member_benefit_policy_badge;
      if(data.kurlylovers_benefit){
        this.kurlylovers_benefit_tag= data.kurlylovers_benefit.tag;
        this.kurlylovers_benefit_badge=data.kurlylovers_benefit.badge;
      }
      if(data.mykurly_banner){
        this.mykurly_banner_image_url=data.mykurly_banner.image_url;
        this.mykurly_banner_landing_url=data.mykurly_banner.landing_url;
        this.mykurly_banner_badge=data.mykurly_banner.badge;
      }
    }.bind(this)).catch(function(e){
      console.log(this)
    }.bind(this))
    kurlyApi({
      method:'get',
      url: '/v3/members/member-benefits'
    }).then(function(response){
      var data = response.data.data;
      var iLen = data.length;
      for(var i = 0; i < iLen; i++) {
        if (data[i].type === 'point') {
          this.memberBenefitsPointType = data[i].type;
          this.memberBenefitsPointTag = data[i].tag || '';
          this.memberBenefitsPointVallue = data[i].value || '';
          this.memberBenefitsPointDescription = data[i].description || '';
        }
        if (data[i].type === 'delivery') {
          this.memberBenefitsDeliveryType = data[i].type;
          this.memberBenefitsDeliveryTag = data[i].tag || '';
          this.memberBenefitsDeliveryVallue = data[i].value || '';
          this.memberBenefitsDeliveryDescription = data[i].description || '';
        }
        if (data[i].type === 'special') {
          this.memberBenefitsSpecialType = data[i].type;
          this.memberBenefitsSpecialTag = data[i].tag || '';
          this.memberBenefitsSpecialVallue = data[i].value || '';
          this.memberBenefitsSpecialDescription = data[i].description || '';
        }
      }
    }.bind(this)).catch(function(e){
      console.log(this)
    }.bind(this))
  },
  methods:{

    update:function(){
      kurlyApi({
        method:'get',
        url:'/v1/mypage'
      })
      .then(function(response) {
        if(response.status != 200) return;
        this.postsData = response.data.data;
        this.userName = this.postsData.user_name;
        this.userGrade = this.postsData.user_grade;
        this.userGradeName = this.postsData.user_grade_name;
        this.userGradeInfo = this.postsData.user_grade_info;
        this.accumulatedMoney = this.postsData.accumulated_money;
        this.couponCount = this.postsData.coupon_count;
        this.expireDate = this.postsData.expire_date;
        this.expirePoint = this.postsData.expire_point;
        if(this.postsData.kurly_pass_expiration_date == null){
          this.kurlyPassExpirationDate = false;
        }else{
          this.kurlyPassExpirationDate = this.postsData.kurly_pass_expiration_date;
        }
        if(this.postsData.menu_invite != null){
          this.inviteEvent = this.postsData.menu_invite;
        }

        // 사용자 메뉴에서 값가져와 붙임
        this.notificationCheck = userMenu.notificationItem

        $('.bg_loading').hide();
      }.bind(this)).catch(function(e){
        // 데이터 없을시에 로그인페이지로 넘기기
        $('.bg_loading').hide();
        this.errors.push(e);
        alert(this.errors.code + this.errors.message);
      });
    }
  }
});

var logourFromMyPage = function() {
  // 주문서 관련 localStorage청소
  localStorage.removeItem('order.address');
  localStorage.removeItem('order.address.modifyID');
  localStorage.removeItem('order.address.tempAddress');
  localStorage.removeItem('order.address.selectedID');
  localStorage.removeItem('order.buyer');
}