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
<link href="https://cdn.jsdelivr.net/npm/daisyui@4.12.14/dist/full.min.css" rel="stylesheet" type="text/css" />
<!-- JQuery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- 폰트어썸 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" />
<!-- common css -->
<link rel="stylesheet" href="/resource/common.css" />
</head>
<body>
	<header class="h-20 flex items-center justify-between container mx-auto text-3xl px-4 bg-pink-100">
        <div class="flex items-center space-x-4">
            <button class="btn btn-square btn-ghost">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                    class="inline-block h-6 w-6 stroke-current text-pink-500">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M4 6h16M4 12h16M4 18h16"></path>
                </svg>
            </button>
            <a class="text-2xl font-semibold flex items-center text-pink-600"
                href="${pageContext.request.contextPath}/">LoveMatch</a>
        </div>
        <ul class="flex space-x-6">
            <c:if test="${empty loginedMember}">
                <li class="hover:underline hover:text-pink-600 transition duration-300">
                    <a class="px-3 py-1" href="${pageContext.request.contextPath}/usr/member/join">JOIN</a>
                </li>
                <li class="hover:underline hover:text-pink-600 transition duration-300">
                    <a class="px-3 py-1" href="${pageContext.request.contextPath}/usr/member/login">LOGIN</a>
                </li>
            </c:if>
            <c:if test="${not empty loginedMember}">
                <li class="hover:underline hover:text-pink-600 transition duration-300">
                    <a class="px-3 py-1" href="${pageContext.request.contextPath}/usr/member/logout">LOGOUT</a>
                </li>
                <li class="hover:underline hover:text-pink-600 transition duration-300">
                    <a class="px-3 py-1" href="${pageContext.request.contextPath}/usr/member/myPage">MyPage</a>
                </li>
            </c:if>
            <li class="hover:underline hover:text-pink-600 transition duration-300">
                <a class="px-3 py-1" href="${pageContext.request.contextPath}/usr/member/heartRank">RANK</a>
            </li>
        </ul>
    </header>


	<section class="my-4 text-2xl">
		<div class="container mx-auto">
			<div>${pageTitle }&nbsp;페이지</div>
		</div>
	</section>
