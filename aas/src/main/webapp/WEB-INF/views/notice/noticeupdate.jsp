<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 수정</title>
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
    /* 스타일은 기존과 동일하게 유지 */
    .container {
        background-color: #f4f4f4;
        padding: 30px 10px;
        border-radius: 8px;
        width: 100%;
        max-width: 900px;
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
    <h1>공지사항 수정</h1>
    <form name="bbsfrm" id="bbsfrm" method="post" action="/notice/update" onsubmit="return bbsCheck()">
    <input type="hidden" name="n_id" value="${notice.n_id}">
    <div class="form-group">
        <label for="title">제목</label>
        <input type="text" name="title" id="title" maxlength="100" required class="form-control" value="${notice.title}">
    </div>
    
        <textarea id="editor" name="content">${notice.n_text}</textarea>
        
        <div class="btn-group">
            <input type="submit" value="수정" class="btn btn-primary">
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
        plugins: [
            'advlist autolink lists link image charmap print preview anchor',
            'searchreplace visualblocks code fullscreen',
            'insertdatetime media table paste code help wordcount'
        ],
        toolbar: 'undo redo | formatselect | ' +
        'bold italic backcolor | alignleft aligncenter ' +
        'alignright alignjustify | bullist numlist outdent indent | ' +
        'removeformat | help | image',
        /*** image upload ***/
        image_title: true,
        images_upload_url: '/notice/upload-image',  // 이미지 업로드 처리할 URL
        images_upload_handler: function (blobInfo, success, failure, progress) {
            var xhr, formData;
            xhr = new XMLHttpRequest();
            xhr.withCredentials = false;
            xhr.open('POST', '/notice/upload-image');
            
            xhr.onload = function() {
                var json;
                if (xhr.status !== 200) {
                    failure('HTTP Error: ' + xhr.status);
                    return;
                }
                json = JSON.parse(xhr.responseText);
                if (!json || typeof json.location != 'string') {
                    failure('Invalid JSON: ' + xhr.responseText);
                    return;
                }
                success(json.location);
            };
            
            formData = new FormData();
            formData.append('file', blobInfo.blob(), blobInfo.filename());
            
            xhr.send(formData);
        },
        automatic_uploads: true,
        file_picker_types: 'image',
        file_picker_callback: function (cb, value, meta) {
            var input = document.createElement('input');
            input.setAttribute('type', 'file');
            input.setAttribute('accept', 'image/*');

            input.onchange = function () {
                var file = this.files[0];

                var reader = new FileReader();
                reader.onload = function () {
                    var id = 'blobid' + (new Date()).getTime();
                    var blobCache =  tinymce.activeEditor.editorUpload.blobCache;
                    var base64 = reader.result.split(',')[1];
                    var blobInfo = blobCache.create(id, file, base64);
                    blobCache.add(blobInfo);

                    cb(blobInfo.blobUri(), { title: file.name });
                };
                reader.readAsDataURL(file);
            };
            input.click();
        },
        content_style: 'body { font-family:Helvetica,Arial,sans-serif; font-size:14px }'
    });

    $("#save").on("click", function(){
        var content = tinymce.activeEditor.getContent();
        console.log(content);
    });
    
});
</script>
</html>