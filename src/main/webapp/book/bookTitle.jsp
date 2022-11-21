<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.* , ajax.book.* , net.sf.json.*"%>
<% 
	String pub = request.getParameter("publish");
	BookDAO dao = new BookDAO();
	
	List<BookDTO> arr = dao.getTitleList(pub);
	JSONArray jsonArr = JSONArray.fromObject(arr);
%>
<%=jsonArr.toString()%>