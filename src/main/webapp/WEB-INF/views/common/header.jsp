<%@page import="net.koreate.cinema.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- jstl 추가 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% MemberVO loginMember =  (MemberVO)session.getAttribute("loginMember"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cinema in Busan</title>

<% String path = request.getContextPath(); %>
<script src="<%=path%>/resources/js/inputCheck.js"></script>
<!-- project contextPath 경로를 저장하는 변수 지정 -->
<link href="<%=path %>/resources/css/header.css" rel="stylesheet" type="text/css" />
<link href="<%=path %>/resources/css/footer.css" rel="stylesheet" type="text/css" />
<link href="<%=path %>/resources/css/common.css" rel="stylesheet" type="text/css" />
<link rel="icon" href="<%=path%>/resources/img/film.ico" type="image/x-icon">

</head>
<body>

<header>

    <!-- 상단 메뉴바 -->
	<div>
	
	    <ul class="sub-nav">
	
	<%if(loginMember == null){ %>
	        <li><a href="<%=path %>/member/login">로그인</a></li>
	        <li><a href="<%=path %>/member/join">회원가입</a></li>
	<%}else{ %>	        
	        <li>
	            <a href="<%=path %>/member/info"><%=loginMember.getNickname() %></a><span>님 환영합니다.</span>
	        </li>

	        <li><a href="<%=path %>/member/logout">로그아웃</a></li>
		<%if(loginMember.getId().equals("admin")){ %>
	        <li><a href="<%=path %>/member/memberList">회원 관리</a></li>
	    <%} %>
	<%} %>		    
	    </ul>
    </div>
    
    <!-- 하단 드롭다운 메뉴 -->
    <div>

        <ul class="main-nav">
            <!-- 영화 -->
            <li>
                <a href="#">영화</a>
                <ul>
                    <li><a href="<%=path %>/movie/goingMov">상영중</a></li>
                    <li><a href="<%=path %>/movie/willGoMov">상영예정</a></li>
                </ul>
            </li>

            <!-- 영화관별 -->
            <li>
                <a href="#">영화관별</a>
                <ul>
                    <li><a href="<%=path %>/theater/mega">메가박스</a></li>
                    <li><a href="<%=path %>/theater/cgv">CGV</a></li>
                    <li><a href="<%=path %>/theater/lotte">롯데시네마</a></li>
                </ul>
            </li>
        </ul>
                
    </div>
    
   	<!-- 홈페이지 로고 삽입 -->
   	<div class="logo">
    <a href="<%=path %>"><img src="${pageContext.request.contextPath}/resources/img/logo2.gif"></a>	
	</div>
</header>

