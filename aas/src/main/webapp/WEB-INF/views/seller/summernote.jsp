<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../header.jsp" %>

<script src="../js/summernote/lang/summernote-ko-KR.js"></script>
<script src="../js/summernote/summernote-lite.js"></script>
<link rel="stylesheet" href="../css/summernote/summernote-lite.css">

<script>
  $(document).ready(function() {
    $('#BOARDCONT').summernote({
      height: 300,                 // 에디터 높이
      minHeight: null,             // 최소 높이
      maxHeight: null,             // 최대 높이
      focus: true,                 // 에디터 로딩 후 포커스를 맞출지 여부
      lang: "ko-KR",               // 한글 설정
      placeholder: '최대3000자까지 쓸 수 있습니다', // placeholder 설정
      toolbar: [
        // [groupName, [list of button]]
        ['fontname', ['fontname']],
        ['fontsize', ['fontsize']],
        ['color', ['color']],
        ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
        ['para', ['ul', 'ol', 'paragraph']],
        ['height', ['height']]
      ],
      fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
      fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
      callbacks: {
        onInit: function() {
          $('.note-editable').css('text-align', 'left');
        }
      }
    });
  });
</script>


<div style="font-size: 30px; font-weight: bold; text-align: center;">
  공연 등록
</div><br>

<textarea name="BOARDCONT" id="BOARDCONT" maxlength="10000" cols="30" rows="5" placeholder="내용을 입력해주세요" class="with-border" style="text-align: left;"></textarea>

<%-- <%@ include file="../footer.jsp" %> --%>
