<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<section class="content">

<div class="container">
<%-- db연동 확인용 제목 나열 코드
	<c:forEach var="m" items="${list}">
    <p>${m.title}</p>
	</c:forEach>
 --%>
	<div class="movie-grid">
	<c:forEach var="m" items="${list}">
	    <div class="movie-card">
	        <img src="${pageContext.request.contextPath}/resources/img/default.png" />
	        <div class="overlay">
	            <p>제목 : ${m.title}</p>
	        </div>
	    </div>
	</c:forEach>
	</div>
	
</div>	
	
</section>