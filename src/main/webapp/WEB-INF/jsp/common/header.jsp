<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html data-theme="light">
<head>
<meta charset="UTF-8">
<title>${pageTitle }</title>
<!-- 테일윈드CSS -->
<script src="https://cdn.tailwindcss.com"></script>
<!-- Dasiy UI -->
<link
	href="https://cdn.jsdelivr.net/npm/daisyui@4.12.14/dist/full.min.css"
	rel="stylesheet" type="text/css" />
<!-- JQuery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- 폰트어썸 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<!-- common css -->
<link rel="stylesheet" href="/resource/common.css" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Single+Day&display=swap"
	rel="stylesheet">
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

</head>
<style>
.logo-text {
	font-family: "Bagel Fat One", system-ui;
	font-weight: 400;
	font-style: normal;
	font-size: 1.5rem;
}

.custom-flex {
	display: flex;
	align-items: center;
	color: #ec4899;
	
}
</style>
	
<body>
	<header
		class="h-20 flex items-center justify-between container mx-auto text-3xl px-4 bg-pink-100">
		<div class="flex items-center space-x-4">
			<a class="logo-text custom-flex"
				href="${pageContext.request.contextPath}/">Welcome to COPI</a>
		</div>
		<ul class="flex space-x-6">
			<c:if test="${empty loginedMember}">
				<li
					class="hover:underline hover:text-pink-600 transition duration-300">
					<a class="px-3 py-1"
					href="${pageContext.request.contextPath}/usr/member/join">JOIN</a>
				</li>
				<li
					class="hover:underline hover:text-pink-600 transition duration-300">
					<a class="px-3 py-1"
					href="${pageContext.request.contextPath}/usr/member/login">LOGIN</a>
				</li>
			</c:if>
			<c:if test="${not empty loginedMember}">
				<li
					class="hover:underline hover:text-pink-600 transition duration-300">
					<a class="px-3 py-1"
					href="${pageContext.request.contextPath}/usr/member/logout">LOGOUT</a>
				</li>
				<li
					class="hover:underline hover:text-pink-600 transition duration-300">
					<a class="px-3 py-1"
					href="${pageContext.request.contextPath}/usr/member/myPage">MyPage</a>
				</li>
				<li
					class="hover:underline hover:text-pink-600 transition duration-300">
					<a class="px-3 py-1"
					href="${pageContext.request.contextPath}/usr/member/list">LIST</a>
				</li>
				<li
					class="hover:underline hover:text-pink-600 transition duration-300">
					<a class="px-3 py-1"
					href="${pageContext.request.contextPath}/usr/member/rank">RANK</a>
				</li>
				<li
					class="hover:underline hover:text-pink-600 transition duration-300">
					<a class="px-3 py-1"
					href="${pageContext.request.contextPath}/usr/article/list">Article</a>

				</li>

				
			</c:if>

		</ul>
	</header>
