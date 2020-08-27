// 숫자 3개 연속인지 아닌지 확인 함수
function hasThreeOrMoreConsecutiveNumbers(input) {
	if (input.length < 3) {
		return false;
	}
	var i = 0, j = 1, k = 2;
	for (var idx = 2; idx < input.length; idx++) {
		if (!isNaN(input[i]) && !isNaN(input[j]) && !isNaN(input[k])) {
			if (input[i] === input[j] && input[j] === input[k]) {
				return true;
			}
		}
		i++;
		j++;
		k++;
	}
	return false;
}

//클래스변경
function class_change(obj, state) {
	if (state === 'good') {
		if (obj.hasClass('bad'))
			obj.removeClass('bad');
		obj.addClass('good');
	} else {
		if (obj.hasClass('good'))
			obj.removeClass('good');
		obj.addClass('bad');
	}
}

// 특수문자 입력방지
function preventSpecialChars($self, type) {
	var str = $self.val();
	var regExp = /(?:[^\w\s\uAC00-\uD7A3\u3131-\u314E\u314F-\u3163\u318D\u119E\u11A2\u2022\u2025a\u00B7\uFE55]|_)+/g;
	var msg = '이름에 한글, 영어, 숫자 외 특수문자를 사용할 수 없습니다.';
	if (type === 'write') {
		if (regExp.test(str)) {
			$self.val(str.replace(regExp, ''));
		}
	} else {
		if (regExp.test(str)) {
			alert(msg);
			if (type === 'result') {
				return false;
			}
		}
		return true;
	}
};

// id 중복확인
function chkId() {
	var alertMsg = "아이디는 6자 이상의 영문 혹은 영문과 숫자 조합만 가능합니다";
	var target = $("[name='m_id']").parent().find('.txt_case2');
	var id_txt = $("[name='m_id']").val();
	var id_trim_txt = id_txt.replace(/(^\s*)|(\s*$)/gi, "");
	$("input[name='m_id']").val(id_trim_txt);
	var form = document.frmMember;
	if ($("input[name='m_id']").val() === "") {
		alert("아이디를 입력해 주세요.");
		return;
	}
	if ($("input[name='m_id']").val().length < 6) {
		alert("아이디는 6자 이상의 영문 혹은 영문과 숫자 조합만 가능합니다");
		return;
	}
	if (!chkText(form.m_id, form.m_id.value, "아이디를 입력해주세요")) return;
	var pattern = /^[a-zA-Z0-9]{1}[^"']{3,15}$/;
	// chkPatten 메소드에서 가져옴
	//var isValidId = eval(idPattern);
	if (!pattern.test(form.m_id.value)) {
		alert(alertMsg);
		return;
	}

	var idValidator = $("[name='m_id']").attr('data-validator');
	if (idValidator === "false") { // 정해진 규칙에 틀린경우
		$("[name=chk_id]").val('');
		alert(alertMsg);
		if (target.hasClass('good'))
			target.removeClass('good');
		target.addClass('bad');
	} else { // 정해진 규칙에 맞는경우
		var inputID = $("input[name='m_id']").val();
		//alert("DB에 중복아이디있는지 확인하러 가기~");
		$.ajax({
			url : '../proc/chkId.jsp',
			type : 'POST',
			data : {
				"inputID": inputID
			},
			dataType : 'json',
			cache: false,
			success : function(data) {
				//alert(data);
				alert(data.msg);
				if (data.result == 0) {		// 사용가능
					$("[name=chk_id]").val('0');											
					class_change($("[name='m_id']").parent().find('.txt_guide').find('.txt_case2'),'good');
				} else {							// 사용불가
					$("[name=chk_id]").val('1');
					class_change($("[name='m_id']").parent().find('.txt_guide').find('.txt_case2'),'bad');
				}
			},
			fail : function() {
				alert("일시적인 장애가 발생하였습니다.\n잠시후 다시 시도해주세요");
			}
		});
		
	}

}

// 이메일 중복확인
function chkEmail() {
	var email_txt = $("input[name='email']").val();
	var trim_txt = email_txt.replace(/(^\s*)|(\s*$)/gi, "");
	var email_regex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	$("input[name='email']").val(trim_txt)
	if ($("input[name='email']").val() === "") {
		alert("이메일 주소를 입력해 주세요.");
		//$('[name=chk_email]').val('0');
		return false;
	}
	if (email_regex.test(trim_txt) === false) {
		alert("잘못된 이메일 형식입니다.");
		//$('[name=chk_email]').val('0');
		return false;
	}

	var form = document.frmMember;
	if (!chkText(form.email, form.email.value, "이메일을 입력해주세요")) {
		//$('[name=chk_email]').val('0');
		return;
	}
	if (!chkPatten(form.email, form.email.getAttribute('option'), "정상적인 이메일 주소를 입력해주세요.")) {
		//$('[name=chk_email]').val('0');
		return;
	}

	var inputEmail = $("input[name='email']").val();
	//alert("DB에 중복이메일 있는지 확인하러 가기~");
	$.ajax({
		url : '../proc/chkEmail.jsp',
		type : 'POST',
		data : {
			"inputEmail" : inputEmail
		},
		dataType : 'json',
		cache: false,
		success : function(data) {
			//alert(data);
			alert(data.msg);
			if (data.result == 0) {		// 사용가능
				$("[name=chk_email]").val('0');											
			} else {							// 사용불가
				$("[name=chk_email]").val('1');
			}
		},
		fail : function() {
			alert("일시적인 장애가 발생하였습니다.\n잠시후 다시시도해주세요");
		}
	});
}



var stopTimer = false; // 타이머 정지
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
		}
	}

	element = document.getElementById(elementId);
	endTime = (+new Date) + 1000 * seconds;
	updateTimer();
}

// 인증번호 요청성공시.. 카운트다운 시작
function authSuccessAction(count_time) {
	stopTimer = false;
	countdown('countdown', count_time);
	$('#btn_cert').addClass('disabled'); // [인증번호 받기] 비활성화
	$('#codeNum').show();
	$('#btn_cert_confirm').removeClass('disabled'); // [인증번호 확인] 활성화
	$('[name=auth_code]').prop("disabled", false);
	$('[name=mobileInp]').attr('readonly', true);

	// 인증번호 입력테두리 활성화및문구노출
	if (!$('.code_num .inp_confirm').hasClass('on'))
		$('.code_num .inp_confirm').addClass('on');
}

// 카운트 다운 정지
function count_down_stop() {
	stopTimer = true;
	$('#countdown').hide();
	$('#btn_cert').removeClass('disabled'); // [인증번호 받기] 활성화
	$('#btn_cert_confirm').addClass('disabled'); // [인증번호 확인] 비활성화
	$('[name=auth_code]').prop("disabled", true);
	$('[name=mobileInp]').attr('readonly', false);
}

var mobile0 = $("#mobile0");
var mobile1 = $("#mobile1");
var mobile2 = $("#mobile2");
// 인증번호 받기 활성화
$('[name=mobileInp]').on('keyup blur', function(e) {
	var inputText = $(this).val();
	var number = inputText.replace(/[^0-9]/g, '');
	$(this).val(number);
	number = $(this).val();

	if ($(this).val().length > 11) {
		$(this).val(number.substring(0, 11));
	}

	mobile0.val(number.substring(0, 3));
	mobile1.val(number.substring(3, 7));
	mobile2.val(number.substring(7, 11));

	var checkNum = '010';
	if ((mobile0.val().indexOf(checkNum) !== 0 && $(this).val().length >= 10)
			|| (mobile0.val().indexOf(checkNum) === 0 && $(this).val().length >= 11)) {
		if ($('#btn_cert').hasClass('disabled'))
			$('#btn_cert').removeClass('disabled');
	} else {
		if (!$('#btn_cert').hasClass('disabled'))
			$('#btn_cert').addClass('disabled');
	}
});

var confirmTxt = $('.field_phone .txt_guide span');
/* 인증번호 체크 타입별 노출문구*/
function confNotice(type) {
	var resultText, classAdd;
	if (type === 'receive') {
		classAdd = 'receive';
		resultText = '인증번호가 오지 않는다면, 통신사 스팸 차단 서비스 혹은 휴대폰 번호 차단 여부를 확인해주세요. (마켓컬리 1644-1107)';
	} else if (type === 'fail') {
		classAdd = 'bad';
		resultText = '인증번호를 확인해주세요';
	} else if (type === 'conf') {
		classAdd = 'good';
		resultText = '인증번호 확인완료';
	}
	confirmTxt.removeClass('receive bad good').addClass(classAdd);
	confirmTxt.text(resultText);
}

// [인증 번호 받기] 버튼 클릭
$('#btn_cert').on('click', function() {
	if ($(this).hasClass('disabled')) {
		return;
	}

	$('.field_phone .txt_guide').show();
	confNotice('receive');

	mobile = mobile0.val() + "-" + mobile1.val() + "-" + mobile2.val();
	auth_code = $('input[name="auth_code"]');

	if ($(this).text() === '다른번호 인증') {
		$(this).text('인증번호 받기');
		$(this).addClass('disabled');
		if ($('.code_num .inp_confirm').hasClass('on'))
			$('.code_num .inp_confirm').removeClass('on');
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

	//alert("인증번호 요청");
	// ajax로 인증 번호 요청
	$.ajax({
		url : '../proc/auth_code.jsp',
		type : 'POST',
		data : {
			"mode" : "get_auth_code",
			"mobile" : mobile
		},
		dataType : 'json',
		async : false,
		success : function(data) {
			//alert(data);
			if (data.result == 1) {
				alert(data.message);
			} else {
				alert(data.message);
				authSuccessAction(parseInt(data.count_time));
			}
		},
		fail : function() {
			alert("일시적인 장애가 발생하였습니다.\n잠시후 다시시도해주세요");
		}
	});
});

// [인증 번호 확인] 버튼 클릭
$('#btn_cert_confirm').on('click', function() {
	if ($(this).hasClass("disabled")) {
		return;
	}

	mobile = mobile0.val() + "-" + mobile1.val() + "-" + mobile2.val();
	var auth_code = $('input[name="auth_code"]').val();

	if (auth_code.length < 4) {
		confNotice('fail');
		return;
	}

	// ajax로 인증 번호 확인 요청
	$.ajax({
		url : '../proc/auth_code.jsp',
		type : 'POST',
		data : {
			"mode" : "check_auth_code",
			"mobile" : mobile,
			"auth_code" : auth_code
		},
		dataType : 'json',
		async : false,
		success : function(data) {
			if (data.result == 1) {
				alert(data.message);
				confNotice('fail');
			} else {
				//$('input[name="auth_finish_code"]').val(data.data.auth_finish_code);
				mobile_auth_finished(true);
			}
		},
		fail : function() {
			alert("일시적인 장애가 발생하였습니다.\n잠시후 다시시도해주세요");
		}
	});

});

// 인증 완료
function mobile_auth_finished(showAlert) {
	stopTimer = true;
	$('#btn_cert').removeClass('disabled'); // [인증번호 받기] 활성화
	$('#btn_cert_confirm').addClass('disabled'); // [인증번호 확인] 비활성화
	$('[name=auth_code]').prop("disabled", true);
	$('#btn_cert').text('다른번호 인증');
	$("[name=check_mobile]").val('1');
	$('[name=mobileInp]').attr("readonly", true);
	
	var mobile = $("#mobile0").val() + '-' + $("#mobile1").val() + '-' + $("#mobile2").val();
	
	$("[name=mobileInp]").val(mobile);

	if (showAlert == true) {
		alert('인증이 완료 되었습니다.');
		confNotice('conf');
	}
}

var birthCheckAction = { // 생년월일검증
	birthGuide : null,
	_birthCheck : {},
	birthCount : false,
	_serverTimeGet : {}, // 서버시간에 대한 정보를 담을 객체
	serverTimeCheck : false, // 서버시간은 1회만 가져오기

	formCheck : function() {
		var self = this;

		this.birthCount = true;

		self._birthCheck = {
			'validator' : true,
			'text' : null,
		};
		if (!self.serverTimeCheck) { // 서버시간 1회만 가져오기
			self.serverTime();
			self.serverTimeCheck = true;
		}
		var _serverTime = self._serverTimeGet;
		var _birthData = { // 입력받은 생년월일 정보
			'year' : $.trim($('[name=birth_year]').val()),
			'month' : $.trim($('[name="birth[]"]').eq(0).val()),
			'day' : $.trim($('[name="birth[]"]').eq(1).val())
		}
		var year = _birthData.year;
		var numYear = Number(year);
		var month = _birthData.month;
		var numMonth = Number(month);
		var day = _birthData.day;
		var numDay = Number(day);
		var minYear = _serverTime.year - 100; //최소년도
		var lastDay = (new Date(year, month, 0)).getDate(); // 해당 월의 마지막 날일
		var dateBirth = new Date(numYear, numMonth - 1, numDay);
		var dateNow = new Date(_serverTime.year, _serverTime.month - 1, _serverTime.day);
		var dateUnderFourteen = new Date(_serverTime.year - 14, _serverTime.month - 1, _serverTime.day); // 14세 미만 년도
		var dateOverHundred = new Date(_serverTime.year - 100, _serverTime.month - 1, _serverTime.day); // 100년 전 년월일

		// 값이 없을때는 검증하지 않음
		if (year === '' && month === '' && day === '') {
			self.birthCount = false;
			return;
		}

		if (!/\d{4}/.test(year)) {
			self._birthCheck.text = '태어난 년도 4자리를 정확하게 입력해주세요.';
			self._birthCheck.validator = false;
			return;
		}

		// 디폴트값인 공백인 경우 체크 하지 않음
		if ((month !== '' && !/^(?:0?[1-9]|1[012])$/.test(month)) || ((year !== '' || day !== '') && month === '')) {
			self._birthCheck.text = '태어난 월을 정확하게 입력해주세요.';
			self._birthCheck.validator = false;
			return;
		}

		// 디폴트값인 공백인 경우 체크 하지 않음 & 월의 마지막달이 틀렸을때
		if ((day !== '' && !/^(?:0?[1-9]|[12]\d|3[01])$/.test(day)) || numDay > lastDay || ((year !== '' || month !== '') && day === '')) {
			self._birthCheck.text = '태어난 일을 정확하게 입력해주세요.';
			self._birthCheck.validator = false;
			return;
		}

		// 만 14세 미만
		if (dateBirth > dateUnderFourteen) {
			self._birthCheck.text = '만 14세 미만은 가입이 불가합니다.';
			// 생년월일이 미래로 입력되었어요.
			if (dateBirth > dateNow) {
				self._birthCheck.text = '생년월일이 미래로 입력되었어요.';
			}
			self._birthCheck.validator = false;
			return;
		}

		// 100년전
		if (dateBirth <= dateOverHundred) {
			self._birthCheck.text = '생년월일을 다시 확인해주세요.';
			self._birthCheck.validator = false;
			return;
		}
	},
	validatorForm : function() {
		var self = this;
		if (!self.birthCount) return true; // 값이 없을때는 검증하지 않음
		self.formCheck();
		if (!self._birthCheck.validator) {
			alert('생년월일을 확인해주세요.');
			$("[name=birth_year]").focus();
			return false;
		} else {
			return true;
		}
	},
	validatorText : function() {
		var self = this;

		self.formCheck();

		self.birthGuide = $('.field_birth .txt_guide .txt');
		if (self._birthCheck.validator) {
			self.birthGuide.parent().hide();
			self.birthGuide.removeAttr('class').addClass('txt');
			self.birthGuide.text('');
		} else {
			self.birthGuide.parent().show()
			self.birthGuide.removeAttr('class').addClass('txt');
			self.birthGuide.addClass('bad');
			self.birthGuide.text(self._birthCheck.text);
		}
	},
	serverTime : function() { // 서버시간가져오기
		var self = this;
		var curDate = new Date();
		self._serverTimeGet = {
			'year' : Number(curDate.getFullYear()),
			'month' : Number(curDate.getMonth() + 1),
			'day' : Number(curDate.getDate())
		}
	}
};

// 생년월일 입력시 폼 포커스 이벤트
$('.birth_day input').focus(function() {
	$(this).parent().addClass('on');
}).keyup(function() {
	var inputText = $(this).val();
	var number = $(this).val().replace(/[^0-9]/g, '');
	$(this).val(number);
}).blur(function() {
	$(this).parent().removeClass('on');
	// KM-1261 회원가입 14세 인증
	birthCheckAction.validatorText();
});

// 서브밋할 때 2차 점검
var isFormJoinSubmit = false;
var validPosition = '';
var defaultTopHeight = $('#header').height();
// input type check
function inputTypeCheck(target) {
	if ((target.attr('type') !== 'checkbox' && target.attr('type') !== 'radio' && target.val() == '')
			|| ((target.attr('type') === 'checkbox' || target.attr('type') === 'radio') && !target.is(":checked"))) {
		return true;
	}
	return false;
}

function validFocus(target) {
	if (target.attr('name') === 'address') {
		target = $('#addressSearch');
	}

	setTimeout(function() {
		target.focus();
		isFormJoinSubmit = false;
	}, 1000);
}

// 서브밋 전 마지막 체크
function formJoinSubmit() {
	// 이벤트 중복방지
	/* 
	if(isFormJoinSubmit){
	  return;
	}
	isFormJoinSubmit = true;
	 */

	var isRequired = true;
	var validMsg = '';
	var validMsgSub = '을(를) 입력해 주세요';

	$("input[type='text']").each(function() {
		var input_txt = $(this).val();
		var input_trim_txt = input_txt.trim();
		$(this).val(input_trim_txt);
	});

	$("#form input[required='']").each(function() {
		var obj = $(this);
		if (inputTypeCheck(obj) && isRequired) {
			isRequired = false;

			validMsg = obj.attr('label');

			if (obj.attr('label') === '') {
				validMsg = obj.attr('placeholder')
			}

			if (obj.attr('type') === 'checkbox' || obj.attr('type') === 'radio') {
				validMsgSub = '에 동의해주세요'
			}
		}

		// 아이디중복 체크
		if (obj.attr('name') === 'm_id' && obj.val() !== '' && $("[name=chk_id]").val() !== '0') {
			isRequired = false;
			validMsg = '아이디 중복확인을 확인해 주세요';
			validMsgSub = '';

		}

		// 사용가능 비밀번호 확인
		if (obj.attr('name') === 'password' && obj.hasClass('bad')) {
			isRequired = false;
			validMsg = '비밀번호를 입력해 주세요';
			validMsgSub = '';
		}

		// 비밀번호확인 일치확인
		if (obj.attr('name') === 'password2' && obj.hasClass('bad')) {
			isRequired = false;
			validMsg = '비밀번호를 한번 더 입력해 주세요';
			validMsgSub = '';
		}

		// 이메일형식 확인
		if (obj.attr('name') === 'email') {
			var email_txt = obj.val();
			var trim_txt = email_txt.trim();
			var email_regex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
			if (email_regex.test(trim_txt) === false) {
				isRequired = false;
				validMsg = '이메일 형식을 확인해 주세요';
				validMsgSub = '';
			}
		}

		if (obj.attr('name') === 'chk_email' && obj.val() !== '0') {
			isRequired = false;
			validMsg = '이메일 중복 확인을 해 주세요';
			validMsgSub = '';
			obj = $('[name=email]');
		}

		if (obj.attr('name') === 'mobile[]' && $("[name=check_mobile]").val() != '1') {
			isRequired = false;
			validMsg = '휴대폰 인증을 완료 해 주세요';
			validMsgSub = '';
			obj = $('[name=mobileInp]');
		}

		if (!isRequired) {
			alert(validMsg + validMsgSub);
			validFocus(obj);
			return false;
		}
	});

	if (!isRequired) {
		return false;
	}

	if ($("input:text[name=recommid]").val() !== "") {
		if ($("input:text[name=recommid]").val() === $("input:text[name=m_id]").val()) {
			alert('아이디와 추천인 아이디가 같습니다. 다시 입력해 주세요');

			validFocus($("[name=recommid]"));
			return false;
		}
	}

	if (!birthCheckAction.validatorForm()) {
		validFocus($("[name=birth_year]"));
		return false;
	}

	$("#form").submit();
}

//주소 검색 관련
function layerAction(deliPoli) {
	var layerDSR = $("#layerDSR");
	var layerType = '.layer_star'; // 샛별배송
	
	layerDSR.show();
	layerDSR.find('.inner_layer').hide();
	
	if(deliPoli === 1) { // 택배배송
	  layerType = '.layer_normal';
	}
	
	if(deliPoli === 2) { // 배송불가
	  layerType = '.layer_none';
	}
	layerDSR.find(layerType).show();
}

function insertViewData(data) {		
	var delivery = $('#delivery');
	var deliveryText;
	
	$('#selectAddress').show();
	$('#selectAddressSub').show();
	
	// 문구
	delivery.removeAttr('class');
	if(data.deliPoli === 0) {
	  deliveryText = '샛별배송';
	  delivery.addClass('type1');
	}
	if(data.deliPoli === 1){
	  deliveryText = '택배배송';
	  delivery.addClass('type2');
	}
	if(data.deliPoli === 2){
	  deliveryText = '배송불가';
	  delivery.addClass('type3');
	}
	
	$('#addressSearch').addClass('re_search');
	$('#addressNo').text("재검색");
	
	delivery.text(deliveryText);
	$('#address_sub').text( data.addressSub );
	$('#addr').text( data.sType ===  'zipcode' ? data.address : data.roadAddress );
	
	//that.countAction();
}

function setAddress(data) {
	layerAction(data.deliPoli);
	
	$('#zipcode0').val(data.zipCode0);
	$('#zipcode1').val(data.zipCode1);
	$('#zonecode').val(data.zoneCode);
	$('#address').val(data.address || data.roadAddress);
	$('#address_sub').val(data.addressSub);
	$('#road_address').val(data.roadAddress);
	$('#deliPoli').val(data.deliPoli);
	
	insertViewData(data);
}

function setDeliveryAddress(data) {
	var addressData = {
	    zipCode0: data.zipCode0,
	    zipCode1: data.zipCode1,
	    zoneCode: data.zoneCode,
	    address: data.address,
	    addressSub: data.addressSub,
	    roadAddress: data.roadAddress,
	    deliPoli: data.deliPoli,
	    sType: data.sType, //주소검색 타입 => zipcode : 기존 우편번호 검색, road : 도로명주소 검색
	}
	
	setAddress(addressData);
}

