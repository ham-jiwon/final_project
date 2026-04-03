<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<c:if test="${fail == 'true' }">
	<script>alert("비밀번호가 일치하지 않습니다.")</script>
</c:if>

<form action="<%=path %>/member/passChangeAction" method = "POST">
	<table>
		<tr >
			<th colspan="2">비밀번호 변경</th> 
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="pass" placeholder="INSERT PW HERE" data-msg="비밀번호" required></td>
		</tr>
		<tr>
			<td>비밀번호 확인</td>
			<td><input type="password" name="passAgain" placeholder="INSERT PW HERE AGAIN" data-msg="비밀번호 확인" required></td>
		</tr>
		<tr>
			<th colspan="2">
				<button>비밀번호 변경</button>
			</th>
		</tr>
	</table>
</form>
<%@ include file="../common/footer.jsp" %>