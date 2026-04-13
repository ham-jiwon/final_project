<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="content">
<div class="container">
    <h2>스케줄 수정</h2>
    
    <form action="/cinema/theater/scheduleUpdate" method="post">
        <input type="hidden" name="schedule_code" value="${schedule.schedule_code}">
        
        <label>영화</label><br>
        <input type="text" value="${schedule.movie_title}" readonly>
        <br>
        
        <label>상영관</label><br>
        <input type="text" value="${schedule.screen_name} · ${schedule.screen_type}" readonly>
        <br>
        
        <label>시작 시간</label><br>
        <input type="datetime-local" name="start_time" 
               value="${schedule.start_time}">
        <br>
        
        <button type="submit">수정 완료</button>
        <a href="/cinema/theater/scheduleList">취소</a>
        
    </form>
</div>
</section>

<%@ include file="../common/footer.jsp" %>