<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- project contextPath 경로를 저장하는 변수 지정 -->
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
<link rel="icon" href="<%=path%>/resources/css/img/puppy.ico" type="image/x-icon">

</head>
<body>

<header>

    <!-- 상단 메뉴바 -->
	<div>
	    <ul class="sub-nav"> <li><a href="#">공지사항</a></li>
	        <li><a href="#">질문과답변</a></li>
	    </ul>
	
	    <ul class="right-menu sub-nav"> <li><a href="<%=path %>">home</a></li>
	        <li><a href="<%=path %>/sendMail.jsp">SEND MAIL</a></li>
	        <li><a href="<%=path %>/sendMailFile.jsp">SEND File MAIL</a></li>
	
	        <li><a href="<%=path %>/member/login">로그인</a></li>
	        <li><a href="<%=path %>/member/join">회원가입</a></li>
	
	        <li>
	            <a href="<%=path %>/info.jsp">회원이름</a><span>님 방가방가</span>
	        </li>
	        <li><a href="<%=path %>/logout.jsp">로그아웃</a></li>
	
	        <li><a href="<%=path %>/memberList.jsp">관리자 페이지</a></li>
	    </ul>
	</div>
    
    <!-- 하단 드롭다운 메뉴 -->
    <div>

        <ul class="main-nav">
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
        </ul>
                
    </div>


</header>