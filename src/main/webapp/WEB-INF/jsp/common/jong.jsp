<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html data-theme="light">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle }</title>
    <!-- 테일윈드CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Daisy UI -->
    <link href="https://cdn.jsdelivr.net/npm/daisyui@4.12.14/dist/full.min.css" rel="stylesheet" type="text/css" />
    <!-- JQuery -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- 폰트어썸 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <!-- common css -->
    <link rel="stylesheet" href="/resource/common.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Single+Day&display=swap" rel="stylesheet">
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

</head>
<style>
/* 종 이미지 고정 */
.notification-container {
    position: fixed;
    bottom: 20px;
    right: 20px;
    z-index: 9999;
}

/* 종 이미지 스타일 */
.bell-icon {
    width: 50px;
    height: 50px;
    cursor: pointer;
    position: relative;
}

/* 알림 배지 스타일 */
.notification-badge {
    position: absolute;
    top: -5px;
    right: -5px;
    width: 20px;
    height: 20px;
    background-color: red;
    color: white;
    font-size: 12px;
    font-weight: bold;
    border-radius: 50%;
    display: flex;  /* 항상 표시되게 함 */
    align-items: center;
    justify-content: center;
}
</style>

<body>
	
    <div class="notification-container">
        <img src="/upload/jong.jpg" alt="Notification" class="bell-icon">
        <span id="notification-badge" class="notification-badge">
            <c:choose>
                <c:when test="${jongCount > 0}">
                    ${jongCount}
                </c:when>
                <c:otherwise>
                    0
                </c:otherwise>
            </c:choose>
        </span>
    </div>

</body>
</html>
