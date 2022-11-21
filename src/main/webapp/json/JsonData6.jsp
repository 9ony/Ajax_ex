<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" import="net.sf.json.*, ajax.book.* , java.util.*"%>

<%
	BookDAO dao=new BookDAO();
	List<BookDTO> arr=dao.getAllBook();
	
	JSONArray obj=JSONArray.fromObject(arr);
	//fromObject(arr) : static메서드. ArrayList를 JSONArray유형으로 변환해서 반환함
	// dto에 날짜유형하고는 호환이 안됨
	
%>
<%=obj.toString()%>