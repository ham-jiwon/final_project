<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp" %>
<c:if test="${param.removeSuccess == 'true' }">
	<script>alert("회원 탈퇴 완료되었습니다.")</script>
</c:if>
	<section class="main">
	<div class="text-box">
		<h1>지켜보고 있다...</h1>
		<h3>한 남자가 그림자 속에 초자연적인 힘이 숨어 있는 새 집으로 이사합니다. 
		어둠의 존재들이 그를 위협하기 시작하자, 그의 용감한 개가 구출하러 옵니다.</h3>
		<h3>A man moves into a new home that has supernatural forces lurking in the shadows. 
		As dark entities start to threaten him, his brave dog comes to the rescue.</h3>
	</div>
	</section>

<%@ include file="/WEB-INF/views/gridTableNew.jsp" %>

<%@ include file="common/footer.jsp" %>
