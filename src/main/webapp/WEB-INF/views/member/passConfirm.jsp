<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
	<c:choose>
	    <c:when test="${param.remove == 'true'}">
	    	<script>
	    		if(confirm("회원 탈퇴를 진행하시겠습니까?")){
	    			alert("비밀번호를 입력해 주십시오.")
	    		}else{
	    			history.back();
	    		}
	    	</script>
	        <form action="<%=path%>/member/remove" method="POST">
	    </c:when>
	    <c:otherwise>
	        <form action="<%=path%>/member/update" method="POST">
	    </c:otherwise>
	</c:choose>
	<table>
		<tr >
			<th colspan="2"> 비밀번호 확인</th> 
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="pass" placeholder="INSERT PW HERE" data-msg="비밀번호 확인" autofocus required></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="passAgain" placeholder="INSERT PW HERE AGAIN" data-msg="비밀번호 확인" required></td>
		</tr>
		<tr>
			<th colspan="2">
				<button>${param.remove == 'true'? '회원 탈퇴' : '회원정보 변경' }</button>
			</th>
		</tr>
		
	</table>
</form>
<%@ include file="../common/footer.jsp" %>