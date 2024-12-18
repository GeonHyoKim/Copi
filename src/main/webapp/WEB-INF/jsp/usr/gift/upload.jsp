<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:set var="pageTitle" value="상품 등록" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
<script>
// 미리보기 및 파일 제한 기능
const previewImages = function (input) {
    const previewContainer = document.getElementById('preview-container');
    const files = Array.from(input.files);


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
	class="bg-gradient-to-r from-pink-300 via-pink-200 to-pink-100 py-12">
	<div class="container mx-auto">
		<div class="bg-white rounded-lg shadow-xl p-10 max-w-2xl mx-auto">
			<form action="doUpload" method="post" enctype="multipart/form-data">
				<div class="grid grid-cols-1 gap-6">
					<div>
						<label class="block text-sm font-medium text-gray-700">상품 이름</label>
						<input type="text" name="giftName" placeholder="상품이름"
							class="input input-bordered w-full py-3 px-4 border rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-pink-500" />
					</div>
					<div>
						<label class="block text-sm font-medium text-gray-700">가격</label>
						<input name="price" placeholder="가격을 입력해주세요"
							class="input input-bordered w-full py-3 px-4 border rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-pink-500" />
					</div>
					<div>
						<label for="giftPic"
							class="block text-sm font-medium text-gray-700">사진</label>
						<div class="relative group">
							<input type="file" id="giftPic" name="giftPic"
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
				<div class="mt-6 flex justify-between">
					<button type="button" onclick="history.back();"
						class="btn btn-outline btn-secondary text-pink-500 border-pink-500 hover:bg-pink-100 hover:text-pink-600">
						뒤로가기</button>
					<button type="submit"
						class="btn bg-pink-500 text-white hover:bg-pink-600 py-3 px-6 rounded-lg transition-colors duration-300 ease-in-out">
						업로드 하기</button>
				</div>
			</form>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>
