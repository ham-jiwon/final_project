<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h2>영화 수정</h2>

<form action="${pageContext.request.contextPath}/admin/movieUpdate" method="post">

    <input type="hidden" name="movie_code" value="${movie.movie_code}"/>

    제목: <input type="text" name="title" value="${movie.title}"/><br>
    감독: <input type="text" name="director" value="${movie.director}"/><br>
    장르: <input type="text" name="genre" value="${movie.genre}"/><br>

    <button type="submit">수정</button>

</form>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>