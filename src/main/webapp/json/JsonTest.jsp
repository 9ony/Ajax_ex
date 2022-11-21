<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- CDN 참조-------------------------------------- -->
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<!-- ------------------------------------------------- -->
<script>
	//응답이 배열 => 배열이용
	//$.each(배열, function(index,obj){ .... }) : jQuery함수 , 
	// 배열의 요소만큼 반복문 돌면서 배열에 저장된 요소를 obj에 할당한다.
	//
	function showList(data){
		let str='<table class="table">';
				$.each(data,function(i,book){ //jQuery each로 반복함
					//alert(i+": "+book.title);
					//published가 dto timestamp객체로 받아서 object로 반환된다.
					//객체를 date로 스트링으로 받아줌 
					let date=(book.published.year+1900)+"-"+(book.published.month+1)+"-"+book.published.data;
					str+='<tr>';
					str+='<td><img src="../book/images/'+book.bimage+'">';					
				    str+='<td>'+book.isbn+'</td>';
				    str+='<td>'+book.title+'</td>';
				    str+='<td>'+book.price+'</td>';
				    str+='<td>'+book.publish+'</td>';
				    str+='<td>'+date+'</td>';
				    str+='</tr>';
				})
				/* for(var i=0; i<data.length; i++){ //for문으로 반복함
					str+='<tr>';
					str+='<td><img src="../book/images/'+data[i].bimage+'">';					
				    str+='<td>'+data[i].isbn+'</td>';
				    str+='<td>'+data[i].title+'</td>';
				    str+='<td>'+data[i].price+'</td>';
				    str+='<td>'+data[i].publish+'</td>';
				    str+='<td>'+data[i].published+'</td>';
				    str+='</td>';
				} */
			str+='</table>';
			$('#msg').html(str);
	}
	//응답이 단일 객체로
	function showData(data){
		let str='<table class="table">';
		   str+='<tr>';
		   str+='<td>도서명</td><td>';
		   str+=data.title;
		   str+='</td>';
		   
		   str+='<tr>';
		   str+='<td>출판사</td><td>';
		   str+=data.publish;
		   str+='</td>';
		   
		   str+='<tr>';
		   str+='<td>가격</td><td>';
		   str+=data.price;
		   str+='</td>';
		   
		   str+='<tr>';
		   str+='<td>출판일</td><td>';
		   str+=data.published;
		   str+='</td>';
		   
		   str+='<tr>';
		   str+='<td>도서이미지</td><td>';
		   str+='<img src="../book/images/'+data.bimage+'">';
		   str+='</td>';
		   str+='</table>';
		   $('#msg').html(str);
	}
	//--------------------------------
	$(function(){
		
		
		$('#bt6').on('click',function(){
			$.ajax({
				type:'get',
				url:'JsonData6.jsp',
				dataType:'json',
				cache:false,
				success:function(res){
					showList(res);
				},
				error:function(res){
					alert('error: '+ err.status)
				}
			})
		})//#bt6------------
		
		$('#bt5').on('click',function(){
			$.ajax({
				type:'get',
				url:'JsonData5.jsp',
				dataType:'json',
				cache:false,
				success:function(res){
					showData(res);
				},
				error:function(res){
					alert('error: '+ err.status)
				}
			})
		})//#bt5------------
		
		$('#bt4').on('click',function(){
			$.ajax({
				type:'get',
				url:'JsonData4.jsp',
				dataType:'json',
				cache:false,
				success:function(res){
					showList(res.books);
				},
				error:function(res){
					alert('error: '+ err.status)
				}
			})
		})//#bt4------------
		
		$('#bt3').on('click',function(){
			$.ajax({
				type:'get',
				url:'JsonData3.jsp',
				dataType:'json',
				cache:false,
				success:function(res){
					showList(res.books);
				},
				error:function(res){
					alert('error: '+ err.status)
				}
			})
		})//#bt3------------
		
		$('#bt2').on('click',function(){
			$.ajax({
				type:'get',
				url:'JsonData2.jsp',
				dataType:'json',
				cache:false,
				success:function(res){
					//alert(res);
					showList(res);
				},
				error:function(res){
					alert('error: '+ err.status)
				}
			})
		})//#bt2------------
		
		$('#bt1').on('click',function(){
			$.ajax({
				type:'get',
				url:'JsonData.jsp',
				//dataType:'json',
				dataType:'text',
				cache:false,
				success:function(res){
					//alert(res);
					let obj=JSON.parse(res); // json형식의 텍스트 문자열을 파싱해서 json객체로 만들어서 반환해준다.
					// JSON.parse(인자:문자열) 객체로바꿔줌 <===> JSON.stringify(인자:객체) 문자열로 바꿔줌
					showData(obj);
				},
				error:function(res){
					alert('error: '+ err.status+", "+res.responseText) //res.responseText 에러떳을때 html표시
				}
			})
		})//#bt1------------
	})
</script>
<div class="container">
	<h1>JSON형태로 데이터를 받아봅시다</h1>
	<h2>JSON이란? - JavaScript Object Notation</h2>
	<h2>자바스크립트에서 이용하는 객체 형태로 데이터를 표현하는 방식</h2>
	<h3>JSON객체에는 문자열,숫자,배열,boolean,null 값만 들어갈 수 있다.</h3>
	   <button id="bt1" class="btn btn-primary">JSON형태로 받기1</button>
	   <button id="bt2" class="btn btn-danger">JSON형태로 받기2</button>
	   <button id="bt3" class="btn btn-success">JSON형태로 받기3</button>
	   <button id="bt4" class="btn btn-info">JSON형태로 받기4-DB에서 가져오기</button>
	   <br><br>
	   <button id="bt5" class="btn btn-warning">JSON형태로 받기5-라이브러리 사용하기</button>
	   <button id="bt6" class="btn btn-default">JSON형태로 받기6-라이브러리 사용하기</button>
	   <button id="bt7" class="btn btn-link">Naver OpenApi에서 도서정보 받아오기</button>
	<hr color='red'>
	<div id="msg" style="margin-top:20px">
		
	</div>
</div>