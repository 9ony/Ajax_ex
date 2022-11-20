<%@page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8" import="ajax.book.* , java.util.*"%>
<%
	String isbn=request.getParameter("isbn");
	BookDAO dao=new BookDAO();
	BookDTO book=new BookDTO();
	book = dao.getBookInfo(isbn);
%>
<result>
<isbn><%=book.getIsbn()%></isbn>
<title><%=book.getTitle()%></title>
<publish><%=book.getPublish()%></publish>
<price><%=book.getPrice()%></price>
<published><%=book.getPublished()%></published>
<bimage><%=book.getBimage()%></bimage>
</result>