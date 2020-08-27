function _ID(obj){return document.getElementById(obj)}
if(typeof thefarmers!=="undefined"){var _oldAlert=window.alert;window.alert=function(){thefarmers.alert.apply(thefarmers,arguments);};}
function popup_zipcode(form)
{window.open("../proc/popup_zipcode.php?form="+form,"","width=400,height=500");}
function chkForm(form)
{if(typeof(mini_obj)!="undefined"||document.getElementById('_mini_oHTML'))mini_editor_submit();var reschk=0;for(i=0;i<form.elements.length;i++){currEl=form.elements[i];if(currEl.disabled)continue;if(currEl.getAttribute("required")!=null||currEl.getAttribute("fld_esssential")!=null){if(currEl.type=="checkbox"||currEl.type=="radio"){if(!chkSelect(form,currEl,currEl.getAttribute("msgR")))return false;}else{if(!chkText(currEl,currEl.value,currEl.getAttribute("msgR")))return false;}}
if(currEl.getAttribute("label")=='주민등록번호'&&currEl.getAttribute("name")=='resno[]'&&currEl.value.length>0){reschk=1;}
if(currEl.getAttribute("option")!=null&&currEl.value.length>0){if(currEl.getAttribute("option")=="regPass"&&!chkPassword(currEl))return false;if(!chkPatten(currEl,currEl.getAttribute("option"),currEl.getAttribute("msgO")))return false;}
if(currEl.getAttribute("minlength")!=null){if(!chkLength(currEl,currEl.getAttribute("minlength")))return false;}}
if(form.password2){if(form.password.value!=form.password2.value){thefarmers.alert("비밀번호가 일치하지 않습니다");form.password.value="";form.password2.value="";return false;}}
if(reschk&&!chkResno(form))return false;if(form.agreeyn){if(form.agreeyn[0].checked===false){alert("-개인정보 수집 및 이용에 대한 안내에 동의 하셔야 작성이 가능합니다.");return false;}}
if(form.chkSpamKey)form.chkSpamKey.value=1;if(document.getElementById('avoidDbl'))document.getElementById('avoidDbl').innerHTML='<p class="txt_operate"><span>처리중입니다 ▶</span></p>';return true;}
function chkLength(field,len)
{text=field.value;if(text.trim().length<len){thefarmers.alert(len+"자 이상 입력하셔야 합니다",function(){field.focus();});return false;}
return true;}
function chkText(field,text,msg)
{text=text.trim();if(text==""){var caption=field.parentNode.parentNode.firstChild.innerText;if(!field.getAttribute("label"))field.setAttribute("label",(caption)?caption:field.name);if(!msg)msg="["+field.getAttribute("label")+"] 필수입력사항";thefarmers.alert(msg,function(){if(field.type!="hidden"&&field.style.display!="none")field.focus();});if(field.tagName!="SELECT")field.value="";return false;}
return true;}
function chkSelect(form,field,msg)
{var ret=false;var fieldname=form.elements[field.name];if(fieldname.length){for(j=0;j<fieldname.length;j++)if(fieldname[j].checked)ret=true;}else{if(fieldname.checked)ret=true;}
if(!ret){if(!field.getAttribute("label")){field.getAttribute("label",field.name);}
var msg2="["+field.getAttribute("label")+"] 필수선택사항";if(msg)msg2+="\n\n"+msg;thefarmers.alert(msg2,function(){field.focus();});return false;}
return true;}
function chkPatten(field,patten,msg)
{var regNum=/^[0-9]+$/;var regEmail=/^[^"'@]+@[._a-zA-Z0-9-]+\.[a-zA-Z]+$/;var regUrl=/^(http\:\/\/)*[.a-zA-Z0-9-]+\.[a-zA-Z]+$/;var regAlpha=/^[a-zA-Z]+$/;var regHangul=/[\uAC00-\uD7A3]/;var regHangulEng=/[\uAC00-\uD7A3a-zA-Z]/;var regHangulOnly=/^[\uAC00-\uD7A3]*$/;var regId=/^[a-zA-Z0-9]{1}[^'"ㄱ-ㅎㅏ-ㅣ\uAC00-\uD7A3]{3,15}$/;var regPass=/^[\x21-\x7E]{10,16}$/;patten=eval(patten);if(!patten.test(field.value)){var caption=field.parentNode.parentNode.firstChild.innerText;if(!field.getAttribute("label"))field.setAttribute("label",(caption)?caption:field.name);var msg2="["+field.getAttribute("label")+"] 입력형식오류";if(msg)msg2+="\n\n"+msg;thefarmers.alert(msg2,function(){field.focus();});return false;}
return true;}
function chkRadioSelect(form,field,val,msg)
{var ret=false;var fieldname=form.elements[field];if(fieldname.length){for(j=0;j<fieldname.length;j++){if(fieldname[j].checked)ret=fieldname[j].value;}}else{if(fieldname.checked)ret=true;}
if(val!=ret){thefarmers.alert(msg);return false;}
return true;}
function chkPassword(field)
{var passwordCount=0;var digit=/[0-9]/;var lower=/[a-z]/;var upper=/[A-Z]/;var punct=/[~`!>@?\/<#\"\'$;:\]%.^,&[*()_+\-=|\\\{}]/;if(digit.test(field.value))passwordCount++;if(lower.test(field.value))passwordCount++;if(upper.test(field.value))passwordCount++;if(punct.test(field.value))passwordCount++;if(passwordCount<2){thefarmers.alert("비밀번호를 확인해주세요");return false;}
return true;}
function formOnly(form){var i,idx=0;var rForm=document.getElementsByTagName("form");for(i=0;i<rForm.length;i++)if(rForm[i].name==form.name)idx++;return(idx==1)?form:form[0];}
function chkResno(form)
{var resno=form['resno[]'][0].value+form['resno[]'][1].value;fmt=/^\d{6}[1234]\d{6}$/;if(!fmt.test(resno)){thefarmers.alert('잘못된 주민등록번호입니다.');return false;}
birthYear=(resno.charAt(6)<='2')?'19':'20';birthYear+=resno.substr(0,2);birthMonth=resno.substr(2,2)-1;birthDate=resno.substr(4,2);birth=new Date(birthYear,birthMonth,birthDate);if(birth.getYear()%100!=resno.substr(0,2)||birth.getMonth()!=birthMonth||birth.getDate()!=birthDate){thefarmers.alert('잘못된 주민등록번호입니다.');return false;}
buf=new Array(13);for(i=0;i<13;i++)buf[i]=parseInt(resno.charAt(i));multipliers=[2,3,4,5,6,7,8,9,2,3,4,5];for(i=0,sum=0;i<12;i++)sum+=(buf[i]*=multipliers[i]);if((11-(sum%11))%10!=buf[12]){thefarmers.alert('잘못된 주민등록번호입니다.');return false;}
return true;}
function chkBox(El,mode)
{if(!El)return;if(typeof(El)!="object")El=document.getElementsByName(El);for(i=0;i<El.length;i++)El[i].checked=(mode=='rev')?!El[i].checked:mode;}
function isChked(El,msg)
{if(!El)return;if(typeof(El)!="object")El=document.getElementsByName(El);if(El)for(i=0;i<El.length;i++)if(El[i].checked)var isChked=true;if(isChked){return(msg)?confirm(msg):true;}else{thefarmers.alert("선택된 사항이 없습니다");return false;}}
function comma(x)
{var temp="";var x=String(uncomma(x));num_len=x.length;co=3;while(num_len>0){num_len=num_len-co;if(num_len<0){co=num_len+co;num_len=0;}
temp=","+x.substr(num_len,co)+temp;}
return temp.substr(1);}
function uncomma(x)
{var reg=/(,)*/g;x=parseInt(String(x).replace(reg,""));return(isNaN(x))?0:x;}
function tab(El)
{if((document.all)&&(event.keyCode==9)){El.selection=document.selection.createRange();document.all[El.name].selection.text=String.fromCharCode(9)
document.all[El.name].focus();return false;}}
function enter()
{if(event.keyCode==13){if(event.shiftKey==false){var sel=document.selection.createRange();sel.pasteHTML('<br>');event.cancelBubble=true;event.returnValue=false;sel.select();return false;}else{return event.keyCode=13;}}}
function miniResize(obj)
{fix_w=obj.clientWidth;var imgs=obj.getElementsByTagName("img");for(i=0;i<imgs.length;i++){if(imgs[i].width>fix_w){imgs[i].width=fix_w;imgs[i].style.cursor="pointer";imgs[i].title="view original size";imgs[i].onclick=popupImg;}}}
function miniSelfResize(contents,obj)
{fix_w=contents.clientWidth;if(obj.width>fix_w){obj.width=fix_w;obj.title="popup original size Image";}else obj.title="popup original Image";obj.style.cursor="pointer";obj.onclick=popupImg;}
function popupImg(src)
{if(typeof(src)!='string')src=this.src;window.open('../board/viewImg.php?src='+escape(src),'','width=1,height=1');}
function chkByte(str)
{var length=0;for(var i=0;i<str.length;i++)
{if(escape(str.charAt(i)).length>=4)
length+=2;else
if(escape(str.charAt(i))!="%0D")
length++;}
return length;}
function strCut(str,max_length)
{var str,msg;var length=0;var tmp;var count=0;length=str.length;for(var i=0;i<length;i++){tmp=str.charAt(i);if(escape(tmp).length>4)count+=2;else if(escape(tmp)!="%0D")count++;if(count>max_length)break;}
return str.substring(0,i);}
function get_objectTop(obj){if(obj.offsetParent==document.body)return obj.offsetTop;else return obj.offsetTop+get_objectTop(obj.offsetParent);}
function get_objectLeft(obj){if(obj.offsetParent==document.body)return obj.offsetLeft;else return obj.offsetLeft+get_objectLeft(obj.offsetParent);}
function mv_focus(field,num,target)
{len=field.value.length;if(len==num&&event.keyCode!=8)target.focus();}
function onlynumber()
{if(window.event==null)return;var e=event.keyCode;if(e>=48&&e<=57)return;if(e>=96&&e<=105)return;if(e==8||e==9||e==13||e==37||e==39)return;event.returnValue=false;}
function explode(divstr,str)
{var temp=str;var i;temp=temp+divstr;i=-1;while(1){i++;this.length=i+1;this[i]=temp.substring(0,temp.indexOf(divstr));temp=temp.substring(temp.indexOf(divstr)+1,temp.length);if(temp=="")break;}}
function getCookie(name)
{var nameOfCookie=name+"=";var x=0;while(x<=document.cookie.length)
{var y=(x+nameOfCookie.length);if(document.cookie.substring(x,y)==nameOfCookie){if((endOfCookie=document.cookie.indexOf(";",y))==-1)
endOfCookie=document.cookie.length;return unescape(document.cookie.substring(y,endOfCookie));}
x=document.cookie.indexOf(" ",x)+1;if(x==0)
break;}
return "";}
String.prototype.trim=function(str){str=this!=window?this:str;return str.replace(/^\s+/g,'').replace(/\s+$/g,'');}
function chg_cart_ea(obj,str,idx)
{if(obj.length)obj=obj[idx];var step=parseInt(obj.getAttribute('step'))||1;var min=parseInt(obj.getAttribute('min'))||0;var max=parseInt(obj.getAttribute('max'))||0;if(isNaN(obj.value)||obj.value==''){thefarmers.alert("구매수량은 숫자만 가능합니다",function(){obj.value=step;obj.focus();});}else{var ea=parseInt(obj.value);if(str=='up'){ea=ea+step;}
else if(str=='dn'){ea=ea-step;}
if(ea<min){ea=min;}
else if(max&&ea>max){alert('최대 수량은 ('+max+'개)입니다!');ea=max;}
var remainder=ea%step
if(remainder>0){ea=ea-remainder;}
if(ea<0)ea=step;obj.value=ea;}}
function buttonX(str,action,width)
{if(!width)width=100;if(action)action=" onClick=\""+action+"\"";ret="<button style='width:"+width+";background-color:transparent;color:transparent;border:0;cursor:default' onfocus=this.blur()"+action+">";ret+="<table width="+(width-1)+" cellpadding=0 cellspacing=0>";ret+="<tr height=22><td><img src='../img/btn_l.gif'></td>";ret+="<td width=100% background='../img/btn_bg.gif' align=center style='font:8pt tahoma' nowrap>"+str+"</td>";ret+="<td><img src='../img/btn_r.gif'></td></tr></table></button>";document.write(ret);}
function selectDisabled(oSelect){var isOptionDisabled=oSelect.options[oSelect.selectedIndex].disabled;if(isOptionDisabled){oSelect.selectedIndex=oSelect.preSelIndex;return false;}else oSelect.preSelIndex=oSelect.selectedIndex;return true;}
function viewSub(obj)
{var obj=obj.parentNode.getElementsByTagName('td')[1].getElementsByTagName('div')[1];if(obj){obj.style.display="block";}}
function hiddenSub(obj)
{var obj=obj.parentNode.getElementsByTagName('td')[1].getElementsByTagName('div')[1];if(obj){obj.style.display="none";}}
function execSubLayer()
{var obj=document.getElementById('menuLayer');for(i=0;i<obj.rows.length;i++){if(typeof(obj.rows[i].cells[1].childNodes[0])!="undefined"){obj.rows[i].cells[0].onmouseover=function(){viewSub(this)}
obj.rows[i].cells[0].onmouseout=function(){hiddenSub(this)}
obj.rows[i].cells[1].style.position="relative";obj.rows[i].cells[1].style.verticalAlign="top";if(typeof(obj.rows[i].cells[1].getElementsByTagName('div')[1])!="undefined"){obj.rows[i].cells[1].getElementsByTagName('div')[1].onmouseover=function(){viewSub(this.parentNode.parentNode.parentNode.getElementsByTagName('td')[0])};obj.rows[i].cells[1].getElementsByTagName('div')[1].onmouseout=function(){hiddenSub(this.parentNode.parentNode.parentNode.getElementsByTagName('td')[0])};}}}}
function execLayer(parent_layer,sun_layer)
{var parent_obj=document.getElementById(parent_layer);var sun_obj=document.getElementById(sun_layer);parent_obj.onmouseover=function(){sun_obj.style.display="block";}
parent_obj.onmouseout=function(){sun_obj.style.display="none";}
sun_obj.onmouseover=function(){sun_obj.style.display="block";}
sun_obj.onmouseout=function(){sun_obj.style.display="none";}}
function viewSubTop(obj)
{var obj=obj.children[1].children[0];obj.style.display="block";}
function hiddenSubTop(obj)
{var obj=obj.children[1].children[0];obj.style.display="none";}
function execSubLayerTop()
{var obj=document.getElementById('menuLayer');for(var i=0;i<obj.rows[0].cells.length;i++){if(typeof(obj.rows[0].cells[i].children[1])!="undefined"){obj.rows[0].cells[i].onmouseover=function(){viewSubTop(this)}
obj.rows[0].cells[i].onmouseout=function(){hiddenSubTop(this)}}}}
function popup(src,width,height)
{window.open(src,'','width='+width+',height='+height+',scrollbars=1');}
function getDcprice(price,dc,po)
{if(!po)po=100;if(!dc)return 0;var ret=(dc.match(/%$/g))?price*parseInt(dc.substr(0,dc.length-1))/100:parseInt(dc);return parseInt(ret/po)*po;}
function embed(src,width,height,vars)
{var codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0";var pluginspage="http://www.macromedia.com/go/getflashplayer";if(document.location.protocol=="https:"){codebase=codebase.replace(/http:/,"https:");pluginspage=pluginspage.replace(/http:/,"https:");}
document.write('\
	<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="'+codebase+'" WIDTH="'+width+'" HEIGHT="'+height+'">\
	<PARAM NAME=movie VALUE="'+src+'">\
	<PARAM NAME=quality VALUE=high>\
	<PARAM NAME=wmode VALUE=transparent>\
	<PARAM NAME=bgcolor VALUE=#FFFFFF>\
	<param name=flashvars value="'+vars+'">\
	<EMBED src="'+src+'" quality=high bgcolor=#FFFFFF WIDTH="'+width+'" HEIGHT="'+height+'" TYPE="application/x-shockwave-flash" PLUGINSPAGE="'+pluginspage+'" flashvars="'+vars+'"></EMBED>\
	</OBJECT>\
	');}
if(typeof(scrollingX)=='undefined'){var scrollingX=function(objnm,elenm){if(objnm=='')return;if(elenm=='')return;this.obj=objnm;this.ele=eval("window.frames."+elenm);this.time=20;this.drX=1;this.scrollX=0;this.is_move=1;this.ele.scrollTo(1,0);}
scrollingX.prototype.stop=function(){this.is_move=0;}
scrollingX.prototype.start=function(){this.is_move=1;}
scrollingX.prototype.initScroll=function()
{this.p_bound=this.ele.document.body.scrollWidth-this.ele.document.body.offsetWidth;this.p_moveRight=Math.floor(this.ele.document.body.scrollWidth/2);this.p_moveLeft=this.p_bound-this.p_moveRight;setInterval(this.obj+'.goScrolling()',this.time);}
scrollingX.prototype.goMove=function(idx)
{if(idx==0)this.drX=-Math.abs(this.drX);else this.drX=+Math.abs(this.drX);var pos=this.scrollX+idx;this.ele.scrollTo(pos,0);}
scrollingX.prototype.goScrolling=function()
{if(!this.is_move)return;this.scrollX=this.ele.document.body.scrollLeft+this.drX;if(this.drX<0&&this.scrollX<1)this.scrollX=this.p_moveRight;if(this.drX>0&&this.scrollX>this.p_bound)this.scrollX=this.p_moveLeft;this.ele.scrollTo(this.scrollX,0);}}
if(typeof(scrollingY)=='undefined'){var scrollingY=function(objnm,elenm){if(objnm=='')return;if(elenm=='')return;this.obj=objnm;this.ele=eval("window.frames."+elenm);this.time=20;this.drY=1;this.scrollY=0;this.is_move=1;this.ele.scrollTo(0,1);}
scrollingY.prototype.stop=function(){this.is_move=0;}
scrollingY.prototype.start=function(){this.is_move=1;}
scrollingY.prototype.initScroll=function()
{this.p_bound=this.ele.document.body.scrollHeight-this.ele.document.body.offsetHeight;this.p_moveBot=Math.floor(this.ele.document.body.scrollHeight/2);this.p_moveTop=this.p_bound-this.p_moveBot;setInterval(this.obj+'.goScrolling()',this.time);}
scrollingY.prototype.goMove=function(idx)
{if(idx==0)this.drY=-Math.abs(this.drY);else this.drY=+Math.abs(this.drY);var pos=this.scrollY+idx;this.ele.scrollTo(0,pos);}
scrollingY.prototype.goScrolling=function()
{if(!this.is_move)return;this.scrollY=this.ele.document.body.scrollTop+this.drY;if(this.drY<0&&this.scrollY<1)this.scrollY=this.p_moveBot;if(this.drY>0&&this.scrollY>this.p_bound)this.scrollY=this.p_moveTop;this.ele.scrollTo(0,this.scrollY);}}
function setCookie(name,value,expires,path,domain,secure){var curCookie=name+"="+escape(value)+
((expires)?"; expires="+expires.toGMTString():"")+
((path)?"; path="+path:"")+
((domain)?"; domain="+domain:"")+
((secure)?"; secure":"");document.cookie=curCookie;}
function clearCookie(name){var today=new Date();var expire_date=new Date(today.getTime()-60*60*24*1000);document.cookie=name+"= "+"; expires="+expire_date.toGMTString();}
function getCookie(name){var dc=document.cookie;var prefix=name+"="
var begin=dc.indexOf("; "+prefix);if(begin==-1){begin=dc.indexOf(prefix);if(begin!=0)return null;}
else begin+=2
var end=document.cookie.indexOf(";",begin);if(end==-1)end=dc.length;return unescape(dc.substring(begin+prefix.length,end));}
function controlCookie(name,elemnt){if(elemnt.checked){var today=new Date()
var expire_date=new Date(today.getTime()+60*60*6*1000)
setCookie(name=name,value='true',expires=expire_date,path='/');if(_ID(name)==null)setTimeout("self.close()");else setTimeout("_ID('"+name+"').style.display='none'");}
else clearCookie(name);return}
function exec_script(src)
{var scriptEl=document.createElement("script");scriptEl.src=src;_ID('dynamic').appendChild(scriptEl);}
function scrollBanner()
{if(document.all){window.attachEvent("onload",initSlide);}
else{window.addEventListener("load",initSlide,false);}}
function initSlide()
{var scroll=document.getElementById('scroll');var scrollTop=get_objectTop(document.getElementById('pos_scroll'));scroll.style.top=document.body.scrollTop+scrollTop+"px";movingSlide();}
function movingSlide()
{var yMenuFrom,yMenuTo,yOffset,timeoutNextCheck;var scroll=document.getElementById('scroll');var scrollTop=get_objectTop(document.getElementById('pos_scroll'));var scrollobjHeight=scroll.clientHeight;var bodyHeight=jQuery(document).height();yMenuFrom=parseInt(scroll.style.top,10)||$(scroll).offset().top;yMenuTo=$(window).scrollTop()+10;if(yMenuTo<scrollTop)yMenuTo=scrollTop;timeoutNextCheck=500;if(yMenuFrom!=yMenuTo){yOffset=Math.ceil(Math.abs(yMenuTo-yMenuFrom)/10);if(yMenuTo<yMenuFrom)yOffset=-yOffset;scroll.style.top=(yMenuFrom+yOffset)+"px";timeoutNextCheck=10;}
if(yMenuFrom>bodyHeight-scrollobjHeight)scroll.style.top=bodyHeight-scrollobjHeight+"px";setTimeout("movingSlide()",timeoutNextCheck);}
function rScrollBanner(mid,pid)
{if(document.all){window.attachEvent("onload",rInitSlide(mid,pid));}
else{window.addEventListener("load",rInitSlide(mid,pid),false);}}
function rInitSlide(mid,pid)
{var scroll=document.getElementById(mid);var scrollTop=get_objectTop(document.getElementById(pid));scroll.style.top=document.body.scrollTop+scrollTop;rMovingSlide(mid,pid);}
function rMovingSlide(mid,pid)
{var yMenuFrom,yMenuTo,yOffset,timeoutNextCheck;var scroll=document.getElementById(mid);var scrollTop=get_objectTop(document.getElementById(pid));var scrollobjHeight=scroll.clientHeight;var bodyHeight=jQuery(document).height();yMenuFrom=parseInt(scroll.style.top,10)||$(scroll).offset().top;yMenuTo=$(window).scrollTop()+10;if(yMenuTo<scrollTop)yMenuTo=scrollTop;timeoutNextCheck=500;if(yMenuFrom!=yMenuTo){yOffset=Math.ceil(Math.abs(yMenuTo-yMenuFrom)/10);if(yMenuTo<yMenuFrom)yOffset=-yOffset;scroll.style.top=(yMenuFrom+yOffset)+"px";timeoutNextCheck=10;}
if(yMenuFrom>bodyHeight-scrollobjHeight)scroll.style.top=bodyHeight-scrollobjHeight+"px";setTimeout("rMovingSlide('"+mid+"','"+pid+"')",timeoutNextCheck);}
function gdscroll(gap)
{var gdscroll=document.getElementById('gdscroll');gdscroll.scrollTop+=gap;}
function eScroll()
{var thisObj=this;this.timeObj=null;this.mode="top";this.width="100%";this.height=20;this.line=1;this.delay=500;this.speed=1;this.id='obj_eScroll';this.contents=new Array();this.align="left";this.valign="middle";this.gap=0;this.direction=1;this.fps=30;this.interval=1;this._foo=0;this.add=add;this.exec=exec;this.start=start;this.stop=stop;this.scroll=scroll;this.direct=direct;this.go=go;this.wating=wating;function add(str)
{this.contents[this.contents.length]=str;}
function exec()
{this.speed=(this.speed>10)?this.speed:this.speed*1000;this.basis=(this.mode=="left")?this.width:this.height;this.interval=Math.round(1000/(1000/this.speed*this.fps));this.direction=this.direction*Math.round(this.basis/this.interval);var outWidth=this.width*((this.mode=="left")?this.line:1);var outHeight=this.height*((this.mode=="top")?this.line:1);var outline="<div id="+this.id+" style='overflow:hidden;width:"+outWidth+"px;height:"+outHeight+"px;'><table></table></div>";document.write(outline);this.obj=document.getElementById(this.id);var tb=this.obj.appendChild(document.createElement("table"));var tbody=tb.appendChild(document.createElement("tbody"));tb.cellPadding=0;tb.cellSpacing=0;tb.onmouseover=function(){thisObj.stop()};tb.onmouseout=function(){thisObj.start()};if(this.mode=="left")var tr=tbody.appendChild(document.createElement("tr"));for(var k=0;k<this.contents.length;k++){if(this.mode=="top")var tr=tbody.appendChild(document.createElement("tr"));var td=tr.appendChild(document.createElement("td"));td.noWrap=true;td.style.width=this.width.toString().match(/%$/)?this.width:(this.width+"px");td.style.height=this.height.toString().match(/%$/)?this.height:(this.height+"px");td.style.textAlign=this.align;td.style.verticalAlign=this.valign;td.innerHTML=this.contents[k];}
var len=(this.contents.length<this.line)?this.contents.length:this.line;for(i=0;i<len;i++){if(this.mode=="top")var tr=tbody.appendChild(document.createElement("tr"));td=tr.appendChild(document.createElement("td"));td.noWrap=true;td.style.width=this.width.toString().match(/%$/)?this.width:(this.width+"px");td.style.height=this.height.toString().match(/%$/)?this.height:(this.height+"px");td.style.textAlign=this.align;td.style.verticalAlign=this.valign;td.innerHTML=this.contents[i];}
tb.style.width=(this.mode==="top"||this.width.toString().match(/%$/))?"100%":((this.width*(this.contents.length+len))+"px");this.obj.parent=this;this.tpoint=this.basis*this.contents.length;this.wating();}
function scroll()
{var out=(this.mode=="left")?this.obj.scrollLeft:this.obj.scrollTop;var ret=(out==this.tpoint)?this.direction:out+this.direction;if(ret<0)ret=this.tpoint+ret;this._foo=out%this.basis+Math.abs(this.direction);if(this._foo>=this.basis){ret=ret-(this._foo-this.basis);thisObj.wating();}
if(this.mode=="left")this.obj.scrollLeft=ret;else this.obj.scrollTop=ret;}
function wating(){clearTimeout(this.timeObj);setTimeout(function(){thisObj.start();},thisObj.delay);}
function start()
{if(this.timeObj!=null)
{this.stop();};this.timeObj=window.setInterval(function(){thisObj.scroll();},thisObj.interval);}
function stop()
{clearTimeout(this.timeObj);}
function direct(d)
{this.direction=Math.abs(this.direction)*d;}
function go()
{this.stop();var out=(this.mode=="left")?thisObj.scrollLeft:thisObj.scrollTop;var ret=(parseInt(out/this.basis)+this.direction)*this.basis;if(ret<0)ret=this.tpoint+ret;if(ret>this.tpoint)ret=this.basis;if(this.mode=="left")thisObj.scrollLeft=ret;else thisObj.scrollTop=ret;}}
function addOnloadEvent(fnc)
{if(typeof window.addEventListener!="undefined")
window.addEventListener("load",fnc,false);else if(typeof window.attachEvent!="undefined"){window.attachEvent("onload",fnc);}
else{if(window.onload!=null){var oldOnload=window.onload;window.onload=function(e){oldOnload(e);window[fnc]();};}
else window.onload=fnc;}}
function order_print(ordno)
{var ordertax=window.open("../mypage/popup_ordertax.php?ordno="+ordno,"ordertax","width=750,height=600,scrollbars=yes");ordertax.focus();}
function divClose(thisID,tplSkin){if(thisID=='cart_botID'){var in_botArray=new Array('moveCartID','cart_topbarID','cart_botbarID','cart_totalpID');}
if(thisID=='wish_botID'){var in_botArray=new Array('wishlist_ID','wish_topbarID','wish_botbarID');}
var ch_Type=thisID.split('_');var TypeDisplayID=new Array();for(c=0;c<in_botArray.length;c++){TypeDisplayID[c]=document.getElementById(in_botArray[c]);if(TypeDisplayID[c].style.display=="block"){if(thisID=='cart_botID')cart_divCloseYn='y';if(thisID=='wish_botID')wish_divCloseYn='y';TypeDisplayID[c].style.display='none';if(c==0){TypeDisplayID[c].height='0';document.getElementById(thisID).src='../skin/'+tplSkin+'/img/common/scroll_'+ch_Type[0]+'_on.gif';}}else{if(thisID=='cart_botID')cart_divCloseYn='n';if(thisID=='wish_botID')wish_divCloseYn='n';TypeDisplayID[c].style.display='block';if(c==0)document.getElementById(thisID).src='../skin/'+tplSkin+'/img/common/scroll_'+ch_Type[0]+'_off.gif';}}
left_scroll_Text();initSlide();}
function popupEgg(asMallId,asOrderId){iXPos=(window.screen.width-700)/2;iYPos=(window.screen.height-600)/2;var egg=window.open("https://gateway.usafe.co.kr/esafe/InsuranceView.asp?mall_id="+asMallId+"&order_id="+asOrderId,"egg","width=700, height=600, scrollbars=yes, left="+iXPos+", top="+iYPos);egg.focus();}
function getTaxbill(doc_number,taxapp)
{_ID('taxprint').style.display='none';var print=function(){if(_ID('taxstep3')&&_ID('loadMsg'))_ID('loadMsg').style.display='none';var req=ajax.transport;if(req.status==200){var jsonData=eval('('+req.responseText+')');_ID('taxstep3').innerHTML+=(jsonData.status_txt!=null?' - '+jsonData.status_txt:'');if(jsonData.tax_path!=null){_ID('taxprint').getElementsByTagName('a')[0].href="javascript:popup('"+jsonData.tax_path+"',750,600);";_ID('taxprint').style.display='block';}
if(taxapp=='Y'&&(jsonData.status=='CAN'||jsonData.status=='ERR'||jsonData.status=='CCR')){_ID('taxstep3').innerHTML+=' <FONT COLOR="EA0095">(세금계산서를 재신청할 수 있습니다.)</FONT>';_ID('taxapply').style.display='block';}}
else{_ID('taxstep3').title=req.getResponseHeader("Status");_ID('taxstep3').innerHTML+='<font class=small color=444444> - 로딩중에러</font>';}}
if(typeof(Ajax)=='undefined')return;if(_ID('taxstep3')&&!_ID('loadMsg')){msgDiv=_ID('taxstep3').appendChild(document.createElement('span'));msgDiv.id='loadMsg';msgDiv.innerHTML='&nbsp;- 데이타 로딩 중입니다. 잠시만 기다려주세요.';}
var ajax=new Ajax.Request("../mypage/indb.php?mode=getTaxbill&doc_number="+doc_number+"&dummy="+new Date().getTime(),{method:"get",onComplete:print});}
var appname=navigator.appName.charAt(0);var move_type=false;var divpop_id;function Start_move(e,thisID){var event=e||window.event;divpop_id=thisID;if(appname=="M"){target_Element=event.srcElement;}else{if(event.which!=1){return false;}
else{move_type=true;target_Element=event.target;}}
move_type=true;Move_x=event.clientX;Move_y=event.clientY;if(appname=="M")target_Element.onmousemove=Moveing;else document.onmousemove=Moveing;}
function Moveing(e){var event=e||window.event;if(move_type==true){var Nowx=event.clientX-Move_x;var Nowy=event.clientY-Move_y;var targetName=document.getElementById(divpop_id);targetName.style.left=int_n(targetName.style.left)+Nowx+"px";targetName.style.top=int_n(targetName.style.top)+Nowy+"px";Move_x=event.clientX;Move_y=event.clientY;return false;}}
function Moveing_stop(){move_type=false;}
function int_n(cnt){if(isNaN(parseInt(cnt))==true)var re_cnt=0;else var re_cnt=parseInt(cnt);return re_cnt;}
document.onmouseup=function(){Moveing_stop();if(ssSubmitCtrl=="minArrow"||ssSubmitCtrl=="maxArrow"){ssSubmitCtrl=="";try{sSearch.submit();}catch(e){}}}
function getElByTagName(name){var objs=document.getElementsByTagName(name);var rtnObjs=new Array();for(var i=0;i<objs.length;i++){rtnObjs[rtnObjs.length]=objs[i];}
return rtnObjs;}
function getElById(id){return document.getElementById(id);}
function offset(obj){if(obj){var p_offset=offset(obj.offsetParent);return{top:obj.offsetTop+p_offset.top,left:obj.offsetLeft+p_offset.left};}
else{return{top:0,left:0};}}
ImageScope={z_index:0,initscope:false,initzoomLayer:false,zooming:false,preloadImage:new Array(),isIE:true,zoom:function(evt,simg,afterfunc){ImageScope.zoomimg=true;var scrollTop=document.body.scrollTop+document.documentElement.scrollTop;var scrollLeft=document.body.scrollLeft+document.documentElement.scrollLeft;var px=(window.event)?window.event.clientX+scrollLeft:evt.pageX;var py=(window.event)?window.event.clientY+scrollTop:evt.pageY;var simg_offset=offset(simg);var simg_width=(!isNaN(parseInt(simg.width)))?parseInt(simg.width):parseInt(simg.style.width);var simg_height=(!isNaN(parseInt(simg.height)))?parseInt(simg.height):parseInt(simg.style.height);var scope=getElById("scope");var zoomLayer=null;var viewer=getElById(simg.getAttribute("viewerid"));if(viewer)zoomLayer=viewer.lastChild;else zoomLayer=getElById("zoomLayer");var limg=zoomLayer.lastChild;if(simg_offset.left>px||simg_offset.left+simg_width<px||simg_offset.top>py||simg_offset.top+simg_height<py){scope.style.display="none";if(viewer){viewer.style.display='none';zoomLayer.style.display="none";viewer.firstChild.style.display="block";}
else zoomLayer.style.display="none";if(afterfunc)afterfunc();document.onmousemove=null;ImageScope.zoomimg=false;setTimeout(function(){if(!ImageScope.zooming){scope.style.display="none";if(viewer){zoomLayer.style.display="none";viewer.firstChild.style.display="block";}
else zoomLayer.style.display="none";if(afterfunc)afterfunc();}},100);return;}
var limg_width=parseInt(limg.width);var limg_height=parseInt(limg.height);var zoomLayer_width=simg.getAttribute("zoomWidth");var zoomLayer_height=simg.getAttribute("zoomHeight");var scope_borderWidth=0;scope_borderWidth+=(!isNaN(parseInt(scope.style.borderLeftWidth)))?parseInt(scope.style.borderLeftWidth):0;scope_borderWidth+=(!isNaN(parseInt(scope.style.borderRightWidth)))?parseInt(scope.style.borderRightWidth):0;var scope_borderHeight=0;scope_borderHeight+=(!isNaN(parseInt(scope.style.borderTopWidth)))?parseInt(scope.style.borderTopWidth):0;scope_borderHeight+=(!isNaN(parseInt(scope.style.borderBottomWidth)))?parseInt(scope.style.borderBottomWidth):0;var perX=0;var perY=0;var scope_width=0;var scope_height=0;try
{if(limg_width==0||limg_height==0)throw "";perX=(limg_width/simg_width);perY=(limg_height/simg_height);scope_width=(zoomLayer_width/perX);scope_height=(zoomLayer_height/perY);}
catch(e)
{perX=0;perY=0;scope_width=0;scope_height=0;}
scope_width=(simg_width<scope_width+scope_borderWidth)?simg_width-scope_borderWidth:scope_width;scope_height=(simg_height<scope_height+scope_borderHeight)?simg_height-scope_borderHeight:scope_height;scope.style.width=scope_width+"px";scope.style.height=scope_height+"px";zoomLayer.style.width=zoomLayer_width+"px";zoomLayer.style.height=zoomLayer_height+"px";if(!viewer)zoomLayer.style.marginLeft=(scope_width+10)+"px";if(!ImageScope.isIE){scope_width+=scope_borderWidth;scope_height+=scope_borderHeight;scope_width=(simg_width<scope_width)?simg_width:scope_width;scope_height=(simg_height<scope_height)?simg_height:scope_height;}
var sx=px-(scope_width/2);var sy=py-(scope_height/2);if(sx<=simg_offset.left)sx=simg_offset.left;else{var maxLeft=Math.ceil(simg_offset.left+simg_width-scope_width);if(sx>=maxLeft)sx=maxLeft;}
if(sy<=simg_offset.top)sy=simg_offset.top;else{var maxTop=Math.ceil(simg_offset.top+simg_height-scope_height);if(sy>=maxTop)sy=maxTop;}
scope.style.left=sx+"px";scope.style.top=sy+"px";scope.style.display="block";scope.style.zIndex="10000";if(!viewer){zoomLayer.style.left=sx+"px";zoomLayer.style.top=sy+"px";}
zoomLayer.style.display="block";limg.style.marginLeft=((sx-simg_offset.left)*-1*perX)+"px";limg.style.marginTop=((sy-simg_offset.top)*-1*perY)+"px";},setImage:function(obj,beforefunc,afterfunc){if(!obj||obj.tagName!="IMG")return;if(navigator.appName!="Microsoft Internet Explorer")ImageScope.isIE=false;if(ImageScope.z_index==0){var objTypes=["IMG","DIV","SPAN","UL"];var objTypes_length=objTypes.length;for(var i=0;i<objTypes_length;i++){var objs=getElByTagName(objTypes[i]);var objs_length=objs.length;for(var j=0;j<objs_length;j++){var z_index=parseInt(objs[j].style.zIndex);if(!isNaN(z_index)&&ImageScope.z_index<z_index)ImageScope.z_index=z_index;}}}
if(ImageScope.initscope==false){ImageScope.initscope=true;var scope=document.createElement("SPAN");scope.setAttribute("id","scope");scope.style.position="absolute";scope.style.display="none";scope.style.width="0px";scope.style.height="0px";scope.style.border="solid 2px #CCCCCC";scope.style.backgroundColor="#FFFFFF";scope.style.filter="alpha(opacity=70)";scope.style.opacity="0.7";scope.style.MozOpacity="0.7";scope.style.zIndex=ImageScope.z_index;getElByTagName("body")[0].appendChild(scope);}
var viewer=getElById(obj.getAttribute("viewerid"));if(viewer){if(viewer.getAttribute("viewReady")!="y"){viewer.setAttribute("viewReady","y");var innerDefault=viewer.innerHTML;innerDefault="<div>"+innerDefault+"</div>";innerDefault+="<div style='width:100%; height:100%; overflow:hidden; display:none; z-index:"+(ImageScope.z_index+10)+"' class='zoomLayer'><img src='' class='limg' onload='this.style.display=\"block\";' onerror='this.style.display=\"none\";' /></div>";viewer.innerHTML=innerDefault;var width=(viewer.getAttribute("width"))?viewer.getAttribute("width"):viewer.style.width;var height=(viewer.getAttribute("height"))?viewer.getAttribute("height"):viewer.style.height;if(width.match(/%/g))width=0;if(height.match(/%/g))height=0;obj.setAttribute("zoomWidth",width.replace(/[^0-9.]*/g,""));obj.setAttribute("zoomHeight",height.replace(/[^0-9.]*/g,""));}}
else if(ImageScope.initzoomLayer==false){ImageScope.initzoomLayer=true;var zoomLayer=document.createElement("SPAN");zoomLayer.setAttribute("id","zoomLayer");zoomLayer.style.position="absolute";zoomLayer.style.display="none";zoomLayer.style.width="0px";zoomLayer.style.height="0px";zoomLayer.style.overflow="hidden";zoomLayer.style.border="dashed 3px";zoomLayer.style.zIndex=(ImageScope.z_index+10);zoomLayer.innerHTML="<img src='' class='limg' onload='this.style.display=\"block\";' onerror='this.style.display=\"none\";' />";getElByTagName("body")[0].appendChild(zoomLayer);}
if(obj.getAttribute("lsrc")){var n=ImageScope.preloadImage.length;var lsrc=obj.getAttribute("lsrc");var isExist=false;for(var i=0;i<n;i++){if(ImageScope.preloadImage[i].src==lsrc){isExist=true;break;}}
if(!isExist){ImageScope.preloadImage[n]=new Image();ImageScope.preloadImage[n].src=obj.getAttribute("lsrc");}}
obj.onmouseover=function(){if(ImageScope.zooming)return;if(!this.getAttribute("zoomWidth")){var width=(!isNaN(parseInt(this.getAttribute("width"))))?parseInt(this.getAttribute("width")):parseInt(this.style.width);this.setAttribute("zoomWidth",width);}
if(!this.getAttribute("zoomHeight")){var height=(!isNaN(parseInt(this.getAttribute("height"))))?parseInt(this.getAttribute("height")):parseInt(this.style.height);this.setAttribute("zoomHeight",height);}
var viewer=getElById(obj.getAttribute("viewerid"));var zoomLayer=null;if(viewer){viewer.style.display='block';viewer.firstChild.style.display="none";zoomLayer=viewer.lastChild;}
else zoomLayer=getElById("zoomLayer");var limg=zoomLayer.lastChild;limg.setAttribute("src",(obj.getAttribute("lsrc")?obj.getAttribute("lsrc"):obj.getAttribute("src")));var self=this;if(beforefunc)beforefunc();document.onmousemove=function(evt){ImageScope.zoom(evt,self,afterfunc);};};}}
var nsTodayShop=function(){function popup(url,w_width,w_height,scroll){var x=(screen.availWidth-w_width)/2;var y=(screen.availHeight-w_height)/2;if(scroll==1){var sc="scrollbars=yes";}
else var sc="scrollbars=no";return window.open(url,"","width="+w_width+",height="+w_height+",top="+y+",left="+x+","+sc);}
return{smsSend:function(n){popup('../todayshop/popup_sms_coupon.php?ordno='+n,500,300);},print:function(n){popup('../todayshop/popup_print_coupon.php?ordno='+n,500,350);}}}();function fnMypageLayerBox(logged){if(logged!=true)return true;var box=document.getElementById('MypageLayerBox');if(box!=undefined){var el=event.srcElement;var pos=offset(el);box.style.position="absolute";box.style.top=pos.top+el.offsetHeight+"px";box.style.left=parseInt(pos.left+el.offsetWidth/2-parseInt(box.style.width.replace('px',''))/2)+"px";box.style.display='block';return false;}
return true;}
function msg_back(){alert("이용 권한이 없습니다. 회원등급이 낮거나 회원가입이 필요합니다.");return;}
function setGoodsImageSoldoutMask(){function _getSize(el){var size={};size={'height':el.offsetHeight,'width':el.offsetWidth};if(size.height==0){var p;for(p=el.parentNode;p.style.display!='none';p=p.parentNode);p.style.display='block';size={'height':el.offsetHeight,'width':el.offsetWidth};p.style.display='none';}
return size;}
var i,css,s_img=document.getElementsByTagName('IMG');var mask=document.getElementById('el-goods-soldout-image-mask');if(!mask)return;var div,a,img,size;for(i in s_img){img=s_img[i];css=img.className;if(css&&css.indexOf('el-goods-soldout-image')>-1){for(a=img.parentNode;a.nodeType!==1&&a.tagName!=='A';a=a.parentNode);for(div=a.parentNode;div.nodeType!==1&&div.tagName!=='DIV';div=div.parentNode);var _mask=mask.cloneNode(true);_mask.id=_mask.id+'_'+i;size=_getSize(img);_mask.style.height="100%";_mask.style.width="100%";_mask.style.display='block';div.style.position='relative';a.insertBefore(_mask,img);}}}
function toggle(objID){obj=document.getElementById(objID);if(obj.style.display=="none"){obj.style.display="block";obj.style.visibility="visible";}
else{obj.style.display="none";obj.style.visibility="hidden";}}
function scrollCateList_ajax(qStr,page,page_num){newDiv=document.createElement("div");newDiv.id="scrollCateTooltip";newDiv.style.zIndex="1000";newDiv.style.display="none";newDiv.style.position="absolute";newDiv.style.padding="10px";newDiv.style.top="0px";newDiv.style.left="0px";newDiv.style.width="100px";newDiv.style.filter="alpha(opacity=80)";newDiv.style.opacity="80";newDiv.style.lineHeight="140%";newDiv.style.background="#ffffff";newDiv.style.color="#000000";newDiv.style.border="1px solid #DFDFDF";document.body.appendChild(newDiv);var url="../goods/ajax_cateList.php?"+qStr;if(page)url=url+"&page="+page;if(page_num)url=url+"&page_num="+page_num;jQuery.ajax({"url":url,"success":function(responseText)
{$("#scrollMoveList").innerHTML=responseText;return true;},"error":function()
{return false;}});}
function scrollTooltipShow(obj){var tooltip=document.getElementById('scrollCateTooltip');tooltip.innerHTML=obj.getAttribute('tooltip');moveList=getBounds(document.getElementById('scrollMoveList'));var pos_x=event.clientX+document.body.scrollLeft+document.documentElement.scrollLeft;var pos_y=event.clientY+document.body.scrollTop+document.documentElement.scrollTop;var tempWidth=tooltip.style.width;tempWidth=parseInt(tempWidth.replace("px",""));var winWidth=(document.body.clientWidth)?document.body.clientWidth:document.documentElement.clientWidth;if(pos_x+10+tempWidth>winWidth)pos_x=pos_x-tempWidth;tooltip.style.left=(pos_x+10)+'px';tooltip.style.top=(pos_y+10)+'px';tooltip.style.display='block';}
function scrollTooltipHide(obj){var tooltip=document.getElementById('scrollCateTooltip');tooltip.innerHTML='';tooltip.style.display='none';}
function getBounds(tag){var ret=new Object();if(tag.getBoundingClientRect){var rect=tag.getBoundingClientRect();ret.left=rect.left+(document.documentElement.scrollLeft||document.body.scrollLeft);ret.top=rect.top+(document.documentElement.scrollTop||document.body.scrollTop);ret.width=rect.right-rect.left;ret.height=rect.bottom-rect.top;}
else{var box=document.getBoxObjectFor(tag);ret.left=box.x;ret.top=box.y;ret.width=box.width;ret.height=box.height;}
return ret;}
function preventContentsCopy(){try
{var sc=document.createElement('script');var script=document.getElementsByTagName('script')[0];sc.type='text/javascript';sc.src='../lib/js/prevent.contents.copy.js';script.parentNode.insertBefore(sc,script);}
catch(e){}}
function gd_ajax(obj){try
{var ajax=new XMLHttpRequest();}
catch(e)
{var ajax=new ActiveXObject("Microsoft.XMLHTTP");}
if(!obj.param)obj.param='';if(!obj.type)obj.type='post';ajax.onreadystatechange=function(){if(ajax.readyState==4){if(ajax.status==200){if(obj.success){obj.success(ajax.responseText);}}}}
obj.type=obj.type.toLowerCase();if(obj.type!='post'){obj.url=obj.url+"?"+obj.param;obj.param=null;}
ajax.open(obj.type,obj.url,true);ajax.setRequestHeader("Content-type","application/x-www-form-urlencoded");ajax.send(obj.param);}
function bgToggle(objID,bg1,bg2){obj=_ID(objID);if(obj.style.background=="url("+bg1+")"){obj.style.background="url("+bg2+")";}
else{obj.style.background="url("+bg1+")";}}
var ssSubmitCtrl,ssPriceTerm;function ssStart_move(e,thisID){var event=e||window.event;divpop_id=thisID;if(appname=="M")target_Element=event.srcElement;else{if(event.which!=1)return false;else{move_type=true;target_Element=event.target;}}
move_type=true;Move_x=event.clientX;tempPixelLeft=parseInt($(target_Element).css("left"));if(appname=="M")target_Element.onmousemove=ssMoveing;else document.onmousemove=ssMoveing;}
function ssMoveing(e){var event=e||window.event;if(move_type==true){var Nowx=event.clientX-Move_x;var targetName=document.getElementById(divpop_id);var minOPrc=_ID('ssOriMinPrc');var maxOPrc=_ID('ssOriMaxPrc');tempX=tempPixelLeft+event.clientX-Move_x;ssSubmitCtrl=targetName.id;var minArrowLeft=parseInt($("#minArrow").css("left"));var maxArrowLeft=parseInt($("#maxArrow").css("left"));if(targetName.id=="minArrow"){tempX=(tempX<0)?0:tempX;tempX=(tempX>maxArrowLeft)?maxArrowLeft:tempX;targetName.style.left=tempX+"px";}
else{tempX=(tempX<minArrowLeft)?minArrowLeft:tempX;tempX=(tempX>156)?156:tempX;targetName.style.left=tempX+"px";}
_ID('ssMinPrice').value=Math.round(Math.round((minArrowLeft/156)*100)/100*ssPriceTerm)+(minOPrc.value*1);_ID('ssMaxPrice').value=Math.round(Math.round((maxArrowLeft/156)*100)/100*ssPriceTerm)+(minOPrc.value*1);return false;}}
function ssPrcSetting(){if(_ID('ssMinPrice')){var minArw=_ID('minArrow');var maxArw=_ID('maxArrow');var minPrc=_ID('ssMinPrice');var maxPrc=_ID('ssMaxPrice');var minOPrc=_ID('ssOriMinPrc');var maxOPrc=_ID('ssOriMaxPrc');if(maxOPrc.value)ssPriceTerm=maxOPrc.value-minOPrc.value;else ssPriceTerm=maxPrc.value-minPrc.value;minArw.style.left=Math.round(((minPrc.value-minOPrc.value)/ssPriceTerm)*156)+"px";maxArw.style.left=Math.round(((maxPrc.value-minOPrc.value)/ssPriceTerm)*156)+"px";minArw.style.display="";maxArw.style.display="";}}
function ssShowMore(objID,menuName,searchID){var el=event.srcElement.parentElement.parentElement;_ID('searchID').value=searchID;_ID('ssMoreSearchName').innerHTML=menuName;_ID('ssMoreOption').innerHTML='';_ID(objID).style.top=get_objectTop(el)+'px';_ID(objID).style.display="block";gd_ajax({url:'../goods/ajax_smartSearch.php',type:'POST',param:"&menuName="+menuName+"&searchID="+searchID+"&"+_ID('queryString').value,success:function(rst){_ID('ssMoreOption').innerHTML=rst;_ID('ssMoreOption').style.display='block';}});}
function ssCheckMoreOption(checkVal,st){if(st){if(_ID('tempOption').value.indexOf(checkVal+"|^")==-1)_ID('tempOption').value+=checkVal+"|^";}
else{_ID('tempOption').value=_ID('tempOption').value.replace(checkVal+"|^","");}}
function ssCheckedOption(optName){var opt=document.getElementsByName(optName+'[]');for(i=0;i<opt.length;i++){if(opt[i].checked)if(_ID('tempOption').value.indexOf(opt[i].id)==-1)_ID('tempOption').value+=opt[i].id+"|^";}}
function ssSubmitMoreOption(){var targetOpt=document.getElementsByName(_ID('searchID').value+"[]");var checkedOpt=_ID('tempOption').value.split("|^");for(i=0;i<targetOpt.length;i++)targetOpt[i].checked=false;for(i=0;i<checkedOpt.length;i++)if(checkedOpt[i])_ID(checkedOpt[i]).checked=true;try{sSearch.submit()}catch(e){}}
function ssCloseMoreOption(){_ID('tempOption').value="";_ID('ssMoreSearchBox').style.display='none';}
function convColor(colorCode){if(colorCode.toLowerCase().indexOf('rgb')==0){colorCode=colorCode.toLowerCase().replace(/rgb/g,'');colorCode=colorCode.toLowerCase().replace(/\(/g,'');colorCode=colorCode.toLowerCase().replace(/\)/g,'');colorCode=colorCode.toLowerCase().replace(/ /g,'');colorCode_tempList=colorCode.split(',');colorCode="";for(i=0;i<colorCode_tempList.length;i++){tmpCode=parseInt(colorCode_tempList[i]).toString(16);if(String(tmpCode).length==1)tmpCode="0"+tmpCode;colorCode+=tmpCode;}
colorCode="#"+colorCode;}
return colorCode;}
function ssSelectColor(targetColor){targetColor=convColor(targetColor);tempColor=_ID("ssColor");if(tempColor.value.indexOf(targetColor)==-1)tempColor.value=tempColor.value+targetColor;if(tempColor.value)color2Tag('selectedColor');try{sSearch.submit()}catch(e){}}
function color2Tag(targetID){if(!_ID("ssColor"))return;var colorTag=_ID(targetID);var colorText=_ID("ssColor").value;var tempColor="";colorTag.innerHTML="";for(i=0;i<colorText.length;i=i+7){tempColor=colorText.substr(i,7);if(tempColor)colorTag.innerHTML+="<div style=\"background:"+tempColor+"\" class=\"paletteColor_selected\" ondblclick=\"deleteColor('"+targetID+"', this.style.backgroundColor);\"></div>\n";}
if(colorTag.innerHTML){colorTag.innerHTML+="<div style=\"clear:left;\"></div>";_ID('selectedColor').style.border="1px solid #E0E0E0";}
else{_ID('selectedColor').style.border="1px solid #FFFFFF";}}
function deleteColor(targetID,delColor){delColor=convColor(delColor);var colorTextObj=_ID("ssColor");colorTextObj.value=colorTextObj.value.replace(delColor,"");color2Tag(targetID);try{sSearch.submit()}catch(e){}}
function layerCartAdd(frm){var goodsName='';var goodsNameItem=[];if($('[name=packageCheck]').val()==='true'){$('#el-multi-option-display .goods-view-order-item').each(function(){goodsNameItem.push($(this).find('.goods-view-order-item-name').text().split('/')[1]);});if(goodsNameItem.length>1){goodsName='<span class="name">'+goodsNameItem[0]+'</span>외 '+(goodsNameItem.length-1)+'종';}else{goodsName=goodsNameItem[0];}}else{goodsName=$('[name=frmView]').find('.goods-view-name').text();}
ajaxCart(jQuery(frm).serialize());}
function ajaxCart(param,callback){var ajaxUrl="/shop/goods/ajax_cartAdd.php";jQuery.ajax({url:ajaxUrl,type:'POST',data:param,success:function(xml){var preview='n';var result=xml.getElementsByTagName('result');var code=result[0].getElementsByTagName('code')[0].firstChild.nodeValue;var msg=result[0].getElementsByTagName('msg')[0].firstChild.nodeValue;if(code=='chkOpenYn'){alert(msg);if(preview=='y'){self.close();}}else if(code=='chkMaxCount'){alert(msg);}
else if(code=='success'){cart_count_down();}else{alert('Error('+code+')입니다.');}}});}
function centerLayer(s,w,h)
{if(!w)w=600;if(!h)h=400;var bodyW=document.body.clientWidth;var bodyH=window.innerHeight;if(typeof window.innerWidth=='undefined')
bodyW=document.body.clientWidth;if(typeof window.innerHeight=='undefined')
bodyH=document.body.clientHeight;var posX=(bodyW-w)/2;var posY=(bodyH-h)/2;var obj=document.createElement("div");var scrollTop=0;if(document.compatMode=='BackCompat')
{scrollTop=document.body.scrollTop;}
else{scrollTop=document.documentElement.scrollTop;}
with(obj.style){position="fixed";left=posX+document.body.scrollLeft+'px';top=posY+scrollTop+'px';width=w+'px';height=h+'px';backgroundColor="#ffffff";border="4px solid #212121";marginLeft='0px';padding='0px';}
obj.id="centerLayer";document.body.appendChild(obj);var ifrm=document.createElement("iframe");with(ifrm.style){width=w+'px';height=h+'px';}
ifrm.style.padding='0px';ifrm.style.marginLeft='0px';ifrm.marginwidth='0px';ifrm.frameBorder="no";ifrm.scrolling="no";obj.appendChild(ifrm);ifrm.src=s;}
function closeCenterLayer()
{parent.document.body.removeChild(parent.document.getElementById('centerLayer'));}
var cart_switch='on';function cartAdd(form,redirectType)
{if(cart_switch=='off'){alert('동작 처리중입니다. 잠시만 기다려주세요^^');return false;}
cart_switch='off';setTimeout(function(){cart_switch='on';},1500);var opt_cnt=0,data;if(typeof nsGodo_MultiOption!='undefined'){nsGodo_MultiOption.clearField();for(var k in nsGodo_MultiOption.data){data=nsGodo_MultiOption.data[k];if(data&&typeof data=='object'){nsGodo_MultiOption.addField(data,opt_cnt);opt_cnt++;}}}
if(typeof chkGoodsForm!='undefined'){if(opt_cnt<1){if(!chkGoodsForm(form))return;}}
else{if(!chkForm(form))return;}
if(redirectType=='Direct')
{var isCody=(typeof form.cody=='object')?form.cody.value:'n';var dirPath=(isCody=='y')?'../../goods/':'';form.action=dirPath+'goods_cart.php';form.submit();}
else if(redirectType=='Confirm'){layerCartAdd(form,redirectType);}
return;}
function createXMLFromString(string){var xmlDocument;var xmlParser;if(window.ActiveXObject){xmlDocument=new ActiveXObject('Microsoft.XMLDOM');xmlDocument.async=false;xmlDocument.loadXML(string);}else if(window.XMLHttpRequest){xmlParser=new DOMParser();xmlDocument=xmlParser.parseFromString(string,'text/xml');}else{return null;}
return xmlDocument;}
function SameAddressSub(text){var div_road_address=document.getElementById('div_road_address');var div_road_address_sub=document.getElementById('div_road_address_sub');if(div_road_address.innerHTML==""){div_road_address_sub.style.display="none";}else{div_road_address_sub.style.display="";div_road_address_sub.innerHTML=text.value;}}
function goodsCopyUrl(){var _copyUrl=location.href;var isIE=(navigator.userAgent.indexOf("MSIE")>=0||navigator.userAgent.indexOf("Trident")>=0?true:false);if(isIE===true){window.clipboardData.setData("Text",_copyUrl);alert("상품의 주소가 복사되었습니다.");}else{temp=prompt("상품의 주소를 복사할 수 있습니다.\n원하는 곳에 붙여넣기 (Ctl+V) 해주세요.",_copyUrl);}}
var review_like_check=false;function review_like(r_no,$self){if(review_like_check)return;review_like_check=true;if(!GD_ISMEMBER){if(confirm("회원전용 서비스 입니다. 로그인/회원가입 페이지로 이동하시겠습니까?")){if(typeof(parent)!="undefined"){parent.location.href="/shop/member/login.php?return_url="+encodeURIComponent(parent.location.href);}else{document.location.href="/shop/member/login.php?return_url="+encodeURIComponent(location.href);}}
return;}else{$.ajax({type:"POST",url:'../goods/ajax_review_like.php',dataType:'json',data:{"mode":"add_like","r_no":r_no},success:function(res){if(res.state=='success'){if(res.cnt){if($self){$self.find('.num').text(res.cnt);}
$('.review-like-cnt[data-sno="'+r_no+'"]').text(res.cnt);}}else{if(res.msg){alert(res.msg);}else{alert('일시적인 오류가 생겨 잠시 후 다시 시도해주시기 바랍니다.');}}
review_like_check=false;}});}}
function review_like_cnt(r_no){$.ajax({type:"POST",url:'../goods/ajax_review_like.php',dataType:'json',data:{"mode":"cnt_like","r_no":r_no},success:function(res){if(res.cnt){$('.review-like-cnt[data-sno="'+r_no+'"]').text(res.cnt);}}});}
function review_addhit(sno){$.ajax({type:"POST",url:'../goods/ajax_review_addhit.php',dataType:'json',data:{"sno":sno},success:function(res){if(res.hit){$('.review-hit-cnt[data-sno="'+sno+'"]').text(res.hit);}}});}
function address_chk_popup(){popup('../proc/popup_address2.php',530,500);}