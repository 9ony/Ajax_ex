<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="ajax.book.* ,net.sf.json.*,java.util.*"%>
<%
	BookDAO dao=new BookDAO();
	List<BookDTO> arr = dao.getPublishList();
	JSONArray jsonArr = JSONArray.fromObject(arr);
	
%>  
<%=jsonArr.toString()%>