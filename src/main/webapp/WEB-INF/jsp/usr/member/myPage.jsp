<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:set var="pageTitle" value="마이" />
<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
<%@ page import="java.text.DecimalFormat" %>


<script>
	document.addEventListener("DOMContentLoaded", () => {
		const slides = document.querySelectorAll(".photo-slide");
		let currentIndex = 0;

		const showSlide = (index) => {
			slides.forEach((slide, i) => {
				slide.style.display = i === index ? "block" : "none";
			});
		};

		document.getElementById("prev-btn").addEventListener("click", () => {
			currentIndex = (currentIndex > 0) ? currentIndex - 1 : slides.length - 1;
			showSlide(currentIndex);
		});

		document.getElementById("next-btn").addEventListener("click", () => {
			currentIndex = (currentIndex < slides.length - 1) ? currentIndex + 1 : 0;
			showSlide(currentIndex);
		});
	});
</script>

<style>
#photo-slider {
	height: 300px; /* 고정된 높이 설정 */
	position: relative;
	overflow: hidden;
}

.photo-slide {
	width: 100%; /* 너비를 부모 요소에 맞게 설정 */
	height: 100%; /* 부모의 높이에 맞게 설정 */
	object-fit: cover; /* 이미지를 꽉 차게 하되 비율을 유지하면서 잘리도록 설정 */
	object-position: center center; /* 이미지의 중심을 기준으로 조정 */
}
</style>

<section class="container mx-auto p-4">
	<h2 class="text-3xl font-semibold text-pink-600 mb-6">회원 정보</h2>
	<!-- 회원 정보 -->
	<div class="bg-white p-6 rounded-lg shadow-md flex">
		<!-- 사진 슬라이더 -->
		<div class="flex-shrink-0 w-64">
			<div class="relative w-full h-full">
				<!-- 사진 출력 -->
				<c:choose>
					<c:when test="${not empty pics}">
						<div id="photo-slider" class="relative overflow-hidden h-full">
							<div class="w-full">
								<c:forEach var="pic" items="${pics}" varStatus="status">
									<img src="/usr/pic/getImage?pic=${pic.pic}"
										class="photo-slide ${status.index == 0 ? '' : 'hidden'} w-full h-full object-cover rounded">
								</c:forEach>
							</div>
							<!-- 화살표 버튼 -->
							<button id="prev-btn"
								class="absolute left-0 top-1/2 transform -translate-y-1/2 text-white px-2 py-1 rounded-full shadow">
								&lt;</button>
							<button id="next-btn"
								class="absolute right-0 top-1/2 transform -translate-y-1/2 text-white px-2 py-1 rounded-full shadow">
								&gt;</button>
						</div>
					</c:when>
					<c:otherwise>
						<p class="text-center">등록된 사진이 없습니다.</p>
					</c:otherwise>
				</c:choose>
			</div>
		</div>

		<!-- 회원 정보 -->
		<div class="ml-8 flex-grow flex flex-col justify-between">
			<table class="table-auto w-full text-left border-collapse">
				<thead>
					<tr>
						<th class="px-4 py-2 bg-pink-100 border-b text-lg text-pink-600">항목</th>
						<th class="px-4 py-2 bg-pink-100 border-b text-lg text-pink-600">정보</th>
					</tr>
				</thead>
				<tbody>
					<tr class="border-b">
						<th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">ID</th>
						<td class="px-4 py-2 border-b">${member.loginId}</td>
					</tr>
					<tr class="border-b">
						<th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">이름</th>
						<td class="px-4 py-2 border-b">${member.name}</td>
					</tr>
					<tr class="border-b">
						<th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">나이</th>
						<td class="px-4 py-2 border-b">${member.age}</td>
					</tr>
					<tr class="border-b">
						<th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">성별</th>
						<td class="px-4 py-2 border-b">${member.sex}</td>
					</tr>
					<tr class="border-b">
						<th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">지역</th>
						<td class="px-4 py-2 border-b">${member.areaId}</td>
					</tr>
					<tr class="border-b">
						<th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">가입일</th>
						<td class="px-4 py-2 text-gray-800">${member.getRegDate().substring(2, 16)}</td>
					</tr>
					<tr class="border-b">
						<th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">하트
							갯수</th>
						<td><span id="likeCnt" class="px-4 py-2 border-b">${likeCount}</span>
							<!-- 좋아요 개수 표시 --></td>
					</tr>
					<tr class="border-b">
						<th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">보유
							포인트</th>
						<td class="px-4 py-2 text-gray-800">${member.point != null ? member.point : 0}원<a
							href="/usr/point/point"
							class="inline-block bg-pink-500 hover:bg-pink-600 text-white font-semibold px-4 py-2 rounded-full shadow-lg transition duration-300 transform hover:scale-105 ml-4">
								💳 포인트 충전하기 </a>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div class="mt-8">
		<h3 class="text-2xl font-semibold text-pink-600 mb-4">선물함</h3>
		<div class="space-x-4">
			<a href="${pageContext.request.contextPath}/usr/gift/list"
				class="btn btn-outline btn-pink-600 hover:bg-pink-600 hover:text-white transition duration-300 px-6 py-2">선물함</a>
		</div>
	</div>

</section>

<div class="mt-8 text-center">
	<button onclick="history.back()"
		class="bg-gray-600 hover:bg-gray-700 text-white font-bold px-6 py-3 rounded-full shadow-lg transition duration-300 mr-4">
		뒤로가기</button>
	<a href="/usr/member/modify?id=${member.getId() }"
		class="bg-pink-600 hover:bg-pink-700 text-white font-bold px-6 py-3 rounded-full shadow-lg transition duration-300 mr-4">
		회원 정보 수정하기 </a>
</div>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>
