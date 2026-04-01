<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<!DOCTYPE html>
<c:if test="${param.updateFail == 'true'}">
	<script>alert("회원정보 변경에 실패하였습니다.")</script>
</c:if>
<form action="<%=path%>/member/adminUpdateAction" method="POST">
	<input type="hidden" name="id" value="${updateMember.id}">
	<input type="hidden" name="pass" value="${updateMember.pass}">
	<table>
		<tr>
			<th colspan="2"><h1>회원정보 수정</h1></th>
		</tr>
		<tr>
			<td>이름</td>
			<td>
				<input type="text" name="name" data-msg="이름" placeholder="INSERT NAME HERE" value="${updateMember.name}"/>
			</td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td>
				<input type="text" name="nickname" data-msg="닉네임" placeholder="INSERT NICKNAME HERE"value="${updateMember.nickname}"/>
			</td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td>
				<input type="text" name="phone" data-msg="전화번호" placeholder="INSERT PHONE HERE"value="${updateMember.phone}"/>
			</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td>
				<input type="text" name="email" data-msg="이메일" placeholder="INSERT EMAIL HERE" value="${updateMember.email}"/>
			</td>
		</tr>
		<tr>
			<td>성별</td>
			<td>
				<label>
				<input type="radio" name="gender" value="남성" <c:if test="${updateMember.gender == '남성'}">checked</c:if> />
				남성
				</label>
				<label>
				<input type="radio" name="gender" value="여성" <c:if test="${updateMember.gender == '여성'}">checked</c:if>/>
				여성
				</label>
			</td>
		</tr>
		<tr>
			<td>나이</td>
			<td>
				<input type="number" name="age" data-msg="나이" placeholder="INSERT AGE HERE" value="${updateMember.age}" max="999"/>
			</td>
		</tr>
		<tr>
			<th colspan="2">
				<button>정보 수정</button>
			</th>
		</tr>
	</table>
</form>
<%@ include file="../common/footer.jsp" %>