<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="채팅" />
<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<style>
.chat-container {
	max-width: 600px;
	margin: auto;
	padding: 10px;
	border-radius: 15px;
	background: #A3C9F1;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	font-family: 'Arial', sans-serif;
}

.chat-header {
	text-align: center;
	padding: 15px;
	background: #0078d4;
	color: white;
	font-weight: bold;
	border-radius: 10px 10px 0 0;
}

.messages {
	height: 450px;
	overflow-y: auto;
	padding: 10px;
	background: #D9E8F7; /* 연한 하늘색 배경 */ /* 밝은 회색 배경 */
	border-radius: 8px;
	margin-bottom: 20px;
}

.message {
	margin: 10px 0;
	padding: 15px 20px;
	border-radius: 20px;
	max-width: 75%;
	word-wrap: break-word;
	font-size: 16px;
	position: relative;
	display: flex;
	flex-direction: column; /* 세로로 쌓이도록 변경 */
	align-items: flex-start;
}

.sent {
	background-color: #FFEB3B; /* 노란색 */
	color: black;
	float: right;
	text-align: right;
	border-radius: 20px 20px 0 20px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.received {
	background-color: #03A9F4; /* 파란색 */
	color: white;
	float: left;
	text-align: left;
	border-radius: 20px 20px 20px 0;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.sender-name {
	font-weight: bold;
	font-size: 15px;
	color: #4e00d4;
}

.timestamp {
	font-size: 12px;
	color: #bbb;
	margin-top: 5px;
}

.read-status {
	font-size: 12px;
	color: #bbb;
	margin-top: 5px;
}

.read-status.read {
	color: green;
}

.read-status.unread {
	color: red;
}

.clear {
	clear: both;
}

.chat-footer {
	display: flex;
	padding: 10px;
	background: #fff;
	border-top: 1px solid #ddd;
}

.chat-footer input[type="text"] {
	flex: 1;
	padding: 12px;
	border: 1px solid #ddd;
	border-radius: 25px;
	outline: none;
	font-size: 14px;
}

.chat-footer button {
	margin-left: 10px;
	padding: 12px 25px;
	background-color: #0078d4;
	color: white;
	border: none;
	border-radius: 25px;
	cursor: pointer;
	font-weight: bold;
}

.chat-footer button:hover {
	background-color: #0056b3;
}

.message {
    margin: 10px 0;
    padding: 15px 20px;
    border-radius: 20px;
    max-width: 75%;
    word-wrap: break-word;
    font-size: 16px;
    position: relative;
    display: flex;
    flex-direction: column; /* 세로로 쌓이도록 변경 */
    align-items: flex-start;
}

.message .message-content {
	display: flex;
	flex-direction: column;
	align-items: flex-start;
}

.message .message-content p {
	margin-bottom: 5px;
}

.message .message-details {
	display: flex;
	justify-content: space-between;
	width: 100%;
	font-size: 12px;
	color: #bbb;
	margin-top: 5px;
}

.message .message-details {
	display: flex;
	justify-content: space-between;
	width: 100%;
	font-size: 12px;
	color: #bbb;
	margin-top: 5px;
	align-items: center; /* 수평 중앙 정렬 */
}

.message .message-details .sender-name {
	color: #0078d4;
	font-weight: bold;
}

.message .message-details .timestamp {
	color: #999;
}

.message .message-details .read-status {
	color: #bbb;
}

.unread-status {
	text-align: center;
	margin-top: 20px;
	font-size: 14px;
	color: red;
	font-weight: bold;
}
</style>
<script>
	function timeAgo(timestamp) {
		const now = new Date();
		const diff = now - new Date(timestamp); // 현재 시간과 차이 계산
		const seconds = Math.floor(diff / 1000);
		const minutes = Math.floor(seconds / 60);
		const hours = Math.floor(minutes / 60);
		const days = Math.floor(hours / 24);
		const months = Math.floor(days / 30);
		const years = Math.floor(days / 365);

		if (seconds < 60) {
			return seconds + '초 전';
		} else if (minutes < 60) {
			return minutes + '분 전';
		} else if (hours < 24) {
			return hours + '시간 전';
		} else if (days < 30) {
			return days + '일 전';
		} else if (months < 12) {
			return months + '개월 전';
		} else {
			return years + '년 전';
		}
	}

	// 페이지 로드 후 각 타임스탬프 업데이트
	window.onload = function() {
		const timestamps = document.querySelectorAll('.timestamp .time');
		timestamps.forEach(function(timestamp) {
			const timeText = timestamp.textContent.trim();
			const timeAgoText = timeAgo(timeText);
			timestamp.textContent = timeAgoText;
		});
	}
</script>

<div class="chat-container">
	<div class="chat-header">${chat[0].senderName}님과
		${chat[0].receiverName}님의 채팅</div>
	<div class="messages">
		<!-- 기존 채팅 메시지 표시 -->
		<c:forEach var="chat" items="${chat}">
    <div class="${chat.senderId == sessionScope.loginedMember.id ? 'message sent' : 'message received'}" data-chat-id="${chat.id}">
        <div class="sender-name">
            <c:if test="${chat.senderId == sessionScope.loginedMember.id}">나</c:if>
            <c:if test="${chat.senderId != sessionScope.loginedMember.id}">${chat.senderName}</c:if>
        </div>
        <div class="message-box">
            <p>${chat.content}</p>
        </div>

        <div class="timestamp">
            <c:if test="${chat.senderId == sessionScope.loginedMember.id}">
                <span class="time">${chat.timestamp}</span>
            </c:if>

            <c:if test="${chat.senderId != sessionScope.loginedMember.id}">
                <span class="time">${chat.timestamp}</span>
            </c:if>
        </div>

        <!-- 안읽음 표시 (메시지 밑에 위치) -->
        <c:if test="${chat.isRead == 1}">
            <div class="unread-status">
                <span class="read-status unread">안읽음</span>
            </div>
        </c:if>

    </div>

    <div class="clear"></div>
</c:forEach>


	</div>

	<!-- 새 메시지 입력 및 전송 -->
	<form action="/usr/chat/send" method="post" class="chat-footer">
		<input type="hidden" name="receiverId" value="${receiverId}" /> <input
			type="text" name="content" placeholder="메시지를 입력하세요" required />
		<button type="submit">보내기</button>
	</form>
</div>



<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>
