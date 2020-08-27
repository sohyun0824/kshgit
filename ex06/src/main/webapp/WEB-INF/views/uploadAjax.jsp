<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
 
 <style type="text/css">
ul{
	list-style:none;
} 
 </style>

</head>
<body>

<h1>Upload with Ajax</h1>

<div class="uploadDiv">
	<input type="file" name="uploadFile" multiple>
</div>

<button id="uploadBtn">Upload</button>

<div class="uploadResult">
	<ul>
	</ul>
</div>


<script>
	$(document).ready(function(){
		
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880; // 5MB
		
		function checkExtension(fileName, fileSize){
			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			return true;
		}
		
		var uploadResult = $(".uploadResult ul");
		
		// 파일 이름에 포함된 공백 문자나 한글 이름 문제 처리 -> encodeURIComponent()
		function showUploadedFile(uploadResultArr){
			
			var str = "";
			
			$(uploadResultArr).each(function(i, obj) {
				if(!obj.image){
					str += "<li><img src='/resources/img/attach.png' style='width:20px'>" + obj.fileName + "</li>";
				}else{
					// str += "<li>" + obj.fileName + "</li>";
					var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
					
					str += "<li><img src='/display?fileName="+fileCallPath+"'><li>";
				}			
			});
			uploadResult.append(str);
		}
		
		
		// 업로드 후에 업로드부분 초기화
		var cloneObj = $(".uploadDiv").clone();
		
		$("#uploadBtn").on("click", function(e){
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			console.log(files);
			
			for (var i = 0; i < files.length; i++) {
				
				if(!checkExtension(files[i].name, files[i].size)){
					return false;
				}
				
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url:"/uploadAjaxAction",
				processData: false,
				contentType: false,
				data: formData,
				type: 'POST',
				dataType : 'json',
				success: function(result){
					console.log(result);
					
					// 첨부파일 목록을 li태그로 추가하는 함수 호출
					showUploadedFile(result);
					
					// 업르드 완료후 다른 파일 업로드할 수 있도록 초기화
					$(".uploadDiv").html(cloneObj.html());
				}
			});
			
		});
	})
</script>

</body>
</html>