<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="채팅" />
<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
<script>
	//웹소켓 사용 스크립트
	$(function() {
		// 웹소켓 연결 설정
		let socket = new SockJS('/ws-stomp');
		let stompClient = Stomp.over(socket);

		// 웹소켓 서버에 연결 후 메시지 구독
		stompClient.connect({}, function() {

			let userId = $('#userId').text();
			stompClient.subscribe('/sub/message', function(message) {
				// 메시지가 도착할 때마다 기존 메시지에 추가
				let notificationDiv = $('#notifications');
				notificationDiv.append(`<span>\${message.body}</span>`);
			})
		})

		$('#sendNotification').click(function() {
			let sender = $('#userId').text(); // 로그인된 사용자 ID
			let receiverId = $('#receiverId').text(); // 수신자 ID
			let content = $('#message').val(); // 입력된 메시지
			
			 console.log("Receiver ID: ", receiverId); 
			
			stompClient.send('/pub/messages', {}, JSON.stringify({
				senderId : sender,
				receiverId : receiverId,
				content : content
			}));
		})
	})
	
</script>
<form action="/usr/chat/send" method="post" class="chat-footer">
	<div>
		<div>알림테스트</div>
		<div>
			현재 로그인된 회원의 ID : <span id="userId">${loginedMember.getName() }</span>
		</div>
		<div>
			알림을 받을 사용자 ID : <span id="receiverId">${member.getName() }</span>
					
		</div>
		<br /> <label> 알림으로 보낼 메시지 : <input
			class="input input-bordered" id="message" name="content" type="text">
		</label> <br />
		<input type="hidden" id="receiverId" name="receiverId" value="${member.id}" />
		<button id="sendNotification">알림 보내기</button>
		<div>알림으로 받은 메시지 내용</div>
		<div id="notifications"></div>
	</div>
</form>
<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>

