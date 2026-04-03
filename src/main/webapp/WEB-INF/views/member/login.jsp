<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<c:if test="${param.fail == 'true' }">
	<script>alert("아이디 또는 비밀번호가 틀렸습니다.")</script>
</c:if>

<form action="<%=path %>/member/loginAction" method = "POST">
	<table class="list">
		<tr >
			<th colspan="2"> 로그인</th> 
		</tr>
		<tr>
			<td>아이디</td>
			<td><input type="text" name="id" placeholder="INSERT ID HERE" data-msg="아이디" autofocus required></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="pass" placeholder="INSERT PW HERE" data-msg="비밀번호" required></td>
		</tr>
		<tr>
			<th colspan="2">
				<button>로그인</button><br><label><input type="checkbox" name="rememberMe">로그인 상태 유지</label>
			</th>
		</tr>
		<tr>
			<th colspan="2">
				<button type="button" onclick="location.href='<%=path%>/member/findPass'">비밀번호 찾기</button>
			</th>
		</tr>
	</table>
</form>
<%@ include file="../common/footer.jsp" %>