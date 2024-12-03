<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

<c:set var="pageTitle" value="마이페이지" />

<section class="container mx-auto p-4">
    <!-- 회원 정보 -->
    <div class="bg-white p-6 rounded-lg shadow-md">
        <h2 class="text-3xl font-semibold text-pink-600 mb-6">회원 정보</h2>
        <table class="table-auto w-full text-left border-collapse">
            <thead>
                <tr>
                    <th class="px-4 py-2 bg-pink-100 border-b text-lg text-pink-600">항목</th>
                    <th class="px-4 py-2 bg-pink-100 border-b text-lg text-pink-600">정보</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="px-4 py-2 border-b font-medium">ID</td>
                    <td class="px-4 py-2 border-b">${member.loginId}</td>
                </tr>
                <tr>
                    <td class="px-4 py-2 border-b font-medium">이름</td>
                    <td class="px-4 py-2 border-b">${member.name}</td>
                </tr>
                <tr>
                    <td class="px-4 py-2 border-b font-medium">나이</td>
                    <td class="px-4 py-2 border-b">${member.age}</td>
                </tr>
                <tr>
                    <td class="px-4 py-2 border-b font-medium">성별</td>
                    <td class="px-4 py-2 border-b">${member.sex}</td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- 쪽지함 링크 -->
    <div class="mt-8">
        <h3 class="text-2xl font-semibold text-pink-600 mb-4">쪽지함</h3>
        <div class="space-x-4">
            <a href="${pageContext.request.contextPath}/usr/message/list" class="btn btn-outline btn-pink-600 hover:bg-pink-600 hover:text-white transition duration-300 px-6 py-2">쪽지함</a>
        </div>
    </div>

   

    <!-- 쪽지 보내기 버튼 -->
    <div class="mt-6">
        <button onclick="location.href='/usr/message/send'" class="btn btn-pink-600 hover:bg-pink-700 text-white px-6 py-3 rounded-full transition duration-300">쪽지 보내기</button>
    </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>
