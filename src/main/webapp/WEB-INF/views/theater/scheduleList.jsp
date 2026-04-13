<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="content">
<div class="container" style="padding: 30px 40px;">

    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
        <h2 style="color:#2d6cdf; font-size:1.4rem;">스케줄 목록</h2>
        <a href="<%=path %>/theater/scheduleAdd" 
           style="padding:8px 18px; background:#2d6cdf; color:#fff; border-radius:6px; font-weight:600; text-decoration:none;">
            + 스케줄 추가
        </a>
    </div>

    <c:if test="${param.success == 'true'}">
        <p style="color:lightgreen; margin-bottom:14px;">✅ 처리 완료!</p>
    </c:if>

    <div style="display:flex; gap:10px; margin-bottom:20px;">
        <select id="listTheater" onchange="loadBranches(this.value)"
                style="padding:8px 12px; background:#2a2a2a; color:#fff; border:1px solid #444; border-radius:6px;">
            <option value="">영화관 선택</option>
            <c:forEach var="theater" items="${theaterList}">
                <option value="${theater.theater_code}">${theater.theater_name}</option>
            </c:forEach>
        </select>

        <select id="listBranch" onchange="loadScheduleList()"
                style="padding:8px 12px; background:#2a2a2a; color:#fff; border:1px solid #444; border-radius:6px;">
            <option value="">지점 선택</option>
        </select>

        <input type="date" id="listDate" onchange="loadScheduleList()"
               style="padding:8px 12px; background:#2a2a2a; color:#fff; border:1px solid #444; border-radius:6px;">
    </div>

    <table style="width:100%; border-collapse:collapse; font-size:0.85rem;">
        <thead>
            <tr style="background:#2a2a2a; color:#2d6cdf;">
                <th style="padding:12px 16px; border-bottom:1px solid #333;">영화</th>
                <th style="padding:12px 16px; border-bottom:1px solid #333;">상영관</th>
                <th style="padding:12px 16px; border-bottom:1px solid #333;">시작시간</th>
                <th style="padding:12px 16px; border-bottom:1px solid #333;">종료시간</th>
                <th style="padding:12px 16px; border-bottom:1px solid #333;">수정</th>
                <th style="padding:12px 16px; border-bottom:1px solid #333;">삭제</th>
            </tr>
        </thead>
        <tbody id="scheduleTableBody">
            <tr><td colspan="6" style="padding:12px; text-align:center; color:#888;">영화관, 지점, 날짜를 선택하세요.</td></tr>
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
            tbody.innerHTML = '<tr><td colspan="6" style="padding:12px; text-align:center; color:#888;">스케줄이 없습니다.</td></tr>';
            return;
        }
        
        let html = '';
        data.forEach(s => {
            const start = new Date(s.start_time);
            const end = new Date(s.end_time);
            
            html += '<tr style="border-bottom:1px solid #333; color:#ccc;">'
                  + '<td style="padding:12px 16px; text-align:center;">'+s.movie_title+'</td>'
                  + '<td style="padding:12px 16px; text-align:center;">'+s.screen_name+' · '+s.screen_type+'</td>'
                  + '<td style="padding:12px 16px; text-align:center;">'+formatTime(start)+'</td>'
                  + '<td style="padding:12px 16px; text-align:center;">'+formatTime(end)+'</td>'
                  + '<td style="padding:12px 16px; text-align:center;"><a href="/cinema/theater/scheduleUpdate?scheduleCode='+s.schedule_code+'"'
                  + ' style="padding:5px 12px; background:#333; color:#2d6cdf; border:1px solid #2d6cdf; border-radius:4px; text-decoration:none; font-size:0.8rem;">수정</a></td>'
                  + '<td style="padding:12px 16px; text-align:center;">'
                  + '<form action="/cinema/theater/scheduleDelete" method="post" style="display:inline"'
                  + ' onsubmit="return confirm(\'삭제하시겠습니까?\')">'
                  + '<input type="hidden" name="scheduleCode" value="'+s.schedule_code+'">'
                  + '<button type="submit" style="padding:5px 12px; background:#333; color:#e05555; border:1px solid #e05555; border-radius:4px; font-size:0.8rem; cursor:pointer;">삭제</button>'
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