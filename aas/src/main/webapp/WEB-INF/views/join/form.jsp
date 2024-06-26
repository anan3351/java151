<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<body>
    <section class="bg-light">
    <div class="container py-4">
        <div class="row align-items-center justify-content-between">
            <a class="navbar-brand h1 text-center" href="index.do">
                
            </a>
        </div>
    </div>
    <form>
        <div class="form-group">
            <label for="exampleInputEmail1" class="form-label mt-4">아이디</label>
            <input type="text" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
        </div>
        <div class="form-group has-success">
            <label class="form-label mt-4" for="inputValid">비밀번호</label>
            <input type="password" class="form-control is-valid" id="inputValid">
            <div class="valid-feedback"></div>
        </div>
        <div class="form-group has-danger">
            <label class="form-label mt-4" for="inputInvalid">비밀번호 재확인</label>
            <input type="password" class="form-control is-invalid" id="inputInvalid">
        </div>
        <div class="form-group">
            <label for="exampleInputEmail1" class="form-label mt-4">이름</label>
            <input type="text" class="form-control" id="exampleInputEmail1">
        </div>
        <div class="bir_wrap">
            <label class="form-label mt-4">생년월일</label>
        </div>
        <div class="bir_yy">
            <span class="ps_box">
                <input type="text" class="form-control" id="yy" placeholder="년(4자)" maxlength="4">
            </span>
        </div>
        <div class="bir_mm">
            <span class="ps_box focus">
                <select class="form-select" id="mm" id="exampleSelect1">
                    <option>월</option>
                    <option>1</option>
                    <option>2</option>
                    <option>3</option>
                    <option>4</option>
                    <option>5</option>
                    <option>6</option>
                    <option>7</option>
                    <option>8</option>
                    <option>9</option>
                    <option>10</option>
                    <option>11</option>
                    <option>12</option>
                </select>
            </span>
        </div>
        <div class="bir_dd">
            <span class="ps_box">
                <input type="text" class="form-control" id="dd" placeholder="일" maxlength="2">
            </span>
        </div>
        <div class="form-group">
            <label for="exampleSelect1" class="form-label mt-4">성별</label>
            <select class="form-select" id="exampleSelect1">
                <option>남자</option>
                <option>여자</option>
                <option>거북</option>
            </select>
        </div>
        <div class="form-group">
            <label for="exampleInputEmail1" class="form-label mt-4">본인 확인 이메일</label>
            <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="선택입력">
        </div>
        <div class="d-grid gap-2">
            <button class="btn btn-primary btn-lg" type="button">가입하기</button>
        </div>
    </form>
</div>
</section>
</body>
<style>
.bg-light{
  height: 1053px;
  padding-top:55px;
  padding-bottom:75px;
}

.flex-fill.mx-xl-5.mb-2{
  margin: 0 auto;
  width : 700px;
  padding-right: 7rem;
  padding-left: 7rem;
}

.container.py-4{
  margin: 0 auto;
  width : 503px;
}

.d-grid.gap-2{
  padding-top: 30px;
}

.bir_yy,.bir_mm,.bir_dd{
  width:160px;
  display:table-cell;
}

.bir_mm+.bir_dd,.bir_yy+.bir_mm{
  padding-left:10px;
}

</style>



<%@ include file="../footer.jsp" %>