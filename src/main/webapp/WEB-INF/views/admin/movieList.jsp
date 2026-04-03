<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<table class="movie-list" border="1" style="width:100%; text-align:center;">
    <tr>
        <th>번호</th>
        <th>제목</th>
        <th>감독</th>
        <th>장르</th>
        <th>관리</th>
    </tr>

    <c:forEach var="m" items="${list}">
        <tr>
            <td>${m.movie_code}(${m.movie_code == 21})</td>
            <td>${m.title}</td>
            <td>${m.director}</td>
            <td>${m.genre}</td>
            <td>
                <button type="button"
                	    onclick="alert('test'); location.href='${pageContext.request.contextPath}/admin/movieUpdate?movie_code=${m.movie_code}';">
                    수정
                </button>
                <button onclick="deleteMovie(${m.movie_code})">
                    삭제
                </button>
            </td>
        </tr>
    </c:forEach>
</table>

<script>
function deleteMovie(id){
    if(confirm("삭제하시겠습니까?")){
        location.href = "${pageContext.request.contextPath}/admin/movieDelete?movie_code=" + id;
    }
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>