<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<section class="content">

<div class="container">

	<div class="movie-grid">
	<c:forEach var="m" items="${list}">
	    <div class="movie-card">
	    
	    	<c:choose>
	    
	            <!-- poster 없을 때 -->
	            <c:when test="${empty m.poster}">
	            	<img src="${pageContext.request.contextPath}/resources/img/default.png" />
	            </c:when>
	
	            <!-- null 아닐 때만 검사 -->
	            <c:when test="${not empty m.poster and fn:startsWith(m.poster, '/resources')}">
	            	<img src="${pageContext.request.contextPath}${m.poster}" />
	            </c:when>
	
	            <!-- 파일명만 있을 때 -->
	            <c:otherwise>
	            	<img src="${pageContext.request.contextPath}/resources/img/movies/${m.poster}" />
	            </c:otherwise>

            </c:choose>
	        <div class="overlay">
	            <p>제목 : ${m.title}</p>
	        </div>
	        
	    </div>
	</c:forEach>
	</div>
	
</div>	
	
</section>