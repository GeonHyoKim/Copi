<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<section class="bg-blue-50 py-12">
    <div class="container mx-auto">
        <div class="bg-white rounded-lg shadow-lg p-8 max-w-md mx-auto">
            <h2 class="text-3xl font-bold text-center text-blue-600 mb-8">로그인</h2>
            <form action="doLogin" method="post" onsubmit="loginForm_onSubmit(this); return false;">
                <div class="space-y-6">
                    <!-- 아이디 입력 -->
                    <div>
                        <label class="block text-sm font-medium text-gray-700">아이디</label>
                        <input type="text" name="loginId" placeholder="아이디를 입력해주세요" 
                               class="input input-bordered w-full" />
                    </div>
                    <!-- 비밀번호 입력 -->
                    <div>
                        <label class="block text-sm font-medium text-gray-700">비밀번호</label>
                        <input type="password" name="loginPw" placeholder="비밀번호를 입력해주세요" 
                               class="input input-bordered w-full" />
                    </div>
                </div>
                <!-- 버튼 -->
                <div class="mt-6 flex justify-between">
                    <button type="button" onclick="history.back();" 
                            class="btn btn-outline btn-secondary">
                        뒤로가기
                    </button>
                    <button type="submit" 
                            class="btn btn-primary bg-blue-500 hover:bg-blue-600 border-none">
                        로그인
                    </button>
                </div>
                <!-- 회원가입 링크 -->
                <p class="mt-4 text-center text-sm text-gray-600">
                    계정이 없으신가요? 
                    <a href="join" class="text-blue-500 hover:underline">회원가입</a>
                </p>
            </form>
        </div>
    </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>