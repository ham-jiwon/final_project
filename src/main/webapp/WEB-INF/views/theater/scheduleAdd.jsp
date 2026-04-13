<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="content">
<div class="container" style="padding:30px 40px;">

    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:30px;">
        <h2 style="color:#2d6cdf; font-size:1.4rem;">스케줄 추가</h2>
        <a href="<%=path %>/theater/scheduleList"
           style="padding:8px 18px; background:#333; color:#fff; border:1px solid #555; border-radius:6px; font-weight:600; text-decoration:none; font-size:0.9rem;">
            ← 목록으로
        </a>
    </div>

    <c:if test="${param.success == 'true'}">
        <p style="color:lightgreen; margin-bottom:14px;">✅ 추가 완료!</p>
    </c:if>

    <form action="/cinema/theater/scheduleAdd" method="post"
          style="background:#1a1a1a; border:1px solid #333; border-radius:12px; padding:30px; max-width:500px; margin: 0 auto;">

        <label style="color:#aaa; font-size:0.85rem;">영화관</label><br>
        <select name="theater_code" onchange="loadBranches(this.value)"
                style="width:100%; padding:10px 12px; margin:6px 0 18px; background:#2a2a2a; color:#fff; border:1px solid #444; border-radius:6px; font-size:0.9rem;">
            <option value="">선택하세요</option>
            <c:forEach var="theater" items="${theaterList}">
                <option value="${theater.theater_code}">${theater.theater_name}</option>
            </c:forEach>
        </select>

        <label style="color:#aaa; font-size:0.85rem;">지점</label><br>
        <select name="branch_code" id="branchSelect" onchange="loadScreens(this.value)"
                style="width:100%; padding:10px 12px; margin:6px 0 18px; background:#2a2a2a; color:#fff; border:1px solid #444; border-radius:6px; font-size:0.9rem;">
            <option value="">영화관을 먼저 선택하세요</option>
        </select>

        <label style="color:#aaa; font-size:0.85rem;">상영관</label><br>
        <select name="screen_code" id="screenSelect"
                style="width:100%; padding:10px 12px; margin:6px 0 18px; background:#2a2a2a; color:#fff; border:1px solid #444; border-radius:6px; font-size:0.9rem;">
            <option value="">지점을 먼저 선택하세요</option>
        </select>

        <label style="color:#aaa; font-size:0.85rem;">영화</label><br>
        <select name="movie_code"
                style="width:100%; padding:10px 12px; margin:6px 0 18px; background:#2a2a2a; color:#fff; border:1px solid #444; border-radius:6px; font-size:0.9rem;">
            <option value="">선택하세요</option>
            <c:forEach var="movie" items="${movieList}">
                <option value="${movie.movie_code}">${movie.title}</option>
            </c:forEach>
        </select>

        <label style="color:#aaa; font-size:0.85rem;">시작 시간</label><br>
        <input type="datetime-local" name="start_time"
               style="width:100%; padding:10px 12px; margin:6px 0 24px; background:#2a2a2a; color:#fff; border:1px solid #444; border-radius:6px; font-size:0.9rem; box-sizing:border-box;">

        <div style="display:flex; gap:10px;">
            <button type="submit"
                    style="flex:1; padding:12px; background:#2d6cdf; color:#fff; border:none; border-radius:6px; font-size:0.95rem; font-weight:600; cursor:pointer;">
                추가
            </button>
            <a href="<%=path %>/theater/scheduleList"
               style="flex:1; padding:12px; background:#333; color:#fff; border:1px solid #555; border-radius:6px; font-size:0.95rem; font-weight:600; text-decoration:none; text-align:center;">
                취소
            </a>
        </div>

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