<%@ include file="../common/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<c:if test="${param.updateFail == 'true'}">
	<script>alert("회원정보 수정 완료.")</script>
</c:if>
	<table>
		<tr>
			<th colspan="10"><h1>회원 목록</h1></th>
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
			<th>수정</th>
			<th>삭제</th>
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
				<td><a href="<%=path%>/member/adminUpdate?id=${member.id}"><button>수정</button></a></td>
				<td><button>삭제</button></td>
			</tr>
		</c:forEach>
		<tr>
			<th colspan="10">
				<c:if test="${pageMaker.first}">
					<a href="?page=1&perPageNum=${pageMaker.criteria.perPageNum}">[처음]</a>
				</c:if>
				
				<c:if test="${pageMaker.prev}">
					<a href="?page=${pageMaker.startPage-1}&perPageNum=${pageMaker.criteria.perPageNum}">[이전]</a>
				</c:if>
				
				<c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					<a href="?page=${i}&perPageNum=${pageMaker.criteria.perPageNum}">[${i}]</a>
				</c:forEach>
				
				<c:if test="${pageMaker.next}">
					<a href="?page=${pageMaker.endPage+1}&perPageNum=${pageMaker.criteria.perPageNum}">[다음]</a>
				</c:if>
				
				<c:if test="${pageMaker.last}">
					<a href="?page=${pageMaker.maxPage}&perPageNum=${pageMaker.criteria.perPageNum}">[마지막]</a>
				</c:if>
			</th>
		</tr>
	</table>
<%@ include file="../common/footer.jsp" %>