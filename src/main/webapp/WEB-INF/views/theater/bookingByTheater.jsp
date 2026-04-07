<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<section class="content">
	<div class="container">
	
		<div class="panel-theater">
            <c:forEach var="theater" items="${theaterList}">
                <div class="theater-item ${theater.theater_code == selectedTheater ? 'selected' : ''}"
                     onclick="selectTheater(${theater.theater_code})">
                    ${theater.theater_name}
                </div>
            </c:forEach>
        </div>
        
        <div class="panel-branch" id="branchPanle">
        	지점을 선택하세요.
        </div>
        
        
        
        
	</div>
</section>
	
<script>
	document.addEventListener('DOMContentLoaded', function() {
	    loadBranches(${selectedTheaterCode});
	});
</script>
<%@ include file="../common/footer.jsp" %>