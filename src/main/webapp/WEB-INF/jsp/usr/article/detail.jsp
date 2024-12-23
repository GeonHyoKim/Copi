<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:set var="pageTitle" value="게시물 상세보기" />
<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<script>
    <c:if test="${not empty message}">
        alert("${message}"); // 성공 메시지
        setTimeout(function() {
            window.location.href = "/usr/article/list";
        }, 1000); // 1초 후 리다이렉트
    </c:if>

    <c:if test="${not empty failMessage}">
        alert("${failMessage}"); // 실패 메시지
    </c:if>
</script>


<section class="container mx-auto p-6 bg-gray-50 rounded-lg shadow-lg">
    <h2 class="text-4xl font-extrabold text-pink-600 mb-8 text-center">게시물 상세보기</h2>

    <!-- 사진 슬라이더 -->
    <div class="flex justify-center mb-8">
        <c:choose>
            <c:when test="${not empty articlePics}">
                <div id="photo-slider" class="relative w-full max-w-md overflow-hidden rounded-lg shadow-lg">
                    <div class="w-full relative">
                        <c:forEach var="articlePic" items="${articlePics}" varStatus="status">
                            <img 
                                src="/usr/pic/getImage?pic=${articlePic.pic}" 
                                class="photo-slide ${status.index == 0 ? '' : 'hidden'} w-full h-64 object-cover rounded-md"
                            >
                        </c:forEach>
                        <!-- 슬라이더 화살표 -->
                        <button id="prev-btn"
								class="absolute left-0 top-1/2 transform -translate-y-1/2 text-white px-2 py-1 rounded-full shadow">&lt;</button>
							<button id="next-btn"
								class="absolute right-0 top-1/2 transform -translate-y-1/2 text-white px-2 py-1 rounded-full shadow">&gt;</button>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <p class="text-center text-gray-500 italic">등록된 사진이 없습니다.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- 게시물 정보 -->
    <div class="bg-white p-6 rounded-lg shadow-md">
        <table class="table-auto w-full border-collapse text-left">
            <tbody>
                <tr class="border-b">
                    <th class="px-4 py-4 bg-pink-100 text-gray-700 font-semibold text-lg">제목</th>
                    <td class="px-4 py-4 text-gray-800">${article.getTitle()}</td>
                </tr>
                <tr class="border-b">
                    <th class="px-4 py-4 bg-pink-100 text-gray-700 font-semibold text-lg">작성일</th>
                    <td class="px-4 py-4 text-gray-800">${article.getUpdateDate()}</td>
                </tr>
                <tr class="border-b">
                    <th class="px-4 py-4 bg-pink-100 text-gray-700 font-semibold text-lg">내용</th>
                    <td class="px-4 py-4 text-gray-800 whitespace-pre-line">${article.getBody()}</td>
                </tr>
                <tr class="border-b">
                    <th class="px-4 py-4 bg-pink-100 text-gray-700 font-semibold text-lg">조회수</th>
                    <td class="px-4 py-4 text-gray-800">${article.getViews()}</td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- 버튼 -->
<div class="mt-10 text-center space-x-4">
    <div class="flex justify-center space-x-4">
        <button 
            onclick="history.back()" 
            class="bg-gray-600 hover:bg-gray-700 text-white font-bold px-8 py-3 rounded-full shadow-lg transition-transform transform hover:scale-105"
        >
            뒤로가기
        </button>
    

        <c:if test="${not empty loginedMember && !canEdit}">
            <a 
                href="/usr/gift/send?receiverId=${article.getMemberId()}" 
                class="bg-pink-600 hover:bg-pink-700 text-white font-bold px-8 py-3 rounded-full shadow-lg transition-transform transform hover:scale-105"
            >
                선물하기
            </a>
        </c:if>

        <c:if test="${canEdit}">
            <!-- 수정하기 버튼 -->
            <a 
                href="/usr/article/articleModify?id=${article.getId()}" 
                class="bg-blue-500 hover:bg-blue-600 text-white font-bold px-8 py-3 rounded-full shadow-lg transition-transform transform hover:scale-105"
            >
                수정하기
            </a>
            <!-- 삭제하기 버튼 -->
            <a 
                href="/usr/article/delete?id=${article.getId()}" 
                class="bg-red-500 hover:bg-red-600 text-white font-bold px-8 py-3 rounded-full shadow-lg transition-transform transform hover:scale-105"
                onclick="return confirm('정말로 삭제하시겠습니까?');"
            >
                삭제하기
            </a>
        </c:if>
    </div>
</div>

</section>

<script>
    let currentSlide = 0;

    // 슬라이드를 이동하는 함수
    function moveSlide(direction) {
        const slides = document.querySelectorAll('.photo-slide');
        const totalSlides = slides.length;

        // 현재 슬라이드 숨기기
        slides[currentSlide].classList.add('hidden');

        // 새로운 슬라이드 계산
        currentSlide = (currentSlide + direction + totalSlides) % totalSlides;

        // 새로운 슬라이드 표시
        slides[currentSlide].classList.remove('hidden');
    }

    // 버튼에 이벤트 리스너 추가
    document.getElementById('prev-btn').addEventListener('click', function() {
        moveSlide(-1);  // 이전 슬라이드
    });

    document.getElementById('next-btn').addEventListener('click', function() {
        moveSlide(1);   // 다음 슬라이드
    });
</script>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>
