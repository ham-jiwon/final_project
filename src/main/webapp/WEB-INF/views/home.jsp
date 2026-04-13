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
	
		<div class="poster-top">
		
	        <!-- 왼쪽 영역 -->
	        <div class="left">
			

			
				<div id="imagePicker" style="display:none;">
				    <!-- 파일 선택 버튼 -->
			   		<label for="bannerFile" class="file-label btn btn-primary">파일 선택</label>
				    <input type="file" id="bannerFile" accept="image/*">
				    
				    <!-- 파일명 표시 -->
			   		<span id="fileName" class="file-name">선택된 파일 없음</span>
				    
				    <!-- 업로드 버튼 -->
				    <button class="btn btn-primary" onclick="uploadBanner()">배너 추가</button>
			    </div>
		    </div>	

	        <!-- 오른쪽 버튼 -->
	        <div class="right">		    
   			<!-- 관리자만 볼 수 있게 버튼 숨기기 -->
				<c:if test="${loginMember != null and loginMember.id eq 'admin'}">
					<button id="openBtn" onclick="toggleList()">이미지 선택</button>
				</c:if>	
			</div>
			
		</div>
		
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
	let banners = [];

	// 불러오기
	window.onload = function(){
	    fetch('/cinema/banner/list')
	        .then(res => res.json())
	        .then(data => {
	        	
	            banners = data;

	            loadImages();
	            
	            const activeBanner = banners.find(b => 
	                b.isActive && b.isActive.trim().toUpperCase() === 'Y'
	            );
	
	            if(activeBanner){
	                changeMain(activeBanner.imgName, document.querySelector(".thumb"));
	                return;
	            }	            

	            const saved = localStorage.getItem("selectedBanner");

	            if(saved){
	                document.querySelector(".main").style.backgroundImage =
	                    "linear-gradient(to bottom, rgba(0,0,0,0.7) 0%, rgba(0,0,0,0.5) 20%, rgba(0,0,0,0.2) 35%, rgba(0,0,0,0.2) 65%, rgba(0,0,0,0.5) 80%, rgba(0,0,0,0.7) 100%)," +
	                    "url('/cinema/resources/img/banner/" + saved + "')";
	            }else if(banners.length > 0){
	                // 기본 배너 설정
	                changeMain(banners[0].imgName, document.querySelector(".thumb"));
	            }
	        });
	}

	// 썸네일 생성
	function loadImages(){
	    let html = "";

	    banners.forEach(function(b){
	    	console.log("banner:", b);
	    	const inactive = !isAdmin && false; // 필요하면 확장
	    	
	        html += '<div class="thumb-box">';

	        html += '<img src="/cinema/resources/img/banner/' + b.imgName + '" '
	              + 'class="thumb" '
	              + ((b.isActive && b.isActive.trim().toUpperCase() === 'Y')
            	  		? 'onclick="changeMain(\'' + b.imgName + '\', this)"' 
        	  			: '') 
    	  		  + '>';
    	  		  
   	  		console.log("isActive:", "[" + b.isActive + "]");

	        if(isAdmin){
	            html += '<div class="admin-btns">';
	            
	            let isOn = (b.isActive && b.isActive.trim().toUpperCase() === 'Y');
	            let btnClass = (b.isActive === 'Y') ? 'on' : 'off';
	            let btnText  = (b.isActive === 'Y') ? 'ON' : 'OFF';
	            let nextState = isOn ? 'N' : 'Y';
	            
	            html += '<button type="button" class="banner-btn ' + btnClass + '" ' + 
	            		'data-id="' + b.id + '" ' +
	            		'data-next="' + nextState + '" ' +
	            		'onclick="event.stopPropagation(); toggleActive(this)">'
	            		+ btnText + '</button>';
	            html += '<button class="btn btn-danger" onclick="event.stopPropagation(); deleteBanner(' + b.id + ')">삭제</button>';
	            html += '</div>';
	        }

	        html += '</div>';
	    });
	    
	    document.getElementById("imgList").innerHTML = html;
	}

	// 관리자 권한 분기 처리
	const isAdmin = "${loginMember != null and loginMember.id eq 'admin'}" === "true";
	
	// ⭐ 버튼 → 리스트 열고 닫기
	function toggleList(){
	    console.log("isAdmin:", isAdmin);  // 👈 확인용
	    
	    if(!isAdmin){
	        alert("관리자만 사용 가능");
	        return;
	    }		
	    
	    const picker = document.getElementById("imagePicker");
	    
	    picker.style.display =
	        (picker.style.display === "block") ? "none" : "block";

	    const list = document.getElementById("imgList");
	    const btn = document.getElementById("openBtn");

	    list.classList.toggle("show");

	    btn.innerText = list.classList.contains("show") 
	        ? "닫기" 
	        : "이미지 선택";
	}

	// ⭐ 이미지 변경
	function changeMain(img, el){
		
		const url = "/cinema/resources/img/banner/" + img + "?t=" + new Date().getTime();
		
		document.querySelector(".main").style.backgroundImage = 
			"linear-gradient(to bottom, rgba(0,0,0,0.7) 0%, rgba(0,0,0,0.5) 20%, rgba(0,0,0,0.2) 35%, rgba(0,0,0,0.2) 65%, rgba(0,0,0,0.5) 80%, rgba(0,0,0,0.7) 100%), " +
			"url('" + url + "')";

	    // 선택 강조
	    document.querySelectorAll(".thumb").forEach(e => e.classList.remove("active"));
	    el.classList.add("active");
	    
	    // 리스트 닫기
	    const list = document.getElementById("imgList");
	    const btn = document.getElementById("openBtn");
	    
	    // 이미지 로컬에 저장
	    localStorage.setItem("selectedBanner", img);
	}
		
	// update 기능
	function toggleActive(btn){
		
	    const id = btn.dataset.id;
	    const next = btn.dataset.next;
	    
	    console.log("id:", id, "next:", next);
		
	    if(!id || !next){
	        console.error("잘못된 값", id, next);
	        return;
	    }		
		
	    fetch('/cinema/banner/update', {
	        method: 'POST',
	        headers: {'Content-Type': 'application/x-www-form-urlencoded'
        	},
            body: new URLSearchParams({
                id: id,
                isActive: next
            })
	    }).then(res => {
	        // 다시 목록 불러오기
	        if(!res.ok) throw new Error("서버 오류");
	        return res.text();
   		})
        .then(() => {
            console.log("성공");
            // 다시 목록만 갱신
            fetch('/cinema/banner/list')
                .then(res => res.json())
                .then(data => {
                    banners = data;
                    loadImages();   // 👈 여기 핵심
                });       	
        })
        .catch(err => console.error(err));
	}
	
	// upload 기능
	function uploadBanner(){

	    const fileInput = document.getElementById("bannerFile");
	    const file = fileInput.files[0];

	    if(!file){
	        alert("파일 선택해라");
	        return;
	    }

	    const formData = new FormData();
	    formData.append("file", file);

	    fetch('/cinema/banner/upload', {
	        method: 'POST',
	        body: formData
	    })
	    .then(res => {
	        if(!res.ok) throw new Error("업로드 실패");
	        return res.text();
	    })
	    .then(() => {
	        console.log("업로드 성공");

	        return fetch('/cinema/banner/list');
	    })
	    .then(res => res.json())
	    .then(data => {
	        banners = data;
	        loadImages();
	    })
	    .catch(err => console.error(err));
	}	
	
	// delete 기능
	function deleteBanner(id){
	    if(!confirm("삭제할까?")) return;
	
	    fetch('/cinema/banner/delete?id=' + id, {
	        method: 'POST'
	    }).then(() => location.reload());
	}
	
	document.querySelectorAll("form").forEach(f => {
	    f.addEventListener("submit", e => e.preventDefault());
	});	
	
	// 파일 선택 로직
	document.getElementById("bannerFile").addEventListener("change", function(){
	    const file = this.files[0];

	    document.getElementById("fileName").innerText =
	        file ? file.name : "선택된 파일 없음";
	});	
	
	</script>

<%@ include file="/WEB-INF/views/gridTableNew.jsp" %>

<%@ include file="common/footer.jsp" %>
