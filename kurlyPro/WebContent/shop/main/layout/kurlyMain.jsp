<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
    /* override */
    #content{padding-bottom:0}
    #qnb{top:516px}

    /* ############## */
    /* 메인 공지 팝업 */
    /* ############## */
    #mainNotice{position:relative;z-index:5000;width:1050px;margin:0 auto}
    #mainNotice .main_popup{overflow:hidden;position:absolute;left:0;top:40px;width:440px;border-radius:6px;background-color:#f4f4f4;
        -webkit-box-shadow:0 1px 8px 0 rgba(0, 0, 0, 0.2);
        -moz-box-shadow:0 1px 8px 0 rgba(0, 0, 0, 0.2);
        box-shadow:0 1px 8px 0 rgba(0, 0, 0, 0.2);
    }
    #mainNotice .main_popup1{left:0}
    #mainNotice .main_popup2{left:0}
    #mainNotice .main_popup3{left:0}
    #mainNotice .main_popup4{left:0}
    #mainNotice .inner_mainpopup{position:relative;height:100%} 
    #mainNotice .pop_view img{width:100%;vertical-align:top}
    /* 하단버튼 */
    #mainNotice .pop_footer{overflow:hidden;width:100%;height:60px;border-top:1px solid #f7f7f7;background-color:#fff}
    #mainNotice .pop_footer .btn{overflow:hidden;float:left;width:100%;height:100%;border:0 none;background-color:#fff;font-weight:700;font-size:16px;color:#333;line-height:20px;text-align:center}
    #mainNotice .pop_select .btn{float:left;width:219px;}
    #mainNotice .pop_select .btn:last-child{float:right;width:219px;border-left:1px solid #f7f7f7}
    /* 비밀번호변경 팝업 */
    #change_pw{position:absolute;left:0;top:0;width:404px}
    #change_pw .inner_popdiv{width:404px;padding:0 20px;background-color:#fff;border:2px solid #514859;text-align:left}
    #change_pw .line{height: 2px;border:none; outline: none;  background-color:#5f0080}
    #change_pw .line_grey{height: 2px;border:none; outline: none;background-color:#dddfe1}
    #change_pw .tit{display:block;padding:32px 0 15px;font-size:16px;font-weight:700;color:#5f0080}
    #change_pw .wrap_pw{padding:22px 0;font-size:16px;color:#000}
    #change_pw .desc{padding-bottom:10px;letter-spacing:-.5px}
    #change_pw .btn_group{height:50px}
    #change_pw .inner_popdiv .btn{overflow:hidden;position:absolute;bottom:2px;height:26px;font-size:14px;line-height:26px}
    #change_pw .inner_popdiv .btn_close { left:2px; width:200px; background-color:#fff; color:#5f0080; border-top:1px solid #5f0080; height:50px; text-align:center; line-height:50px; font-size:16px; letter-spacing:0.5px}
    #change_pw .inner_popdiv .link_move{right:2px;width:200px;background-color:#5f0080;color:#fff;border:1px solid #512771; height:50px; text-align:center; line-height:50px; font-size:16px; letter-spacing:0.5px}
    #change_pw .inp_tit{display:block;padding:13px 0 5px 0;font-size:14px;letter-spacing:-.5px; color:#5f0080;font-weight:bold}
    #change_pw .wrap_inp{position:relative}
    #change_pw .txt_placeholder {position:absolute; z-index:9; display:block; font-size:16px; top:12px; left:10px;font-family:"Noto Sans";font-weight:200;line-height:18px; color:#949296}
    #change_pw .pw_inp{width:100%;padding:10px}
    #change_pw .item_info dt{padding-bottom:5px}
    #change_pw .pw_notice{padding-top:19px}
    #change_pw .new_pw{margin-bottom:20px}
    #change_pw .mark_valid{ display:none;font-size:12px;color:#514859;line-height:20px}
    #change_pw .wrap_inp .mark_valid .good{ color:#0e851a }
    #change_pw .wrap_inp .mark_valid .bad{ color:#b3130b }
    #change_pw .wrap_inp .mark_coincide.good{ color:#0e851a }
    #change_pw .wrap_inp .mark_coincide.bad{ color:#b3130b }
    #change_pw .pw_inp.inp_invalid{border: 1px solid #b3130b}
    #change_pw input[type=password]{height:44px; outline: none; border: 1px solid #514859}

    /* #### */
    /* 공통 */
    /* #### */
    .page_main{overflow:hidden;width:100%;margin:0;opacity:0}
    .page_main *{color:#333}
    .page_main .bg{background-color:#f7f7f7}
    .page_main .tit_goods{padding:79px 0 35px}
    .page_main .tit_goods.top_short{padding-top:21px}
    .page_main .tit_goods .tit{font-weight:700;font-size:28px;line-height:32px;letter-spacing:-0.3px;text-align:center}
    .page_main .tit_goods .name{position:relative;font-weight:700}
    .page_main .tit_goods a{cursor:pointer}
    .page_main .tit_goods .name .ico{padding:0 31px;background:url(https://res.kurly.com/pc/service/main/1908/ico_title_link_x1.png) no-repeat 100% 50%;font-weight:700}
    .page_main .tit_goods .tit_desc{display:block;padding-top:10px;font-weight:400;font-size:16px;color:#999;line-height:20px;text-align:center}
    .page_main .list_goods a{cursor:pointer}
    .page_main .list_goods .thumb_goods{z-index:10000;display:block;overflow:hidden}
    .page_main .list_goods .thumb_goods .ico{z-index:1;transition:all 0.3s ease-in-out}
    .page_main .list_goods .thumb_goods .thumb{display:block;margin:0 auto;background-position:50% 50%;background-size:cover;transform:scale(1);transition:all 0.3s ease-in-out}
    .page_main .list_goods .thumb_goods:hover .thumb{transform:scale(1.02);transition:all 0.3s ease-in-out}

    /* 슬라이드_버튼 */
    .page_main .bx-controls-direction{position:relative;width:1050px;margin:0 auto}
    .page_main .bx-controls-direction .bx-next,
    .page_main .bx-controls-direction .bx-prev{overflow:hidden;position:absolute;bottom:316px;width:60px;height:60px;border:0 none;font-size:0;line-height:0;text-indent:-9999px;transition:opacity 0.5s}
    .page_main .bx-controls-direction .bx-prev{left:-30px;background:url(https://res.kurly.com/pc/service/main/1908/btn_prev_default.png?v=1) no-repeat 50% 50%;transition:background 0.5s}
    .page_main .bx-controls-direction .bx-prev:hover{background:url(https://res.kurly.com/pc/service/main/1908/btn_prev_default_hover_x1.png?v=1) no-repeat 50% 50%;transition:background 0.5s}
    .page_main .bx-controls-direction .bx-next{right:-30px;background:url(https://res.kurly.com/pc/service/main/1908/btn_next_default.png?v=1) no-repeat 50% 50%;transition:background 0.5s}
    .page_main .bx-controls-direction .bx-next:hover{background:url(https://res.kurly.com/pc/service/main/1908/btn_next_default_hover_x1.png?v=1) no-repeat 50% 50%;transition:background 0.5s}
    .page_main .bg .bx-controls-direction .bx-prev{left:-30px;background:url(https://res.kurly.com/pc/service/main/1908/btn_prev_gray_x1.png?v=1) no-repeat 50% 50%;transition:background 0.5s}
    .page_main .bg .bx-controls-direction .bx-prev:hover{background:url(https://res.kurly.com/pc/service/main/1908/btn_prev_gray_hover_x1.png?v=1) no-repeat 50% 50%;transition:background 0.5s}
    .page_main .bg .bx-controls-direction .bx-next{right:-30px;background:url(https://res.kurly.com/pc/service/main/1908/btn_next_gray_x1.png?v=1) no-repeat 50% 50%;transition:background 0.5s}
    .page_main .bg .bx-controls-direction .bx-next:hover{background:url(https://res.kurly.com/pc/service/main/1908/btn_next_gray_hover_x1.png?v=1) no-repeat 50% 50%;transition:background 0.5s}
    .page_main .bx-controls-direction .disabled{opacity:0}

    /* ####### */
    /* 1종노출 */
    /* ####### */
    /* 1종노출+슬라이드+fullsize */
    .main_type1 .list_goods .thumb_goods{width:auto;height:370px;background-repeat:no-repeat;background-position:50% 50%;background-size:auto auto;font-size:0;line-height:0;text-indent:-9999px;}
    .main_type1 .bx-controls-auto{overflow:hidden;font-size:0;line-height:0;text-indent:-9999px}
    .main_type1 .bx-controls-direction .bx-next,
    .main_type1 .bx-controls-direction .bx-prev{bottom:159px;width:52px;height:52px;opacity:0}
    .main_type1 .bx-controls-direction .bx-prev:hover,
    .main_type1 .bx-controls-direction .bx-prev{left:-91px;background:url(https://res.kurly.com/pc/service/main/1908/ico_prev1_x1.png) no-repeat 50% 50%;transition:opacity 0.5s}
    .main_type1 .bx-controls-direction .bx-next:hover,
    .main_type1 .bx-controls-direction .bx-next{right:-91px;background:url(https://res.kurly.com/pc/service/main/1908/ico_next1_x1.png) no-repeat 50% 50%;transition:opacity 0.5s}
    .main_type1 .list_goods:hover .bx-next,
    .main_type1 .list_goods:hover .bx-prev{opacity:1}
    @media all and (max-width: 1250px){
        .main_type1 .bx-controls-direction .bx-prev:hover,
        .main_type1 .bx-controls-direction .bx-prev{left:-26px}
        .main_type1 .bx-controls-direction .bx-next:hover,
        .main_type1 .bx-controls-direction .bx-next{right:-26px}
    }

    /* ####### */
    /* 4종노출 */
    /* ####### */
    /* 4종노출+슬라이드 */
    .main_type2 .list_goods{width:1050px;height:506px;margin:0 auto}
    .main_type2 .list_goods .list{width:99999px}
    .main_type2 .list_goods li{float:left;width:249px;height:506px;margin-right:18px}
    .main_type2 .list_goods .thumb_goods{position:relative;background-color:#eee}
    .main_type2 .list_goods .ico{position:absolute;left:0;top:0;width:62px;height:54px}
    .main_type2 .list_goods .thumb{width:249px;height:320px}
    .main_type2 .list_goods .name{display:block;overflow:hidden;max-height:50px;margin-top:11px;
        text-overflow:ellipsis;display: -webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;word-wrap:break-word
    }
    .main_type2 .list_goods .txt{font-size:16px;line-height:23px}
    .main_type2 .list_goods .price{display:block;padding-top:6px;font-weight:700;font-size:16px;line-height:20px}
    .main_type2 .list_goods .cost{display:block;padding-top:4px;font-size:14px;color:#ccc;line-height:18px;text-decoration:line-through}
    /* 엠디의 추천 */
    .category_type{padding-bottom:100px}
    .category_type .list_goods{height:462px}
    .category_type .list_goods.none{height:0}
    .category_type .list_goods li{height:462px}
    .category_type .bx-controls-direction .bx-next,
    .category_type .bx-controls-direction .bx-prev{bottom:272px}
    .category_type .category .list_category{width:1050px;max-width:1050px;padding:0 0 20px;margin:0 auto;text-align:center;font-size:0}
    .category_type .category .list_category li{display:inline-block;padding:0 5px 20px}
    .category_type .category .list_category .cut:before{content:"";display:block;overflow:hidden;width:100%;height:0}
    .category_type .category .list_category .menu{display:inline-block;height:40px;padding:9px 20px 0 19px;border:1px solid #f7f7f6;border-radius:20px;background-color:#f7f7f7;font-size:14px;line-height:18px}
    .category_type .category .list_category .menu:hover{border:1px solid #f7f3f7;background-color:#f7f3f8;color:#5f0080}
    .category_type .category .list_category .on:hover,
    .category_type .category .list_category .on{border:1px solid #5f0081;background-color:#5f0080;font-weight:700;color:#fff}
    .category_type .link_cate{width:516px;margin:0 auto}
    .category_type .link_cate .link{display:block;overflow:hidden;height:56px;padding-top:16px;border:1px solid #e3e3e3;border-radius:3px;font-size:16px;line-height:20px;text-align:center;letter-spacing:-0.3px;cursor:pointer}
    .category_type .link_cate .ico{padding:0 18px;background:url(https://res.kurly.com/pc/service/main/1903/ico_more_link_x1.png) no-repeat 100% 3px}
    .category_type .min .bx-controls{opacity:0}
    .category_type .list_goods.over{overflow:hidden}
    .category_type .list_goods.over .bx-controls{opacity:0}

    /* ####### */
    /* 3종노출 */
    /* ####### */
    .main_type3 .list_goods{width:1050px;margin:0 auto}
    .main_type3 .list_goods .list{width:99999px}
    .main_type3 .list_goods li{float:left;width:338px;margin-right:18px}
    .main_type3 .list_goods .thumb_goods{display:block;position:relative}
    .main_type3 .list_goods .ico{position:absolute;left:0;top:0;width:62px;height:54px}
    .main_type3 .list_goods .thumb{width:338px}
    .main_type3 .list_goods .name{display:block;overflow:hidden}
    .main_type3 .list_goods .desc{display:block;overflow:hidden;text-align:center;white-space:nowrap;text-overflow:ellipsis}
    .main_type3 .list_goods .desc .txt{font-size:16px;line-height:20px}
    /* 3종노출_이벤트 */
    .main_event .list_goods{overflow:hidden;height:538px}
    .main_event .list_goods .list{width:1068px}
    .main_event .list_goods li{height:538px}
    .main_event .list_goods .thumb{height:338px}
    .main_event .list_goods .name{max-height:54px;margin-top:17px;text-align:center;
        text-overflow:ellipsis;display: -webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;word-wrap:break-word
    }
    .main_event .list_goods .name .txt{font-weight:700;font-size:18px;line-height:28px;letter-spacing:-0.3px}
    .main_event .list_goods .desc{padding-top:8px}
    .main_event .list_goods .desc .txt{color:#999}
    .main_event.min .list_goods{text-align:center}
    .main_event.min .list_goods .list{display:inline-block;width:auto;padding-left:18px}
    /* 3종노출_레시피 */
    .main_recipe .list_goods{height:303px}
    .main_recipe .list_goods li{height:303px}
    .main_recipe .list_goods .thumb{height:225px}
    .main_recipe .list_goods .name{padding-top:12px;text-align:center;white-space:nowrap;text-overflow:ellipsis}
    .main_recipe .list_goods .txt{font-size:16px;line-height:20px}
    .main_recipe .bx-controls-direction .bx-next,
    .main_recipe .bx-controls-direction .bx-prev{bottom:160px}

    /* ####### */
    /* 6종노출 */
    /* ####### */
    /* 6종노출+슬라이드 : 인스타그램전용 */
    .main_type4 .list_goods{width:1050px;height:175px;margin:0 auto}
    .main_type4 .list_goods .list{width:99999px}
    .main_type4 .list_goods li{float:left;width:175px;height:175px}
    .main_type4 .list_goods .thumb{width:175px;height:175px}
    .main_type4 .list_goods .thumb_goods:hover .thumb{transform:scale(1)}
    .main_type4 .bnr{padding:39px 0 100px;font-weight:700;font-size:16px;line-height:29px;text-align:center}
    .main_type4 .bnr .txt{display:block;font-weight:400;color:#999}
    .main_type4 .bnr a{font-weight:700}
    .main_type4 .bx-controls-direction .bx-next,
    .main_type4 .bx-controls-direction .bx-prev{bottom:58px}
    .main_type4 .bx-controls-auto{overflow:hidden;font-size:0;line-height:0;text-indent:-9999px}

    /* ######## */
    /* 스페셜딜 */
    /* ######## */
    .main_special{padding-bottom:88px}
    .main_special .inner_special{overflow:hidden;width:1050px;margin:0 auto;padding-top:80px;border-top:1px solid #ddd}
    .main_special .inner_special.no_line{border-top:0 none}
    .main_special .tit_goods{float:left;width:338px;padding:11px 0 7px 12px}
    .main_special .tit_goods .tit{height:173px;text-align:left}
    .main_special .tit_goods .name{font-weight:700;font-size:32px;line-height:48px}
    .main_special .tit_goods .tit_desc:before{content:"";display:block;width:12px;height:1px;margin:7px 0 16px 2px;background-color:#999;word-break:break-all}
    .main_special .tit_goods .tit_desc{font-size:16px;line-height:24px;letter-spacing:0;text-align:left;}
    .main_special .sub_hook{padding:0 0 10px 22px;background:url(https://res.kurly.com/pc/service/main/1907/ico_hook.png) no-repeat 0 2px;font-size:14px;color:#ccc;line-height:20px;letter-spacing:-0.4px}
    .main_special .list_goods{float:right;width:694px}
    .main_special .list_goods .list{overflow:hidden;width:712px}
    .main_special .list_goods li{width:694px}
    .main_special .list_goods .thumb_goods{position:relative;background-color:#eee}
    .main_special .list_goods .thumb{display:block;width:694px;height:338px;}
    .main_special .list_goods .ico{position:absolute;left:0;top:0;width:62px;}
    .main_special .list_goods .bg{position:absolute;left:0;bottom:0;width:100%;height:40px;opacity:0.6}
    .main_special .list_goods .count{position:absolute;left:0;bottom:8px;width:100%;text-align:center}
    .main_special .list_goods .count .num{font-weight:bold;font-size:20px;color:#fff;line-height:24px}
    .main_special .list_goods .count .txt{font-size:14px;color:#fff;line-height:24px;vertical-align:2px}
    .main_special .list_goods .info_goods{position:relative}
    .main_special .list_goods .name{display:block;overflow:hidden;width:100%;padding:13px 0 0 4px;white-space:nowrap;text-overflow:ellipsis}
    .main_special .list_goods .name .txt{font-size:16px;line-height:24px}
    .main_special .list_goods .sub_name{display:block;overflow:hidden;width:100%;padding:5px 0 7px 4px;font-size:16px;color:#999;line-height:20px;white-space:nowrap;text-overflow:ellipsis}
    .main_special .list_goods .dc{position:absolute;right:10px;bottom:4px;font-weight:800;font-size:26px;line-height:30px}
    .main_special .list_goods .price{padding-left:4px;font-weight:bold;font-size:20px;line-height:30px}
    .main_special .list_goods .cost{padding-left:4px;font-size:14px;color:#ccc;line-height:30px;text-decoration:line-through}
    /* sold_out */
    .main_special .list_goods .sold_out .bg{height:100%;background-color:#000;opacity:0.5}
    .main_special .list_goods .sold_out .info{position:absolute;left:0;top:50%;width:100%;margin-top:-2px;transform:translate(0, -50%);text-align:center}
    .main_special .list_goods .sold_out .tit{display:block;font-weight:bold;font-size:28px;color:#fff;line-height:40px}
    .main_special .list_goods .sold_out .desc{display:block;padding:11px 10px 0;font-size:16px;color:#fff;line-height:24px;word-break:break-all}
    /* 2개일때 */
    .main_special .list_goods2 li{float:left;width:338px;margin-right:18px;padding-bottom:3px}
    .main_special .list_goods2 .thumb{width:338px;height:434px}
    .main_special .list_goods2 .name{height:66px;padding-top:14px;white-space:normal;
        display: -webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;word-wrap:break-word
    }
    .main_special .list_goods2 .sub_name{display:none;padding:0}
    
    /* #### */
    /* 배너 */
    /* #### */
    .bnr_main{width:1050px;margin:0 auto}
    .bnr_main .link{display:block;min-height:140px;background-color:#eee;background-position:50% 50%;background-size:cover;cursor:pointer}
    .bnr_main .tit{display:block;overflow:hidden;width:100%;padding:35px 50px 0;font-weight:700;font-size:28px;line-height:38px;white-space:nowrap;text-overflow:ellipsis}
    .bnr_main .txt{display:block;overflow:hidden;width:100%;padding:5px 50px 0;font-size:16px;line-height:24px;white-space:nowrap;text-overflow:ellipsis}
    .bnr_type2 .link{height:160px;padding-top:24px}
    .bnr_type2 .tit{line-height:40px}
    .bnr_type2 .txt{padding-top:7px}

    @media
    only screen and (-webkit-min-device-pixel-ratio: 1.5),
    only screen and (min-device-pixel-ratio: 1.5),
    only screen and (min-resolution: 1.5dppx) {
        .page_main .bx-controls-direction .bx-prev{background:url(https://res.kurly.com/pc/service/main/1908/btn_prev_default_x2.png?v=1) no-repeat 50% 50%;background-size:60px 60px}
        .page_main .bx-controls-direction .bx-prev:hover{background:url(https://res.kurly.com/pc/service/main/1908/btn_prev_default_hover_x2.png?v=1) no-repeat 50% 50%;background-size:60px 60px}
        .page_main .bx-controls-direction .bx-next{background:url(https://res.kurly.com/pc/service/main/1908/btn_next_default_x2.png?v=1) no-repeat 50% 50%;background-size:60px 60px}
        .page_main .bx-controls-direction .bx-next:hover{background:url(https://res.kurly.com/pc/service/main/1908/btn_next_default_hover_x2.png?v=1) no-repeat 50% 50%;background-size:60px 60px}
        .page_main .bg .bx-controls-direction .bx-prev{background:url(https://res.kurly.com/pc/service/main/1908/btn_prev_gray_x2.png?v=1) no-repeat 50% 50%;background-size:60px 60px}
        .page_main .bg .bx-controls-direction .bx-prev:hover{background:url(https://res.kurly.com/pc/service/main/1908/btn_prev_gray_hover_x2.png?v=1) no-repeat 50% 50%;background-size:60px 60px}
        .page_main .bg .bx-controls-direction .bx-next{background:url(https://res.kurly.com/pc/service/main/1908/btn_next_gray_x2.png?v=1) no-repeat 50% 50%;background-size:60px 60px}
        .page_main .bg .bx-controls-direction .bx-next:hover{background:url(https://res.kurly.com/pc/service/main/1908/btn_next_gray_hover_x2.png?v=1) no-repeat 50% 50%;background-size:60px 60px}
        .page_main .tit_goods .name .ico{background:url(https://res.kurly.com/pc/service/main/1908/ico_title_link_x2.png) no-repeat 100% 50%;background-size:32px 32px}
        .main_type1 .bx-controls-direction .bx-prev:hover,
        .main_type1 .bx-controls-direction .bx-prev{background:url(https://res.kurly.com/pc/service/main/1908/ico_prev1_x2.png) no-repeat 50% 50%;background-size:52px 52px}
        .main_type1 .bx-controls-direction .bx-next:hover,
        .main_type1 .bx-controls-direction .bx-next{background:url(https://res.kurly.com/pc/service/main/1908/ico_next1_x2.png) no-repeat 50% 50%;background-size:52px 52px}
        .main_md .link_more .ico{background:url(https://res.kurly.com/pc/service/main/1903/ico_more_link_x2.png) no-repeat 100% 50%;background-size:20px 20px}
        .category_type .link_more .ico{background-image:url(https://res.kurly.com/pc/service/main/1903/ico_more_link_x2.png);background-size:20px 20px}
        .main_special .sub_hook{background:url(https://res.kurly.com/pc/service/main/1907/ico_hook_x2.png) no-repeat 0 2px;background-size:18px 18px}
    }

    #footer{opacity:0}
</style>

<!-- jquery slider -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>

<script>
	$(function () {
		choiceCategory('A');
		
		$("#kurlyMain .main_type1 .list").bxSlider({
			mode: "horizontal", // 가로 방향 수평 슬라이드
                     infiniteLoop : true,
                     speed: 500, // 이동 속도를 설정
                     pager: false, // 현재 위치 페이징 표시 여부 설정
                     slideWidth : 0, // 아이템1개의 사이즈
                     moveSlides: 1, // 슬라이드 이동시 개수
                     minSlides: 1, // 최소 노출 개수
                     maxSlides: 1, // 최대 노출 개수
                     slideMargin: 0, // 슬라이드간의 간격
                     auto: true, // 이미지 회전 자동 여부
                     pause : 3000, // 자동롤링시 한번이동후 멈춤시간
                     stopAutoOnClick : true,
                     autoHover: true, // 마우스 호버시 정지 여부
                     controls: true, // 이전 다음 버튼 노출 여부
                     autoControls  : true, // 시작 중지 버튼 여부
                     hideControlOnEnd : false, // 맨앞, 맨뒤 버튼 노출여부
                     easing : "ease-in-out", // 효과
					 touchEnabled : false	// touch swipe 동작 허용여부, 기본 true
		});

		$("#kurlyMain .main_type2 .list").bxSlider({
			mode: "horizontal", // 가로 방향 수평 슬라이드
                     infiniteLoop : false,
                     speed: 500, // 이동 속도를 설정
                     pager: false, // 현재 위치 페이징 표시 여부 설정
                     slideWidth : $("#kurlyMain .main_type2 .list li:eq(0)").width(), // 아이템1개의 사이즈
                     moveSlides: 4, // 슬라이드 이동시 개수
                     minSlides: 4, // 최소 노출 개수
                     maxSlides: 4, // 최대 노출 개수
                     slideMargin: 18, // 슬라이드간의 간격
                     auto: false, // 이미지 회전 자동 여부
                     pause : 0, // 자동롤링시 한번이동후 멈춤시간
                     stopAutoOnClick : true,
                     autoHover: true, // 마우스 호버시 정지 여부
                     controls: true, // 이전 다음 버튼 노출 여부
                     autoControls  : false, // 시작 중지 버튼 여부
                     hideControlOnEnd : true, // 맨앞, 맨뒤 버튼 노출여부
                     easing : "swing", // 효과
                   	 touchEnabled : false
		});
		
		$("#kurlyMain .main_recipe .list").bxSlider({
			mode: "horizontal", // 가로 방향 수평 슬라이드
                     infiniteLoop : false,
                     speed: 500, // 이동 속도를 설정
                     pager: false, // 현재 위치 페이징 표시 여부 설정
                     slideWidth : $("#kurlyMain .main_recipe .list li:eq(0)").width(), // 아이템1개의 사이즈
                     moveSlides: 3, // 슬라이드 이동시 개수
                     minSlides: 3, // 최소 노출 개수
                     maxSlides: 3, // 최대 노출 개수
                     slideMargin: 18, // 슬라이드간의 간격
                     auto: false, // 이미지 회전 자동 여부
                     pause : 0, // 자동롤링시 한번이동후 멈춤시간
                     stopAutoOnClick : true,
                     autoHover: true, // 마우스 호버시 정지 여부
                     controls: true, // 이전 다음 버튼 노출 여부
                     autoControls  : false, // 시작 중지 버튼 여부
                     hideControlOnEnd : true, // 맨앞, 맨뒤 버튼 노출여부
                     easing : "swing", // 효과
                     touchEnabled : false
		});							
		
		$("#kurlyMain .main_type4 .list").bxSlider({
			mode: "horizontal", // 가로 방향 수평 슬라이드
                     infiniteLoop : false,
                     speed: 500, // 이동 속도를 설정
                     pager: false, // 현재 위치 페이징 표시 여부 설정
                     slideWidth : $("#kurlyMain .main_recipe .list li:eq(0)").width(), // 아이템1개의 사이즈
                     moveSlides: 6, // 슬라이드 이동시 개수
                     minSlides: 6, // 최소 노출 개수
                     maxSlides: 6, // 최대 노출 개수
                     slideMargin: 0, // 슬라이드간의 간격
                     auto: false, // 이미지 회전 자동 여부
                     pause : 0, // 자동롤링시 한번이동후 멈춤시간
                     stopAutoOnClick : true,
                     autoHover: true, // 마우스 호버시 정지 여부
                     controls: true, // 이전 다음 버튼 노출 여부
                     autoControls  : false, // 시작 중지 버튼 여부
                     hideControlOnEnd : true, // 맨앞, 맨뒤 버튼 노출여부
                     easing : "swing", // 효과
                     touchEnabled : false
		});
	})
</script>

<div id="kurlyMain" class="page_aticle page_main" style="opacity: 1;">
	<h2 class="screen_out">마켓컬리 메인</h2>
	
	<!-- .main_type1 메인배너-->
	<div class="main_type1">
		<div class="list_goods">
			<ul class="list">
				<c:forEach var="i" begin="1" end="11" step="1">
					<li><a class="thumb_goods" style="background-image: url('../data/main/type1/pc_img_${ i }.jpg');">메인배너</a></li>
				</c:forEach>
			</ul>
		</div>
	</div>
		
	<!-- main_type2 추천상품 목록 -->
	<div class="main_type2">
		<div class="product_list">
			<div class="tit_goods">
				<h3 class="tit">
					<span class="name"> 이 상품 어때요? </span>
				</h3>
			</div>
			<div class="list_goods">
				<ul class="list">
					<!-- 상품 반복 -->
					<c:forEach items="${ recommendList }" var="dto">
						<li class="">
							<a class="thumb_goods" href="../goods/goods_view.do?group_no=${ dto.group_no }">
								<c:if test="${ dto.discount ne 0 }">
									<img src="../data/my_icon/icon_save_${ dto.discount }.png" alt="SALE" class="ico">
								</c:if>
								<img src="../../mobile/service/main/1903/bg_150x195.png" alt="상품이미지" class="thumb" style="background-image: url(../..${ dto.main_img })">
							</a>
							<div class="info_goods">
								<span class="name">
									<a class="txt" href="../goods/goods_view.do?group_no=${ dto.group_no }">${ dto.name }</a>
								</span>
								<c:if test="${ dto.discount ne 0 }">
									<span class="price"><fmt:formatNumber value="${ dto.price * ((100-dto.discount)/100) }" pattern="#,###"/>원</span>
									<span class="cost"><fmt:formatNumber value="${ dto.price }" pattern="#,###"/>원</span>
								</c:if>
								<c:if test="${ dto.discount eq 0 }">
									<span class="price"><fmt:formatNumber value="${ dto.price }" pattern="#,###"/>원</span>
								</c:if>
							</div>
						</li>
					</c:forEach>	
				</ul>
			</div>
		</div>
	</div>

	<%
		String[] eventName = {"유가원 최대 20% 할인", "식단관리 두유 모음전", "쌍계명차 최대 20% 할인"};
		String[] eventDesc = {"100% 유기농만 고집하는", "더 가벼운 내일을 위해", "내 몸을 위한 차 한잔"};
		request.setAttribute("eventName", eventName);
		request.setAttribute("eventDesc", eventDesc);
	%>
	
	<!-- main_type3 이벤트 목록 -->
	<div class="main_type3 bg">
		<div class="main_event">
			<div class="tit_goods">
				<h3 class="tit">
					<a class="name"><span class="ico">이벤트 소식</span></a>
				</h3>
			</div>
			<div class="list_goods">
				<ul class="list">
					<!-- 이벤트 목록 3개만 뿌리기 -->
					<c:forEach var="i" begin="1" end="3" step="1">
						<li>
							<a class="thumb_goods">
								<img src="../../mobile/service/main/1903/bg_94x94.png" alt="상품이미지" class="thumb" style="background-image: url(../data/main/3/event_${ i }.jpg);">
							</a>
							<div class="info_goods">
								<div class="inner_info">
									<span class="name">
										<a class="txt">${ eventName[i-1] }</a>
									</span> 
									<span class="desc">
										<a class="txt">${ eventDesc[i-1] }</a>
									</span>
								</div>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	
	<!-- main_type2 알뜰상품 목록 -->
	<div class="main_type2">
		<div class="product_list">
			<div class="tit_goods">
				<h3 class="tit">
					<a href="../goods/goods_list.do?category=sale" class="name">
						<span class="ico">알뜰 상품</span>
					</a>
				</h3>
			</div>
			<div class="list_goods">
				<ul class="list">
					<!-- 상품목록 반복 -->
					<c:forEach items="${ saleList }" var="dto">
					<li class="">
						<a class="thumb_goods" href="../goods/goods_view.do?group_no=${ dto.group_no }">
							<!-- 상품 할인율에 맞는 이미지로 띄우기 : 이미지이름의 숫자만 변경하면 됨 -->
							<img src="../data/my_icon/icon_save_${ dto.discount }.png" alt="SALE" class="ico">
							<img src="../../mobile/service/main/1903/bg_150x195.png" alt="상품이미지" class="thumb" style="background-image: url(../..${ dto.main_img });">
						</a>
						<div class="info_goods">
							<span class="name">
								<a class="txt" href="../goods/goods_view.do?group_no=${ dto.group_no }">${ dto.name }</a>
							</span>
							<span class="price"><fmt:formatNumber value="${ dto.price * ((100-dto.discount)/100) }" pattern="#,###"/>원</span>
							<span class="cost"><fmt:formatNumber value="${ dto.price }" pattern="#,###"/>원</span>
							
						</div>
					</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	
	<!-- main_type2 MD의 추천 -->
	<div class="main_type2">
		<div class="category_type">
			<div class="tit_goods top_short">
				<h3 class="tit">
					<span class="name"> MD의 추천 </span>
				</h3>
			</div>
			<div class="category_menu">
				<div class="bg_category">
					<span class="bg_shadow shadow_before"></span> 
					<span class="bg_shadow shadow_after"></span>
				</div>
				<div class="category">
					<ul class="list_category">
						<!-- 카테고리 선택되면 addClass("on") -->
						<c:forEach items="${ p_categoryList }" var="dto">
							<li>
								<a href="javascript:choiceCategory('${ dto.parent_seq}')" class="menu" data="${ dto.parent_seq }"> ${ dto.pc_name } </a>
							</li>
						 </c:forEach>
					</ul>
				</div>
			</div>
			<div class="list_goods">
			
				<%-- 
				<ul class="list">
					<!-- 카테고리별 상품 6개씩 뿌리기.. 동적생성 -->
					<c:forEach var="i" begin="1" end="6" step="1">
						<li class="">
							<a class="thumb_goods">
								상품에 할인율이 있다면 해당 할인율이미지 띄우기 
								<c:if test="">
									<img src="../data/my_icon/icon_save_20.png" alt="SALE" class="ico">
								</c:if>
								<img src="../../mobile/service/main/1903/bg_150x195.png" alt="상품이미지" class="thumb" style="background-image: url(http://placehold.it);">
							</a>
							<div class="info_goods">
								<span class="name">
									<a class="txt">상품명</a>
								</span>
								상품에 할인율 있다면 할인가와 원가 출력 
								<c:if test="">
									<span class="price">할인가</span>
									<span class="cost">7,980원</span>
								</c:if>
								<!-- 할인없으면 그냥 가격 출력 -->
								<span class="price">가격</span>
							</div>
						</li>
					</c:forEach>				
				</ul>									
				--%>
				
			</div>
			<div class="link_cate">
				<!-- 변경된 카테고리명 띄우기 -->				
				<a class="link">
					<span class="ico">선택한 카테고리명 전체보기</span>
				</a>
			</div>
		</div>
	</div>
	
	<script>
		function choiceCategory(seq){
			$(".category_type .list_category a").each(function(i, element) {
				if($(element).hasClass("on")){
					$(element).removeClass("on");
				}
			});
			$(".category_type .list_category a[data=" + seq + "]").addClass("on");
			
			$.ajax({
				url : "../proc/categoryList.jsp",
				type : "GET",
				data : {
					"seq" : seq
				},
				dataType : 'json',
				cache : false,
				success : function(data) {					
					var target = $(".category_type .list_goods");
					target.empty();
					var goodsList = data.goodsList;
					//console.log(goodsList);
					var ul_list = $("<ul/>").addClass("list");
					for (var i = 0; i < goodsList.length; i++) {
						var a_thumb = $("<a/>").addClass("thumb_goods");
						var discount = goodsList[i].discount;
						var price = goodsList[i].price;
						//console.log(typeof price);
						if(discount != 0){
							a_thumb.append($("<img/>").attr("src", "../data/my_icon/icon_save_" + discount + ".png").attr("alt", "SALE").addClass("ico"));
						}
						a_thumb.append($("<img/>").attr("src", "../../mobile/service/main/1903/bg_150x195.png").attr("alt", "상품이미지").addClass("thumb").css("background-image", "url(../.." + goodsList[i].main_img + ")"));
						a_thumb.attr("href", "../goods/goods_view.do?group_no=" + goodsList[i].group_no);
						
						var div_info = $("<div/>").addClass("info_goods");
						div_info.append($("<span/>").addClass("name").append($("<a/>").addClass("txt").text(goodsList[i].name).attr("href", "../goods/goods_view.do?group_no=" + goodsList[i].group_no)));
						if(discount != 0){
							var salePrice = price*((100-discount)/100);
							div_info.append($("<span/>").addClass("price").text(salePrice.toLocaleString() + "원").append($("<span/>").addClass("cost").text(price.toLocaleString() + "원")));
						} else{
							div_info.append($("<span/>").addClass("price").text(price.toLocaleString() + "원"));
						}
						
						ul_list.append($("<li/>").append(a_thumb).append(div_info));
					}					
					target.append(ul_list);
					
					$("#kurlyMain .main_type2 .list").bxSlider({
						mode: "horizontal", // 가로 방향 수평 슬라이드
			                     infiniteLoop : false,
			                     speed: 500, // 이동 속도를 설정
			                     pager: false, // 현재 위치 페이징 표시 여부 설정
			                     slideWidth : $("#kurlyMain .main_type2 .list li:eq(0)").width(), // 아이템1개의 사이즈
			                     moveSlides: 4, // 슬라이드 이동시 개수
			                     minSlides: 4, // 최소 노출 개수
			                     maxSlides: 4, // 최대 노출 개수
			                     slideMargin: 18, // 슬라이드간의 간격
			                     auto: false, // 이미지 회전 자동 여부
			                     pause : 0, // 자동롤링시 한번이동후 멈춤시간
			                     stopAutoOnClick : true,
			                     autoHover: true, // 마우스 호버시 정지 여부
			                     controls: true, // 이전 다음 버튼 노출 여부
			                     autoControls  : false, // 시작 중지 버튼 여부
			                     hideControlOnEnd : true, // 맨앞, 맨뒤 버튼 노출여부
			                     easing : "swing", // 효과
			                     touchEnabled : false
					});
					
					$(".category_type .link_cate span").text(data.pc_name + " 전체보기");
					$(".category_type .link_cate .link").attr("href","../goods/goods_list.do?category=" + seq);
				},
				fail : function() {
					alert("일시적인 장애가 발생하였습니다.\n잠시후 다시 시도해주세요");
				}
			});
			
		}
	</script>
	
	<!-- main_type2 오늘의 신상품 -->
	<div class="main_type2">
		<div class="product_list">
			<div class="tit_goods top_short">
				<h3 class="tit">
					<a class="name">
						<span class="ico">오늘의 신상품</span> 
						<span class="tit_desc">매일 정오, 컬리의 새로운 상품을 만나보세요</span>
					</a>
				</h3>
			</div>
			<div class="list_goods">
				<ul class="list">
					<!-- 신상품 목록 6개 띄우기 -->
					<c:forEach items="${ newList }" var="dto">
						<li class="">
							<a class="thumb_goods" href="../goods/goods_view.do?group_no=${ dto.group_no }">
								<c:if test="${ dto.discount ne 0 }">
									<img src="../data/my_icon/icon_save_${ dto.discount }.png" alt="SALE" class="ico">
								</c:if>
								<img src="../../mobile/service/main/1903/bg_150x195.png" alt="상품이미지" class="thumb" style="background-image: url(../..${ dto.main_img })">
							</a>
							<div class="info_goods">
								<span class="name">
									<a class="txt" href="../goods/goods_view.do?group_no=${ dto.group_no }">${ dto.name }</a>
								</span>
								<c:if test="${ dto.discount ne 0 }">
									<span class="price"><fmt:formatNumber value="${ dto.price * ((100-dto.discount)/100) }" pattern="#,###"/>원</span>
									<span class="cost"><fmt:formatNumber value="${ dto.price }" pattern="#,###"/>원</span>
								</c:if>
								<c:if test="${ dto.discount eq 0 }">
									<span class="price"><fmt:formatNumber value="${ dto.price }" pattern="#,###"/>원</span>
								</c:if>
							</div>
						</li>
					</c:forEach>					
				</ul>
			</div>
		</div>
	</div>
	
	<!-- main_type2 지금 가장 핫한 상품 -->
	<div class="main_type2 bg" style="background-color: rgb(247, 247, 247);">
		<div class="product_list">
			<div class="tit_goods">
				<h3 class="tit">
					<a class="name">
						<span class="ico">지금 가장 핫한 상품</span>
					</a>
				</h3>
			</div>
			<div class="list_goods">
				<ul class="list">
					<!-- 핫한 상품 목록 반복 -->
					<c:forEach items="${ hotList }" var="dto">
						<li class="">
							<a class="thumb_goods" href="../goods/goods_view.do?group_no=${ dto.group_no }">
								<c:if test="${ dto.discount ne 0 }">
									<img src="../data/my_icon/icon_save_${ dto.discount }.png" alt="SALE" class="ico">
								</c:if>
								<img src="../../mobile/service/main/1903/bg_150x195.png" alt="상품이미지" class="thumb" style="background-image: url(../..${ dto.main_img })">
							</a>
							<div class="info_goods">
								<span class="name">
									<a class="txt" href="../goods/goods_view.do?group_no=${ dto.group_no }">${ dto.name }</a>
								</span>
								<c:if test="${ dto.discount ne 0 }">
									<span class="price"><fmt:formatNumber value="${ dto.price * ((100-dto.discount)/100) }" pattern="#,###"/>원</span>
									<span class="cost"><fmt:formatNumber value="${ dto.price }" pattern="#,###"/>원</span>
								</c:if>
								<c:if test="${ dto.discount eq 0 }">
									<span class="price"><fmt:formatNumber value="${ dto.price }" pattern="#,###"/>원</span>
								</c:if>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	
	<!-- main_type2 시즌제 목록 -->
	<%-- 
	<div class="main_type2">
		<div class="product_list">
			<div class="tit_goods">
				<h3 class="tit">
					<a class="name">
						<span class="ico">시원한 여름</span>
					</a>
				</h3>
			</div>
			<div class="list_goods">
				<ul class="list"">
					<!-- 상품 반복 -->
					<c:forEach var="i" begin="1" end="6" step="1">
						<li class="">
							<a class="thumb_goods">
								상품에 할인율이 있다면 해당 할인율이미지 띄우기 ..
								<c:if test="">
									<img src="../data/my_icon/icon_save_20.png" alt="SALE" class="ico">
								</c:if>
								
								<img src="../../mobile/service/main/1903/bg_150x195.png" alt="상품이미지" class="thumb" style="background-image: url(http://placehold.it);">
							</a>
							<div class="info_goods">
								<span class="name"><a class="txt">상품명${ i }</a></span>
								상품에 할인율 있다면 할인가와 원가 출력 
								<c:if test="">
									<span class="price">할인가</span>
									<span class="cost">7,980원</span>
								</c:if>
								
								<!-- 할인없으면 그냥 가격 출력 -->
								<span class="price">가격</span>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	 --%>
	<%
		String [] recipeNames = {"티라미수", "도다리 양념구이", "황태양념구이", "도다리 냉이국", "메로 미소된장조림"};
		request.setAttribute("recipeNames", recipeNames);
	%>
	
	<!-- 컬리의 레시피 -->
	<div class="main_type3">
		<div class="main_recipe">
			<div class="tit_goods top_short">
				<h3 class="tit">
					<a class="name">
						<span class="ico">컬리의 레시피</span>
					</a>
				</h3>
			</div>
			<div class="list_goods">
				<ul class="list">
					<!-- 레시피 목록 반복 -->
					<c:forEach var="i" begin="1" end="5" step="1">
						<li>
							<a class="thumb_goods">
								<img src="../../mobile/service/main/1903/bg_240x160.png" alt="상품이미지" class="thumb" style="background-image: url(../data/board/recipe/m/recipe_${ i }.jpg);">
							</a>
							<div class="info_goods">
								<div class="inner_info">
									<span class="name">
										<a class="txt">${ recipeNames[i-1] }</a>
									</span>
								</div>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>

	<!-- main_type4 인스타그램 후기 -->
	<div class="main_type4">
		<div class="tit_goods">
			<h3 class="tit">인스타그램 고객 후기</h3>
		</div>
		<div class="list_goods">
			<ul class="list">
				<li>
					<!-- 이동이 왜 안될까...ㅠㅠ -->
					<a target="_blank" class="thumb_goods" href="https://www.instagram.com/p/CB4hagypgz-/">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/106292266_901346570344741_751990585231866938_n.jpg?_nc_cat=102&amp;_nc_sid=8ae9d6&amp;_nc_ohc=8fQLUQW5u9MAX8W9KRe&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=d8c9e90a5bd703eb3812da7a10197abd&amp;oe=5F2E72AB">
					</a>
				</li>
				<li>
					<a target="_blank" class="thumb_goods">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/105299945_2863245100469640_437596639219726318_n.jpg?_nc_cat=105&amp;_nc_sid=8ae9d6&amp;_nc_ohc=93sg7iIdKbUAX8yZweC&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=67693c2c5bbf2dff6322b4d937e76d37&amp;oe=5F2BCF7C">
					</a>
				</li>
				<li>
					<a target="_blank" class="thumb_goods">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/104447126_267388727930985_7970622766971527416_n.jpg?_nc_cat=103&amp;_nc_sid=8ae9d6&amp;_nc_ohc=NSwLNTzjGOcAX-tRrjb&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=338265f1c443c668c2ed8aaebfebaae2&amp;oe=5F2C62EF">
					</a>
				</li>
				<li>
					<a target="_blank" class="thumb_goods">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/104687155_176723593809402_1333996615459003364_n.jpg?_nc_cat=107&amp;_nc_sid=8ae9d6&amp;_nc_ohc=w87dd0eg7EcAX-GWDuy&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=bd722b42ad8579db602c0922b8e0c0a5&amp;oe=5F2BE336">
					</a>
				</li>
				<li>
					<a target="_blank" class="thumb_goods">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/103984285_160843812172448_7287460931748995676_n.jpg?_nc_cat=107&amp;_nc_sid=8ae9d6&amp;_nc_ohc=Dvu4iNJsos0AX9en_RY&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=0556f5a38b5964e62768f25eaf99f203&amp;oe=5F2E3EDA">
					</a>
				</li>
				<li>
					<a target="_blank" class="thumb_goods">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.29350-15/103791122_291252065347718_4827079958461148554_n.jpg?_nc_cat=109&amp;_nc_sid=8ae9d6&amp;_nc_ohc=ZLs567FI42EAX_bwoFY&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=d42fc7b30820c7dd03a537b5abb36824&amp;oe=5F2D93BE">
					</a>
				</li>
				<li>
					<a target="_blank" class="thumb_goods">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.29350-15/103479773_2707899736161190_6704187562580756939_n.jpg?_nc_cat=100&amp;_nc_sid=8ae9d6&amp;_nc_ohc=Oqm87RXEZ58AX_i-JdW&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=43bf6f62c2393bcae3a02b7f85213bda&amp;oe=5F2DEA3D">
					</a>
				</li>
				<li>
					<a target="_blank" class="thumb_goods">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.29350-15/103087347_2589320831283452_2540152935903402353_n.jpg?_nc_cat=101&amp;_nc_sid=8ae9d6&amp;_nc_ohc=rzoEY5WHwCMAX-3rbqy&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=e7896667d4094977613058dc395560fd&amp;oe=5F2BDBFB">
					</a>
				</li>
				<li>
					<a target="_blank" class="thumb_goods">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.29350-15/103752903_2890947777669793_3520440265971638569_n.jpg?_nc_cat=101&amp;_nc_sid=8ae9d6&amp;_nc_ohc=vHA_dVSzcuYAX_ZZ2EG&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=6ad00eb7b2efe03036743000e987a2c8&amp;oe=5F2D7A59">
					</a>
				</li>
				<li>
					<a target="_blank" class="thumb_goods">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/100576067_4055672231118323_1549464363644792964_n.jpg?_nc_cat=100&amp;_nc_sid=8ae9d6&amp;_nc_ohc=jz_l5FNy938AX-hPwIB&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=e2b1b5e62340178be09dcedd63619ded&amp;oe=5F2DDC96">
					</a>
				</li>
				<li>
					<a target="_blank" class="thumb_goods">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/98334951_3377529135614219_8548088398915909600_n.jpg?_nc_cat=105&amp;_nc_sid=8ae9d6&amp;_nc_ohc=1wJPa8-cNpYAX-xf1AL&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=079cb67f247d2346d125a050d03cd661&amp;oe=5F2D83A7">
					</a>
				</li>
				<li>
					<a target="_blank" class="thumb_goods">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/97359285_647862239394873_8798189223669020353_n.jpg?_nc_cat=109&amp;_nc_sid=8ae9d6&amp;_nc_ohc=Bvq2H2vcSJsAX9Udw_N&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=9bb2c45da7ef160fa4c79ccd1df63586&amp;oe=5F2CBB2D">
					</a>
				</li>
				<li>
					<a target="_blank" class="thumb_goods">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/97565190_253521135768354_8688925557310269968_n.jpg?_nc_cat=100&amp;_nc_sid=8ae9d6&amp;_nc_ohc=2RfrVOa9DlMAX8Xx0B6&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=c6d5612cfc0cda9c6ee482d878b7b3a0&amp;oe=5F2BC8EB">
					</a>
				</li>
				<li>
					<a target="_blank" class="thumb_goods">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/96677819_261240075254209_8609585973691659032_n.jpg?_nc_cat=109&amp;_nc_sid=8ae9d6&amp;_nc_ohc=KCxyWH1mmUwAX-yZvrM&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=b1f98fba327dfa7c2509923a1031f2d9&amp;oe=5F2DD9CF">
					</a>
				</li>
				<li>
					<a target="_blank" class="thumb_goods">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/97222512_261445634908164_3809229327532808822_n.jpg?_nc_cat=106&amp;_nc_sid=8ae9d6&amp;_nc_ohc=aNTuAagNlywAX-2S0Po&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=a25d70638585352355d4bc513427699c&amp;oe=5F2DD62E">
					</a>
				</li>
				<li>
					<a target="_blank" class="thumb_goods">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/97179322_3529066963786748_5405826853238477701_n.jpg?_nc_cat=107&amp;_nc_sid=8ae9d6&amp;_nc_ohc=dViWOFDXKYkAX_DI-Wl&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=bc9d981967006dc4518173546c3fccfa&amp;oe=5F2E51EE">
					</a>
				</li>
				<li>
					<a target="_blank" class="thumb_goods">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/96259077_275760300266194_3201460871940506632_n.jpg?_nc_cat=109&amp;_nc_sid=8ae9d6&amp;_nc_ohc=7dGy4gPtb4AAX--Nw0h&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=6a7e37fa1a95d249f25060ca07d51a70&amp;oe=5F2BD1C7">
					</a>
				</li>
				<li>
					<a target="_blank" class="thumb_goods">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/96239346_1163720700647560_6280692634116570715_n.jpg?_nc_cat=102&amp;_nc_sid=8ae9d6&amp;_nc_ohc=zY7SYG2JhjoAX8Ct2dz&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=4d95e12fc8285bf7d3cc9af9efeb55d2&amp;oe=5F2D764E">
					</a>
				</li>
				<li>
					<a target="_blank" class="thumb_goods">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/95560803_570631923867717_8591014174503754504_n.jpg?_nc_cat=107&amp;_nc_sid=8ae9d6&amp;_nc_ohc=nBEaq2SPxDcAX84cJJd&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=168bf976670a258c9a22b1be835d770c&amp;oe=5F2EADD1">
					</a>
				</li>
				<li>
					<a target="_blank" class="thumb_goods">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.29350-15/95730440_234708757868353_178540069407381703_n.jpg?_nc_cat=103&amp;_nc_sid=8ae9d6&amp;_nc_ohc=Ng6n8i-M0iIAX__aWP4&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=bd475cdbfcd317368b1b27bdfb726633&amp;oe=5F2F3A42">
					</a>
				</li>				
				<li>
					<a target="_blank" class="thumb_goods">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/96140459_2517251928584898_4589571189539387731_n.jpg?_nc_cat=106&amp;_nc_sid=8ae9d6&amp;_nc_ohc=7_VrE_kLo2oAX9dnox_&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=44c7b23203fe182babe302f134a7b147&amp;oe=5F2ECCAA">
					</a>
				</li>
				<li>
					<a target="_blank" class="thumb_goods">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/95454834_2560173730887772_6467043718228716671_n.jpg?_nc_cat=101&amp;_nc_sid=8ae9d6&amp;_nc_ohc=kVXK4dtzV2cAX_JH41-&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=e926c04f68a301e011f8b71b02d09227&amp;oe=5F2D0D54">
					</a>
				</li>
				<li>
					<a target="_blank" class="thumb_goods">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/95170936_233629871209332_2175462979513717344_n.jpg?_nc_cat=102&amp;_nc_sid=8ae9d6&amp;_nc_ohc=FgKSPAi8Vq8AX-dgWqL&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=5f716e3b0fa70202a6e4881e28c0be90&amp;oe=5F2F0872">
					</a>
				</li>
				<li>
					<a target="_blank" class="thumb_goods">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/88207453_201848397721811_4247467902103762894_n.jpg?_nc_cat=105&amp;_nc_sid=8ae9d6&amp;_nc_ohc=i7WMLtUta1IAX-ZdaSb&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=6c9ba19e92467ba9e4586c831b5e4053&amp;oe=5F2CA4B8">
					</a>
				</li>
				<li>
					<a target="_blank" class="thumb_goods">
						<img alt="상품이미지" class="thumb"
						src="https://scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/87537187_603645113553621_6721470477092521103_n.jpg?_nc_cat=111&amp;_nc_sid=8ae9d6&amp;_nc_ohc=Y5kLRy9cVcUAX94jUWL&amp;_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;oh=912253159ab43ea2610bcd3b5afb3dda&amp;oe=5F2F3F0C">
					</a>
				</li>
			</ul>
		</div>
		<div class="bnr">
			<span class="txt">더 많은 고객 후기가 궁금하다면?</span> 
			<a href="https://www.instagram.com/marketkurly_regram/" target="_blank">@marketkurly_regram</a>
		</div>
	</div>

	<!-- bnr_main -->
	<div class="bnr_main">
		<a class="link" style="background-image: url(../data/main/15/pc_img_1568875999.png);">
			<span class="inner_link">
				<img src="../data/main/15/pc_img_1568875999.png">
			</span>
		</a>
	</div>

</div>