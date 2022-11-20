<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1"> <!--모바일 반응형 지원 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>pizza2.jsp</title>
<!--CDN 참조  -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<style type="text/css">
	/* body,h2{
		font-family:돋움,돋움체,verdana;
		color:navy;
	} */
</style>
<!-- type="text/javascript" -->
<script>
	let req=false;//전역변수
	const init=function(){
		//Ajax요청을 보내기 위해서 반드시 필요한 객체- XMLHttpRequest객체
		//이 객체를 얻는 방법이 브라우저마다 조금씩 다르다
		try{
			req=new XMLHttpRequest();
			//alert(req);
		}catch(e){
			try{
			//IE 옛버전인 경우
			req=new ActiveXObject("Msxml2.XMLHTTP"); //ie일경우
			}catch(e2){
				req=false;
			}
		}
		if(!req){
			alert('req객체 생성 실패')
		}
	}//init-----------
	const getUserInfo=function(){
		//사용자가 입력한 연락처 값을 알아내자.
		let phone=$('#phone').val();
		//alert(phone);
		//서버쪽에 고객의 연락처 정보를 파라미터로 전달해보자.
		
		//[1]
		req.open('GET','pizzaResult2.jsp?phone='+phone,true);
		//open(요청방식,url,비동기여부) ==> 요청을 보낼 준비를 하는 메서드
		
		//[2] send()를 호출하기 전에 onreadystatechange 속성값에 콜백함수를 지정해야 한다.
		req.onreadystatechange=UpdatePage;
		//[3] 요청을 전송한다.
		req.send(null);
		//get방식 요청일 경우 null을 매개변수로 전달하고
		//post방식 요청일 경우 파라미터 데이터("phone=111&userid=aaa")를 매개변수로 넣어준다
	}//--------------
	
	const UpdatePage=function(){
		//alert(req.readyState+"/"+req.status);
		if(req.readyState==4 && req.status==200){
			//성공적인 응답이 왔다면 ==> 응답 데이터를 받아보자
			let res=req.responseXML;
			//alert(res); //XMLDocument객체로 반환된다. ===> 이문서를 파싱후 필요한 데이터 추출
			//응답유형이 text형식이면 responseText로 받고
			//			xml형식이면 responseXML로 받는다.
			//'#' 구분자를 기준으로 쪼개어 배열에 할당
			//let tokens=res.split('#');
			//let num=tokens[0]; //회원번호
			
			
			//xml파싱
			let num=$(res).find("idx").text(); // ==> getter $(res).find("키값").text(); 키값안 text가져옴
			let name=$(res).find("name").text();
			let addr=$(res).find("addr").text();
			let type=$(res).find("addr").attr("type"); //attr(type) ==> 속성명을 가져옴
			//alert(type); //addr type= m1 출력
			
			if(parseInt(num)==0){
				//배달할 주소 입력 폼을 보여주자
				$('#nonUser').show(1000);
				$('#userInfo').html("").hide(1000);
				$('#addr').focus();
			}else{
				//회원인 경우 => 회원정보 보여주기
				//`` << 백틱 사용
				let str=`<ul class='list-group'>
						<li class='list-group-item list-group-item-success'>`+num+`</li>
						<li class='list-group-item list-group-item-info'>`+name+`</li>
						<li class='list-group-item list-group-item-danger'>`+addr+`</li>
						</ul>
				`
				$('#userInfo').html(str).show(1000);
				$('#nonUser').hide(1000);
				$('#addr').val("");
				
			}
			//alert(res);
			//$('#userInfo').html("<h3 class='text-primary'>"+res+"</h3>");
		}
	
	}
	
	window.onload=init;//창이켜질때 init실행
</script>

</head>
<body>
<div class="section">
<div class="container">
	<h1>Pizza Order Page</h1>
	<form role="form" class="form-horizontal" 
	name="orderF" id="orderF"
	 action="order.jsp" method="POST">
		<div class="form-group">
			<p class="text-info">
			<b>귀하의 전화번호를 입력하세요:</b>
			<input type="text" size="20" name="phone" id="phone" onchange="getUserInfo()" class="form-control"/>
			</p>
			<p class="text-danger">
			<b>
				귀하가 주문하신 피자는 아래 주소로 배달됩니다.
			</b>	
			</p>
			<div id="userInfo"></div>
			
			<div id="address"></div>
			<!-- 비회원 입력 폼 : 비회원일 경우 주소입력 폼을 보여주자.-->
			<div id="nonUser" style="display:none;">
				주소: <input type="text" name="addr" id="addr"
						size="60" style="border:2px solid maroon;" class="form-control"/>
			</div>
			<!-- ------------------------------------------- -->
			<p class="text-info">
			<b>주문 내역을 아래에 기입하세요</b></p>
			<p>
				<textarea name="orderList"
				 id="orderList" rows="6" cols="50" class="form-control"></textarea>
			</p>
			<p>
				<input type="submit" value="Order Pizza" class="btn btn-primary"/>
			</p>
		</div>
	</form>
</div>
</div> 
</body>
</html>




