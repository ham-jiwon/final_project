<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<section class="content">
	<div class="movie-grid">
	<c:forEach var="i" begin="1" end="8">
	    <div class="movie-card">
	        <img src="/cinema/resources/img/movies/cgv/0404/gundam.jpg" />
	        <div class="overlay">
	            <p>영화 줄거리 ${i}</p>
	        </div>
	    </div>
	</c:forEach>
	</div>
</section>