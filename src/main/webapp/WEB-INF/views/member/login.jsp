<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<form action="loginAction" method = "POST">
	<table>
		<tr >
			<th colspan="2"> 로그인</th> 
		</tr>
		<tr>
			<td>아이디</td>
			<td><input type="text" name="id" required></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="pass" required></td>
		</tr>
		<tr>
			<th colspan="2">
				<button>로그인</button>
			</th>
		</tr>
		
	</table>
</form>
<%@ include file="../common/footer.jsp" %>