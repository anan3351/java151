<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>answerform</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.tiny.cloud/1/4limsqsr4t2l3p5v338g1nblplu7cdds2zueq39vw7qjcwf9/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>

    <link rel="stylesheet" href="/css/template.css">
	<style>
	
	.container {
	    background-color: #f4f4f4; /* body 배경색과 동일하게 설정 */
	    padding: 30px 10px; /* 양옆 여백을 줄이기 위해 padding 조정 */
	    border-radius: 8px;
	    width: 100%; /* 컨테이너의 너비를 100%로 설정 */
	    max-width: 900px; /* 최대 너비를 1200px로 설정 */
	    margin-top: 150px;
	}
	h1 {
	    text-align: center;
	    color: #333;
	    margin-bottom: 30px;
	}
	.form-group {
	    margin-bottom: 20px;
	}
	.form-group label {
	    display: inline-block;
	    width: 50px;
	    margin-right: 10px;
	    font-weight: bold;
	}
	.form-control {
	    width: calc(100% - 65px);
	    padding: 10px;
	    border: 1px solid #ddd;
	    border-radius: 4px;
	    box-sizing: border-box;
	    font-size: 16px;
	}
	
	
	
	
	
	
	/*버튼*/
	.btn-group {
    text-align: center;
    margin-top: 20px;
	}
	.btn {
	    padding: 10px 20px;
	    border: none;
	    border-radius: 4px;
	    cursor: pointer;
	    font-size: 16px;
	    margin: 0 5px;
	}
	.btn-primary {
	    background-color: #0070c9;
	    color: white;
	}
	.btn-danger {
	    background-color: #bdb9b9;
	    color: white;
	}
	.btn-primary:hover, .btn-danger:hover {
	    opacity: 0.9;
	}
	
	</style>
</head>
<body>
<%@ include file="../header.jsp" %>
    <div class="container">
        <h1>답변 작성</h1>
        <form name="answerForm" id="answerForm" method="post" action="/qna/insertAnswer" onsubmit="return answerCheck()">
            <input type="hidden" name="parent_id" value="${parentId}">
            <div class="form-group">
                <label for="q_title">제목</label>
                <input type="text" name="q_title" id="q_title" value="답변입니다." readonly class="form-control">
            </div>
            
            <textarea id="editor" name="q_text"></textarea>
            
            <div class="btn-group">
                <input type="submit" value="저장" class="btn btn-primary">
                <input type="button" value="취소" class="btn btn-danger" onclick="history.back()">
            </div>
        </form>
    </div>
<%@ include file="../footer.jsp" %>
</body>

<script>
$(function(){
    var plugins = [
        "advlist", "autolink", "lists", "link", "image", "charmap", "print", "preview", "anchor",
        "searchreplace", "visualblocks", "code", "fullscreen", "insertdatetime", "media", "table",
        "paste", "code", "help", "wordcount", "save"
    ];
    var edit_toolbar = 'formatselect fontselect fontsizeselect |'
               + ' forecolor backcolor |'
               + ' bold italic underline strikethrough |'
               + ' alignjustify alignleft aligncenter alignright |'
               + ' bullist numlist |'
               + ' table tabledelete |'
               + ' link image';

    tinymce.init({
    	language: "ko_KR", //한글판으로 변경
        selector: '#editor',
        height: 500,
        menubar: false,
        plugins: plugins,
        toolbar: edit_toolbar,
        
        /*** image upload ***/
        image_title: true,
        /* enable automatic uploads of images represented by blob or data URIs*/
        automatic_uploads: true,
        /*
            URL of our upload handler (for more details check: https://www.tiny.cloud/docs/configure/file-image-upload/#images_upload_url)
            images_upload_url: 'postAcceptor.php',
            here we add custom filepicker only to Image dialog
        */
        file_picker_types: 'image',
        /* and here's our custom image picker*/
        file_picker_callback: function (cb, value, meta) {
            var input = document.createElement('input');
            input.setAttribute('type', 'file');
            input.setAttribute('accept', 'image/*');

            /*
            Note: In modern browsers input[type="file"] is functional without
            even adding it to the DOM, but that might not be the case in some older
            or quirky browsers like IE, so you might want to add it to the DOM
            just in case, and visually hide it. And do not forget do remove it
            once you do not need it anymore.
            */
            input.onchange = function () {
                var file = this.files[0];

                var reader = new FileReader();
                reader.onload = function () {
                    /*
                    Note: Now we need to register the blob in TinyMCEs image blob
                    registry. In the next release this part hopefully won't be
                    necessary, as we are looking to handle it internally.
                    */
                    var id = 'blobid' + (new Date()).getTime();
                    var blobCache =  tinymce.activeEditor.editorUpload.blobCache;
                    var base64 = reader.result.split(',')[1];
                    var blobInfo = blobCache.create(id, file, base64);
                    blobCache.add(blobInfo);

                    /* call the callback and populate the Title field with the file name */
                    cb(blobInfo.blobUri(), { title: file.name });
                };
                reader.readAsDataURL(file);
            };
            input.click();
        },
        /*** image upload ***/
        
        content_style: 'body { font-family:Helvetica,Arial,sans-serif; font-size:14px }'
    });


    $("#save").on("click", function(){
        var content = tinymce.activeEditor.getContent();
        console.log(content);
    });
    
});


function answerCheck() {
    var content = tinymce.get("editor").getContent();
    
    if (content.trim() === "") {
        alert("내용을 입력해주세요.");
        return false;
    }
    
    return true;
}
</script>
</html>