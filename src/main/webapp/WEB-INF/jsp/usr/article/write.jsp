<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:set var="pageTitle" value="글 작성" />
<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<script>
    const MAX_FILES = 5; // 업로드 가능한 최대 파일 수

    const writeForm_onSubmit = function (form) {
        form.title.value = form.title.value.trim();
        form.body.value = form.body.value.trim();

        if (form.title.value.length === 0) {
            alert('제목을 입력해주세요');
            form.title.focus();
            return false;
        }

        if (form.body.value.length === 0) {
            alert('내용을 입력해주세요');
            form.body.focus();
            return false;
        }

        form.submit();
    };

    // 미리보기 및 파일 제한 기능
    const previewImages = function (input) {
        const previewContainer = document.getElementById('preview-container');
        const files = Array.from(input.files);

        // 이미 선택된 파일 수 + 새로 선택한 파일 수 체크
        const currentFileCount = previewContainer.children.length;
        if (currentFileCount + files.length > MAX_FILES) {
            alert(`사진은 최대 "5"장까지 업로드할 수 있습니다.`);
            input.value = ""; // 파일 선택 초기화
            return;
        }

        files.forEach((file) => {
            if (file.type.startsWith("image/")) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    const img = document.createElement("img");
                    img.src = e.target.result;
                    img.alt = "미리보기 이미지";
                    img.className = "w-24 h-24 object-cover rounded-lg shadow-md mr-2 mb-2";

                    // 미리보기 삭제 버튼 추가
                    const imgWrapper = document.createElement("div");
                    imgWrapper.className = "relative inline-block";
                    imgWrapper.appendChild(img);

                    const removeBtn = document.createElement("button");
                    removeBtn.type = "button";
                    removeBtn.textContent = "X";
                    removeBtn.className =
                        "absolute top-0 right-0 bg-red-500 text-white text-xs rounded-full px-1";
                    removeBtn.onclick = function () {
                        imgWrapper.remove();
                        input.value = ""; // 선택 초기화
                    };
                    imgWrapper.appendChild(removeBtn);

                    previewContainer.appendChild(imgWrapper);
                };
                reader.readAsDataURL(file);
            }
        });
    };
</script>


<section
	class="bg-gradient-to-r from-blue-300 via-blue-200 to-blue-100 py-12">
	<div class="container mx-auto">
		<div class="bg-white rounded-lg shadow-xl p-10 max-w-2xl mx-auto">
			<h2 class="text-3xl font-bold text-center text-blue-600 mb-6">게시글
				작성</h2>
			<form action="doWrite" method="post" enctype="multipart/form-data"
				onsubmit="return writeForm_onSubmit(this);">
				<div class="space-y-6">
					<!-- 제목 -->
					<div>
						<label for="title" class="block text-sm font-medium text-gray-700">제목</label>
						<input type="text" id="title" name="title"
							placeholder="제목을 입력해주세요"
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
						<label for="articlePics"
							class="block text-sm font-medium text-gray-700">사진</label>
						<div class="relative group">
							<input type="file" id="articlePics" name="articlePics"
								accept=".jpg,.jpeg,.png" multiple
								class="absolute inset-0 w-full h-full opacity-0 cursor-pointer"
								onchange="previewImages(this)" />
							<div
								class="flex items-center justify-center w-full h-12 bg-blue-500 text-white rounded-lg shadow-sm hover:bg-blue-600 transition duration-300 ease-in-out">
								<img src="/upload/image.png" alt="사진 선택" class="h-8 w-8 mr-2" />
								<span>사진 선택</span>
							</div>
						</div>
						<p class="text-sm text-gray-500 mt-2">JPEG, PNG 형식의 사진을 최대
							5장까지 업로드할 수 있습니다.</p>
					</div>

					<!-- 미리보기 -->
					<div id="preview-container" class="flex flex-wrap mt-4">
						<!-- 선택된 사진 미리보기가 여기에 표시됩니다 -->
					</div>
				</div>

				<!-- 버튼 -->
				<div class="mt-6 flex justify-between">
					<button type="button" onclick="history.back();"
						class="btn btn-outline btn-secondary text-blue-500 border-blue-500 hover:bg-blue-100 hover:text-blue-600">
						뒤로가기</button>
					<button type="submit"
						class="btn bg-blue-500 text-white hover:bg-blue-600 py-3 px-6 rounded-lg transition-colors duration-300 ease-in-out">
						작성하기</button>
				</div>
			</form>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>
