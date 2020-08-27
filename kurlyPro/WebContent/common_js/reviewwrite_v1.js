var reviewWrite = function(){}

reviewWrite.prototype= {
    writeCheck:null, // 글쓰기-유무
    heightCheck:null, //textarea height check
    goodsNo:null, // goods number
    fieldCmtCount:null, // textarea text count
    deviceType:null, // PC,Mobile check
    photoStorage:null, // photo default markup 
    photoCount:null, // photo count
    validatorCheck:null, 
    modifyType : false, // modify check
    init:function(type,writeType){
        // this.obj = obj,
        this.writeCheck = false,
        this.heightCheck = $('#fieldCmt').height(),
        this.goodsNo = $('[name=goodno]').val(),
        this.fieldCmtCount = 0,
        this.photoStorage = $('.inner_photo').eq(0).html(),
        this.photoCount = 0,
        this.validatorCheck = false,
        this.modifyType = writeType,
        this.deviceType = type;
    },
    fieldHeight:function($target){
        var $this = this;
        if($this.deviceType === 'mobile'){ // 모바일분기처리
            $target.height($this.heightCheck).height($target.prop('scrollHeight'));
        }else{
            $target.height($this.heightCheck).height($target.prop('scrollHeight'));    
        }
    },
    maxCount:function($target,maxNum,type){ // 텍스트사이즈 체크
        var $this = this;
        var $obj = $target.parents('.field_cmt').find('.txt_count .num');
        var str = $target.val();
        var _byte = 0;
        var strlength = 0;
        var charStr = '';
        var maxlength = maxNum;// 최대글자수 제한은 이곳에 수치로적용(한글 2byte, 영문,숫자,공백2byte)
        var cutstr = '';
        // if(str.length<=0) return;
        for(var i=0;i<str.length;i++){
            charStr=str.charAt(i);
            if(escape(charStr).length>4){
                _byte+=1; // byte 처리시에는 2로 바꿔야함
            }else{
                _byte++;
            }
            if(_byte<=maxlength) strlength=i+1;
        }
        $obj.text(_byte);
        if(_byte>maxlength){
            cutstr=$target.val().substr(str,strlength);
            $target.val(cutstr);
            $obj.text(maxlength);
            return;
        }else{
            $obj.text(_byte);
        }
        if(type === true) $this.fieldCmtCount = _byte;
        $this.formCheck();
    },
    formCheck:function(){ // 등록유무체크
        var $this = this;
        if($('[name=subject]').val().length >= 1 && $this.fieldCmtCount >= 10){
            $this.writeCheck = true;
            if($('#btnSubmit').hasClass('btn_disabled')) $('#btnSubmit').removeClass('btn_disabled');
        }else{
            $this.writeCheck = false;
            if(!$('#btnSubmit').hasClass('btn_disabled')) $('#btnSubmit').addClass('btn_disabled');
        }
    },
    reviewValidate:function(){
        var $this = this;
        if(!$this.writeCheck) return false;
        $('.bg_loading').show();
        $this.validatorCheck = true;
        $this.reviewSave();
    },
    reviewSave:function(){
        var $this = this;
        if(!$this.validatorCheck) return;
        $('.bg_loading').show();
        $('.btn_upload').html('');    
        if($this.modifyType){
            $('input[name="file[]"]').each(function(idx){
                var checkCount =  $this.photoCount + idx - 1;
                $(this).attr('name', 'file[' + checkCount + ']');
            });
        }

        
        $('#form_review').submit();
        
        
    },action:function(){
        var $this = this;
        // 제목 validator
        $('[name=subject]').on('keydown keyup focus blur',function(e){
            $this.maxCount($(this),100);

            if(e.originalEvent.type == 'focus'){
                if(!$(this).hasClass('on')) $(this).addClass('on');
            }
            if(e.originalEvent.type == 'blur'){
                if($(this).hasClass('on')) $(this).removeClass('on');
            }
        });
        // 후기작성 validator
        $('#fieldCmt').on('keydown keyup focus blur',function(e){
            $this.fieldHeight($(this));
            $this.maxCount($(this),9999999999,true);
            
            if(e.originalEvent.type == 'focus'){
                if(!$(this).parent().hasClass('on')) $(this).parent().addClass('on');
            }
            if(e.originalEvent.type == 'blur'){
                if($(this).parent().hasClass('on')) $(this).parent().removeClass('on');
            }
        });

        // 사진수정
        if($this.modifyType){ 
            $this.maxCount($('[name=subject]'),100);
            $this.fieldHeight($('#fieldCmt'));
            $this.maxCount($('#fieldCmt'),9999999999,true);
            $this.formCheck();
            if($this.deviceType === 'pc'){ // 모바일은 제외처리
                if($('[name=file_length]').val()){
                    $('.inner_photo').eq(0).remove(); // 수정시
                    $this.photoCount = parseInt($('[name=file_length]').val()) + 1;
                    $('.file_count .num').text($this.photoCount);
                    if($this.photoCount >= 8){ // 등록횟수넣기
                        $('.photo_add .btn_upload').hide();
                    }else{
                        $('.photo_add .btn_upload').show();
                    }
                }
                // 삭제 
                $('.btn_delete').on('click', function(){
                    var num = $(this).parent().find('[name="file_ori[]"]').attr('data-num');
                    var inpDelete = '<input type="hidden" value="on" name="del_file['+num+']">';
                    $('[name=form_review]').append(inpDelete);
                    $(this).parent().hide();
                    $this.photoCount--;
                    $('.file_count .num').text($this.photoCount);
                    if($this.photoCount < 8) $('.photo_add .btn_upload').show();
                });
            }else{  // 모바일은 제외처리 예외
                $('.inner_photo').eq(0).html(''); // ready 시 Storage 샘플이미지제거    
            }
        }else{
            $('.inner_photo').eq(0).html(''); // ready 시 Storage 샘플이미지제거    
        }

        // 등록하기
        $('#btnSubmit').on('click',function(){
            $this.reviewValidate();
            
            // 후기쓰기에서 등록한 이미지 파일 배열에 담기
            /*
            var file = [];
            
            for (var i = 0; i < $("span.photo").length; i++) {
            	var img = $("span.photo:eq("+ i +")").css("background-image").replace('url(','').replace(')','').replace(/\"/gi, "");
				file.push(img);
			}

            
            $.ajax({
            	url:"./ajax_review_insert/insert_review.jsp",
            	type:"POST",
            	traditional:true,
            	enctype: 'multipart/form-data',
            	data:{"goods_no": goods_no, 
            		  "order_no" : order_no,
            		  "m_id" : m_id,
            		  "m_name" : m_name,
            		  "subject" : subject,
            		  "content" : content,
            		  "file" : file
            		  }, 
            	dataType: "json", 
            	processData: false,
            	contentType: false,
            	cache : false,
            	success : function(data){
            		alert("complete");
                    $("#btnSubmit").prop("disabled", false);
            		
            	}, 
            	error: function(){
            		alert("후기등록 실패..");
            	}
            })
            
            */
        });
        
        
    },photoUpload:function($obj){
        var $this = this;
        var upload = event.target ? event.target : window.event.srcElement;
        var photoUrl;
        var file = upload.files[0];
        var reader = new FileReader();
        var img = new Image();
        reader.readAsDataURL(file);
        reader.onload = function(_file){
            img.src = _file.target.result;
            photoUrl = img.src;
            if($.trim(img.src) == "") return;
            img.addEventListener("load", function(){
                var imgSize = Math.round(file.size/1024);
                if(imgSize > 11000){
                    alert('최대 10MB 이하 이미지 파일만 첨부 가능합니다.');
                    $obj.val('');
                    return false;
                }else{
                    photoSet();    
                }
            });
        }
        reader.onerror = function(){alert("정상 등록되지 않았습니다.")}
        function photoSet(){
            $('.inner_photo').append($this.photoStorage);
            var $target = $('.inner_photo').find('.item_photo').eq($('.inner_photo').find('.item_photo').length - 1);
            $target.find('.photo').css({
                'background-image':'url(' + photoUrl + ')'
            });
            $target.show();
            $this.photoCount++;

            if($this.photoCount >= 8){ // 등록횟수넣기
                $('.photo_add .btn_upload').hide();
            }else{
                $('.photo_add .btn_upload').show();
            }

            // type="file" name="file[]" 생성 
            var newFile = '<input type="file" name="file[]" class="file_upload" onchange="photoUp($(this))" value="사진등록하기" accept="image/*">';
            $obj.parent().append(newFile);
            // type="file" name="file[]" 이동
            $('.inner_photo .item_photo:last-child').append($obj);
            
            // 삭제 
            $target.find('.btn_delete').on('click', function(){
                $(this).parent().remove();
                if($('.photo_add .btn_upload').css('display') == 'none') $('.photo_add .btn_upload').show();
                $this.photoCount--;
                $('.file_count .num').text($this.photoCount);
                if($this.deviceType === 'mobile'){
                    $('.photo_add').width($('.photo_add').width() - 84);
                    if($('.photo_add').width() < $(window).width()) $('.photo_scroll').scrollLeft(0);
                }
            });
            // 이미지 카운트
            $('.file_count .num').text($this.photoCount);
            if($this.deviceType === 'mobile'){
                $('.photo_add').width($('.photo_add').width() + 84);
                if($('.photo_add').width() >= $(window).width()){
                    var num = parseInt($('.photo_add').width());
                    $('.photo_scroll').scrollLeft(num);
                }
            }
        }
    }
}