<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="comment-section">

  <input type="hidden" id="movie_code" value="${movie.movie_code}">
  <input type="hidden" id="member_id" 
  		 value="${sessionScope.loginMember.id}">
		 <%-- <span style="color:gray">로그인ID: ${sessionScope.loginMember.id}</span> --%>
  <input type="hidden" id="is_admin" 
         value="${sessionScope.loginMember.id eq 'admin'}">
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
