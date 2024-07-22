<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>qnaform</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.tiny.cloud/1/4limsqsr4t2l3p5v338g1nblplu7cdds2zueq39vw7qjcwf9/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
    <link rel="stylesheet" href="/css/template.css">
    <style>
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
            width: 100px;
            margin-right: 10px;
            font-weight: bold;
        }
        .form-control {
            width: calc(100% - 120px);
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
            height: 40px; /* 높이를 40px로 설정 */
    		line-height: 1.2; /* line-height 조정 */
        }
        select.form-control {
		    height: 40px; /* 높이를 40px로 설정 */
		    padding: 8px 12px; /* 패딩을 조정 */
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
        <h1>문의하기</h1>
        <form name="qnaForm" id="qnaForm" method="post" action="/qna/insert" onsubmit="return qnaCheck()">
            <div class="form-group">
                <label for="q_open">공개 여부</label>
                <select name="q_open" id="q_open" class="form-control" required>
                    <option value="1">공개</option>
                    <option value="0">비공개</option>
                </select>
            </div>
            <div class="form-group">
                <label for="subject">제목</label>
                <input type="text" name="q_title" id="q_title" maxlength="100" required class="form-control">
            </div>
            <textarea id="editor" name="q_text"></textarea>
            <div class="btn-group">
                <input type="submit" value="저장" class="btn btn-primary">
                <input type="reset" value="취소" class="btn btn-danger">
            </div>
        </form>
    </div>
    <%@ include file="../footer.jsp" %>
</body>
<script>
    $(function(){
        var plugins = [
            "advlist autolink lists link image charmap print preview anchor",
            "searchreplace visualblocks code fullscreen",
            "insertdatetime media table paste code help wordcount save"
        ];
        var edit_toolbar = 'formatselect fontselect fontsizeselect |'
                        + ' forecolor backcolor |'
                        + ' bold italic underline strikethrough |'
                        + ' alignjustify alignleft aligncenter alignright |'
                        + ' bullist numlist |'
                        + ' table tabledelete |'
                        + ' link image';

        tinymce.init({
            language: "ko_KR",
            selector: '#editor',
            height: 500,
            menubar: false,
            plugins: plugins,
            toolbar: edit_toolbar,
            image_title: true,
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
                        var blobCache = tinymce.activeEditor.editorUpload.blobCache;
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

    function qnaCheck() {
        var title = document.getElementById("q_title").value;
        var content = tinymce.get("editor").getContent();
        if (title.trim() === "") {
            alert("제목을 입력해주세요.");
            return false;
        }
        if (content.trim() === "") {
            alert("내용을 입력해주세요.");
            return false;
        }
        return true;
    }
</script>
</html>