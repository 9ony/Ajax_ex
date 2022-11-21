<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
response.setHeader("Pragma","No-cache"); //HTTP 1.0 
response.setDateHeader ("Expires", 0); 
	response.setHeader("Cache-Control","no-cache");
%>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BOOK</title>
<!-- CDN 참조-------------------------------------- -->
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<!-- ------------------------------------------------- -->
<style type="text/css">
	.listbox{
		background:#efefef;
		color:gray;
		border:1px solid gray;
	}
	.blist{
		margin:0;
		padding:5px;
		list-style-type:none;
	}
	img{
		display:block;
		width:100%;
		height:auto;
	}
</style>


<script type="text/javascript">
	//jQuery의 $.ajax()함수를 이용해서 ajax 요청을 해보자
	/*
		$.ajax({
			type:'get', //요청방식
			url:'서버페이지', //요청보낼 서버페이지 url ~.jsp
			cache:false, //캐시사용안함
			dataType:'xml', //응답유형
			success:function(res){ //성공적으로 수행 됬을때
				
			},
			error:function(err){ //에러발생시
				
			}
		})
	*/
	// 출판사데이터들을 가져와서 showSelect 함수 인자로 넘겨줌
	function getPublish(){
		$.ajax({
			type:'get',
			url:'bookPublish.jsp',
			cache:false,
			dataType:'json'
		})
		.done(function(res){
			//alert(JSON.stringify(res))
			showSelect(res);
		})
		.fail(function(err){
			alert('error: '+err.status)
			
		})
	}//----------------------
	//출판사 목록을 옵션에 넣어주고 선택된 출판사를 getTitleByPub 인자로 넘겨줌
	function showSelect(data){
		let str='<select name="publish" onchange="getTitleByPub(this.value)">';
			str+='<option value"">:::출판사 목록:::</option>';
			$.each(data, function(i,pub){
				str+='<option value="'+pub.publish+'">'+pub.publish+"</option>";
			})
			str+='</select>';
		$('#sel').html(str);
	}//---------------------
	//출판사명에 해당하는 책들을 옵션에 할당해주고 선택된 책을 bookInfo함수 인자로 넘겨준다.
	function showSelect2(data){
		let str='<select name="publishTitle" onchange="bookInfo(this.value)">';
			str+='<option value"">:::도서명:::</option>';
			$.each(data, function(i,book){
				str+='<option value="'+book.title+'">'+book.title+"</option>";
			})
			str+='</select>';
		$('#sel2').html(str);
	}//---------------------
	//출판사명으로 검색하는 함수
	function getTitleByPub(val){
		alert(val);
		$.ajax({
			type:'get',
			//encodeURIComponent() 자바스크립트함수 get으로오는 한글을 인코딩처리해줌
			url:'bookTitle.jsp?publish='+encodeURIComponent(val),
			dataType:'json',
			cache:false,
			success:function(res){
				showSelect2(res);
			},
			error:function(err){
				alert('error :'+err.status)
			}
		})
	}//--------------------
	function bookInfo(vtitle){
		if(vtitle=="검색"){ //검색버튼이라면
			vtitle=$('#books').val(); //검색어 가져오기
			//vtitle을 가져온 검색어로 바꿔준다
		}//if------------
		$.ajax({
			type:'get',
			url:'bookAll.jsp?title='+encodeURIComponent(vtitle),
			cache:false,
			dataType:'html'
		}).done(function(res){
			$('#book_data').html(res);
		}).fail(function(err){
			alert('err: '+err.status)
		})
	}
	
	/* db에 책 가져오기 */
	function getAllBook(){
		//alert('a')
		$.ajax({
			type:'GET',
			url:'bookAll.jsp',
			cache:false,
			dataType:'html',
			success:function(res){
				//alert(res);
				$('#book_data').html(res);
			},
			error:function(err){
				alert('error:'+err.status());
			}
		})
	}
	/*
		ajax요청 보내기
		get방식으로
		?isbn=visbn
		bookDelete.jsp로 
		응답유형: xml
		
		bookDelete.jsp에서는 BookDAO생성해서
		메서드 호출
		int deleteBook(isbn)==>delete문을 수행
		
		결과값이 0보다 크면
		getAllBook()호출
	*/
	function goDel(visbn){
		$.ajax({
				type:'GET',
				url:'bookDelete.jsp?isbn='+visbn,
				cache:false,
				dataType:'xml',
				success:function(res){
					//alert(res);
					let n = $(res).find('result').text();//string
					if(parseInt(n)>0){
						alert("삭제완료");
						getAllBook();
					}
					else {
						alert("삭제실패");
					}
				},
				error:function(err){
					alert('error:'+err.status());
				}
			})
		}
	/*
	get방식으로
	bookInfo.jsp요청 보내기
	?isbn=visbn
	응답유형: xml
	
	bookInfo.jsp에서 BookDAO생성해서 getBookInfo(isbn)호출하기
	
	그 결과 xml형태로 출력하기

	*/
	//실습
	function goMyEdit(visbn){
		$.ajax({
			type:'GET',
			url:'bookInfomy.jsp?isbn='+visbn,
			cache:false,
			dataType:'xml',
			success:function(res){
				let isbn=$(res).find("isbn").text();
				let title=$(res).find("title").text();
				let publish=$(res).find("publish").text();
				let price=$(res).find("price").text();
				let published=$(res).find("published").text();
				let bimage=$(res).find("bimage").text();
				//alert(isbn+"/"+title+"/"+publish+"/"+price+"/"+published+"/"+bimage); //잘오나확인
				$('#isbn').val(isbn);
				$('#title').val(title);
				$('#publish').val(publish);
				$('#price').val(price);
				$('#published').val(published);
				$('#bimage').html("<img src=images/"+bimage+">");
			},
			error:function(err){
				alert('error:'+err.status());
			}
		})
	}
	//json으로 실습
	function goEdit(visbn){
		//alert(visbn);
		$.ajax({
			type:'post',
			url:'bookInfo.jsp',
			data:"isbn="+visbn, //post방식일때 전송할 파라미터 데이터는 data속성값으로 넣어준다.
			dataType:'json', //응답유형을 json
			cache:false,
			success:function(res){
				//alert(JSON.stringify(res));//[Object object]
				let vtitle=res.title;
				let vpublish=res.publish;
				let vpubdate=res.published;
				let vprice=res.price;
				let vimage=res.bimage;
				//alert(vtitle)
				$('#isbn').val(visbn);
				$('#title').val(vtitle);
				$('#publish').val(vpublish);
				$('#published').val(vpubdate);
				$('#price').val(vprice);
				let str="<img src='./images/"+vimage+"'>";
				$('#bimage').html(str);				
			},
			error:function(err){
				alert('error: '+err.status);
			}
		})
	}//-----------------------
	/*post방식으로 수정할 데이터 보내기
	bookUpdate.jsp로
	data 속성값으로 수정할 값을 파라미터 데이터로 만들어 보내야 한다.
	*/
	function goMyEditEnd(){
		/* let visbn = $('#isbn').val();
		let title = $('#title').val();
		let publish = $('#publish').val();
		let price = $('#price').val();
		alert(isbn+"/"+title+"/"+publish+"/"+price); */
		let param = $('#editF').serialize();
		$.ajax({
			type:'post',
			url:'bookUpdatemy.jsp',
			data: param,
			cache:false,
			dataType:'xml',
			success:function(res){
				let n=$(res).find("result").text();
				if(parseInt(n)>0){
					alert("수정완료"); //check
					getAllBook();
				}
			},
			error:function(err){
				alert('errer : '+err.status);
			}
		}) 
	}//----------
	function goEditEnd(){
		let param = $('#editF').serialize();
		$.ajax({
			type:'post',
			url:'bookUpdate.jsp',
			data: param,
			cache:false,
			dataType:'json',
		}).done(function(res){ //succes일 때 수행하는 콜백함수
				let n=res.result;
				if(parseInt(n)>0){
					alert("수정완료"); //check
					getAllBook();
				}
		}).fail(function(err){ //error일 때 수행하는 콜백함수
			alert('errer : '+err.status);
		})
	}//------------
	//자동검색 함수
	function autoComp(val){
		console.log(val);
		$.ajax({
			type:'get',
			url:'autoComplete.jsp?title='+encodeURIComponent(val),
			dataType:'html',
			cache:false
			}).done(function(res){ //succes일 때 수행하는 콜백함수
					//alert(res)
					$('#lst2').html(res);
					$('#lst1').show();
					$('#lst2').show();
			}).fail(function(err){ //error일 때 수행하는 콜백함수
					alert('errer : '+err.status);
			})
	}
	
	function setting(vtitle){
		// alert(vtitle); 
		$('#books').val(vtitle);
		$('#lst1').hide();
		$('#lst2').hide();
	} 
	
	$(function(){ //창이 로드됬을때 목록을 띄워준다
		getAllBook();
	})
</script>
</head>
<!--onload시 출판사 목록 가져오기  -->
<body onload="getPublish()">
   <div class="container">
	<h2 id="msg">서적 정보 페이지</h2>
<form name="findF" id="findF" role="form"
 action="" method="POST">
<div class="form-group">
<label for="sel" class="control-label col-sm-2">출판사</label>
<span id="sel"></span>
<span id="sel2"></span>
</div>
<p>
<div class='form-group'>
	<label for="books" class="control-label col-sm-2" id="msg1">도서검색</label>
	<div class="col-sm-6">
	<input type="text" name="books" id="books"
	 onkeyup="autoComp(this.value)"
	 class="form-control" >
	 <!-- ---------------------------- -->
	 <div id="lst1" class="listbox"
	  style="display:none">
	 	<div id="lst2" class="blist"
	 	 style="display:none">
	 	</div>
	 </div>
	 <!-- ---------------------------- -->
	</div>
</div>
</form>
<div>
 
 <button type="button"
  onclick="bookInfo('검색')"
  class="btn btn-primary">검색</button>
 
 <button type="button" onclick="getAllBook()" class="btn btn-success">모두보기</button>
 <button type="button" id="openBtn"
  class="btn btn-info">OPEN API에서 검색</button><br><br>
</div>
<div id="localBook">

<table class="table table-bordered" border="1" style="margin:0,padding:0">
	<tr class="info">
		<td style="width:20%;">서명</td>
		<td style="width:20%;">출판사</td>
		<td style="width:20%;">가격</td>
		<td style="width:20%;">출판일</td>
		<td style="width:20%;">편집</td>
	</tr>
</table>
<!-- ----------------------- -->
<div id="book_data"></div>
<!-- ----------------------- -->
<form id="editF" name="editF">
<table id="book_info" class="table table-hover" border="2">
	<tr>
		<td width="20%">ISBN코드</td>
		<td>
		<input type="text" name="isbn" id="isbn"
		class="form-control" readonly>
		</td>
		<td rowspan="6" width="30%" id="bimage" class="text-center"></td>
	</tr>
	<tr>
		<td>서명</td>
		<td>
		<input type="text" name="title" id="title"
		class="form-control">
		</td>
		
	</tr>
	<tr>
		
		<td>출판사</td>
		<td>
		<input type="text" name="publish" id="publish"
		class="form-control">
		</td>
		
	
	</tr>
	<tr>
	
		<td>가격</td>
		<td>
		<input type="text" name="price" id="price"
		class="form-control">
		</td>
		
	</tr>
	<tr>
	
		<td>출판일</td>
		<td>
		<input type="text" name="published"
		 id="published"  disabled
		class="form-control">
		</td>
		
	</tr>
	<tr>
		<td colspan="2">
		<button type="button"
		onclick="goEditEnd()" class="btn btn-danger">갱신</button></td>
	</tr>
</table>
</form>
	</div>
</div><!-- #localBook end -->

<!-- ------------------------------- -->
<div id="openApiBook">

</div>
	
</body>
</html>

<!-- https://apis.daum.net/search/book -->
<!-- 53c73f32f6c4150ca5aa184ba6250d8e -->

<!-- https://apis.daum.net/search/book?apikey=53c73f32f6c4150ca5aa184ba6250d8e&q=다음카카오&output=json -->




