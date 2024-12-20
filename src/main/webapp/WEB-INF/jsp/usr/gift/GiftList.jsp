<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:set var="pageTitle" value="게시글 목록" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f4f4f9;
}

.articles-container {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
	justify-content: center; /* 가운데 정렬 */
	gap: 20px;
	padding: 20px;
}

.article-card {
	background-color: white;
	border-radius: 8px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	overflow: hidden;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	text-decoration: none;
	color: inherit;
	border: 2px solid transparent; /* 기본 테두리 */
	
}

.article-card:hover,
.article-card.selected { /* 선택 시 스타일 */
	transform: translateY(-5px);
	box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
	border: 2px solid #007BFF;
}
.article-image {
	width: 100%;
	height: 180px;
	object-fit: cover;
}

.article-details {
	padding: 15px;
}

.article-title {
	font-size: 1.2em;
	font-weight: bold;
	margin: 10px 0;
	color: #333;
}

.article-writer {
	font-size: 0.9em;
	color: #666;
}

.write-button {
	display: inline-block;
	margin: 20px;
	padding: 10px 20px;
	background-color: #007BFF;
	color: white;
	text-decoration: none;
	border-radius: 4px;
	transition: background-color 0.3s ease;
	font-weight: bold;
}

.write-button:hover {
	background-color: #0056b3;
}
</style>
<c:if test="${not empty message}">
    <script>
        alert("${message}");
    </script>
    
</c:if>
<script>
document.addEventListener('DOMContentLoaded', () => {
	const cards = document.querySelectorAll('.article-card');
	let selectedGift = null;

	cards.forEach(card => {
		card.addEventListener('click', () => {
			// 이전 선택된 카드 스타일 초기화
			if (selectedGift) {
				selectedGift.classList.remove('selected');
			}

			// 현재 선택된 카드 강조
			card.classList.add('selected');
			selectedGift = card;

			// 선택된 선물 ID 저장 (예: 서버로 전송하거나 폼에 추가)
			const giftName = card.querySelector('.article-title').textContent;
			console.log('선택된 선물:', giftName);
		});
	});
});
</script>
    <h2 class="text-3xl font-bold text-pink-600 mb-8 text-center">선물 보내기</h2>

<div class="articles-container" id="articleContainer">
	<c:forEach var="gift" items="${gifts}">
		<a href="#" class="article-card">
			<c:choose>
				<c:when test="${not empty gift.giftPic}">
					<img src="/usr/pic/getImage?pic=${gift.giftPic.pic}"
						class="article-image" />
				</c:when>
				<c:otherwise>
					<img src="/static/default-pic.jpg" class="article-image"
						alt="No Image" />
				</c:otherwise>
			</c:choose>
			<div class="article-details">
				<p class="article-title">${gift.giftName}</p>
				<p class="article-writer">${gift.price}원</p>
			</div>
		</a>
	</c:forEach>
</div>
<section class="container mx-auto p-6 bg-gray-50 rounded-lg shadow-lg">

    <form action="/usr/message/doSend" method="post" class="bg-white p-6 rounded-lg shadow-md">
        <input type="hidden" id="receiverId" name="receiverId" value="${receiverId}" />

        <!-- 내용 입력란 -->
        <div class="mb-6">
            <label for="content" class="block text-gray-700 font-semibold mb-2">선택된 상품: ${gift.giftName} </label>
            <label for="content" class="block text-gray-700 font-semibold mb-2">메세지:</label>
            <textarea id="content" name="content" rows="4" class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-600"
                placeholder="메세지 내용을 입력하세요" required></textarea>
        </div>

        <!-- 버튼들 -->
        <div class="text-center">
            <button type="submit" class="bg-pink-600 hover:bg-pink-700 text-white font-bold px-6 py-3 rounded-full shadow-lg transition duration-300 mr-4">
                보내기
            </button>
            <button type="button" onclick="history.back();" class="bg-gray-600 hover:bg-gray-700 text-white font-bold px-6 py-3 rounded-full shadow-lg transition duration-300">
                뒤로가기
            </button>
        </div>
    </form>
</section>
<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>
