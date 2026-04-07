<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="movie-update-wrap">

<h2>영화 등록</h2>

<form action="${pageContext.request.contextPath}/admin/movieRgst" 
      method="post"
      enctype="multipart/form-data">

    제목: <input type="text" name="title"/><br>
    감독: <input type="text" name="director"/><br>
    장르: <input type="text" name="genre"/><br>
    
    개봉일:
    <input type="date" name="release_date"/><br>
    
    줄거리:<br>
    <textarea name="story" rows="5"></textarea><br>
    
    상영시간:
    <input type="number" name="running_time">
    
    현재 포스터:<br>
    <img id="previewImg"
         style="width:100px;"><br>
         
    <span id="noImageText">
    <br><br>(이미지 업로드)<br><br><br><br>
	</span>    
    
    포스터 업로드:<br>
    
    <label class="file-label" for="posterFile">
        파일 선택
    </label>
    <input type="file" id="posterFile" name="posterFile">
    
    <span id="file-name">선택된 파일 없음</span>

    <div class="btn-group">
        <button type="submit">등록</button>
        <button type="button" 
            onclick="location.href='${pageContext.request.contextPath}/admin/movieList'">
            취소
        </button>
    </div>    

</form>

</div>

<script src="${pageContext.request.contextPath}/resources/js/MovieList.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>