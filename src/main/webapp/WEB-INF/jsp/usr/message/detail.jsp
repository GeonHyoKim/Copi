<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>
<c:set var="pageTitle" value="쪽지 상세보기" />

<section class="container mx-auto p-6 bg-gray-50 rounded-lg shadow-lg">
    <h2 class="text-3xl font-bold text-pink-600 mb-8 text-center">쪽지 상세보기</h2>

    <div class="bg-white p-6 rounded-lg shadow-md">
        <table class="table-auto w-full border-collapse">
            <tbody>
                <tr class="border-b">
                    <th class="px-4 py-2 bg-pink-100 text-gray-700 text-left w-1/4">보낸 사람</th>
                    <td class="px-4 py-2 text-gray-800">${message.senderName}</td>
                </tr>
                <tr class="border-b">
                    <th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">받은 사람</th>
                    <td class="px-4 py-2 text-gray-800">${message.receiverName}</td>
                </tr>
                <tr class="border-b">
                    <th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">내용</th>
                    <td class="px-4 py-2 text-gray-800 whitespace-pre-line">${message.content}</td>
                </tr>
                <tr>
                    <th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">보낸 날짜</th>
                    <td class="px-4 py-2 text-gray-800">${message.timestamp}</td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- 뒤로가기 버튼 -->
    <div class="mt-8 text-center">
        <button onclick="history.back()" class="bg-pink-600 hover:bg-pink-700 text-white font-bold px-6 py-3 rounded-full shadow-lg transition duration-300">
            뒤로가기
        </button>
    </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>
