<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<c:if test="${param.fail == 'true'}">
	<script>alert("존재하지 않는 아이디입니다.");</script>
</c:if>
<form action="<%=path %>/member/passCode" method = "GET">
	<table class="list pass-box">
		<tr >
			<th colspan="2">비밀번호 찾기</th> 
		</tr>
		<tr>
			<td colspan="2">
				회원가입 시 등록한 이메일로 인증코드를 보내드립니다. <br>
				아이디 입력 후 전송 버튼을 눌러주세요.				
			</td>
		</tr>
		<tr>
			<td>아이디</td>
			<td><input type="text" name="id" placeholder="INSERT ID HERE" data-msg="아이디" required></td>
		</tr>
		<tr>
			<th colspan="2">
				<button>인증코드 발송</button>
			</th>
		</tr>
	</table>
</form>
<%@ include file="../common/footer.jsp" %>