<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<section class="content">

<div class="container">

	<div class="movie-grid">
	<c:forEach var="m" items="${list}">
	    <div class="movie-card">
	        <img src="${empty m.poster 
					 ? pageContext.request.contextPath + '/resources/img/default.png' 
					 : pageContext.request.contextPath + m.poster}" 
		     />
	        <div class="overlay">
	            <p>제목 : ${m.title}</p>
	        </div>
	    </div>
	</c:forEach>
	</div>
	
</div>	
	
</section>