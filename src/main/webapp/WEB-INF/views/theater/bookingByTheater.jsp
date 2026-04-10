<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<style>
	/* 전체 wrapper */
    .panel-wrapper {
        display: flex;
        flex-direction: row;
        border: 1px solid #444;
        border-radius:12px;
        height: 500px;
        background-color: #222;
        overflow:hidden;
    }

    /* 왼쪽 3개 기둥 공통 */
    .panel-movie, .panel-theater, .panel-branch {
        flex: 0 0 250px; 
        border-right: 1px solid #444;
        overflow-y: auto;
    }

    /* ⭐️ 오른쪽 통합 기둥 (날짜/스케줄) ⭐️ */
    .panel-right {
        flex: 1; /* 시간표 영역이니 조금 더 넓게 배분 */
        display: flex;
        flex-direction: column; /* 위아래로 쌓기 */
        height: 100%;
        min-width: 0;     /* flex 자식이 넘치지 않게 */
    }
    /* 아이템 공통 */
	.movie-item, .theater-item, .branch-item, .date-item, .schedule-item{
	    padding: 12px 16px;
	    cursor: pointer;
	    border-bottom: 1px solid #333;
	    color: #ccc;
	    font-size: 0.85rem;
	    transition: background 0.15s, color 0.15s;
	}
	.movie-item:hover, .theater-item:hover, .branch-item:hover, .date-item:hover, .schedule-item:hover {
    background: #2e2e2e;
    color: #fff;
	}
	
	.movie-item.selected, .theater-item.selected, .branch-item.selected, .date-item.selected, .schedule-item.selected {
    background: #3a3a3a;
    color: #e8b84b;             /* 선택 강조색 */
    font-weight: 600;
	}
	
	.panel-date {
    display: flex;
    flex-wrap: nowrap;
    overflow-x: auto;   /* 날짜 많으면 가로 스크롤 */
    border-bottom: 1px solid #444;
    flex-shrink: 0;
	}
	
	/* 날짜 아이템 */
	.date-item {
	    display: inline-flex;
	    flex-direction: column;
	    align-items: center;
	    justify-content: center;
	    padding: 10px 14px;
	    cursor: pointer;
	    border-right: 1px solid #333;
	    transition: background 0.15s;
	    gap: 2px;
	}
	.date-month { font-size: 0.75rem; color: #888; }
	.date-day   { font-size: 1rem;  font-weight: 600; color: #eee; }
	.date-week  { font-size: 0.75rem; color: #888; }
	.date-item.selected .date-day { color: #e8b84b; }
    
    /* 스케줄 아이템 */
	.schedule-item {
	    display: inline-block;
	    margin: 8px;
	    padding: 10px 16px;
	    background: #2a2a2a;
	    border: 1px solid #444;
	    border-radius: 8px;
	    cursor: pointer;
	    transition: background 0.15s, border-color 0.15s;
	}
	.schedule-item:hover {
	    background: #333;
	    border-color: #e8b84b;
	}
	.schedule-time   { font-size: 1.1rem; font-weight: 700; color: #fff; display: block; }
	.schedule-screen { font-size: 0.72rem; color: #888; margin-top: 3px; display: block; }
</style>
<section class="content">
	<div class="container">
		
		<div class="panel-wrapper">
		
			<div class="panel-theater">
	            <c:forEach var="theater" items="${theaterList}">
	                <div class="theater-item ${theater.theater_code == selectedTheater ? 'selected' : ''}"
	                     onclick="selectTheater(${theater.theater_code}, this)">
	                    ${theater.theater_name}
	                </div>
	            </c:forEach>
	        </div>
	        
	        <div class="panel-branch" id="branchPanel">
	        	영화관을 선택해 주세요.
	        </div>
	        
	        <div class="panel-movie" id="moviePanel">
	        	
	        </div>
	        
	        <div class="panel-rigth">
	        
				<div class="panel-date" id="datePanel">
				
				</div>
				<div class="panel-schedule" id="schedulePanel">
				
				</div>
				
			</div>
				
        </div>
        
	</div>
</section>
	
<script>
	let selectedBranchCode = null;
	let selectedMovieCode = null;
	let selectedTheaterCode = null;
	
	document.addEventListener('DOMContentLoaded', function() {
	    loadBranches(${selectedTheater});
	});
	
	function selectTheater(theaterCode, el){
		document.querySelectorAll('.theater-item').forEach(e => e.classList.remove('selected'));
		el.classList.add('selected');
		selectedTheaterCode = theaterCode;
		loadBranches(theaterCode);
	}
	
	function loadBranches(theaterCode){
		if(!theaterCode) return;
		
		fetch("/cinema/theater/branchList?theaterCode=" + theaterCode)
		.then(response => response.json())
		.then(data => {
			const panel = document.getElementById('branchPanel');
			document.getElementById("moviePanel").innerHTML = "";
			document.getElementById("datePanel").innerHTML = "";
	        document.getElementById("schedulePanel").innerHTML = "";
	        
			if(data.length === 0){
				panel.innerHTML = '지점이 없습니다.';
				return;
			}
			let html = '';
			data.forEach(branch => {
				html += '<div class="branch-item" onclick="loadMovies('+branch.branch_code+', this)">' 
				+ branch.branch_name + '</div>'; 
			})
			panel.innerHTML = html;
		})
	}
	
	function loadMovies(branchCode, el){
		selectedBranchCode = branchCode;
		document.querySelectorAll('.branch-item').forEach(e => e.classList.remove('selected'));
		el.classList.add('selected');
		document.getElementById("datePanel").innerHTML = "";
	    document.getElementById("schedulePanel").innerHTML = "";
	    
	    
		fetch("/cinema/theater/movieByBranch?branchCode="+branchCode)
		.then(response => response.json())
		.then(data => {
			const panel = document.getElementById("moviePanel");
			
			if(data.length === 0){
				panel.innerHTML = "상영중인 영화가 없습니다.";
				return;
			}
			let html = '';
			data.forEach(movie => {
				html += '<div class="movie-item" onclick="loadDates(' + movie.movie_code + ', this)">'+movie.title+'</div>';
			})
			panel.innerHTML = html;
		})
	}
	
	function loadDates(movieCode, el){
		selectedMovieCode = movieCode;
		document.querySelectorAll(".movie-item").forEach(e => e.classList.remove('selected'));
		el.classList.add('selected')
		document.getElementById("schedulePanel").innerHTML = "";
		
		fetch("/cinema/theater/scheduleByMovie?branchCode="+selectedBranchCode+"&movieCode="+movieCode)
		.then(response => response.json())
		.then(data => {
			const panel = document.getElementById("datePanel");
			
			if(data.length === 0){
				panel.innerHTML = "상영 일정이 없습니다.";
				return;
			}
			
			// 날짜 중복 제거
			const dates = [...new Set(data.map(s => {
				const d = new Date(s.start_time);
				const y = d.getFullYear();
			    const m = String(d.getMonth() + 1).padStart(2, '0');
			    const day = String(d.getDate()).padStart(2, '0');
			    return y+'-'+m+'-'+day;
				/* return d.getFullYear() + '-' + String(d.getMonth()+1).padStart(2, '0') + '-'
					   + String(d.getDate()).padStart(2, '0'); */
			}))];
			
			let html = '';
				const dayNames = ['일','월','화','수','목','금','토'];
			dates.forEach(date => {
				const d = new Date(date);
				const month = d.getMonth() + 1;
				const day = d.getDate();
				const dayName = dayNames[d.getDay()];
				
				html += '<div class="date-item" onclick="loadSchedules(\''+date+'\', this)">'
					 + '<span class="date-month">' + month + '월</span>'
					 + '<span class="date-day">' + day + '일</span>'
					 + '<span class="date-week">(' + dayName + ')</span>'
					 + '</div>';
			});
			panel.innerHTML = html;
			console.log(html);
		}).catch(error => {
	        console.error("데이터 로드 실패:", error);
	        document.getElementById("datePanel").innerHTML = "데이터를 불러오는 중 오류가 발생했습니다.";
	    });
	}
	
	 // 스케줄 불러오기
    function loadSchedules(date, el){
        document.querySelectorAll('.date-item').forEach(e => e.classList.remove('selected'));
        el.classList.add('selected');
        
        fetch("/cinema/theater/scheduleByDate?branchCode=" + selectedBranchCode
            + "&movieCode=" + selectedMovieCode + "&date=" + date)
        .then(response => response.json())
        .then(data => {
            const panel = document.getElementById("schedulePanel");
            
            if(data.length === 0){
                panel.innerHTML = "스케줄이 없습니다.";
                return;
            }
            let html = '';
            data.forEach(schedule => {
                const start = new Date(schedule.start_time);
                const hours = String(start.getHours()).padStart(2, '0');
                const mins = String(start.getMinutes()).padStart(2, '0');
                
             	// 여기서 theaterCode 기반 URL 결정
                let bookingUrl = "";
                if (selectedTheaterCode == 1) {
                    bookingUrl = "https://cgv.co.kr/cnm/movieBook";
                } else if (selectedTheaterCode == 2) {
                    bookingUrl = "https://www.lottecinema.co.kr/NLCHS/Ticketing";
                } else {
                    bookingUrl = "https://www.megabox.co.kr/booking";
                }
                
                html += '<div class="schedule-item" onclick="goBooking(\'' + bookingUrl + '\')">'
                      + '<span class="schedule-time">' + hours + ':' + mins + '</span><br>'
                      + '<span class="schedule-screen">' + schedule.screen_name + ' · ' + schedule.screen_type + '</span>'
                      + '</div>';
            });
            panel.innerHTML = html;
        }).catch(error => console.error("scheduleByDate 오류:", error));
    }
	 
    function goBooking(url){
		 if(confirm("예매 페이지로 이동하시겠습니까?")){
			 window.open(url, '_blank');
		 }
	 }
	
</script>
<%@ include file="../common/footer.jsp" %>