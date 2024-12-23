<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:set var="pageTitle" value="실패" />


<script>
    <c:if test="${not empty message}">
        alert("${message}"); // 서버에서 전달된 message를 alert로 띄우기
        setTimeout(function() {
            window.location.href = "${redirectUrl}"; 
        });
    </c:if>

    <c:if test="${not empty failMessage}">
        alert("${failMessage}"); // 실패 메시지
    </c:if>
</script>

	<a href="/usr/home/home">홈으로 가기</a>

	
	
<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>