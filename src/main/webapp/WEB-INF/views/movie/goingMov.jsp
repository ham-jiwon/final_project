<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<section class="content">
	<div class="text-box2">
		<h3>여기는 상영중인 영화 페이지입니다.</h3>
	</div>
	<div class="movie-grid">
	<c:forEach var="i" begin="1" end="8">
	    <div class="movie-card">
	        <img src="/cinema/resources/img/dog.png" />
	        <div class="overlay">
	            <p>영화 제목 ${i}</p>
	        </div>
	    </div>
	</c:forEach>
	</div>
</section>


<%@ include file="../common/footer.jsp" %>