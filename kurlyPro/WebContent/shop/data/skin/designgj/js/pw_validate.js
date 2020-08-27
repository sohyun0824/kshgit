var pwValidate=new function(){var $self=this;var device='P';var origin_id="pwOrigin";var new_id="pwNew";var confirm_id="pwNewConfirm";var $this_element="";var event_type="";var check_type1=false;var check_type2=false;var return_url=null;$self.parentDom=$("#change_pw .inner_popdiv");$self.init=function(_device,_return_url){device=_device?_device:'P';return_url=_return_url;$('.pw_inp').on('blur focus keyup',$self.inputEventHandler);}
$self.inputEventHandler=function(arg_event_info){$this_element=$(this);event_type=arg_event_info.type;$self.placeholderHandler();if((event_type=='focus')){$this_element.siblings('.mark_valid').show();}
if(event_type=='keyup'){if(arg_event_info.keyCode==13)
{$self.finalValid();return;}
switch($this_element.attr('id')){case origin_id:{$self.pwOriginHandler();break;}
case new_id:{$self.pwNewHandler();break;}
case confirm_id:{$self.pwNewConfirmHandler();break;}}}}
$self.pwOriginHandler=function(){if($this_element.val()==''){$self.inputOutlineHandler(origin_id,'good');$self.markEffectHandler($('.mark_diff'),'bad');$self.inputOutlineHandler(new_id,'bad');}else{if($('#'+new_id).val()!=''){if($('#'+new_id).val()==$this_element.val()){$self.inputOutlineHandler(new_id,'bad');$self.markEffectHandler($('.mark_diff'),'bad');}else{$self.markEffectHandler($('.mark_diff'),'good');$self.inputOutlineHandler(new_id,'good');$self.markEffectHandler($('.mark_invalid_now_password'),'good');$self.markEffectHandler($('.mark_invalid_etc'),'good');$self.inputOutlineHandler(origin_id,'good');}}}}
$self.pwNewHandler=function(){if($this_element.val()==""){$self.changeColor(new_id);$self.inputOutlineHandler(new_id,'bad');$self.markEffectHandler($('.mark_diff'),'bad');$self.markEffectHandler($('.mark_length'),'bad');$self.markEffectHandler($('.mark_mix'),'bad');$self.markEffectHandler($('.mark_numbers'),'bad');}else{if($this_element.val()==$('#'+origin_id).val()){$self.inputOutlineHandler(new_id,'bad');$self.markEffectHandler($('.mark_diff'),'bad')}else{if($('#'+origin_id).val()!=""){$self.inputOutlineHandler(origin_id,'good');$self.markEffectHandler($('.mark_diff'),'good');$self.inputOutlineHandler(new_id,'bad');}else{$self.markEffectHandler($('.mark_diff'),'bad');}}
if($this_element.val()==$('#'+confirm_id).val()){$self.inputOutlineHandler(confirm_id,'good');$self.inputOutlineHandler(new_id,'good');$self.markEffectHandler($('.mark_coincide'),'good');}else{if($('#'+confirm_id).val()==""){$self.inputOutlineHandler(new_id,'bad');}else{$self.inputOutlineHandler(confirm_id,'bad');$self.markEffectHandler($('.mark_coincide'),'bad');}}
$self.lengthValid();$self.characterValid();$self.validateNumbers();}}
$self.pwNewConfirmHandler=function(){if($this_element.val()==""){$self.changeColor(confirm_id);$self.inputOutlineHandler(confirm_id,'bad');$self.markEffectHandler($('.mark_coincide'),'bad');}else{if($this_element.val()==$('#'+new_id).val()){$self.inputOutlineHandler(confirm_id,'good');$self.markEffectHandler($('.mark_coincide'),'good');}else{$self.inputOutlineHandler(confirm_id,'bad');$self.markEffectHandler($('.mark_coincide'),'bad');}}}
$self.markEffectHandler=function(obj,valid){if(valid==='good'){if(obj.hasClass('bad')){obj.removeClass('bad');}
obj.addClass('good');}else if(valid==='bad'){if(obj.hasClass('good')){obj.removeClass('good');}
obj.addClass('bad');}else{$('.mark_valid').addClass('good bad');$('.mark_valid ul li').addClass('good bad');}}
$self.inputOutlineHandler=function(arg_target_id,arg_type){if(arg_target_id==""){console.log("Error : inputOutlineHandler->arg_target_id : 필수값 누락");return;}
if(arg_type=='good'){$('#'+arg_target_id).removeClass('inp_invalid');}else if(arg_type=='bad'){$('#'+arg_target_id).addClass('inp_invalid');}else{console.log("Error : inputOutlineHandler->arg_type : 정의되지 않은 형식입니다.");}}
$self.placeholderHandler=function(){switch(event_type){case 'focus':{$this_element.siblings('.txt_placeholder').hide();break;}
case 'blur':{}
case 'keyup':{if($this_element.val()==""){$this_element.siblings('.txt_placeholder').show();}else{$this_element.siblings('.txt_placeholder').hide();}
break;}}}
$self.lengthValid=function(){if($this_element.val().length<10){check_type1=false;$self.markEffectHandler($('.mark_length'),'bad');}else{check_type1=true;$self.markEffectHandler($('.mark_length'),'good');}}
$self.characterValid=function(){$chk_val=$('#pwNew').val();var checkNumber=$chk_val.search(/[0-9]/g);var checkEnglish=$chk_val.search(/[a-zA-Z]/ig);var checkSpecial=$chk_val.search(/[^a-zA-Z0-9]/ig);var checkAscii=$chk_val.search(/[^a-zA-Z0-9~`!>@?/<#"'\$;:\]%\.\^,&\[*()_\+\-=|\\{}]/ig);if(checkNumber>=0&&checkEnglish>=0&&checkAscii===-1){check_type2=true;}else if(checkNumber>=0&&checkSpecial!==-1&&checkAscii===-1){check_type2=true;}else if(checkEnglish>=0&&checkSpecial!==-1&&checkAscii===-1){check_type2=true;}else if(checkEnglish>=0&&checkSpecial===-1&&checkAscii===-1){if(checkNumber===-1)check_type2=false;}else{check_type2=false;}
if(check_type1===false&&check_type2===false){$self.markEffectHandler($('.mark_length'),'bad');$self.markEffectHandler($('.mark_mix'),'bad');$('#pwNew').addClass('inp_invalid');}
if(check_type1===true&&check_type2===false){$self.markEffectHandler($('.mark_length'),'good');$self.markEffectHandler($('.mark_mix'),'bad');$('#pwNew').addClass('inp_invalid');}
if(check_type1===false&&check_type2===true){$self.markEffectHandler($('.mark_length'),'bad');$self.markEffectHandler($('.mark_mix'),'good');$('#pwNew').addClass('inp_invalid');}
if(check_type1===true&&check_type2===true){$self.markEffectHandler($('.mark_length'),'good');$self.markEffectHandler($('.mark_mix'),'good');$('#pwNew').removeClass('inp_invalid');}}
$self.validateNumbers=function(){var input=$self.parentDom.find('.wrap_inp #pwNew').val()
if($self.hasThreeOrMoreConsecutiveNumbers(input)){$self.markEffectHandler($('.mark_numbers'),'bad');$('#pwNew').addClass('inp_invalid');}else{$self.markEffectHandler($('.mark_numbers'),'good');$('#pwNew').removeClass('inp_invalid');}};$self.hasThreeOrMoreConsecutiveNumbers=function(input){if(input.length<3){return false;}
var i=0,j=1,k=2;for(var idx=2;idx<input.length;idx++){if(!isNaN(input[i])&&!isNaN(input[j])&&!isNaN(input[k])){if(input[i]===input[j]&&input[j]===input[k]){return true;}}
i++;j++;k++;}
return false;}
$self.changeColor=function(arg_area){switch(arg_area){case new_id:{$('.mark_valid ul li').removeClass('good bad');$('#pwNew').removeClass('inp_invalid');break;}
case confirm_id:{$('.mark_valid').removeClass('good bad');$('#pwNewConfirm').removeClass('inp_invalid');break;}}}
$self.finalValid=function(){if(($('#'+new_id).val()!='')&&($('#'+confirm_id).val()!='')&&($('#'+origin_id).val()!='')){var oldPassword=$('#'+origin_id).val();var newPassword=$('#'+new_id).val();var confirmNewPassword=$('#'+confirm_id).val();$('.mark_invalid_etc').html('');if(oldPassword==newPassword){alert('비밀번호를 확인해주세요');return false;}
if($self.hasThreeOrMoreConsecutiveNumbers(newPassword)){alert('비밀번호를 확인해주세요');return false;}
if((confirmNewPassword==newPassword)&&((check_type2==true)&&(check_type1==true))){var post_data={"mode":"change_pwd_after_login","originalPassword":oldPassword,"newPassword":newPassword,"newPassword_confirm":confirmNewPassword};$.ajax({type:"POST",url:'/shop/member/indb.member.php',dataType:'json',data:post_data,success:function(res){if(res.code=='0000'){if(device=='M'){if(!!return_url){document.location.href=location.protocol+'//'+location.hostname+return_url;return;}
document.location.href=location.protocol+'//'+location.hostname+'/m2';}else{$("#change_pw").hide();}
if("/shop/admin/"==document.location.pathname||"/shop/admin/#C"==document.location.pathname)document.location.href=document.location.pathname;}else{var now_id;if(res.code=='1111'){now_id=origin_id;$('.mark_invalid_etc').html(res.msg);$('.mark_invalid_etc').show();$self.markEffectHandler($('.mark_invalid_etc'),'bad');}else{if(res.code=='2222'){now_id=new_id;}else if(res.code=='3333'){now_id=confirm_id;}}
$self.inputOutlineHandler(now_id,'bad');alert('비밀번호를 확인해주세요');}}});}else{alert('비밀번호를 확인해주세요');}}else{alert('비밀번호를 확인해주세요');}}
$self.emptyPwState=function(){var selector=_ID('el-password-strength-indicator')
if(selector){selector.style.display="none";}}
$self.checkNewPassword=function(form){if(_ID('newPassword').value){var param={form:form,fields:['m_id','birth_year','phone[]','birth[]','mobile[]','email']}
nsGodo_PasswordStrength.appendBlacklist(param);nsGodo_PasswordStrength.appendBlacklist(param);}
else{$self.emptyPwState();}}
$self.checkPasswordForm=function(f,m_id,token,otp,deviceType){if(!_ID('newPassword').value){alert("새 비밀번호를 입력해 주세요.");_ID('newPassword').focus();return false;}
if(!_ID('confirmPassword').value){alert("새 비밀번호 확인을 입력해 주세요.");_ID('confirmPassword').focus();return false;}
if(_ID('newPassword').value!=_ID('confirmPassword').value){alert("새 비밀번호와 비밀번호 확인이 일치하지 않습니다.");_ID('confirmPassword').focus();return false;}
var optValue;if(deviceType==='pc'){optValue=otp}else{optValue=f.otp.value}
parent.nsGodo_PasswordFinder.changePwd(_ID('newPassword').value,m_id,token,f.passwordSkin.value,optValue,deviceType);return false;}};