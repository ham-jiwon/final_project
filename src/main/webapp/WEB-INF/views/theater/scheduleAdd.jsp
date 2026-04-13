<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="content">
<div class="container">
    <h2>스케줄 추가</h2>
    
    <c:if test="${param.success == 'true'}">
        <p>✅ 추가 완료!</p>
    </c:if>
    
    <form action="/cinema/theater/scheduleAdd" method="post">
    
        <label>영화관</label><br>
        <select name="theater_code" onchange="loadBranches(this.value)">
            <option value="">선택하세요</option>
            <c:forEach var="theater" items="${theaterList}">
                <option value="${theater.theater_code}">${theater.theater_name}</option>
            </c:forEach>
        </select>
        <br>
        
        <label>지점</label><br>
        <select name="branch_code" id="branchSelect" onchange="loadScreens(this.value)">
            <option value="">영화관을 먼저 선택하세요</option>
        </select>
        <br>
        
        <label>상영관</label><br>
        <select name="screen_code" id="screenSelect">
            <option value="">지점을 먼저 선택하세요</option>
        </select>
        <br>
        
        <label>영화</label><br>
        <select name="movie_code">
		    <option value="">선택하세요</option>
		    <c:forEach var="movie" items="${movieList}">
		        <option value="${movie.movie_code}">${movie.title}</option>
		    </c:forEach>
		</select>
        
        <label>시작 시간</label><br>
        <input type="datetime-local" name="start_time">
        <br>
        
        <button type="submit">추가</button>
        
    </form>
</div>
</section>

<script>
function loadBranches(theaterCode) {
    if(!theaterCode) return;
    document.getElementById("branchSelect").innerHTML = "<option>로딩중...</option>";
    document.getElementById("screenSelect").innerHTML = "<option>지점을 먼저 선택하세요</option>";
    
    fetch("/cinema/theater/branchList?theaterCode=" + theaterCode)
    .then(r => r.json())
    .then(data => {
        let html = '<option value="">선택하세요</option>';
        data.forEach(b => {
            html += '<option value="'+b.branch_code+'">'+b.branch_name+'</option>';
        });
        document.getElementById("branchSelect").innerHTML = html;
    });
}

function loadScreens(branchCode) {
    if(!branchCode) return;
    document.getElementById("screenSelect").innerHTML = "<option>로딩중...</option>";
    
    fetch("/cinema/theater/screenByBranch?branchCode=" + branchCode)
    .then(r => r.json())
    .then(data => {
        let html = '<option value="">선택하세요</option>';
        data.forEach(s => {
            html += '<option value="'+s.screen_code+'">'+s.screen_name+'</option>';
        });
        document.getElementById("screenSelect").innerHTML = html;
    });
}
</script>

<%@ include file="../common/footer.jsp" %>