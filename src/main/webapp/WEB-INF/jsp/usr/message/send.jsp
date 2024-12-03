<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
<c:set var="pageTitle" value="쪽지 보내기" />

<section class="container mx-auto p-6 bg-gray-50 rounded-lg shadow-lg">
    <!-- 페이지 제목 -->
    <h2 class="text-3xl font-bold text-pink-600 mb-8 text-center">쪽지 보내기</h2>

    <!-- 쪽지 보내기 폼 -->
    <form action="/usr/message/doSend" method="post" class="bg-white p-6 rounded-lg shadow-md">
        <input type="hidden" id="receiverId" name="receiverId" value="${receiverId}" />

        <!-- 내용 입력란 -->
        <div class="mb-6">
            <label for="content" class="block text-gray-700 font-semibold mb-2">내용:</label>
            <textarea id="content" name="content" rows="4" class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-600"
                placeholder="쪽지 내용을 입력하세요" required></textarea>
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
