<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section class="main">

<h1>${movie.title}</h1>

<p>감독: ${movie.director}</p>
<p>장르: ${movie.genre}</p>
<p>상영시간: ${movie.running_time}분</p>
<p>연령: ${movie.age_limit}세</p>

<div>
    ${movie.story}
</div>

</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>