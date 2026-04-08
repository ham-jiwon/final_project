<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<style>
	/* 전체 wrapper */
    .panel-wrapper {
        display: flex;
        flex-direction: row;
        border: 1px solid #444;
        height: 500px;
        background-color: #222;
    }

    /* 왼쪽 3개 기둥 공통 */
    .panel-movie, .panel-theater, .panel-branch {
        flex: 1; 
        border-right: 1px solid #444;
        overflow-y: auto;
    }

    /* ⭐️ 오른쪽 통합 기둥 (날짜/스케줄) ⭐️ */
    .panel-right {
        flex: 1.5; /* 시간표 영역이니 조금 더 넓게 배분 */
        display: flex;
        flex-direction: column; /* 위아래로 쌓기 */
        height: 100%;
    }
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
	        	지점을 선택하세요.
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
	
	
	document.addEventListener('DOMContentLoaded', function() {
	    loadBranches(${selectedTheater});
	});
	
	function selectTheater(theaterCode, el){
		document.querySelectorAll('.theater-item').forEach(e => e.classList.remove('selected'));
		el.classList.add('selected');
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
					 + '<span class="date-day">' + day + '</span>'
					 + '<span class="date-week">' + dayName + '</span>'
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
                
                html += '<div class="schedule-item">'
                      + '<span class="schedule-time">' + hours + ':' + mins + '</span><br>'
                      + '<span class="schedule-screen">' + schedule.screen_name + ' · ' + schedule.screen_type + '</span>'
                      + '</div>';
            });
            panel.innerHTML = html;
        }).catch(error => console.error("scheduleByDate 오류:", error));
    }
	
</script>
<%@ include file="../common/footer.jsp" %>