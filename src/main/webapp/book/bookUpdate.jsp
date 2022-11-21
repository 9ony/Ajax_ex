<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="ajax.book.* , java.util.*"%>
<jsp:useBean id="bookDto" class="ajax.book.BookDTO" scope="page"/>
<jsp:setProperty property="*" name="bookDto"/>
<%
	//파라미터로 넘어온 값을 bookDto객체에 모두 셋팅
	BookDAO dao=new BookDAO();
	//bean으로 생성
	/* BookDTO book=new BookDTO();
	book.setIsbn(request.getParameter("isbn"));
	book.setTitle(request.getParameter("title"));
	book.setPrice(Integer.parseInt(request.getParameter("price")));
	book.setPublish(request.getParameter("publish")); */
	int n =dao.updateBook(bookDto);
%>
{
	"result":<%=n%>
}