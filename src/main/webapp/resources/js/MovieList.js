/**
 * 관리자 영화관리 페이지에 삽입된 JavaScript
 */


function showStory(btn) {

    let story = btn.dataset.story;

    // null / undefined 방어
    if (!story || story === 'null') {
        alert("줄거리를 준비중입니다.");
        return;
    }

    // 문자열 보장
    story = String(story);

    if (story.trim() === '') {
        alert("줄거리가 없습니다.");
        return;
    }    

    document.getElementById("storyText").innerText = story;
    document.getElementById("storyModal").style.display = "block";
}

function closeModal() {
    document.getElementById("storyModal").style.display = "none";
}

document.addEventListener("DOMContentLoaded", function() {

    const fileInput = document.getElementById("posterFile");
    const previewImg = document.getElementById("previewImg");

    if (fileInput) {
        fileInput.addEventListener("change", function(e) {

            const file = e.target.files[0];

            if (file) {
                if (!file.type.startsWith("image/")) {
                    alert("이미지 파일만 선택 가능합니다.");
                    return;
                }

                // previewImg 있을 때만 실행
                if (previewImg) {
                    const reader = new FileReader();
                    reader.onload = function(event) {
                        previewImg.src = event.target.result;

                        previewImg.style.display = "block";                                 // 이미지 보이기
                        document.getElementById("noImageText").style.display = "none";      // 텍스트 숨기기                        
                    };

                    reader.readAsDataURL(file);
                }
                
            }

            const fileName = e.target.files.length > 0 
                ? e.target.files[0].name 
                : "선택된 파일 없음";

            document.getElementById("file-name").innerText = fileName;
        });
    }
});

document.addEventListener("DOMContentLoaded", function() {

/**
 * 관리자 영화관리 페이지에 삽입된 JavaScript
 */


function showStory(btn) {

    let story = btn.dataset.story;

    // null / undefined 방어
    if (!story || story === 'null') {
        alert("줄거리를 준비중입니다.");
        return;
    }

    // 문자열 보장
    story = String(story);

    if (story.trim() === '') {
        alert("줄거리가 없습니다.");
        return;
    }    

    document.getElementById("storyText").innerText = story;
    document.getElementById("storyModal").style.display = "block";
}

function closeModal() {
    document.getElementById("storyModal").style.display = "none";
}

document.addEventListener("DOMContentLoaded", function() {

    const fileInput = document.getElementById("posterFile");
    const previewImg = document.getElementById("previewImg");

    if (fileInput) {
        fileInput.addEventListener("change", function(e) {

            const file = e.target.files[0];

            if (file) {
                if (!file.type.startsWith("image/")) {
                    alert("이미지 파일만 선택 가능합니다.");
                    return;
                }

                // previewImg 있을 때만 실행
                if (previewImg) {
                    const reader = new FileReader();
                    reader.onload = function(event) {
                        previewImg.src = event.target.result;

                        previewImg.style.display = "block";                                 // 이미지 보이기
                        document.getElementById("noImageText").style.display = "none";      // 텍스트 숨기기                        
                    };

                    reader.readAsDataURL(file);
                }
                
            }

            const fileName = e.target.files.length > 0 
                ? e.target.files[0].name 
                : "선택된 파일 없음";

            document.getElementById("file-name").innerText = fileName;
        });
    }
});

document.addEventListener("DOMContentLoaded", function() {

    setTimeout(() => {
            document.querySelectorAll(".poster-path").forEach(el => {

                el.style.opacity = 0;  // 먼저 서서히 사라짐

                setTimeout(() => {
                    el.remove();       // 그 다음 제거
                }, 300);

            });
        }, 3000);

    });


});