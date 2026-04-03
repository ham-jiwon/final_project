/**
 * inputCheck.js
 */

// 문서가 모두 로드 되면 실행
window.onload = function(){
	// tag 이름이 input인 모든 요소들을 배열로 반환
	var input = document.getElementsByTagName("input");
	// 전체 버튼을 선택
	var btns = document.querySelectorAll("button");
	
	if(!btns) return;	
	
	// button tag click event 발생 시 호출 될 함수
	btns.forEach(function(btn){                      // 반복 처리
	    btn.addEventListener("click", function(event){  // 덮어쓰기 X
		
			for(var i = 0; i<input.length; i++){
				// 작성된 value 값이 없을때.
				if(input[i].value.length == 0 && input[i].dataset.msg){
					var msg = input[i].dataset.msg+"를 확인해주세요.";
					alert(msg);
					input[i].focus();
					// 기본 이벤트 무시(전역 로직 설정되는지 최소 1회 확인)
					event.preventDefault();
					break;
				}
			}
		});
	});
	
}










