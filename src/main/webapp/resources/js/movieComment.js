/**
 * 해당 js 파일은 movieDetail.jsp 및 movieComment.jsp에 적용하기 위해 작성되었습니다.
 */
	console.log("JS 로드됨");
    
	
    function loadComments(callback){

		const movieEl = document.getElementById("movie_code");
    	const memberEl = document.getElementById("member_id");

		if (!movieEl || !memberEl) {
			console.warn("필수 요소 없음");
			return;
    	}

		let movieCode = document.getElementById("movie_code").value;
		
		let loginId = document.getElementById("member_id").value;
		
		// 디버깅용 출력코드
		console.log("loginId:", loginId);
		console.log("is_admin raw:", document.getElementById("is_admin").value);
		
		fetch(path + "/comment/list?movie_code=" + movieCode)
		.then(res => res.json())
		.then(data => {

  	    let html = "";

		let isAdmin = document.getElementById("is_admin").value === "true";

  	    data.forEach(c => {
  	    	// 디버깅용 출력코드
  	    	console.log(c);
  	    	console.log("loginId type :", typeof loginId);
  	    	console.log("c.member_id type :", typeof c.member_id);
  	    	
   	  		html += "<div class='comment-item'>";
   	  		
  	  		html += "<b>" + c.nickname + "</b>";
  	  		html += "<span class='stars'>" + getStars(c.score) + "</span>";
  	  		
  	  		// 내용 영역
  		    html += "<div class='comment-content' id='content-" + c.comment_num + "'>";
  		    html += c.content.replace(/\n/g, "<br>");
  		    html += "</div>";
  		    
  		    // 수정 UI (숨김)
  		    html += "<div class='edit-area' id='edit-" + c.comment_num + "' style='display:none'>";
  		    html += "<textarea id='editContent-" + c.comment_num + "'>" + c.content + "</textarea>";

  		    html += "<div class='edit-star' id='edit-star-" + c.comment_num + "'>";
  		    for(let i=1; i<=5; i++){
  		    	html += "<span onmouseover='hoverEditStar(" + c.comment_num + "," + i + ")' onclick='setEditScore(" + c.comment_num + "," + i + ")'>★</span>";
  		    }
  		    html += "</div>";

  		    html += "<input type='hidden' id='editScore-" + c.comment_num + "' value='" + c.score + "'>";

  		    html += "<button class='save-btn' onclick='saveEdit(" + c.comment_num + ")'>저장</button>";
  		    html += "<button class='cancel-btn' onclick='cancelEdit(" + c.comment_num + ")'>취소</button>";
  		    html += "</div>";
  		    
  		    // 버튼
  		    if(loginId === c.member_id || isAdmin){
  			    html += "<button class='edit-btn' onclick='showEdit(" + c.comment_num + ")'>수정</button>";		    
  		  		html += "<button class='delete-btn' onclick='deleteComment(" + c.comment_num + ")'>삭제</button>";
  		    }
  		    
  	  	    html += "<hr>";	  		
  	  		html += "</div>";	    	
  	    });

  	    document.getElementById("comment-list").innerHTML = html;
		
		if (callback) callback();
  	  });

  	}
	

    function writeComment(){

    	  let content = document.getElementById("content").value;
    	  let score = document.getElementById("score").value;

    	  // ☆ movie_code, member_id는 hidden이나 세션에서 가져와야 함
    	  let movieCode = document.getElementById("movie_code").value;
    	  let memberId = document.getElementById("member_id").value;
    	  
    	  if(!memberId){
    	    alert("로그인 후 이용해주세요");
    	    return;
    	  }
    	  
    	  if(!score){
    	    alert("별점을 선택하세요");
    	    return;
    	  }  

    	  fetch(path + "/comment/write", {
    	    method : "POST",
    	    headers : {
    	      "Content-Type" : "application/x-www-form-urlencoded"
    	    },
    	    body : "movie_code=" + movieCode
    	         + "&member_id=" + memberId
    	         + "&content=" + encodeURIComponent(content)
    	         + "&score=" + score
    	  })
    	  .then(res => {
    	      if(!res.ok) throw new Error("요청 실패");
    	      return res.text();
    	  })
    	  .then(data => {
    	    console.log("응답:", data);
    	    alert("댓글 등록 완료");

    	    // 입력 초기화
    	    document.getElementById("content").value = "";
    	    document.getElementById("score").value = "";

    	    // TODO: 댓글 다시 불러오기
    	    loadComments();	// 댓글 갱신
    	    loadRating();	// 평점 갱신
    	  })
    	  .catch(err => {
    	    console.error(err);
    	    alert("댓글 등록 실패");
    	  });  

    	}

            	// 수정 페이지 별점 관련
    	function setEditScore(comment_num, score){
    		  editSelectedScore[comment_num] = score;

    		  document.getElementById("editScore-" + comment_num).value = score;

    		  paintEditStar(comment_num, score);
    	}

    	// 마우스 오버
    	function hoverEditStar(comment_num, n){
    		  paintEditStar(comment_num, n);
    	}

    	function paintEditStar(comment_num, score){
    		  let stars = document.querySelectorAll("#edit-star-" + comment_num + " span");

    		  stars.forEach((s, i) => {
    		    s.style.color = i < score ? "gold" : "gray";
    		  });
    	}

    	function getStars(score){
    		  let full = "★".repeat(score);
    		  let empty = "☆".repeat(5 - score);
    		  return full + empty;
    	}

    	let editSelectedScore = {};

    	document.addEventListener("mouseover", function(e){

    	  document.querySelectorAll(".edit-star").forEach(div => {

    	    let comment_num = div.id.split("-")[2];

    	    if(!div.contains(e.target)){
    	      let score = editSelectedScore[comment_num] || 0;
    	      paintEditStar(comment_num, score);
    	    }

    	  });

    	});

    		
    	let selectedScore = 0;

    	function hoverStar(n){
    	  let stars = document.querySelectorAll("#star-input span");

    	  stars.forEach((s, i) => {
    	    s.style.color = i < n ? "gold" : "gray";
    	  });
    	}

    	function setScore(n){
    	  selectedScore = n;
    	  document.getElementById("score").value = n;

    	  hoverStar(n); // 선택 고정
    	}
    		
    	// 수정 함수
    	function updateComment(comment_num, oldContent, oldScore){

    	  let content = prompt("댓글 수정", oldContent);
    	  let score = prompt("별점 (1~5)", oldScore);

    	  if(!content) return;

    	  fetch(path + "/comment/update", {
    	    method : "POST",
    	    headers : {
    	      "Content-Type" : "application/x-www-form-urlencoded"
    	    },
    	    body : "comment_num=" + comment_num
    	         + "&content=" + encodeURIComponent(content)
    	         + "&score=" + score
    	  })
    	  .then(res => res.text())
    	  .then(data => {
    	    alert("수정 완료");
    	    loadComments();
    	    loadRating();
    	  });
    	}

    	// 수정 UI 열기
    	function showEdit(comment_num){
    		  // 모든 edit 닫기
    		  document.querySelectorAll(".edit-area").forEach(el => {
    		    el.style.display = "none";
    		  });
    		  
    		  // 모든 content 다시 보이게
    		  document.querySelectorAll(".comment-content").forEach(el => {
    		    el.style.display = "block";
    		  });	  

    		  // 선택한 것만 열기
    		  document.getElementById("edit-" + comment_num).style.display = "block";
    		  document.getElementById("content-" + comment_num).style.display = "none";
    		  
    		  // 버튼 숨김/표시
    		  document.querySelector("#edit-" + comment_num).parentElement.querySelector(".edit-btn").style.display = "none";
    		  document.querySelector("#edit-" + comment_num).parentElement.querySelector(".delete-btn").style.display = "none";

    		  document.querySelector("#edit-" + comment_num).parentElement.querySelector(".save-btn").style.display = "inline-block";
    		  document.querySelector("#edit-" + comment_num).parentElement.querySelector(".cancel-btn").style.display = "inline-block";	  
    		  
    		  // 별점 색칠
    		  let score = document.getElementById("editScore-" + comment_num).value;
    		  setEditScore(comment_num, score);	  
    	}

    	// 수정 취소
    	function cancelEdit(comment_num){
    	  document.getElementById("edit-" + comment_num).style.display = "none";
    	  document.getElementById("content-" + comment_num).style.display = "block";  
    	  
    	  // 버튼 원상복구
    	  let parent = document.getElementById("edit-" + comment_num).parentElement;

    	  parent.querySelector(".edit-btn").style.display = "inline-block";
    	  parent.querySelector(".delete-btn").style.display = "inline-block";

    	  parent.querySelector(".save-btn").style.display = "none";
    	  parent.querySelector(".cancel-btn").style.display = "none";  
    	}

    	// 저장
    	function saveEdit(comment_num){

    	  let content = document.getElementById("editContent-" + comment_num).value;
    	  let score = document.getElementById("editScore-" + comment_num).value;

    	  fetch(path + "/comment/update", {
    	    method : "POST",
    	    headers : {
    	      "Content-Type" : "application/x-www-form-urlencoded"
    	    },
    	    body : "comment_num=" + comment_num
    	         + "&content=" + encodeURIComponent(content)
    	         + "&score=" + score
    	  })
    	  .then(res => res.text())
    	  .then(data => {
    	    alert("수정 완료");
    	    loadComments();
    	    loadRating();
    	  });
    	}

    	// 삭제 함수
    	function deleteComment(comment_num){
    	  if(!confirm("삭제하시겠습니까?")) return;

    	  fetch(path + "/comment/delete", {
    	    method : "POST",
    	    headers : {
    	      "Content-Type" : "application/x-www-form-urlencoded"
    	    },
    	    body : "comment_num=" + comment_num
    	  })
    	  .then(res => res.text())
    	  .then(data => {
    	    alert("삭제 완료");
    	    loadComments();
    	    loadRating();
    	  });
    	}

    	// 댓글 파라미터 애니메이션 효과
    	function init() {
    		console.log("init 실행");

    		loadComments(() => { // 댓글
				loadRating();
			});
    	

			// star-input 안전 처리
			const starInput = document.getElementById("star-input");
			if (starInput) {
				starInput.addEventListener("mouseleave", function(){
					hoverStar(selectedScore);
				});
			}
    	}

    	function loadRating(){

    	    let movieCode = document.getElementById("movie_code").value;

    	    fetch(path + "/comment/rating?movie_code=" + movieCode)
				.then(res => res.json())
				.then(data => {

    	        // 평균
    	        document.querySelector(".rating-left h1").innerText = data.avg.toFixed(1);

    	        // 총 개수
    	        document.querySelector(".rating-left p").innerText = data.count + "명 평가";

    	        // 평점 퍼센트
    	        let percent = (data.avg / 5) * 100;
    	        
    	        const starFront = document.querySelector(".stars-bottom .star-front");
    	        
    	        if (starFront) {
    	        	starFront.style.width = percent + "%";
    	        }
    	        
				console.log(percent);

    	        // 막대
    	        const bars = document.querySelectorAll(".fill");
    	        
    	        // 1단계: 전부 0으로 초기화
    	        bars.forEach(bar => {
    	            bar.style.width = "0%";
    	        });
				
				bars[0].offsetWidth;

    	        // 2단계: 살짝 딜레이 후 다시 채움 (핵심)
    	        setTimeout(() => {
    	            bars.forEach((bar, i) => {
    	                let score = i + 1;
    	                
    	                let count = data.map[score] || 0;
    	                let percent = data.count > 0 ? (count * 100 / data.count) : 0;

    	                bar.style.width = percent + "%";
    	            });
    	        }, 300); // 0.3초 딜레이

    	    });
    	}

		if (document.readyState === "loading") {
			document.addEventListener("DOMContentLoaded", init);
		} else {
			init();
		}		

