<%@ include file="../common/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<table>
		<tr>
			<th colspan="8"><h1>회원 목록</h1></th>
		</tr>
		<tr>
			<th>회원 번호</th>
			<th>아이디</th>
			<th>이름</th>
			<th>닉네임</th>
			<th>전화번호</th>
			<th>이메일</th>
			<th>성별</th>
			<th>나이</th>
		</tr>
		<c:forEach var="member" items="${memberList}">
			<tr>
				<td>${member.num}</td>
				<td>${member.id}</td>
				<td>${member.name}</td>
				<td>${member.nickname}</td>
				<td>${member.phone}</td>
				<td>${member.email}</td>
				<td>${member.gender}</td>
				<td>${member.age}</td>
			</tr>
		</c:forEach>
	</table>
<%@ include file="../common/footer.jsp" %>