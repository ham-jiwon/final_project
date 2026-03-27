<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<section class="main2">
	<div class="text-box2">
		<h3>여기는 상영중인 영화 페이지입니다.</h3>
		<c:forEach var="m" items="${list}">
		    ${m.title} <br>
		    ${m.director} <br>
		    ------------------<br>
		</c:forEach>
	</div>
</section>

<%@ include file="../common/footer.jsp" %>