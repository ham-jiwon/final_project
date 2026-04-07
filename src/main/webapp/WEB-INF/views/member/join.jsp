<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<!DOCTYPE html>
<c:if test="${param.fail == 'true' }">
	<script>alert("이미 존재하는 아이디입니다.")</script>
</c:if>
<c:if test="${param.pwFail == 'true' }">
	<script>alert("비밀번호를 다시 확인해주세요.")</script>
</c:if>
<form action="<%=path %>/member/joinAction" method="POST">
	<table class="list join-box">
		<tr>
			<th colspan="2"><h1>회원가입</h1></th>
		</tr>
		<tr>
			<td>아이디</td>
			<td>
				<input type="text" name="id" data-msg="아이디" placeholder="INSERT ID HERE" autofocus/>
			</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>
				<input type="password" name="pass" data-msg="비밀번호" placeholder="INSERT PW HERE" />
			</td>
		</tr>
		<tr>
			<td>비밀번호 확인</td>
			<td>
				<input type="password" name="passAgain" data-msg="비밀번호 확인" placeholder="INSERT PW HERE AGAIN" />
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
				<div class="gender">
					<label>
					<input type="radio" name="gender" value="남성" checked />
					남성
					</label>
					<label>
					<input type="radio" name="gender" value="여성" />
					여성
					</label>
				</div>
			</td>
		</tr>
		<tr>
			<td>나이</td>
			<td>
				<input type="number" name="age" data-msg="나이" placeholder="INSERT Age HERE" max="999"/>
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