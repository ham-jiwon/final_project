<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			    <button class="btn disabled" disabled title="서비스 준비중입니다">
			        예매하기
			    </button>
			</div>  
		</div>      

        <!-- 정보+줄거리 (오른쪽) -->
        <div class="info">
            <h2>${movie.title}</h2>
            <p>감독: ${movie.director}</p>
            <p>장르: ${movie.genre}</p>
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
    </div>



    

</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>