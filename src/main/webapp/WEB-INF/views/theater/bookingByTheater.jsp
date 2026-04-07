<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<section class="content">
	<div class="container">
	
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
        
        
        
	</div>
</section>
	
<script>
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
		document.querySelectorAll('.branch-item').forEach(e => e.classList.remove('selected'));
		el.classList.add('selected');
		
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
				html += '<div class="movie-item">' + movie.title + '</div>';
			})
			panel.innerHTML = html;
		})
	}
</script>
<%@ include file="../common/footer.jsp" %>