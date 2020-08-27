// mWeb용 
Vue.component('user-menu-mw', {
    props:['loginCheck', 'notificationItem'],
    template:'\
    <span>\
        <span class="ico"  v-if="notificationItem.couponBadge || notificationItem.emoneyBadge || notificationItem.specialBadge || notificationItem.myBnrBadge || notificationItem.friendsBadge"></span>\
    </span>\
    '
});

// PC용
Vue.component('user-menu-pc', {
    props:['loginCheck', 'notificationItem', 'userInfo', 'returnUrl'],
    template:'\
    <ul class="list_menu">\
        <li class="menu none_sub menu_join" v-if="!loginCheck">\
            <a href="/shop/member/join.php" class="link_menu">회원가입</a>\
        </li>\
        <li class="menu none_sub" v-if="!loginCheck">\
            <a href="/shop/member/login.php" class="link_menu" v-if="!returnUrl">로그인</a>\
            <a :href="\'/shop/member/login.php?return_url=\' + returnUrl" class="link_menu" v-if="returnUrl">로그인</a>\
        </li>\
        <li class="menu menu_user" v-if="loginCheck">\
            <a @click="clickEvent(\'/shop/mypage/mypage_orderlist.php\')" class="link_menu grade_comm">\
                <span class="ico_grade" :class="classAdd(userInfo.userGrade)" v-html="userInfo.userGradeName"></span>\
                <span class="txt"><span class="name" v-html="userInfo.memberName"></span><span class="sir">님</span></span>\
                <span v-if="notificationItem.couponBadge || notificationItem.emoneyBadge || notificationItem.specialBadge || notificationItem.myBnrBadge">\
                    <img src="https://res.kurly.com/pc/service/common/1904/ico_new_20x20.png" alt="New" class="ico_new">\
                </span>\
            </a>\
            <ul class="sub">\
                <li>\
                    <a href="/shop/mypage/mypage_orderlist.php">주문 내역</a>\
                </li>\
                <li>\
                    <a href="/shop/mypage/mypage_wishlist.php">늘 사는 것</a>\
                </li>\
                <li>\
                    <a href="/shop/mypage/mypage_review.php">상품후기</a>\
                </li>\
                <li>\
                    <a href="/shop/mypage/mypage_emoney.php">적립금</a>\
                    <img v-if="notificationItem.emoneyBadge" src="https://res.kurly.com/pc/service/common/1904/ico_new_20x20.png" alt="New" class="ico_new">\
                </li>\
                <li>\
                    <a href="/shop/mypage/mypage_coupon.php">쿠폰</a>\
                    <img v-if="notificationItem.couponBadge" src="https://res.kurly.com/pc/service/common/1904/ico_new_20x20.png" alt="New" class="ico_new">\
                </li>\
                <li>\
                    <a href="/shop/member/myinfo.php">개인 정보 수정</a>\
                </li>\
                <li>\
                    <a href="/shop/member/logout.php" @click="branchEvent()">로그아웃</a>\
                </li>\
            </ul>\
        </li>\
        <li class="menu">\
            <a href="/shop/board/list.php?id=notice" class="link_menu">고객센터</a>\
            <ul class="sub">\
                <li>\
                    <a href="/shop/board/list.php?id=notice">공지사항</a>\
                </li>\
                <li>\
                    <a href="/shop/service/faq.php">자주하는 질문</a>\
                </li>\
                <li>\
                    <a href="/shop/mypage/mypage_qna.php">1:1 문의</a>\
                </li>\
                <li v-if="loginCheck">\
                    <a href="/shop/main/html.php?htmid=mypage/bulk_order.htm">대량주문 문의</a>\
                </li>\
                <li>\
                    <a href="/shop/mypage/offer.php">상품 제안</a>\
                </li>\
                <li>\
                    <a href="/shop/mypage/echo_packing.php">에코포장 피드백</a>\
                </li>\
            </ul>\
        </li>\
        <li class="menu lst">\
            <a href="#none" onclick="address_chk_popup();return false;" class="link_menu">배송지역 검색</a>\
        </li>\
    </ul>\
    '
    ,methods :{
        classAdd : function(gradeNum){
            return 'grade' + gradeNum;
        },
        branchEvent : function(){ // KM-1238 장차석 : Branch Web SDK
            branch.logout();
        },
        clickEvent: function(url){
            // KM-1483 Amplitude 연동
            KurlyTracker.setAction('select_my_kurly_tab').sendData();
            location.href = url;
        }
    },
});

var userMenu = new Vue({
    el: '#userMenu',
    data: {
        loginCheck : false,
        notification : null, // 데이터받는부분
        notificationItem : [], // 데이터객체화
        userInfo : [],
        postArr : [], // 뱃지제거용
        afterCheck : false, // 예외처리(뺏지 제거는 하지만 현재 페이지엔 노출되는경우)
        errors: [],
        count : 0,
        returnUrl : false,
        type: 'pc'
    },
    mounted: function () {
    },
    methods: {
        update : function(postText){
            if(postText === undefined || postText === false){
                sessionStorage.badgeCheck = false;
                postText = false;
            }else{
                if(sessionStorage.badgeCheck !== postText){
                    sessionStorage.badgeCheck = postText;
                }else{
                    this.afterCheck = true;
                }
            }
            var date = new Date().getTime(); // 뒤로가기시 캐시제거용

            kurlyApi({
                method:'get',
                url:'/v1/mypage/notification?'+date
            })
            .then(function(response) {
                if(response.status != 200) return;
                this.notification = response.data.data;
                this.itemSet(postText);
               
                $('.bg_loading').hide();
            }.bind(this)).catch(function(e){
                // 데이터 없을시에 로그인페이지로 넘기기
                $('.bg_loading').hide();
                this.errors.push(e);
                alert(this.errors.code + this.errors.message);
            });
        },
        itemSet : function(postText){
            if(this.notification.mykurly_banner === null){
                this.notification.mykurly_banner = {
                    image_url : null,
                    landing_url : null,
                    badge : null
                }
            }
            if(this.notification.kurlylovers_benefit === null){
                this.notification.kurlylovers_benefit = {
                    tag : null,
                    badge : null
                }
            }
            this.notificationItem ={
                couponBadge : this.notification.coupon_badge, // 쿠폰뱃지
                emoneyBadge : this.notification.emoney_badge, // 적립금뱃지
                friendsBadge : this.notification.friends_invite_badge, // 친구추천뱃지
                specialTag : this.notification.kurlylovers_benefit.tag, // 특별한혜택명
                specialBadge : this.notification.kurlylovers_benefit.badge, // 특별한혜택뱃지
                myBnrUrl : this.notification.mykurly_banner.image_url, // 마이페이지 배너URL
                myBnrLink : this.notification.mykurly_banner.landing_url, // 마이페이지 배너Link
                myBnrBadge : this.notification.mykurly_banner.badge // 마이페이지 배너뱃지
            }
            
            if(postText != false){
                if(this.notificationItem.couponBadge && postText === 'coupon_badge'){
                    this.postArr.push('coupon_badge');
                }else if(this.notificationItem.emoneyBadge && postText === 'emoney_badge'){
                    this.postArr.push('emoney_badge');
                }else if(this.notificationItem.friendsBadge && postText === 'friends_invite_badge'){
                    this.postArr.push('friends_invite_badge');
                }
            }
            
            this.mypageCall();
        },
        mypageCall : function(){
            var $self = this;

            if($('#myPageTop').length > 0){
                if($self.notificationItem.myBnrBadge){
                    $self.postArr.push('mykurly_banner');
                }else{
                    if($self.notificationItem.specialBadge){
                        $self.postArr.push('kurlylovers_benefit');
                        $self.afterCheck = true;
                    }
                }
            }

            if($self.postArr.length > 0){
                kurlyApi({
                    method:'post',
                    url:'/v1/mypage/notification/read',
                    data:{
                        'badge_type':$self.postArr
                    }
                }).then(function(response){
                    if(response.status != 200) return;
                    $self.postArr = [];
                    if($self.afterCheck != true){
                        $self.notification = response.data.data;
                        $self.itemSet(false);    
                    }else{
                        $('.bg_loading').hide();    
                    }
                }.bind(this)).catch(function(e){
                    this.errors.push(e);
                    alert(this.errors.code + this.errors.message);
                });
            }

            if($('#myPageTop').length > 0){
                myPageTop.type= $self.type;
                myPageTop.update();
            }
        }
    }
});