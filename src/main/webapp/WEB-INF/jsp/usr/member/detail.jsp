<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:set var="pageTitle" value="회원 상세보기" />
<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<section class="container mx-auto p-6 bg-gray-50 rounded-lg shadow-lg">
    <!-- 페이지 제목 -->
    <h2 class="text-3xl font-bold text-pink-600 mb-8 text-center">회원 상세보기</h2>

    <!-- 상세 정보 테이블 -->
    <div class="bg-white p-6 rounded-lg shadow-md">
        <table class="table-auto w-full border-collapse">
            <tbody>
                <tr class="border-b">
                    <th class="px-4 py-2 bg-pink-100 text-gray-700 text-left w-1/3">회원 번호</th>
                    <td class="px-4 py-2 text-gray-800">${member.getId()}</td>
                </tr>
                <tr class="border-b">
                    <th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">가입일</th>
                    <td class="px-4 py-2 text-gray-800">${member.getRegDate().substring(2, 16)}</td>
                </tr>
                <tr class="border-b">
                    <th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">성별</th>
                    <td class="px-4 py-2 text-gray-800">${member.getSex()}</td>
                </tr>
                <tr class="border-b">
                    <th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">이름</th>
                    <td class="px-4 py-2 text-gray-800">${member.getName()}</td>
                </tr>
                <tr class="border-b">
                    <th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">나이</th>
                    <td class="px-4 py-2 text-gray-800">${member.getAge()}</td>
                </tr>
                <tr>
                    <th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">지역</th>
                    <td class="px-4 py-2 text-gray-800">${member.getAreaId()}</td>
                </tr>
                <tr>
                    <th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">하트 갯수</th>
                    <td class="px-4 py-2 text-gray-800">${member.getHearts()}</td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- 버튼들 -->
    <div class="mt-8 text-center">
        <button onclick="history.back()" class="bg-gray-600 hover:bg-gray-700 text-white font-bold px-6 py-3 rounded-full shadow-lg transition duration-300 mr-4">
            뒤로가기
        </button>
        <!-- 하트 버튼 -->
<button id="heartButton" onclick="increaseHeart(${member.id})" class="heart-button">
    <span id="heartIcon">💖</span> <span id="heartCount">${member.hearts}</span>
</button>

<script>
    function increaseHeart(memberId) {
        fetch(`/usr/member/increaseHeart?id=${memberId}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                // 성공적으로 하트 수 증가시킴
                const heartCountElement = document.getElementById('heartCount');
                heartCountElement.innerText = data.newHeartCount; // 새 하트 수로 업데이트
            } else {
                alert('하트 증가 실패');
            }
        });
    }
</script>
        <a href="/usr/message/send?receiverId=${member.getId()}" class="bg-pink-600 hover:bg-pink-700 text-white font-bold px-6 py-3 rounded-full shadow-lg transition duration-300">
            메세지 보내기
        </a>
    </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>
