<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
<c:set var="pageTitle" value="선물 보내기" />

<style>
/* 회원 카드 */
.gift-card {
	width: 180px; /* 카드의 너비 */
	height: 240px; /* 카드의 높이 */
	background-color: #fff;
	border-radius: 20px;
	box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	padding: 20px;
	text-align: center;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	cursor: pointer; /* 클릭 커서로 변경 */
	border: 2px solid transparent; /* 기본 경계선은 투명 */
}

/* 카드 hover시 강조 */
.gift-card:hover {
	transform: scale(1.05); /* 카드 크기 확대 */
	box-shadow: 0 12px 20px rgba(0, 0, 0, 0.2); /* 그림자 효과 강화 */
	border-color: #ec4899; /* 경계선 색상 변경 */
}

/* 사진 */
.gift-pic {
	width: 160px; /* 사진의 가로 크기 */
	height: 160px; /* 사진의 세로 크기 */
	object-fit: cover; /* 이미지가 영역에 맞게 잘리도록 */
	margin-bottom: 10px; /* 사진과 이름 사이의 간격 */
	border-radius: 10px; /* 사진의 테두리 둥글게 */
}

</style>

<div class="gifs-container" id="giftsContainer">
	<c:forEach var="gift" items="${gifts}">
		<div class="gift-card" data-sex="${gift.sex}">
			<a href="/usr/member/detail?id=${gift.id}"> <c:choose>
					<c:when test="${not empty gift.pic}">
						<img src="/usr/pic/getImage?pic=${gift.pic}"
							class="gift-pic" />
					</c:when>
					<c:otherwise>
						<div class="gift-pic bg-gray-200"></div>
					</c:otherwise>
				</c:choose>
				<div class="gift-name">
					<c:if test="${not empty gift}">
						<p>${gift.giftName}${gift.price}</p>
					</c:if>
				</div>
			</a>
		</div>
	</c:forEach>
</div>

<section class="container mx-auto p-6 bg-gray-50 rounded-lg shadow-lg">
    <h2 class="text-3xl font-bold text-pink-600 mb-8 text-center">선물 보내기</h2>

    <form action="/usr/message/doSend" method="post" class="bg-white p-6 rounded-lg shadow-md">
        <input type="hidden" id="receiverId" name="receiverId" value="${receiverId}" />

        <!-- 내용 입력란 -->
        <div class="mb-6">
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
