<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<!DOCTYPE html>
<form action="<%=path %>/member/updateAction" method="POST">
	<table>
		<tr>
			<th colspan="2"><h1>회원정보 수정</h1></th>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>
				<input type="password" name="pass" data-msg="비밀번호" placeholder="INSERT PW HERE" />
			</td>
		</tr>
		<tr>
			<td>이름</td>
			<td>
				<input type="text" name="name" data-msg="이름" placeholder="INSERT NAME HERE"/>
			</td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td>
				<input type="text" name="nickname" data-msg="닉네임" placeholder="INSERT NICKNAME HERE"/>
			</td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td>
				<input type="text" name="phone" data-msg="전화번호" placeholder="INSERT PHONE HERE"/>
			</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td>
				<input type="text" name="email" data-msg="이메일" placeholder="INSERT EMAIL HERE"/>
			</td>
		</tr>
		<tr>
			<td>성별</td>
			<td>
				<label>
				<input type="radio" name="gender" value="남성" checked />
				남성
				</label>
				<label>
				<input type="radio" name="gender" value="여성" />
				여성
				</label>
			</td>
		</tr>
		<tr>
			<td>나이</td>
			<td>
				<input type="number" name="age" data-msg="나이" placeholder="INSERT Age HERE"/>
			</td>
		</tr>
		<tr>
			<th colspan="2">
				<button>회원가입</button>
			</th>
		</tr>
	</table>
</form>
<%@ include file="../common/footer.jsp" %>