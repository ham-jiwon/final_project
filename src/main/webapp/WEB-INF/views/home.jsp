<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp" %>

	<!-- <script>alert("회원 탈퇴 완료되었습니다.")</script> -->
	
	<!-- 디버깅용 사용자 정보 확인 코드
	<div style="color:red;">
    loginUser: ${loginMember} <br>
    userId: ${loginMember.id}
	</div>
	 -->
	


<c:set var="path" value="${pageContext.request.contextPath}" />
	
	<section id="poster">
		<!-- 관리자만 볼 수 있게 버튼 숨기기 -->
		<c:if test="${loginMember != null and loginMember.id eq 'admin'}">
		<button id="openBtn" onclick="toggleList()">이미지 선택</button>
		</c:if>
		<div id = "imgList"></div>
	</section>
	<section class="main">
	
	<div class="text-box">
		<h1>저희 Cinema in Busan 홈페이지를 찾아주셔서 감사합니다.</h1>
		<h3>따사로운 계절을 맞이하여 여러 흥미로운 영화가 선보이고 있습니다. 
		자칫 무료한 일상에 여러분의 소중한 사람들과 함께 간직할 아름다운 추억과 감동의 시간들을 보내시길 바라며
		귀하와 귀하의 가정에 항상 좋은 일들만 가득하시기를 바랍니다.</h3>
		<h3>In the warm season, several interesting movies are on display.
			We hope you have beautiful memories and touching moments that you will cherish with your precious people in your boring daily life
			We hope you and your household are always full of good things.</h3>
	</div>
	</section>

	<script>
	let images = [
	    "banner_00.png",
	    "banner_01.png",
	    "banner_02.png",
	    "banner_03.png",
	    "banner_04.png",
	    "banner_05.png",
	    "banner_06.jpg"
	];
	
	// 불러오기
	window.onload = function(){
	    loadImages();
	    const saved = localStorage.getItem("selectedBanner");

	    if(saved){
	        document.querySelector(".main").style.backgroundImage =
	            "linear-gradient(to bottom, rgba(0,0,0,0.7) 0%, rgba(0,0,0,0.5) 20%, rgba(0,0,0,0.2) 35%, rgba(0,0,0,0.2) 65%, rgba(0,0,0,0.5) 80%, rgba(0,0,0,0.7) 100%), " +
	            "url('/cinema/resources/img/banner/" + saved + "')";
	    }	    
	}

	// 썸네일 생성
	function loadImages(){
	    let html = "";

	    images.forEach(function(img){
	        html += '<img src="/cinema/resources/img/banner/' + img + '" '
	              + 'class="thumb" '
	              + 'onclick="changeMain(\'' + img + '\', this)">';
	    });
	    
	    document.getElementById("imgList").innerHTML = html;
	}

	// 관리자 권한 분기 처리
	const isAdmin = ${loginMember != null and loginMember.id eq 'admin'};
	
	// ⭐ 버튼 → 리스트 열고 닫기
	function toggleList(){
	    console.log("isAdmin:", isAdmin);  // 👈 확인용

	    if(!isAdmin){
	        alert("관리자만 사용 가능");
	        return;
	    }		
		
	    const list = document.getElementById("imgList");
	    const btn = document.getElementById("openBtn");

	    list.classList.toggle("show");

	    btn.innerText = list.classList.contains("show") 
	        ? "닫기" 
	        : "이미지 선택";
	}

	// ⭐ 이미지 변경
	function changeMain(img, el){
		document.querySelector(".main").style.backgroundImage = 
			"linear-gradient(to bottom, rgba(0,0,0,0.7) 0%, rgba(0,0,0,0.5) 20%, rgba(0,0,0,0.2) 35%, rgba(0,0,0,0.2) 65%, rgba(0,0,0,0.5) 80%, rgba(0,0,0,0.7) 100%), " +
			"url('/cinema/resources/img/banner/" + img + "')";

	    // 선택 강조
	    document.querySelectorAll(".thumb").forEach(e => e.classList.remove("active"));
	    el.classList.add("active");
	    
	    // 리스트 닫기
	    const list = document.getElementById("imgList");
	    const btn = document.getElementById("openBtn");
	    
	    // 이미지 로컬에 저장
	    localStorage.setItem("selectedBanner", img);
	}	
	</script>

<%@ include file="/WEB-INF/views/gridTableNew.jsp" %>

<%@ include file="common/footer.jsp" %>
