<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="content">
<div class="container">
    <h2>스케줄 목록</h2>
    <a href="<%=path %>/theater/scheduleAdd">스케줄 추가</a>
    
    <c:if test="${param.success == 'true'}">
        <p>✅ 처리 완료!</p>
    </c:if>
    
    <select id="listTheater" onchange="loadBranches(this.value)">
        <option value="">영화관 선택</option>
        <c:forEach var="theater" items="${theaterList}">
            <option value="${theater.theater_code}">${theater.theater_name}</option>
        </c:forEach>
    </select>
    
    <select id="listBranch" onchange="loadScheduleList()">
        <option value="">지점 선택</option>
    </select>
    
    <input type="date" id="listDate" onchange="loadScheduleList()">
    
    <table border="1">
        <thead>
            <tr>
                <th>영화</th>
                <th>상영관</th>
                <th>시작시간</th>
                <th>종료시간</th>
                <th>수정</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody id="scheduleTableBody">
            <tr><td colspan="6">영화관, 지점, 날짜를 선택하세요.</td></tr>
        </tbody>
    </table>

</div>
</section>

<script>
function loadBranches(theaterCode) {
    if(!theaterCode) return;
    document.getElementById("listBranch").innerHTML = "<option>로딩중...</option>";
    
    fetch("/cinema/theater/branchList?theaterCode=" + theaterCode)
    .then(r => r.json())
    .then(data => {
        let html = '<option value="">지점 선택</option>';
        data.forEach(b => {
            html += '<option value="'+b.branch_code+'">'+b.branch_name+'</option>';
        });
        document.getElementById("listBranch").innerHTML = html;
    });
}

function loadScheduleList() {
    const branchCode = document.getElementById("listBranch").value;
    const date = document.getElementById("listDate").value;
    if(!branchCode || !date) return;
    
    fetch("/cinema/theater/scheduleListAjax?branchCode="+branchCode+"&date="+date)
    .then(r => r.json())
    .then(data => {
        const tbody = document.getElementById("scheduleTableBody");
        
        if(data.length === 0){
            tbody.innerHTML = '<tr><td colspan="6">스케줄이 없습니다.</td></tr>';
            return;
        }
        
        let html = '';
        data.forEach(s => {
            const start = new Date(s.start_time);
            const end = new Date(s.end_time);
            
            html += '<tr>'
                  + '<td>'+s.movie_title+'</td>'
                  + '<td>'+s.screen_name+' · '+s.screen_type+'</td>'
                  + '<td>'+formatTime(start)+'</td>'
                  + '<td>'+formatTime(end)+'</td>'
                  + '<td><a href="/cinema/theater/scheduleUpdate?scheduleCode='+s.schedule_code+'">수정</a></td>'
                  + '<td>'
                  + '<form action="/cinema/theater/scheduleDelete" method="post" style="display:inline"'
                  + ' onsubmit="return confirm(\'삭제하시겠습니까?\')">'
                  + '<input type="hidden" name="scheduleCode" value="'+s.schedule_code+'">'
                  + '<button type="submit">삭제</button>'
                  + '</form>'
                  + '</td>'
                  + '</tr>';
        });
        tbody.innerHTML = html;
    });
}

function formatTime(date) {
    return String(date.getHours()).padStart(2,'0') + ':' + String(date.getMinutes()).padStart(2,'0');
}
</script>

<%@ include file="../common/footer.jsp" %>