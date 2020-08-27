/**
 * 기능명세
 * pc, mobile 구분
 * 해당 페이지에 주소 노출 폼이 있는 경우 해당 값 추가 (backEnd 전달 용이기 때문에 아이디 또는 네임은 기존 그대로 유지)
 * 나머지 주소에 글자수 체크 적용 필요
 *
 */
var addressAction = (function(global) {
  var addressData = {
    // zipCode0: '',
    // zipCode1: '',
    // zoneCode: '',
    // address: '',
    // addressSub: '',
    // roadAddress: '',
    // deliPoli: '', // 0 : 샛별, 1 : 택배, null : 배송불가
    // sType: '', // 주소검색 타입 zipcode : 기존 우편번호 검색 / road : 도로명주소 검색
    // device: '' // 'mobile' : '' // pc는 값없음
  }


  var _address = {
    setAddress: function(data) {
      var that = this;

      addressData = data;

      /**
       * 배송유형 선택
       */
      $.ajax({
        url: '/shop/proc/ajax_address_chk.php',
        type: 'POST',
        data: {
          address: addressData.address,
          address_sub: addressData.addressSub,
          zipcode: addressData.zipCode0 + '-' + addressData.zipCode1,
          zonecode: addressData.zoneCode
        },
        dataType: 'json',
        async: false,
      }).done(function (data) {
        addressData.deliPoli = data.deliPoli;
        // deliveryCheck.layerShow();
        // deliveryCheck.elementSet();
        that.layerAction();
      }).fail(function () {
        alert("일시적인 장애가 발생하였습니다.\n잠시후 다시시도해주세요.");
      });


      that.sendFormDataAdd();
      that.insertViewData();
    },

    /**
     * form 전송 input에 값 추가
     */
    sendFormDataAdd: function(){
      if($('#deliPoli').length === 0){
        return;
      }

      $('#zipcode0').val(addressData.zipCode0);
      $('#zipcode1').val(addressData.zipCode1);
      $('#zonecode').val(addressData.zoneCode);
      $('#address').val(addressData.address || addressData.roadAddress);
      $('#address_sub').val(addressData.addressSub);
      $('#road_address').val(addressData.roadAddress);
      $('#deliPoli').val(addressData.deliPoli);
    },


    /**
     * UI 용 노출형 텍스트
     */
    insertViewData: function(){
      if($('#selectAddress').length === 0){
        return;
      }

      var $selector = {
        eventTarget: $('#addressSearch'),
        delivery: $('#delivery'),
        selectAddr: $('#selectAddress'),
        selectSub: $('#selectAddressSub'),
        addr: $('#addr'),
        addrNo: $('#addressNo'),
        addrSub: $('#address_sub')
      }

      var that = this, deliveryText = '샛별배송';

      $selector.selectAddr.show();
      $selector.selectSub.show();

      // 문구
      $selector.delivery.removeAttr('class');
      if(addressData.deliPoli === 0) {
        $selector.delivery.addClass('type1');
      }
      if(addressData.deliPoli === 1){
        deliveryText = '택배배송';
        $selector.delivery.addClass('type2');
      }
      if(addressData.deliPoli === ''){
        deliveryText = '배송불가';
        $selector.delivery.addClass('type3');
      }

      if(addressData.device === 'm'){
        // mobile
        $selector.addrNo.hide();
      }else{
        // pc
        $selector.eventTarget.addClass('re_search');
        $selector.addrNo.text($selector.addrNo.data('text'));
      }
      $selector.delivery.text(deliveryText);
      $selector.addrSub.text( addressData.addressSub );
      $selector.addr.text( addressData.sType ===  'zipcode' ? addressData.address : addressData.roadAddress );

      that.countAction();
    },


    /**
     * PD-818 : 나머지 주소 텍스트 입력시 카운트 되도록 설정
     */
    countAction: function(){
      var maxByteLimit = 99; // 글자수제한
      var staticLengthAddr = null; // length
      var $checkText = null; // 현재입력된 글자수
      var $limitText = null; // 최대입력가능한 글자수
      var $addressSub = null; // 세부주소
      var $addressSubValue = null; // 세부주소값
      var $addressValue = null; // 주소값
      var $fieldAddressSub = null;

      var subAddress = {
        default : function(){
          var that = this;
          $checkText = $('.field_address .chk_bytes .bytes');
          $limitText = $('.field_address .chk_bytes .limit');
          $addressSub = $('[name=address_sub]');

          if(addressData.sType ===  'zipcode'){
            $addressValue = addressData.address;
          }else{
            $addressValue = addressData.roadAddress;
          }

          $addressSubValue = $addressSub.val();

          staticLengthAddr = $addressValue.length;
          that.addressSubSplit();

          $addressSub.on('change keyup paste cut focus', function(e){
            e.preventDefault();
            $addressSubValue = $(this).val();
            that.limitTextCount();
          });
        },
        addressSubSplit : function(){ // 최대입력가능한 글자수 초과시 뒷글자 제거
          var that = this;
          var maxAddress = 60;
          if( addressData.deliPoli === 0){
            var txtMax = maxAddress + staticLengthAddr;
            if(staticLengthAddr >= 39){
              maxAddress = 98 - staticLengthAddr;
              txtMax = 99;
            }
            $addressSub.attr('maxlength', maxAddress);
            $addressSub.val($addressSubValue.substring(0, maxAddress));
            $limitText.text(txtMax);
          }else{
            $addressSub.attr('maxlength', maxAddress - staticLengthAddr);
            $addressSub.val($addressSubValue.substring(0, maxAddress - staticLengthAddr));
            $limitText.text(maxAddress);
          }
          $addressSubValue = $addressSub.val();
          if( $fieldAddressSub !== null){
            $fieldAddressSub.text($addressSub.val());
          }
          that.limitTextCount();
        },
        limitTextCount : function(){ // 텍스트 카운트 노출
          var that = this;
          $checkText.text( $addressSubValue.length + staticLengthAddr );
        },
      }

      subAddress.default();
    },


    /**
     * 결과 레이어 노출 => 확인후 삭제 예정
     */
    layerAction: function(){
      var that = this;
      var $layerDSR = $("#layerDSR");
      var $dsrThumb = $layerDSR.find('.ani img');
      var layerType = '.layer_star'; // 샛별배송

      $layerDSR.show();
      $layerDSR.find('.inner_layer').hide();

      // KM-1955 : 이미지교체
      $dsrThumb.each(function(){
        $(this).attr('src', $(this).data('src'));
      });

      if (addressData.deliPoli === 1) { // 택배배송
        layerType = '.layer_normal';
      }

      if (addressData.deliPoli === '') { // 배송불가
        layerType = '.layer_none';
      }
      $layerDSR.find(layerType).show();
    }
  }
  return _address
})(window);

/**
 * 해당 함수는 주소검색 PHP 파일에서 params값을 전달해주어 사용됨.
 * 회원가입에서 사용
 * @param data Object
 */
var setDeliveryAddress = function (data) {
  var addressData = {
    zipCode0: data.zipcode0,
    zipCode1: data.zipcode1,
    zoneCode: data.zonecode,
    address: data.address,
    addressSub: data.address_sub,
    roadAddress: data.road_address,
    sType: data.s_type, //주소검색 타입 => zipcode : 기존 우편번호 검색, road : 도로명주소 검색
    device: data.gubun === 'mobile' ? 'm' : 'pc'
  }

  // iframe 타입(mobile) , popup 타입(pc) 구분필요. (appResult 없음)
  // 배송방법 자동선택
  if (addressData.device == 'm') {
    // _parentHeader.addressAction.setAddress();
    parent.addressAction.setAddress(addressData);
    if (typeof parent.addressPopup !== 'undefined'){
      parent.addressPopup.close();
    } else {
      window.parent.close();
    }
  } else {
    // PC - 회원가입
    parent.opener.addressAction.setAddress(addressData);
    window.parent.close();
  }
}