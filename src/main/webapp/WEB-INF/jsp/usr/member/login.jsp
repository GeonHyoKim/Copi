<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:set var="pageTitle" value="로그인" />
<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<script>
    const loginForm_onSubmit = function(form) {
        form.loginId.value = form.loginId.value.trim();
        form.loginPw.value = form.loginPw.value.trim();

        if (form.loginId.value.length == 0) {
            alert('아이디를 입력해주세요');
            form.loginId.focus();
            return;
        }

        if (form.loginPw.value.length == 0) {
            alert('비밀번호를 입력해주세요');
            form.loginPw.focus();
            return;
        }

        form.submit();
    }
</script>

<section class="bg-gradient-to-r from-pink-300 via-pink-200 to-pink-100 py-12">
    <div class="container mx-auto">
        <div class="bg-white rounded-lg shadow-xl p-10 max-w-md mx-auto">
            <h2 class="text-3xl font-bold text-center text-pink-600 mb-6">로그인</h2>
            
            <!-- 메시지 출력 -->
            <c:if test="${not empty message}">
                <div class="bg-red-100 text-red-600 p-3 rounded mb-4 text-center">
                    <c:out value="${message}" />
                </div>
            </c:if>

            <form action="doLogin" method="post" onsubmit="loginForm_onSubmit(this); return false;">
                <div class="space-y-6">
                    <!-- 아이디 입력 -->
                    <div>
                        <label class="block text-sm font-medium text-gray-700">아이디</label>
                        <input type="text" name="loginId" placeholder="아이디를 입력해주세요" 
                               class="input input-bordered w-full py-3 px-4 border rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-pink-500" />
                    </div>
                    <!-- 비밀번호 입력 -->
                    <div>
                        <label class="block text-sm font-medium text-gray-700">비밀번호</label>
                        <input type="password" name="loginPw" placeholder="비밀번호를 입력해주세요" 
                               class="input input-bordered w-full py-3 px-4 border rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-pink-500" />
                    </div>
                </div>
                <!-- 버튼 -->
                <div class="mt-6 flex justify-between">
                    <button type="button" onclick="history.back();" 
                            class="btn btn-outline btn-secondary text-pink-500 border-pink-500 hover:bg-pink-100 hover:text-pink-600">
                        뒤로가기
                    </button>
                    <button type="submit" 
                            class="btn bg-pink-500 text-white hover:bg-pink-600 py-3 px-6 rounded-lg transition-colors duration-300 ease-in-out">
                        로그인
                    </button>
                </div>
                <!-- 회원가입 링크 -->
                <p class="mt-4 text-center text-sm text-gray-600">
                    계정이 없으신가요? 
                    <a href="join" class="text-pink-500 hover:underline">회원가입</a>
                </p>
            </form>
        </div>
    </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>
