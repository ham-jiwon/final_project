<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<section class="content">

<div class="container">

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