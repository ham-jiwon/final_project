<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section class="container">

    <div class="detail-top">
        <!-- 포스터 (왼쪽) -->
        <div class="poster">
            <img src="${pageContext.request.contextPath}${movie.poster}"
                 onerror="this.src='${pageContext.request.contextPath}/resources/img/default.png'"/>
        
        
			<div class="btn-area">
			    <!-- 목록으로 -->
			    <a href="${pageContext.request.contextPath}/movie/goingMov" class="btn">
			        목록으로
			    </a>
			
			    <!-- 예매하기 (비활성) -->
			    <a href="/cinema/theater/bookingByMovie?movie_code=${movie.movie_code}">
				    <button>
				        예매하기
				    </button>
				</a>
			</div>  
		</div>      

        <!-- 정보+줄거리 (오른쪽) -->
        <div class="info">
            <h2>${movie.title}</h2>
            <p>감독: ${movie.director}</p>
            <p>장르: ${movie.genre}</p>
			<p>
			개봉일 :
			<fmt:formatDate value="${movie.release_date}" pattern="yyyy-MM-dd"/>
			</p>            
            <p>상영시간: ${movie.running_time}분</p>
            <p>
            연령: 
			<c:choose>
			    <c:when test="${movie.age_limit == 0}">
			        전체이용가
			    </c:when>
			    <c:otherwise>
			        ${movie.age_limit}세
			    </c:otherwise>
			</c:choose>
            </p>
            <p>줄거리</p>
	        <!-- 줄거리 -->
		    <div class="story story-box">
		        ${movie.story}
		    </div>
        </div>

    </div><!-- end detail-top -->
    
	<div class="rating-summary">
	
	    <!-- 왼쪽: 평균 -->
	    <div class="rating-left">
	        <h1><fmt:formatNumber value="${avgRating}" pattern="0.0"/></h1>
	
	        <div class="stars-bottom">
	            <c:forEach begin="1" end="5" var="i">
	                <c:choose>
	                    <c:when test="${i <= avgRating}">
	                        ★
	                    </c:when>
	                    <c:otherwise>
	                        ☆
	                    </c:otherwise>
	                </c:choose>
	            </c:forEach>
	        </div>
	
	        <p>${ratingCount}명 평가</p>
	    </div>
	
	    <!-- 오른쪽: 막대 -->
	    <div class="rating-right">
	    	    
			<c:forEach begin="1" end="5" var="score">
							        
				<!-- 역순 score => jsp 버전에 따라 적용 불가 -->
				<%-- <c:set var="score" value="${6 - i}" /> --%>
				
				<!-- 개수 -->
			    <c:set var="count" value="${ratingMap[score]}" />
			    <c:if test="${empty count}">
				    <c:set var="count" value="0" />
				</c:if>
			    
			    <!-- 퍼센트 -->
			    <c:set var="percent" value="0"/>	    	
			    <c:if test="${ratingCount > 0}">
			        <c:set var="percent" value="${(count * 100.0) / ratingCount}"/>
			    </c:if>			    
			
				<%-- 디버깅 확인용 코드
				${score} → ${ratingMap[score]} 
				--%>
			
				<!-- 출력 -->
				
			    <div class="bar">
			        <span>${score}</span>
			
			        <div class="progress">
			            <div class="fill" data-width="${percent}%"></div> <%-- <div class="fill" style="width:${percent}%"> --%>
			        </div>
			    </div>
			
			</c:forEach>
	
	    </div>
	
	</div><!-- end rating-summary -->    

    <div>
    	<jsp:include page="movieComment.jsp" />
    </div>

    

</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>