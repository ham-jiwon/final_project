<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHoi House</title>
<% String path = request.getContextPath(); %>
<!-- project contextPath 경로를 저장하는 변수 지정 -->
<link href="<%=path %>/resources/css/header.css" rel="stylesheet" type="text/css" />
<link href="<%=path %>/resources/css/footer.css" rel="stylesheet" type="text/css" />
<link href="<%=path %>/resources/css/common.css" rel="stylesheet" type="text/css" />
<link rel="icon" href="<%=request.getContextPath()%>/css/img/puppy.ico" type="image/x-icon">
</head>
<body>
	<header>
		<div>
			<ul>
				<li><a href="<%=path %>">home</a></li>
				<li><a href="<%=path %>/sendMail.jsp">SEND MAIL</a></li>
				<li><a href="<%=path %>/sendMailFile.jsp">SEND File MAIL</a></li>
				
				
			
				<!-- 비 로그인시용자 -->
				<li><a href="<%=path %>/login.jsp">로그인</a></li>
				<li><a href="<%=path %>/join.jsp">회원가입</a></li>
				<!-- 로그인 된 사용자 -->
				<li>
					<a href="<%=path %>/info.jsp">
						<!-- 회원이름 -->
					</a>님 방가방가
				</li>
				<li><a href="<%=path %>/logout.jsp">로그아웃</a></li>
				
					<!-- 관리자 로그인일 경우 -->
					<li><a href="<%=path %>/memberList.jsp">회원관리</a></li>
			</ul>
		</div>
		<div>
			<ul>
				<li><a href="#">공지사항</a></li>
				<li><a href="#">질문과답변</a></li>
			</ul>
		</div>
	</header>