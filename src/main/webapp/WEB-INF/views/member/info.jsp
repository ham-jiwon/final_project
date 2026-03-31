<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<c:if test="${param.passAgainFail == 'true' }">
	<script>alert("비밀번호를 다시 확인해 주세요.")</script>
</c:if>
	<table>
		<tr >
			<th colspan="2">회원정보</th> 
		</tr>
		<tr>
			<td>아이디</td>
			<td><%=loginMember.getId() %></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><%=loginMember.getName() %></td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td><%=loginMember.getNickname() %></td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><%=loginMember.getPhone() %></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><%=loginMember.getEmail() %></td>
		</tr>
		<tr>
			<td>성별</td>
			<td>
				<input type="radio" <%= loginMember.getGender().equals("남성")? "checked" : "disabled" %>/> 남성 
				<input type="radio" <%= loginMember.getGender().equals("여성")? "checked" : "disabled" %>/> 여성
			</td>
		</tr>
		<tr>
			<td>나이</td>
			<td><%=loginMember.getAge() %></td>
		</tr>
		<tr>
			<th colspan="2">
				<a href="<%=path%>/member/passConfirm"><button type="button">정보 수정</button></a>
			</th>
		</tr>
		<tr>
			<th colspan="2">
				<a href="<%=path%>/member/passConfirm?remove=true"><button type="button">회원 탈퇴</button></a>
			</th>
		</tr>
		<tr>
			<th colspan="2">
				<a href="<%=path%>"><button type="button">메인으로</button></a>
			</th>
		</tr>
		
	</table>
<%@ include file="../common/footer.jsp" %>