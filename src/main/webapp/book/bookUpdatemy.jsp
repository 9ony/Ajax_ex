<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="ajax.book.* , java.util.*"%>
<%
	BookDAO dao=new BookDAO();
	BookDTO book=new BookDTO();
	book.setIsbn(request.getParameter("isbn"));
	book.setTitle(request.getParameter("title"));
	book.setPrice(Integer.parseInt(request.getParameter("price")));
	book.setPublish(request.getParameter("publish"));
	int n =dao.updateBook(book);
%>
<result>
	<%=n%>
</result>