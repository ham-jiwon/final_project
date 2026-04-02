<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="comment-section">

  <input type="hidden" id="movie_code" value="${movie.movie_code}">
  <input type="hidden" id="member_id" value="${loginMember.id}">

  <h3>댓글</h3>
  
  <div id="comment-list"></div>

  <div class="comment-input-area">

  <textarea id="content" placeholder="댓글 입력"></textarea>
  
  <div class="comment-side">
  
	  <div id="star-input">
		  <span onmouseover="hoverStar(1)" onclick="setScore(1)">★</span>
		  <span onmouseover="hoverStar(2)" onclick="setScore(2)">★</span>
		  <span onmouseover="hoverStar(3)" onclick="setScore(3)">★</span>
		  <span onmouseover="hoverStar(4)" onclick="setScore(4)">★</span>
		  <span onmouseover="hoverStar(5)" onclick="setScore(5)">★</span>
	  </div>
	  
	  <input type="hidden" id="score">
	
	  <button onclick="writeComment()">등록</button>
  
  </div>
</div>
</div>

<script>

const path = "${pageContext.request.contextPath}";

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
  .then(res => res.text())
  .then(data => {
    console.log("응답:", data);
    alert("댓글 등록 완료");

    // 입력 초기화
    document.getElementById("content").value = "";
    document.getElementById("score").value = "";

    // TODO: 댓글 다시 불러오기
    loadComments();
  });

}


function loadComments(){

	  let movieCode = document.getElementById("movie_code").value;
	  
	  let loginId = document.getElementById("member_id").value;

	  fetch(path + "/comment/list?movie_code=" + movieCode)
	  .then(res => res.json())
	  .then(data => {

	    let html = "";

	    data.forEach(c => {
	    	// 디버깅용 출력코드
	    	console.log("loginId type :", typeof loginId);
	    	console.log("c.member_id type :", typeof c.member_id);
	    	
 	  		html += "<div class='comment-item'>";
 	  		
	  		html += "<b>" + c.member_id + "</b>";
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

		    html += "<button onclick='saveEdit(" + c.comment_num + ")'>저장</button>";
		    html += "<button onclick='cancelEdit(" + c.comment_num + ")'>취소</button>";
		    html += "</div>";
		    
		    // 버튼
		    if(loginId === c.member_id){
			    html += "<button onclick='showEdit(" + c.comment_num + ")'>수정</button>";		    
		  		html += "<button onclick='deleteComment(" + c.comment_num + ")'>삭제</button>";
		    }
		    
	  	    html += "<hr>";	  		
	  		html += "</div>";	    	
	    });

	    document.getElementById("comment-list").innerHTML = html;
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

document.getElementById("star-input").addEventListener("mouseleave", function(){
  hoverStar(selectedScore); // 원래 선택값으로 복구
});	
	
	
window.onload = function(){
	  loadComments();
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
	  
	  // 별점 색칠
	  let score = document.getElementById("editScore-" + comment_num).value;
	  setEditScore(comment_num, score);	  
}

// 수정 취소
function cancelEdit(comment_num){
  document.getElementById("edit-" + comment_num).style.display = "none";
  document.getElementById("content-" + comment_num).style.display = "block";  
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
  });
}



</script>

