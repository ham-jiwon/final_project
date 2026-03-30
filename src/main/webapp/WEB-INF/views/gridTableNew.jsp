<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<section class="content">

<div class="container">

	<div class="movie-grid">
	<c:forEach var="m" items="${list}">
	    <div class="movie-card">
	        <img src="${pageContext.request.contextPath}${m.poster}" />
	        <div class="overlay">
	            <p>영화 줄거리 ${i}</p>
	        </div>
	    </div>
	</c:forEach>
	</div>
	
</div>	
	
</section>