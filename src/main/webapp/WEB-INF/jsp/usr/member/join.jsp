<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:set var="pageTitle" value="회원가입" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<script>
    // 서버에서 전달된 메시지가 있으면 알림을 띄우고 리다이렉트
    <c:if test="${not empty message}">
        alert("${message}");  // 회원가입 성공 메시지
        setTimeout(function() {
            window.location.href = "/usr/home/home"; // 홈으로 리다이렉트
        });
    </c:if>
</script>

<script>
    let validLoginId = null;
    const joinForm_onSubmit = function(form) {
        form.loginId.value = form.loginId.value.trim();
        form.loginPw.value = form.loginPw.value.trim();
        form.pwChk.value = form.pwChk.value.trim();
        form.name.value = form.name.value.trim();
        form.age.value = form.age.value.trim();
        form.num.value = form.num.value.trim();
        form.sex.value = form.sex.value.trim();
        form.areaId.value = form.areaId.value.trim();

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

        if (form.name.value.length == 0) {
            alert('이름을 입력해주세요');
            form.name.focus();
            return;
        }

        if (form.age.value.length == 0) {
            alert('나이를 입력해주세요');
            form.age.focus();
            return;
        }
        if (form.num.value.length == 0) {
            alert('번호를 입력해주세요');
            form.num.focus();
            return;
        }

        if (form.sex.value.length == 0) {
            alert('성별을 입력해주세요');
            form.sex.focus();
            return;
        }
        if (form.areaId.value.length == 0) {
            alert('지역을 입력해주세요');
            form.areaId.focus();
            return;
        }

        if (form.loginPw.value != form.pwChk.value) {
            alert('비밀번호가 일치하지 않습니다');
            form.loginPw.value = '';
            form.pwChk.value = '';
            form.loginPw.focus();
            return;
        }

        form.submit();
    }
</script>

<section class="bg-gradient-to-r from-pink-300 via-pink-200 to-pink-100 py-12"> <!-- 부드러운 연핑크 그라디언트 배경 -->
    <div class="container mx-auto">
        <div class="bg-white rounded-lg shadow-xl p-10 max-w-2xl mx-auto"> <!-- 흰색 배경을 사용하고 그림자 효과 강화 -->
            <h2 class="text-3xl font-bold text-center text-pink-600 mb-6">회원가입</h2>
            <form action="doJoin" method="post" enctype="multipart/form-data"
                onsubmit="joinForm_onSubmit(this); return false;">
                <div class="grid grid-cols-1 gap-6">
                    <div>
                        <label class="block text-sm font-medium text-gray-700">아이디</label>
                        <input type="text" name="loginId" placeholder="아이디를 입력해주세요"
                            class="input input-bordered w-full py-3 px-4 border rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-pink-500" />
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700">비밀번호</label>
                        <input type="password" name="loginPw" placeholder="비밀번호를 입력해주세요"
                            class="input input-bordered w-full py-3 px-4 border rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-pink-500" />
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700">비밀번호 확인</label>
                        <input type="password" name="pwChk" placeholder="비밀번호를 다시 입력해주세요"
                            class="input input-bordered w-full py-3 px-4 border rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-pink-500" />
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700">이름</label>
                        <input type="text" name="name" placeholder="이름을 입력해주세요"
                            class="input input-bordered w-full py-3 px-4 border rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-pink-500" />
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700">나이</label>
                        <input type="number" name="age" placeholder="나이를 입력해주세요"
                            class="input input-bordered w-full py-3 px-4 border rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-pink-500" />
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700">성별</label>
                        <select name="sex" class="select select-bordered w-full py-3 px-4 border rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-pink-500">
                            <option value="" disabled selected>성별을 선택해주세요</option>
                            <option value="남성">남성</option>
                            <option value="여성">여성</option>
                            <option value="기타">기타</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700">번호</label>
                        <input type="tel" name="num" placeholder="번호를 입력해주세요"
                            class="input input-bordered w-full py-3 px-4 border rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-pink-500" />
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700">지역</label>
                        <input type="text" name="areaId" placeholder="지역을 입력해주세요"
                            class="input input-bordered w-full py-3 px-4 border rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-pink-500" />
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700">사진</label>
                        <div>
                            <input type="file" name="pic" class="w-full py-3 px-4 border rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-pink-500"/>
                        </div>
                    </div>
                </div>
                <div class="mt-6 flex justify-between">
                    <button type="button" onclick="history.back();" 
                        class="btn btn-outline btn-secondary text-pink-500 border-pink-500 hover:bg-pink-100 hover:text-pink-600">
                        뒤로가기
                    </button>
                    <button type="submit" 
                        class="btn bg-pink-500 text-white hover:bg-pink-600 py-3 px-6 rounded-lg transition-colors duration-300 ease-in-out">
                        회원가입 하기
                    </button>
                </div>
            </form>
        </div>
    </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>
