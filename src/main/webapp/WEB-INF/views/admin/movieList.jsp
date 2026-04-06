<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    
    
<div class="movie-wrap">    
	<table class="movie-list" border="1" style="width:100%; text-align:center;">
		<thead>
		    <tr>
		        <th>No.</th>
		        <th>포스터</th>
		        <th>제목</th>
		        <th>감독</th>
		        <th>장르</th>
		        <th>줄거리</th>
		        <th>관리</th>
		    </tr>
	    </thead>
	    <tbody>
		    <c:forEach var="m" items="${list}">
		        <tr>
		            <td>${m.movie_code}</td>
		            <td>
					    <img 
							src="${pageContext.request.contextPath}${m.poster}" 
					        class="poster-img"
					        onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/img/default.png';">
					</td>
		            <td>
		                ${m.title}
	
					    <c:if test="${loginMember != null && loginMember.id eq 'admin'}">
					        <br><span class="poster-path">(${m.poster})</span>
					    </c:if>
		            </td>
		            <td>${m.director}</td>
		            <td>${m.genre}</td>
		            <td>
					    <button onclick="showStory(this)" data-story="${fn:escapeXml(m.story)}">보기</button>
					</td>
		            <td>
		                <button type="button"
		                	    onclick="location.href='${pageContext.request.contextPath}/admin/movieUpdate?movie_code=${m.movie_code}';">
		                    수정
		                </button>
		                <button onclick="deleteMovie(${m.movie_code})">
		                    삭제
		                </button>
		            </td>
		        </tr>
		    </c:forEach>
		</tbody>
	</table>
</div>

<script>
function deleteMovie(id){
    if(confirm("삭제하시겠습니까?")){
        location.href = "${pageContext.request.contextPath}/admin/movieDelete?movie_code=" + id;
    }
}
</script>

<script src="${pageContext.request.contextPath}/resources/js/MovieList.js"></script>

<div id="storyModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <p id="storyText"></p>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>