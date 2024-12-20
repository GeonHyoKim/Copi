<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<c:set var="pageTitle" value="PresentList" />

<section class="container mx-auto p-6 bg-gray-50 rounded-lg shadow-lg">
    <h2 class="text-4xl font-bold text-pink-600 mb-8 text-center">선물함</h2>

    <div class="mb-12 bg-white p-8 rounded-lg shadow-md">
        <h3 class="text-2xl font-semibold text-pink-600 mb-6 border-b pb-3">받은 선물함</h3>
        <table class="table-auto w-full text-left border-collapse">
            <thead>
                <tr>
                    <th class="px-4 py-2 bg-pink-100 border-b text-gray-700">보낸 사람</th>
                    <th class="px-4 py-2 bg-pink-100 border-b text-gray-700">보낸 선물</th>
                    <th class="px-4 py-2 bg-pink-100 border-b text-gray-700">내용</th>
                    <th class="px-4 py-2 bg-pink-100 border-b text-gray-700">보낸 날짜</th>
                    <th class="px-4 py-2 bg-pink-100 border-b text-gray-700">상세보기</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="present" items="${receivedPresents}">
                    <tr class="hover:bg-pink-50">
                        <td class="px-4 py-2 border-b">${present.senderName}</td> <!-- senderName을 출력 -->
                        <td class="px-4 py-2 border-b">${present.giftName}</td> <!-- senderName을 출력 -->
                        <td class="px-4 py-2 border-b truncate max-w-xs">${present.content}</td>
                        <td class="px-4 py-2 border-b">${present.timestamp}</td>
                        <td class="px-4 py-2 border-b">
                            <a href="/usr/gift/detail?id=${present.id}" class="text-pink-600 font-semibold hover:underline">상세보기</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="mb-12 bg-white p-8 rounded-lg shadow-md">
        <h3 class="text-2xl font-semibold text-pink-600 mb-6 border-b pb-3">보낸 선물함</h3>
        <table class="table-auto w-full text-left border-collapse">
            <thead>
                <tr>
                    <th class="px-4 py-2 bg-pink-100 border-b text-gray-700">받은 사람</th>
                    <th class="px-4 py-2 bg-pink-100 border-b text-gray-700">받은 선물</th>
                    <th class="px-4 py-2 bg-pink-100 border-b text-gray-700">내용</th>
                    <th class="px-4 py-2 bg-pink-100 border-b text-gray-700">보낸 날짜</th>
                    <th class="px-4 py-2 bg-pink-100 border-b text-gray-700">상세보기</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="present" items="${sentPresents}">
                    <tr class="hover:bg-pink-50">
                        <td class="px-4 py-2 border-b">${present.receiverName}</td> <!-- receiverName을 출력 -->
                        <td class="px-4 py-2 border-b">${present.giftName}</td> <!-- receiverName을 출력 -->
                        <td class="px-4 py-2 border-b truncate max-w-xs">${present.content}</td>
                        <td class="px-4 py-2 border-b">${present.timestamp}</td>
                        <td class="px-4 py-2 border-b">
                            <a href="/usr/gift/detail?id=${present.id}" class="text-pink-600 font-semibold hover:underline">상세보기</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

	<div class="mt-8 text-center">
		<button onclick="history.back()"
			class="bg-gray-600 hover:bg-gray-700 text-white font-bold px-6 py-3 rounded-full shadow-lg transition duration-300 mr-4">
			뒤로가기</button>
	</div>
	
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>
