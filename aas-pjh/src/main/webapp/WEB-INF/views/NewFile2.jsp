<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <style>
  	
    /* Remove the navbar's default margin-bottom and rounded borders */ 
    .navbar {
      margin-bottom: 0;
      border-radius: 0;
      background-color: #ffffff;
    }
    
    /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    .row.content {height: 450px}
    
    /* Set gray background color and 100% height */
    .sidenav {
      padding-top: 20px;
      background-color: #f1f1f1;
      height: 100%;
    }
    
    /* Set black background color, white text and some padding */
    footer {
      background-color: #555;
      color: white;
      padding: 15px;
    }
    
    .centerBox {
    	width: 450;
    	margin-left: auto;
    	margin-right: auto;
    }
    

    
    /* On small screens, set height to 'auto' for sidenav and grid */
    @media screen and (max-width: 767px) {
      .sidenav {
        height: auto;
        padding: 15px;
      }
      .row.content {height:auto;} 
    }
  </style>
</head>
<body>


<div class="container-fluid">
  <div class="row">
	<img alt="poster1" src="./images/logo.png" style="display:inline; height: auto;" >&nbsp;&nbsp;&nbsp;
	<input type="text" class="centerBox"> <input type="button" value="검색">&nbsp;&nbsp;&nbsp;
	<a href="#">로그인</a>&nbsp;&nbsp;&nbsp;
	<a href="#">회원가입</a>&nbsp;&nbsp;&nbsp;
	<a href="#">마이페이지</a>
  </div>
</div>

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">Logo</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="#">Home</a></li>
        <li><a href="#">About</a></li>
        <li><a href="#">Projects</a></li>
        <li><a href="#">Contact</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container-fluid text-center" style="height: 70vh; overflow-y: auto;">
	<div class="row content" style="text-align: center;">
    	<div class="col-sm-1 sidenav" style="height: 70vh; overflow-y: auto;">
	      <p><a href="#">Link</a></p>
	      <p><a href="#">Link</a></p>
	      <p><a href="#">Link</a></p>
	    </div>
	    <div class="col-sm-8 text-left"> 
	      <div style="font-size: 24px; font-weight: bold;">
	             인기 공연
			</div>
	
		<div>
			<img alt="poster1" src="./images/android.jpg" style="display:inline; width: 20%; height: auto;" >
	        <img alt="poster1" src="./images/android.jpg" style="display:inline; width: 20%; height: auto;" >
	        <img alt="poster1" src="./images/android.jpg" style="display:inline; width: 20%; height: auto;" >
	      	<img alt="poster1" src="./images/android.jpg" style="display:inline; width: 20%; height: auto;" >
		</div>
	    <hr>
		<h3>Test</h3>
	    <p>Lorem ipsum...</p>
	</div>
  </div>
</div>

<footer class="container-fluid text-center" style="height:100px">
  <p>Footer Text</p>
</footer>

</body>
</html>

