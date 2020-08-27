var birthCheckAction = { // 생년월일검증
  birthGuide : null,
  _birthCheck : {},
  birthCount : false,
  _serverTimeGet : {},
  serverTimeCheck : false, // 서버시간은 1회만 가져오기
  formCheck : function(){
    var $self = this;

    $self.birthCount = true;

    $self._birthCheck = {
      'validator' : true,
      'text':null,
    };
    if(!$self.serverTimeCheck){
      $self.serverTime();
      $self.serverTimeCheck = true;
    }
    var _serverTime = $self._serverTimeGet;
    var _birthData = {
      'year': $.trim($('[name=birth_year]').val()),
      'month': $.trim($('[name="birth[]"]').eq(0).val()),
      'day': $.trim($('[name="birth[]"]').eq(1).val()),
    }
    var year = _birthData.year;
    var numYear = Number(year);
    var month = _birthData.month;
    var numMonth = Number(month);
    var day = _birthData.day;
    var numDay = Number(day);
    var minYear = _serverTime.year - 100;	//최소년도
    var lastDay = ( new Date( year, month, 0) ).getDate();	// 해당 월의 마지막 날일
    var dateBirth = new Date(numYear, numMonth - 1, numDay);
    var dateNow = new Date(_serverTime.year, _serverTime.month - 1, _serverTime.day);
    var dateUnderFourteen = new Date(_serverTime.year - 14, _serverTime.month - 1, _serverTime.day);	// 14세 미만 년도
    var dateOverHundred = new Date(_serverTime.year - 100, _serverTime.month - 1, _serverTime.day);

    // 값이 없을때는 검증하지 않음
    if (year === '' && month === '' && day === '') {
      $self.birthCount = false;
      return;
    }

    if ( !/\d{4}/.test(year) ) {
      $self._birthCheck.text = '태어난 년도 4자리를 정확하게 입력해주세요.';
      $self._birthCheck.validator = false;
      return;
    }

    // 디폴트값인 공백인 경우 체크 하지 않음
    if ( ( month !== '' && !/^(?:0?[1-9]|1[012])$/.test(month) ) || ((year !== ''|| day !== '') && month === '')) {
      $self._birthCheck.text = '태어난 월을 정확하게 입력해주세요.';
      $self._birthCheck.validator = false;
      return;
    }

    // 디폴트값인 공백인 경우 체크 하지 않음 & 월의 마지막달이 틀렸을때
    if ( ( day !== '' && !/^(?:0?[1-9]|[12]\d|3[01])$/.test(day) ) || numDay > lastDay || ((year !== ''|| month !== '') && day === '')) {
      $self._birthCheck.text = '태어난 일을 정확하게 입력해주세요.';
      $self._birthCheck.validator = false;
      return;
    }

    // 만 14세 미만
    if (dateBirth > dateUnderFourteen) {
      $self._birthCheck.text = '만 14세 미만은 가입이 불가합니다.';
      // 생년월일이 미래로 입력되었어요.
      if (dateBirth > dateNow) {
        $self._birthCheck.text = '생년월일이 미래로 입력되었어요.';
      }
      $self._birthCheck.validator = false;
      return;
    }

    // 100년전
    if (dateBirth <= dateOverHundred) {
      $self._birthCheck.text = '생년월일을 다시 확인해주세요.';
      $self._birthCheck.validator = false;
      return;
    }
  }, validatorForm : function(){
    var $self = this;
    if(!$self.birthCount) return true; // 값이 없을때는 검증하지 않음
    $self.formCheck();
    if(! $self._birthCheck.validator ){
      alert('생년월일을 확인해주세요.');
      $("[name=birth_year]").focus();
      return false;
    }else{
      return true;
    }
  }, validatorText : function(){
    var $self = this;

    $self.formCheck();

    $self.birthGuide = $('.field_birth .txt_guide .txt');
    if($self._birthCheck.validator){
      $self.birthGuide.parent().hide();
      $self.birthGuide.removeAttr('class').addClass('txt');
      $self.birthGuide.text('');
    }else{
      $self.birthGuide.parent().show()
      $self.birthGuide.removeAttr('class').addClass('txt');
      $self.birthGuide.addClass('bad');
      $self.birthGuide.text($self._birthCheck.text);
    }
  }, serverTime : function(){ // 서버시간가져오기
    var $self = this;
    var curDate = new Date(window.webStatus.timestamp);
    $self._serverTimeGet = {
      'year' : Number(curDate.getFullYear()),
      'month' : Number(curDate.getMonth()+1),
      'day' : Number(curDate.getDate())
    }
  }
};

//특수문자 입력 방지
function preventSpecialChars($self, type) {
  var str = $self.val();
  var regExp = /(?:[^\w\s\uAC00-\uD7A3\u3131-\u314E\u314F-\u3163\u318D\u119E\u11A2\u2022\u2025a\u00B7\uFE55]|_)+/g;
  var msg = '이름에 한글, 영어, 숫자 외 특수문자를 사용할 수 없습니다.';
  if(type === 'write'){
    if(regExp.test(str)){
      $self.val(str.replace(regExp, ''));
    }
  }else{
    if(regExp.test(str)){
      alert(msg);
      if(type === 'result'){
        return false;
      }
    }
    return true;
  }
};


$(document).ready(function () {
  // 이용약관전체동의
  var checkBoxAction = {
    parentTarget : null, // 전체선택체크박스 + 하위체크박스
    allTarget : null, // 전체선택체크박스
    chlidTarget : null, // 하위체크박스
    selectCount : 0, // 하나의 셋트에 들어가 있는 하위 체크박스 수
    caseSet : null, // 예외 케이스
    caseSetTarget : null,
    caseSetCount : 0,
    set : function(){
      var $self = this;
      var type = false;
      $('.checkbox_parent [type=checkbox]').on('click', function(){
        $self.setSelector($(this).parents('.checkbox_parent').find('[name=agree_allcheck]'));
        if($(this).attr('name') === 'agree_allcheck'){
          $self.allAction( $self.allTarget.is(':checked') );
        }else{
          if( $(this).data('child') ){
            type = 'child';
          }else if( $(this).data('parent') ){
            type = 'parent';
          }
          $self.setSelector( $(this), type );
          if( $(this).data('parent') ){
            $self.checkChange( $self.caseSetTarget, $(this).is(':checked'));
          }else{
            $self.checkChange( $(this), $(this).is(':checked'));
          }
          $self.checkCount( type );
        }
      });
    },
    setSelector : function(target, type){
      var $self = this;
      $self.parentTarget = target.parents('.checkbox_parent');
      $self.allTarget = $self.parentTarget.find('[name=agree_allcheck]');
      $self.chlidTarget = $self.parentTarget.find('.checkbox_child [type=checkbox]');
      $self.selectCount = $self.chlidTarget.length;
      if(type !== false){
        $self.caseSet = target.parents('.checkbox_case').find('[data-parent]');
        $self.caseSetTarget = target.parents('.checkbox_case').find('[data-child]');
        $self.caseSetCount = $self.caseSetTarget.length;
      }
    },
    allAction : function(checkResult){
      var $self = this;
      $self.checkChange( $self.chlidTarget, checkResult);
    },
    checkCount : function( type ){
      var $self = this;
      var count = 0;
      if(type !== false){
        var countSub = 0;
        $self.caseSetTarget.each(function(){
          if($(this).is(':checked')){
            countSub++;
          }
        })
        if($self.caseSetCount === countSub){
          $self.checkChange( $self.caseSet, true);
        }else{
          $self.checkChange( $self.caseSet, false);
        }
      }
      $self.chlidTarget.each(function(){
        if($(this).is(':checked')){
          count++;
        }
      })
      if($self.selectCount === count){
        $self.checkChange( $self.allTarget, true);
      }else{
        $self.checkChange( $self.allTarget, false);
      }
    },
    checkChange : function(obj, result){
      obj.attr('checked', result)
      obj.prop('checked', result);
    }
  }
  checkBoxAction.set();



  // ----모바일 인증 v2 start ----
  var checkCertBtn = true; // 인증 하기 버튼 활성화 여부
  var confirmCertBtn = false; // 인증 확인 버튼 활성화 여부
  var stopTimer = false; // 타이머 정지
  var mobile0 = $('input[name="mobile[]"]').eq(0);
  var mobile1 = $('input[name="mobile[]"]').eq(1);
  var mobile2 = $('input[name="mobile[]"]').eq(2);

  /* 인증번호 체크 확인용 전역변수선언 */
  var confirmTxt = $('.field_phone .txt_guide span');

  /* 인증번호 체크 타입별 노출문구*/
  function confNotice(type){
    var resultText, classAdd;
    if(type === 'receive'){
      classAdd = 'receive';
      resultText = '인증번호가 오지 않는다면, 통신사 스팸 차단 서비스 혹은 휴대폰 번호 차단 여부를 확인해주세요. (마켓컬리 1644-1107)';
    }else if(type === 'fail'){
      classAdd = 'bad';
      resultText = '인증번호를 확인해주세요';
    }else if(type === 'conf'){
      classAdd = 'good';
      resultText = '인증번호 확인완료';
    }
    confirmTxt.removeClass('receive bad good').addClass(classAdd);
    confirmTxt.text(resultText);
  }

  // 인증번호 받기 활성화
  $('[name=mobileInp]').on('keyup blur',function(e){
    var inputText = $(this).val();
    var number = inputText.replace(/[^0-9]/g,'');
    $(this).val(number);
    number = $(this).val();

    if($(this).val().length > 11){
      $(this).val(number.substring(0,11));
    }
    mobile0.val(number.substring(0,3));
    mobile1.val(number.substring(3,7));
    mobile2.val(number.substring(7,11));
    var checkNum = '010';
    if( ( mobile0.val().indexOf(checkNum) !== 0 && $(this).val().length >= 10) || (mobile0.val().indexOf(checkNum) === 0 && $(this).val().length >= 11) ){
      if(confirmCertBtn == false){
        if($('#btn_cert').hasClass('disabled')) $('#btn_cert').removeClass('disabled');
        checkCertBtn = true;
      }
    } else {
      if(!$('#btn_cert').hasClass('disabled')) $('#btn_cert').addClass('disabled');
      checkCertBtn = false;
    }
  });

  function countdown(elementId, seconds) {
    var element, endTime, hours, mins, msLeft, time;

    function updateTimer() {
      if (stopTimer == true) {
        $('#countdown').hide();
        return;
      }

      $('#countdown').show();

      msLeft = endTime - (+new Date);
      if (msLeft < 0) {
        count_down_stop();
        alert('인증 제한 시간이 지났습니다');
      } else {
        time = new Date(msLeft);
        hours = time.getUTCHours();
        mins = time.getUTCMinutes();
        element.innerHTML = (hours ? hours + ':' + ('0' + mins).slice(-2) : mins) + ' : ' + ('0' + time.getUTCSeconds()).slice(-2);
        certifyTime = setTimeout(updateTimer, time.getUTCMilliseconds());

        checkCertBtn = false;
        confirmCertBtn = true;
      }
    }

    element = document.getElementById(elementId);
    endTime = (+new Date) + 1000 * seconds;
    updateTimer();
  }

  // 카운트 다운 시작
  function authSuccessAction(count_time) {
    stopTimer = false;
    checkCertBtn = false;
    confirmCertBtn = true;
    countdown('countdown', count_time);
    $('#btn_cert').addClass('disabled'); // [인증번호 받기] 비활성화
    $('#codeNum').show();
    $('#btn_cert_confirm').removeClass('disabled'); // [인증번호 확인] 활성화
    $('[name=auth_code]').prop("disabled", false);
    $('[name=mobileInp]').attr('readonly',true);

    // 인증번호 입력테두리 활성화및문구노출
    if(!$('.code_num .num_count').hasClass('on')) $('.code_num .num_count').addClass('on');
  }

  // 카운트 다운 정지
  function count_down_stop() {
    stopTimer = true;
    checkCertBtn = true;
    confirmCertBtn = false;
    $('#countdown').hide();
    $('#btn_cert').removeClass('disabled'); // [인증번호 받기] 활성화
    $('#btn_cert_confirm').addClass('disabled'); // [인증번호 확인] 비활성화
    $('[name=auth_code]').prop("disabled", true);
    $('[name=mobileInp]').attr('readonly',false);
  }

  // 인증 완료
  function mobile_auth_finished(showAlert)
  {
    stopTimer = true;
    checkCertBtn = true;
    confirmCertBtn = false;
    $('#btn_cert').removeClass('disabled'); // [인증번호 받기] 활성화
    $('#btn_cert_confirm').addClass('disabled'); // [인증번호 확인] 비활성화
    $('[name=auth_code]').prop("disabled", true);
    $('#btn_cert').text('다른번호 인증');
    $("[name=check_mobile]").val('1');
    $('[name=mobileInp]').attr("readonly", true);

    if (showAlert == true)
    {
      alert('인증이 완료 되었습니다.');
      confNotice('conf');
    }
  }

  // [인증 번호 받기] 버튼 클릭
  $('#btn_cert').on('click', function() {
    if($(this).hasClass('disabled')){
      return;
    }

    $('.field_phone .txt_guide').show();
    confNotice('receive');

    if (!checkCertBtn) {
      return;
    }

    mobile = mobile0.val() + "-" + mobile1.val() + "-" + mobile2.val();
    auth_code = $('input[name="auth_code"]');

    if ($(this).text() === '다른번호 인증')
    {
      $(this).text('인증번호 받기');
      $(this).addClass('disabled');
      checkCertBtn = false;
      if($('.code_num .num_count').hasClass('on')) $('.code_num .num_count').removeClass('on');
      $('.field_phone .txt_guide').hide();
      $('#codeNum').hide();
      $('[name=mobileInp]').attr("readonly", false).val('');
      $('[name=check_mobile]').val('');
      return;
    }

    if ($("[name=check_mobile]").val() === '1') {
      $('#btn_cert').text('인증번호 받기');
      $('[name=mobileInp]').attr("readonly", false);
      mobile0.val('');
      mobile1.val('');
      mobile2.val('');
      auth_code.val('');
      $("[name=check_mobile]").val('');
      return;
    }

    if (mobile0.val() == "" || mobile1.val() == "" || mobile2.val() == "") {
      alert('정확한 휴대폰 번호를 입력해 주세요');
      return;
    }

    // 인증 번호 요청
    $.ajax({
      url: '/shop/proc/auth_code.php',
      type: 'POST',
      data: {
        "mode": "get_auth_code",
        "mobile": mobile
      },
      dataType: 'json',
      async: false
    }).success(function(data) {
      if (data.result == false) {
        alert(data.message);
      } else {
        alert(data.message);
        authSuccessAction(parseInt(data.data.count_time));
      }
    }).fail(function() {
      alert("일시적인 장애가 발생하였습니다.\n잠시후 다시시도해주세요");
    });
  });

  // [인증 번호 확인] 버튼 클릭
  $('#btn_cert_confirm').on('click', function() {
    if (confirmCertBtn == false) {
      return;
    }

    mobile = mobile0.val() + "-" + mobile1.val() + "-" + mobile2.val();
    auth_code = $('input[name="auth_code"]').val();

    if( auth_code.length < 6){
      confNotice('fail');
      return;
    }

    // 인증 번호 확인 요청
    $.ajax({
      url: '/shop/proc/auth_code.php',
      type: 'POST',
      data: {
        "mode": "check_auth_code",
        "mobile": mobile,
        "auth_code": auth_code
      },
      dataType: 'json',
      async: false
    }).success(function(data) {
      if (data.result == false) {
        //alert(data.message);
        confNotice('fail');
      } else {
        $('input[name="auth_finish_code"]').val(data.data.auth_finish_code);
        mobile_auth_finished(true);
      }
    }).fail(function() {
      alert("일시적인 장애가 발생하였습니다.\n잠시후 다시시도해주세요");
    });
  });
  // ----모바일 인증 v2 end ----
});


// 검사 통과 못하는 경우 해당 위치로 이동
var isFormJoinSubmit = false;
var validPosition = '', defaultTopHeight = $('#header').height() + $('#appBanner').height();
function validFocus($target) {
  if( window.appResult.device === 'pc'){

    if($target.attr('name') === 'address'){
      $target = $('#addressSearch');
    }

    setTimeout(function(){
      $target.focus();
      isFormJoinSubmit = false;
    }, 1000);
  }else{
    validPosition = $target.closest('.join_cell').offset().top - defaultTopHeight;
    window.scrollTo(0, validPosition);
    isFormJoinSubmit = false;
  }
}

// input type check
function inputTypeCheck($target){
  if(
    ( $target.attr('type') !== 'checkbox' &&  $target.attr('type') !== 'radio' && $target.val() == '' )
    ||
    (( $target.attr('type') === 'checkbox' ||  $target.attr('type') === 'radio' ) && !$target.is(":checked") )
  ){
    return true;
  }
  return false;
}

function formJoinSubmit() {
  // 이벤트 중복방지
  if(isFormJoinSubmit){
    return;
  }
  isFormJoinSubmit = true;

  var isRequired = true, validMsg = '', validMsgSub = '을(를) 입력해 주세요';

  $("input[type='text']").each(function(){
    var input_txt = $(this).val();
    var input_trim_txt = input_txt.trim();
    $(this).val(input_trim_txt);
  });

  $("#form input[required='']").each(function() {
    var obj = $(this);
    if ( inputTypeCheck(obj) && isRequired){
      isRequired = false;

      validMsg = obj.attr('label');

      if(obj.attr('label') === ''){
        validMsg = obj.attr('placeholder')
      }

      if(obj.attr('type') === 'checkbox' || obj.attr('type') === 'radio'){
        validMsgSub = '에 동의해주세요'
      }
    }

    // 아이디중복 체크
    if(obj.attr('name') === 'm_id' && obj.val() !== '' && ( $("[name=id_chk]").val() !== 'y' && $("[name=chk_id]").val() !== '1' ) ){

      isRequired = false;
      validMsg = '아이디 중복확인을 확인해 주세요';
      validMsgSub = '';

      var validCheckText = $("[name=m_id]").parents('.join_cell').find('.txt_guide').find('.txt').eq(1);
      if(typeof validCheckText !== 'undefined') {
        if(validCheckText.hasClass('good')) validCheckText.removeClass('good');
        if(!validCheckText.hasClass('good')) validCheckText.addClass('bad');
      }
    }

    // 사용가능 비밀번호 확인
    if(obj.attr('name') === 'password'
      &&  obj.hasClass('bad')) {
      isRequired = false;
      validMsg = '비밀번호를 입력해 주세요';
      validMsgSub = '';
    }

    // 비밀번호확인 일치확인
    if(obj.attr('name') === 'password2' && obj.hasClass('bad')) {
      isRequired = false;
      validMsg = '비밀번호를 한번 더 입력해 주세요';
      validMsgSub = '';
    }

    // 이메일형식 확인
    if(obj.attr('name') === 'email') {
      var email_txt = obj.val();
      var trim_txt = email_txt.trim();
      var email_regex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
      if (email_regex.test(trim_txt) === false) {
        isRequired = false;
        validMsg = '이메일 형식을 확인해 주세요';
        validMsgSub = '';
      }
    }

    if(obj.attr('name') === 'chk_email' && obj.val() === ''){
      isRequired = false;
      validMsg = '이메일 중복 확인을 해 주세요';
      validMsgSub = '';
      obj = $('[name=email]');
    }

    if(obj.attr('name') === 'mobile[]' && $("[name=check_mobile]").val() != '1') {
      isRequired = false;
      validMsg = '휴대폰 인증을 완료 해 주세요';
      validMsgSub = '';
      obj = $('[name=mobileInp]');
    }

    if (!isRequired){
      alert(validMsg + validMsgSub);
      validFocus(obj);
      return false;
    }
  });

  if (!isRequired){
    return false;
  }

  if ($("input:text[name=recommid]").val() !== ""){
    if($("input:text[name=recommid]").val() === $("input:text[name=m_id]").val()){
      alert('아이디와 추천인 아이디가 같습니다. 다시 입력해 주세요');

      validFocus($("[name=recommid]"));
      return false;
    }
  }

  if(! birthCheckAction.validatorForm()){
    validFocus($("[name=birth_year]"));
    return false;
  }

  if($('#bgLoading').length > 0){
    $('#bgLoading').show();
  }
  $("#form").submit();
}

