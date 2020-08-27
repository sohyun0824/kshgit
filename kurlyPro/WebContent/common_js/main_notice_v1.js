// Mobile
Vue.component('pop-view-mobile',{
    props:['idx', 'item', 'popupId', 'popupClose'],
    template:'\
        <div>\
        <div :id="popupId+item.id" class="main_popup" :style="{\'z-index\':(10000-idx)}">\
            <div class="inner_mainpopup">\
                <div class="pop_view" v-html="item.mobile_content" v-if="item.mobile_link == \'\'">\
                </div>\
                <div class="pop_view" v-if="item.mobile_link != \'\'">\
                    <a :href="item.mobile_link" v-html="item.mobile_content" class="link">\
                    </a>\
                </div>\
                <div class="pop_footer " :class="{pop_select : item.buttons.length > 1}"><!-- 버튼이 2개일때 클래스 추가 class="pop_select" -->\
                    <button @click="clickEvent(\'popupNotice\'+item.id, btn.no_show_hours)" type="button" class="btn" :data-day="btn.no_show_hours" v-for="(btn, idx) in item.buttons">{{ btn.label }}</button>\
                </div>\
            </div>\
        </div>\
        </div>\
        '
    ,methods:{
        clickEvent:function(name, time){
            this.$emit('popup-close', name, time);
        }
    }
});
// PC
Vue.component('pop-view-pc',{
    props:['idx', 'item', 'popupId', 'popupClose'],
    template:'\
        <div>\
        <div :id="popupId+item.id" class="main_popup" :style="{\'left\':(450*idx)+\'px\'}">\
            <div class="inner_mainpopup">\
                <div class="pop_view" v-html="item.pc_content" v-if="item.pc_link == \'\'">\
                </div>\
                <div class="pop_view" v-if="item.pc_link != \'\'">\
                    <a :href="item.pc_link" v-html="item.pc_content" class="link">\
                    </a>\
                </div>\
                <div class="pop_footer" :class="{ pop_select : item.buttons.length > 1}"><!-- 버튼이 2개일때 클래스 추가 class="pop_select" -->\
                    <button @click="clickEvent(\'popupNotice\'+item.id, btn.no_show_hours)" type="button" class="btn" :data-day="btn.no_show_hours" v-for="btn in item.buttons">{{ btn.label }}</button>\
                </div>\
            </div>\
        </div>\
        </div>\
    '
    ,methods:{
        clickEvent:function(name, time){
            this.$emit('popup-close', name, time);
        }
    }
});

var mainNotice = new Vue({
    el: '#mainNoticePop',
    data: {
        postsData : [], // 데이터불러오기
        popList : [], // 각각팝업담기
        noData : false, // 값이 없는 경우 비노출
        popCount : 0, // 팝업노출갯수카운팅
        checkId : [],
        popupId : 'popupNotice', // 팝업에 사용되는 ID 하드코딩
        errors : [],
        type : 'mobile'
    },
    mounted: function () {
        this.update();
        
    },
    methods: {
        update:function(){
            var that = this;

            kurlyApi({
                method:'get',
                url:'/v2/notice'
            })
            .then(function(response){
                if(response.status != 200) return;  
 
                that.postsData = response.data.data.popups;
                if(that.postsData == null || that.postsData.length == 0){
                    that.noData = true;
                    return;
                }
                for(var i = 0; i < that.postsData.length; i ++){
                    if( getCookie(that.popupId + that.postsData[i].id) != 1 ){
                        that.popCount++;
                        that.popList.push(that.postsData[i]);
                    }
                }
                that.popupShow();
            }).catch(function(e){
                console.log('catch this', this)
                // this.popupShow();
                // this.errors.push(e);
                // alert(this.errors.code + this.errors.message);
            });
        },
        popupClose : function(name, time){ // 버튼 클릭시 동작
            var $this = this;
            if(time != 0){
                if(time >= 9999){
                    setCookie(name, 1, time);                        
                }else{
                    setCookie(name, 1, time/24);
                }
            }
            document.getElementById(name).style.display = 'none';
            $this.popCount--;
            $this.popupShow();

            // 중복갯수일때 딤드효과 처리
            var $bgCount = $('#bgLoadingNotice');
            if(this.type === 'mobile'){
                $bgCount.css('z-index', Number( $bgCount.css('z-index') ) - 1);
            }
        },
        popupShow : function(){
            if(this.type === 'mobile'){  // mobile 전용
                if(this.popCount > 0){
                    $('body').css('overflow', 'hidden');
                    $('#bgLoadingNotice').show();
                }else{
                    $('body').removeAttr('style');
                    $('#bgLoadingNotice').hide();
                }
            }else{
                $('.main_popup').each(function(idx){
                    if($(this).css('display') != 'none'){
                        var pos = parseInt($(this).css('left')) * (idx-1);
                        if(pos < 0) pos = 0;
                        $(this).animate({
                            left : pos
                        },500);    
                    }
                });
                // 비밀번호 체크팝업노출(공지팝업 모두 닫은후에 노출됨)
                if($('#change_pw').hasClass('checkOn')){
                    if(this.popCount <= 0){
                        $('#change_pw').show();
                    }
                }
            }
            
            // KM-1483 Amplitude
            if(this.popCount === 0){
                KurlyTracker.setScreenName('recommendation');
            }else{
                KurlyTracker.setScreenName('announce');
            }
        },
    },
    updated : function(){
        this.$nextTick(function(){
            // mobile 에서 팝업이 작은 경우 화면 중앙에 올려지게 처리
            function mWebCheck(){
                var winHeight = $(window).height() - 40;
                var resultHeight = $('.main_popup').eq(0).height();
                if(resultHeight > 100){
                    $('.main_popup').each(function(idx){
                        resultHeight = $(this).height();
                        if(winHeight < resultHeight){
                            $(this).addClass('over');
                        }else{
                            $(this).addClass('under');
                        }
                    });
                }else{
                    setTimeout(function(){
                        mWebCheck();
                    }, 1000);
                }
            }
            if(this.type === 'mobile' && this.popCount > 0){
                mWebCheck();
            }
        });
    }
});