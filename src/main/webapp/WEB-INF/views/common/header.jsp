<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- project contextPath 경로를 저장하는 변수 지정 -->
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHoi House</title>
    <link rel="stylesheet" href="<%=path%>/resources/css/common.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/header.css">     
    <link rel="stylesheet" href="<%=path%>/resources/css/footer.css">
</head>
<body>

<header>
    <div>
        <!-- ✅ 전체 메뉴를 하나의 ul로 묶기 -->
        <ul>

            <!-- 영화 -->
            <li>
                <a href="#">영화</a>
                <ul>
                    <li><a href="<%=path %>/sendMailFile.jsp">상영중</a></li>
                    <li><a href="<%=path %>/sendMailFile.jsp">상영예정</a></li>
                </ul>
            </li>

            <!-- 영화관별 -->
            <li>
                <a href="#">영화관별</a>
                <ul>
                    <li><a href="<%=path %>/sendMailFile.jsp">메가박스</a></li>
                    <li><a href="<%=path %>/sendMailFile.jsp">CGV</a></li>
                    <li><a href="<%=path %>/sendMailFile.jsp">롯데시네마</a></li>
                </ul>
            </li>

            <!-- 기존 메뉴 -->
            <li><a href="<%=path %>">home</a></li>
            <li><a href="<%=path %>/sendMail.jsp">SEND MAIL</a></li>
            <li><a href="<%=path %>/sendMailFile.jsp">SEND File MAIL</a></li>

            <!-- 비 로그인 -->
            <li><a href="<%=path %>/login.jsp">로그인</a></li>
            <li><a href="<%=path %>/join.jsp">회원가입</a></li>

            <!-- 로그인 -->
            <li>
                <a href="<%=path %>/info.jsp">회원이름</a>님 방가방가
            </li>
            <li><a href="<%=path %>/logout.jsp">로그아웃</a></li>

            <!-- 관리자 -->
            <li><a href="<%=path %>/memberList.jsp">관리자 페이지</a></li>

        </ul>
    </div>

    <!-- 오른쪽 메뉴 -->
    <div>
        <ul>
            <li><a href="#">공지사항</a></li>
            <li><a href="#">질문과답변</a></li>
        </ul>
    </div>
</header>