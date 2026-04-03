<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<c:if test="${param.fail == 'true'}">
	<script>alert("코드를 다시 확인해 주세요.");</script>
</c:if>
<form action="<%=path %>/member/passChange" method = "POST">
	<table>
		<tr >
			<th colspan="2">인증코드 입력</th> 
		</tr>
		<tr>
			<td colspan="2">
				발송된 메일의 인증코드를 입력해 주세요.
			</td>
		</tr>
		<tr>
			<td>인증코드</td>
			<td><input type="text" name="userCode" placeholder="INSERT CODE HERE" data-msg="인증코드" required></td>
		</tr>
		<tr>
			<th colspan="2">
				<button>인증코드 확인</button>
			</th>
		</tr>
	</table>
</form>
<%@ include file="../common/footer.jsp" %>