<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:set var="pageTitle" value="글 작성" />
<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<script>
    const writeForm_onSubmit = function(form) {
        form.title.value = form.title.value.trim();
        form.body.value = form.body.value.trim();

        if (form.title.value.length == 0) {
            alert('제목을 입력해주세요');
            form.title.focus();
            return false;
        }

        if (form.body.value.length == 0) {
            alert('내용을 입력해주세요');
            form.body.focus();
            return false;
        }

        form.submit();
    }
</script>

<section class="bg-gradient-to-r from-blue-300 via-blue-200 to-blue-100 py-12">
    <div class="container mx-auto">
        <div class="bg-white rounded-lg shadow-xl p-10 max-w-2xl mx-auto">
            <h2 class="text-3xl font-bold text-center text-blue-600 mb-6">게시글 작성</h2>
            <form action="doWrite" method="post" enctype="multipart/form-data" 
                onsubmit="return writeForm_onSubmit(this);">
                <div class="space-y-6">
                    <!-- 제목 -->
                    <div>
                        <label for="title" class="block text-sm font-medium text-gray-700">제목</label>
                        <input type="text" id="title" name="title" placeholder="제목을 입력해주세요" 
                            class="input input-bordered w-full py-3 px-4 border rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500" />
                    </div>
                    
                    <!-- 내용 -->
                    <div>
                        <label for="body" class="block text-sm font-medium text-gray-700">내용</label>
                        <textarea id="body" name="body" rows="5" placeholder="내용을 입력해주세요" 
                            class="input input-bordered w-full py-3 px-4 border rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"></textarea>
                    </div>
                    
                    <!-- 사진 업로드 -->
                    <div>
                        <label for="pic" class="block text-sm font-medium text-gray-700">사진</label>
                        <input type="file" id="pic" name="pic" 
                            class="w-full py-3 px-4 border rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500" />
                    </div>
                </div>

                <!-- 버튼 -->
                <div class="mt-6 flex justify-between">
                    <button type="button" onclick="history.back();" 
                            class="btn btn-outline btn-secondary text-blue-500 border-blue-500 hover:bg-blue-100 hover:text-blue-600">
                        뒤로가기
                    </button>
                    <button type="submit" 
                            class="btn bg-blue-500 text-white hover:bg-blue-600 py-3 px-6 rounded-lg transition-colors duration-300 ease-in-out">
                        작성하기
                    </button>
                </div>
            </form>
        </div>
    </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>
