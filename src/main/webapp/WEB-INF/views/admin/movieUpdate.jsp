<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
    
<fmt:formatDate value="${movie.release_date}" pattern="yyyy-MM-dd" var="formattedDate"/>

<div class="movie-update-wrap">

<h2>영화 수정</h2>

<form action="${pageContext.request.contextPath}/admin/movieUpdate" 
	  method="post"
	  enctype="multipart/form-data">

    <input type="hidden" name="movie_code" value="${movie.movie_code}"/>
    <input type="hidden" name="oldPoster" value="${movie.poster}"/>

    제목: <input type="text" name="title" value="${movie.title}"/><br>
    감독: <input type="text" name="director" value="${movie.director}"/><br>
    장르: <input type="text" name="genre" value="${movie.genre}"/><br>
    
    개봉일: <input type="date" name="release_date" 
       value="${formattedDate}" />
    
    줄거리:<br>
    <textarea name="story" rows="5">${movie.story}</textarea><br>
    
    현재 포스터:<br>
    <img id="previewImg"
    	 data-original="${pageContext.request.contextPath}${movie.poster}"
    	 src="${pageContext.request.contextPath}${movie.poster}" 
         style="width:100px;"><br>
                 
    포스터 변경:<br>
    
    <label class="file-label" for="posterFile">
    	파일 선택
   	</label>
    <input type="file" id="posterFile" name="posterFile">
    
    <span id="file-name">선택된 파일 없음</span>

	<div class="btn-group">
    <button type="submit">수정</button>
	<button type="button" onclick="location.href='${pageContext.request.contextPath}/admin/movieList'">
	    취소
	</button>
	</div>    

</form>

</div>

<script src="${pageContext.request.contextPath}/resources/js/MovieList.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>