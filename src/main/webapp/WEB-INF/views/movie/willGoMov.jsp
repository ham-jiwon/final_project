<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
    
<%@ include file="../common/header.jsp" %>
<section class="content">

	<div class="container">
		<div class="text-box2">
			<h3 class="title-line">여기는 상영 예정인 영화 페이지입니다.</h3>
		</div>
		
		<div class="movie-grid">
			<c:forEach var="m" items="${list}">
			    <div class="movie-card">
			    
			        <img 
			            src="${pageContext.request.contextPath}${m.poster}" 
			            onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/img/default.png';"
			        />
			        
			        <div class="overlay"
			        	 onclick="location.href='${pageContext.request.contextPath}/movie/movieDetail?code=${m.movie_code}'"
			        	 style="cursor:pointer;">
			        	<p class="story">
						    ${fn:substring(m.story, 0, 50)}...
						</p>
			            <p class="title">제목 : ${m.title}</p>
			        </div>
			        
			    </div>
			</c:forEach>
			
		</div>		
	</div>
	
</section>

<c:if test="${page eq 'goingMov' or page eq 'willGoMov'}">
<script src="${pageContext.request.contextPath}/resources/js/MovieList.js"></script>
</c:if>
<%@ include file="../common/footer.jsp" %>