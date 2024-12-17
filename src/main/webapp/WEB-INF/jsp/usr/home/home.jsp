<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:set var="pageTitle" value="메인" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Single+Day&display=swap"
	rel="stylesheet">
<style>
section {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin: 4rem auto;
	max-width: 1000px;
}

.home-2 {
	margin-top: 15rem;
}

.text-box {
	flex: 1;
	text-align: left;
	margin-top: 3rem;
	margin-right: 0.5rem;
	margin-left: 5rem;
}

.text-box h1 {
	font-size: 3.5rem;
	font-family: "Single Day", cursive;
	font-weight: 400;
	color: #000;
	line-height: 1.5;
}

.text-box-2 h1 {
	font-size: 2.2rem;
	font-family: "Single Day", cursive;
	font-weight: 400;
	color: #000;
	line-height: 1.5;
}

.text-box {
	flex: 1;
	text-align: left;
	margin-top: 3rem;
	margin-right: 0.5rem;
	margin-left: 5rem;
}

.text-box-1 {
	margin-left: 5rem;
}

.text-box a {
	display: inline-block;
	margin-top: 1rem;
	margin-left: 5rem;
	padding: 0.75rem 1.5rem;
	background-color: #ec4899;
	color: #fff;
	border-radius: 9999px;
	text-decoration: none;
	font-size: 1rem;
	font-weight: bold;
	transition: background-color 0.3s ease;
}

.text-box a:hover {
	background-color: #db2777;
}

.image-container {
	flex: 1;
	position: relative;
	height: 400px;
}

.image-container div {
	position: absolute;
	width: 250px;
	height: 250px;
	border-radius: 12px;
	box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
	overflow: hidden;
}

.image1 {
	top: 10px;
	left: 50px;
	transform: rotate(-10deg);
}

.image2 {
	top: 260px;
	right: 300px;
	transform: rotate(5deg);
}

.image3 {
	top: 200px;
	left: 230px;
	transform: rotate(-5deg);
}

.image-container img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.copi, .mein {
	color: #ec4899;
}

.mein-4 {
	font-size: 1.3rem; /* 글씨 크기 조정 */
	color: #6c6c6c; /* 연한 회색으로 색상 조정 */
	font-weight: normal; /* 굵기 조정 */
}

.review {
	flex-direction: column;
	align-items: center;
	position: relative;
	width: 600px;
	background-color: #fff;
	border-radius: 20px;
	box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	padding: 20px;
	margin-bottom: 20px;
	white-space: nowrap; /* 텍스트가 한 줄로 표시되도록 설정 */
	overflow: hidden; /* 내용이 넘치면 잘리도록 설정 */
	text-overflow: ellipsis; /* 텍스트가 넘칠 경우 생략 부호로 표시 */
}

.review:hover {
	transform: translateY(-10px);
	box-shadow: 0 12px 20px rgba(0, 0, 0, 0.15);
}

.review-container {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
	background-color: #f0f4f8;
	padding: 2rem;
	margin-top: 5rem; /* 이 부분을 더 크게 조정하여 아래로 내려보세요 */
	margin-bottom: 5rem; /* 추가로 아래에 여백을 줄 수도 있습니다 */
	border-radius: 10px;
}

.review-box {
	display: none;
}

.review-box.active {
	display: block;
}
</style>
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
	display: flex; /* 항상 표시되게 함 */
	align-items: center;
	justify-content: center;
}

.home-4 {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin: 4rem auto;
	margin-top: 18rem;
	max-width: 1000px;
}

.home-4 .image-container {
	flex: 1;
	position: relative;
	height: 400px; /* 이미지 크기 조정 */
}

.home-4 .chat-image {
	width: 100%;
	height: 100%;
	object-fit: cover; /* 이미지가 박스 크기에 맞게 채워지도록 설정 */
	border-radius: 15px; /* 모서리 둥글게 처리 */
}

.home-4 .text-box {
	flex: 1;
	text-align: left;
	margin-left: 3rem;
}

.home-4 .text-box h1 {
	font-size: 2.5rem;
	font-family: "Single Day", cursive;
	font-weight: 400;
	color: #000;
	line-height: 1.5;
}

.text-box-4 h1 {
	font-size: 1.8rem; /* 글씨 크기 조정 */
	color: #6c6c6c; /* 연한 회색으로 색상 조정 */
	font-weight: normal; /* 굵기 조정 */
}

.home-4 .text-box .mein {
	color: #ec4899;
}

@media ( max-width : 768px) {
	.home-4 {
		flex-direction: column;
		align-items: center;
		text-align: center;
	}
	.home-4 .image-container {
		width: 80%;
		height: auto;
	}
	.home-4 .text-box {
		margin-left: 0;
		margin-top: 2rem;
	}
}
</style>
<style>
/* 아래에서 위로 올라오는 애니메이션 */
@keyframes slideUp {
    0% {
        opacity: 0;
        transform: translateY(50px); /* 텍스트가 아래에서 시작 */
    }
    100% {
        opacity: 1;
        transform: translateY(0); /* 텍스트가 원위치로 */
    }
}

.home-1 .text-box {
    animation: slideUp 1s ease-out; /* 애니메이션 적용 */
}

@keyframes slideInLeft {
    0% {
        opacity: 0;
        transform: translateX(-50px); /* 왼쪽에서 시작 */
    }
    100% {
        opacity: 1;
        transform: translateX(0); /* 원위치로 */
    }
}

.home-2 .text-box {
    animation: slideInLeft 1s ease-out; /* 애니메이션 적용 */
}

.home-4 .text-box {
    animation: slideInLeft 1s ease-out; /* 애니메이션 적용 */
}

/* 오른쪽에서 왼쪽으로 나타나는 애니메이션 */
@keyframes slideInRight {
    0% {
        opacity: 0;
        transform: translateX(50px); /* 오른쪽에서 시작 */
    }
    100% {
        opacity: 1;
        transform: translateX(0); /* 원위치로 */
    }
}

.home-3 .text-box h1 {
    animation: slideInRight 1s ease-out; /* 애니메이션 적용 */
}

</style>


<section class="home-1">
	<div class="image-container">
		<div class="image1">
			<img src="/resource/img/couple1.jpg" alt="친구 1">
		</div>
		<div class="image2">
			<img src="/resource/img/couple2.jpg" alt="친구 2">
		</div>
		<div class="image3">
			<img src="/resource/img/couple3.jpg" alt="친구 3">
		</div>
	</div>
	<div class="text-box">
		<h1 class=text-box-1>
			전국 팔도 <span class="mein">미인</span>들<br> <span class="copi">코피</span>에
			다 모였다!
		</h1>
		<a href="/usr/member/join">코피 회원가입하기</a>
	</div>
</section>





<section class="home-2">
	<div class="text-box-2">
		<h1 class="text-box">
			<span class="mein">실제 이용자</span>들이<br> 남긴 소중한 후기, <br> <span
				class="mein">2000개 이상</span>의<br> 진솔한 경험담!
		</h1>
	</div>
	<div class="review-container"
		style="background-color: #f7d1d1; position: relative; left: 100px;">
		<!-- 첫 번째 5개의 리뷰 -->
		<div class="review-box active">
			<div class="review">“코피는 정말 편리하고, 빠르게 만날 수 있는 서비스입니다! 정말 좋아요!”</div>
			<div class="review">“매칭 시스템이 정말 좋고, 상대방도 적극적으로 대화를 나눠줘서 즐거웠어요.</div>
			<div class="review">“어떤 사람을 만날지 몰라서 기대되고 설렙니다.”</div>
			<div class="review">“회원가입이 쉬워서 금방 시작할 수 있었고, 빠르게 친구를 만났어요!”</div>
			<div class="review">“코피에서 만난 사람들과 진지한 대화를 나누고 있어서 뿌듯합니다.”</div>
		</div>
		<!-- 두 번째 5개의 리뷰 -->
		<div class="review-box">
			<div class="review">“소개팅 시스템이 마음에 들어요. 점점 더 좋은 사람을 만날 수 있을 것
				같아요.”</div>
			<div class="review">“한 번도 실패한 적 없어요! 코피 덕분에 항상 좋은 만남이 이어집니다.”</div>
			<div class="review">“다양한 사람들이 있어서 매번 새로운 경험을 할 수 있어요.”</div>
			<div class="review">“매칭이 잘 되어가고 있어서 계속 사용하고 싶어요. 추천합니다!”</div>
			<div class="review">“코피에서 만난 사람과 정말 잘 맞아서 만남을 이어가고 있어요.”</div>
		</div>
		<!-- 세 번째 5개의 리뷰 -->
		<div class="review-box">
			<div class="review">“이용자가 많아서 정말 다양한 사람을 만날 수 있어요. 즐겁습니다!”</div>
			<div class="review">“인터페이스가 직관적이라 사용하기 편하고, 사람들도 친절해요.”</div>
			<div class="review">“데이트를 시작한 후 정말 많은 좋은 경험을 했습니다. 감사합니다, 코피!”</div>
			<div class="review">“서비스가 정말 만족스러워요. 적극 추천합니다!”</div>
			<div class="review">“매칭의 질이 너무 좋아서 계속해서 사용하고 있어요.”</div>
		</div>
		<!-- 네 번째 5개의 리뷰 -->
		<div class="review-box">
			<div class="review">“코피에서 만난 사람과 정말 잘 맞아서 행복한 시간을 보내고 있어요.”</div>
			<div class="review">“다양한 사람들과 소통할 수 있는 기회가 많아서 좋습니다.”</div>
			<div class="review">“앱이 정말 직관적이고 쉽게 사용할 수 있어서 만족스럽습니다.”</div>
			<div class="review">“서비스가 매우 유용하고, 많은 사람들이 이용해서 신뢰감이 가요.”</div>
			<div class="review">“여기서 만난 사람들과 점점 친해져서 기분이 좋아요!</div>
		</div>
	</div>
</section>

<section class="home-3">
	<div class="phone" style="display: flex; align-items: center;">
		<!-- 휴대폰 이미지 -->
		<div class="phone-image-container"
			style="position: relative; width: 580px; height: 500px; border-radius: 20px; overflow: hidden; box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.2);">
			<img src="/upload/phone.png" alt="휴대폰 이미지"
				style="width: 100%; height: 100%; object-fit: cover;">
			<!-- 휴대폰 안에 들어갈 이미지 -->
			<img src="/upload/map2.jpg" alt="내부 이미지"
				style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 36.9%; height: 92%; border-radius: 10px;">
		</div>

		<!-- 오른쪽 텍스트 박스 -->
		<div class="text-box" style="margin-left: 2rem;">
			<h1 class="text-box-3">
				위치 기반으로 <br>
				<span class="mein">주변 이성친구</span><br> 찾아보세요!
			</h1>
		</div>
	</div>
</section>

<section class="home-4">
	<div class="text-box">
		<h1 class="text-box-4">
			<span class="mein">설레는 1:1 채팅</span><br> <span class="mein-4">새로운
				사람들과 대화하며 즐거운 시간을 보내세요!</span>
		</h1>
	</div>
	<div class="image-container">
		<img src="/upload/chat1.png" alt="채팅" class="chat-image">
	</div>
</section>

<script>
let currentReviewSet = 0; // 현재 보이는 리뷰 세트

const showNextReviews = () => {
    const reviewBoxes = document.querySelectorAll('.review-box');
    reviewBoxes[currentReviewSet].classList.remove('active'); // 이전 리뷰 세트 숨기기
    currentReviewSet = (currentReviewSet + 1) % reviewBoxes.length; // 다음 리뷰 세트로 이동
    reviewBoxes[currentReviewSet].classList.add('active'); // 새로운 리뷰 세트 보이기
};
//5초마다 리뷰 세트를 변경
setInterval(showNextReviews, 5000);
</script>

<style>
/* #chat-list 기본적으로 숨김 */
#chat-list {
    display: none;
    position: fixed; /* 화면에 고정되도록 설정 */
    bottom: 30px; /* 종 위로 표시되도록 위치 조정 */
    right: -5%; /* 화면 가운데에 종 아이콘을 배치 */
    transform: translateX(-50%); /* 가운데 정렬을 위한 트랜스폼 */
    width: 300px; /* 적당한 너비 */
    background-color: white; /* 배경색 */
    border: 1px solid #ccc; /* 테두리 */
    padding: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    z-index: 10; /* 다른 요소보다 위에 표시 */
    max-height: 400px; /* 최대 높이 설정 */
    overflow-y: auto; /* 스크롤 가능하게 설정 */
}

/* 각 채팅 항목 스타일 */
#chat-list div {
    padding: 8px;
    border-bottom: 1px solid #f0f0f0; /* 항목 간 구분선 */
}

#chat-list div p {
    margin: 0; /* margin 제거 */
    font-size: 14px; /* 폰트 크기 조정 */
}

#chat-list div:last-child {
    border-bottom: none; /* 마지막 항목의 구분선 제거 */
}


</style>
<c:if test="${not empty loginedMember}">
    <div class="notification-container">
        <img src="/upload/jong.jpg" alt="Notification" class="bell-icon" id="notification-icon">
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

    <!-- 채팅 리스트를 보여줄 div (기본적으로 숨김) -->
    <div id="chat-list">
        <!-- 여기에 채팅 내용이 표시될 예정 -->
    </div>
</c:if>

<script>
	document.getElementById('notification-icon').addEventListener('click', function() {
		const chatList = document.getElementById('chat-list');
		if (chatList.style.display === 'block') {
	        chatList.style.display = 'none';
	    } else {
	    fetch('/getUnreadChats')  // 서버에서 메시지 목록을 가져오는 URL
	        .then(response => response.json())
	        .then(data => {
	            console.log(data);
	            const chatList = document.getElementById('chat-list');
	            chatList.innerHTML = ''; // 기존 내용 초기화
	
	            if (data.length === 0) {
	                chatList.innerHTML = '<p>새로운 메시지가 없습니다.</p>';
	            } else {
	                data.forEach(chat => {
	                    const chatItem = document.createElement('div');
	                    chatItem.innerHTML = `<p><strong>보낸사람:</strong> \${chat.senderName}</p><p><strong>메세지:</strong> \${chat.content}</p>`;
	                    
	                    chatItem.addEventListener('click', function() {
                            // receiverId를 서버에서 받아온 id로 설정
                            const senderId = chat.senderId;
                            window.open(`http://localhost:8080/usr/chat/chat?receiverId=\${senderId}`, '_blank', 'width=405', 'height=510');
                        });
	                    
	                    chatList.appendChild(chatItem);
	                });
	            }
	
	            // 메시지 리스트 보이기
	            chatList.style.display = 'block';
	        })
	        .catch(error => console.error('Error fetching chats:', error));
	    }
	});

</script>



<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>
