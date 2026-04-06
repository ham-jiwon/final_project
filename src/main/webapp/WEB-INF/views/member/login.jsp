<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<c:if test="${param.fail == 'true' }">
	<script>alert("아이디 또는 비밀번호가 틀렸습니다.")</script>
</c:if>
<c:if test="${param.passChangeSuccess == 'true'}">
	<script>alert("비밀번호 변경이 완료되었습니다.")</script>
</c:if>

<div class="login-box">
	<form action="<%=path %>/member/loginAction" method="POST">
		<table class="list">
			
			<!-- 제목 -->
			<tr class="title-row">
				<th colspan="2">로그인</th> 
			</tr>
			
			<!-- 아이디 -->
			<tr>
				<td>아이디</td>
				<td>
					<input type="text" name="id" placeholder="INSERT ID HERE" data-msg="아이디" autofocus required>
				</td>
			</tr>
			
			<!-- 비밀번호 -->
			<tr>
				<td>비밀번호</td>
				<td>
					<input type="password" name="pass" placeholder="INSERT PW HERE" data-msg="비밀번호" required>
				</td>
			</tr>
			
			<!-- 로그인 버튼 -->
			<tr>
				<td colspan="2" class="center">
					<button type="submit">로그인</button>
				</td>
			</tr>
			
			<!-- 체크박스 -->
			<tr>
				<td colspan="2" class="center">
					<label class="keep-login">
						<input type="checkbox" name="rememberMe">
						로그인 상태 유지
					</label>
				</td>
			</tr>
			
			<!-- 비밀번호 찾기 -->
			<tr>
				<td colspan="2" class="center">
					<button type="button" onclick="location.href='<%=path%>/member/findPass'">
						비밀번호 찾기
					</button>
				</td>
			</tr>
			
		</table>
	</form>
</div>
<%@ include file="../common/footer.jsp" %>