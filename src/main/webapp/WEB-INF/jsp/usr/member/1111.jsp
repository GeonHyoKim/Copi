<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:set var="pageTitle" value="회원정보 수정" />
<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<script>
let removedImagesList = [];
	const writeForm_onSubmit = function(form) {
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

		
	    console.log(removedImagesList);
		form.submit();
	};

	function removeExistingImage(articlePicId) {
		console.log("Trying to remove image with ID: " + articlePicId); // 전달된 ID 확인

		// data-pic-id 속성을 사용하여 이미지를 찾습니다.
		const imageContainer = document
				.querySelector(`[data-pic-id="\${articlePicId}"]`);

		console.log("Image container:", imageContainer); // 찾은 요소 출력

		// 이미지가 존재하는 경우 삭제
		if (imageContainer) {
			imageContainer.remove(); // 이미지 삭제
			console.log("Image removed");
			
			removedImagesList.push(articlePicId); // List에 ID 추가
			
			// 삭제된 이미지를 추적하는 input 업데이트
			const removedImagesInput = document.getElementById('removedImages');
			let currentRemovedImages = removedImagesInput.value;
			currentRemovedImages = currentRemovedImages ? currentRemovedImages
					+ ',' + articlePicId : articlePicId;
			removedImagesInput.value = currentRemovedImages;
		} else {
			console.log("Image container not found!");
		}
		console.log(removedImagesList);
	}

	document.addEventListener("DOMContentLoaded", function() {

		// 이미지 미리보기 처리 함수
		function previewImage(event) {
			const file = event.target.files[0]; // 선택된 파일
			const reader = new FileReader(); // FileReader 객체 생성
			const imagePreviewContainer = document
					.getElementById('imagePreviewContainer');
			const uploadButton = document.getElementById('uploadButton'); // 업로드 버튼

			// 현재 이미지 개수를 확인
			const currentImageCount = imagePreviewContainer.children.length;

			// 최대 업로드 가능한 이미지 개수
			const maxImageCount = 5;

			// 이미지 개수가 5 이상이면 업로드 제한
			if (currentImageCount >= maxImageCount) {
				alert("최대 5장의 이미지만 업로드할 수 있습니다.");
				return;
			}

			// FileReader로 파일을 읽었을 때 처리할 함수
			reader.onload = function(e) {
				// 미리보기 이미지와 삭제 버튼을 포함할 div 생성
				const previewWrapper = document.createElement('div');
				previewWrapper.classList.add('relative', 'inline-block'); // 삭제 버튼을 위한 상대적 위치 지정

				const imagePreview = document.createElement('img');
				imagePreview.src = e.target.result; // 미리보기 이미지로 설정
				imagePreview.classList.add('w-32', 'h-32', 'object-cover',
						'mr-2'); // 이미지 스타일 설정

				// 삭제 버튼 생성
				const deleteButton = document.createElement('button');
				deleteButton.innerHTML = 'X'; // 버튼에 "X" 텍스트
				deleteButton.classList.add('absolute', 'top-0', 'right-0',
						'bg-red-500', 'text-white', 'rounded-full', 'w-6',
						'h-6', 'flex', 'items-center', 'justify-center');
				deleteButton.onclick = function() {
					// 해당 이미지를 삭제
					previewWrapper.remove();

					// 삭제 후 버튼 다시 활성화 (이미지가 5개 미만일 때)
					if (imagePreviewContainer.children.length < maxImageCount) {
						uploadButton.style.display = 'block';
					}
				};

				// 이미지와 삭제 버튼을 감싸는 div에 이미지와 삭제 버튼을 추가
				previewWrapper.appendChild(imagePreview);
				previewWrapper.appendChild(deleteButton);

				// 미리보기 컨테이너에 추가
				imagePreviewContainer.appendChild(previewWrapper);

				// 이미지 개수가 5개에 도달하면 업로드 버튼 숨김
				if (imagePreviewContainer.children.length >= maxImageCount) {
					uploadButton.style.display = 'none';
				}
			};

			if (file) {
				reader.readAsDataURL(file); // 선택된 파일을 base64 URL로 변환
			}
		}

		// 이미지 업로드 이벤트 처리
		const uploadButton = document.getElementById('newArticlePic');
		uploadButton.addEventListener('change', previewImage);
	});
</script>

<section class="container mx-auto p-4">
	<div class="bg-white p-6 rounded-lg shadow-md">
		<form action="doModify" method="post" enctype="multipart/form-data"
			onsubmit="return writeForm_onSubmit(this);">
			<h2 class="text-3xl font-semibold text-pink-600 mb-6">게시물 정보</h2>
			<input type="hidden" name="id" value="${member.getId()}" /> <input
				type="hidden" id="removedImages" name="removedImages" value="" />
			<!-- 삭제된 이미지 ID 저장 -->

			<table class="table-auto w-full text-left border-collapse">
				<thead>
					<tr>
						<th class="px-4 py-2 bg-pink-100 border-b text-lg text-pink-600">항목</th>
						<th class="px-4 py-2 bg-pink-100 border-b text-lg text-pink-600">정보</th>
						<th class="px-4 py-2 bg-pink-100 border-b text-lg text-pink-600">수정할
							내용</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="px-4 py-2 border-b font-medium">ID</td>
						<td class="px-4 py-2 border-b">${member.loginId}</td>
						<td class="px-4 py-2 border-b">변경할 수 없습니다</td>
					</tr>
					<tr>
						<td class="px-4 py-2 border-b font-medium">이름</td>
						<td class="px-4 py-2 border-b">${member.name}</td>
						<td><input id="name" name="name" type="text"
							placeholder="변경할 이름을 입력해주세요" value="${member.getName()}" /></td>
					</tr>
					<tr>
						<td class="px-4 py-2 border-b font-medium">나이</td>
						<td class="px-4 py-2 border-b">${member.age}</td>
						<td><input id="age" name="age" type="text"
							placeholder="변경할 나이를 입력해주세요" value="${member.getAge()}" /></td>
					</tr>
					<tr>
						<td class="px-4 py-2 border-b font-medium">성별</td>
						<td class="px-4 py-2 border-b">${member.sex}</td>
						<td class="px-4 py-2 border-b">변경할 수 없습니다</td>
					</tr>
					<tr>
						<td class="px-4 py-2 border-b font-medium">지역</td>
						<td class="px-4 py-2 border-b">${member.areaId}</td>
						<td><input id="areaId" name="areaId" type="text"
							placeholder="변경할 지역을 입력해주세요" value="${member.getAreaId()}" /></td>
					</tr>


					<tr>
						<td class="px-4 py-2 border-b font-medium">사진</td>
						<td class="px-4 py-2 border-b">
							<div id="imagePreviewContainer"
								class="flex items-center space-x-4">
								<c:choose>
									<c:when test="${not empty pics}">
										<c:forEach var="pic" items="${pics}">
											<div class="relative" data-pic-id="${pic.id}">
												<img src="/usr/pic/getImage?pic=${pic.pic}" alt="사진"
													class="w-24 h-24 object-cover" />
												<button type="button"
													class="absolute top-0 right-0 bg-red-500 text-white rounded-full w-6 h-6 flex items-center justify-center"
													onclick="removeExistingImage('${pic.id}')">X</button>
											</div>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<div class="text-gray-500">등록된 사진이 없습니다. 사진을 추가하세요!</div>
									</c:otherwise>
								</c:choose>
							</div>
						</td>

						<td class="px-4 py-2 border-b">
							<!-- 새로운 사진 업로드 -->
							<div id="newImageUploadContainer"
								class="flex items-center space-x-4">
								<label for="newArticlePic" id="uploadButton"
									class="cursor-pointer"> <img src="/upload/image.png"
									alt="파일 선택" class="w-32 h-32">
								</label> <input type="file" name="articlePics" id="newArticlePic"
									class="hidden" onchange="previewImage(event)">
							</div>
						</td>
					</tr>
				</tbody>
			</table>

			<!-- 수정하기 버튼 -->
			<div class="mt-6 flex justify-between">
				<button type="submit"
					class="bg-pink-600 text-white font-bold px-6 py-3 rounded-full shadow-lg hover:bg-pink-700 transition duration-300">
					수정하기</button>
				<!-- 뒤로가기 버튼 -->
				<button type="button" onclick="history.back()"
					class="bg-gray-600 hover:bg-gray-700 text-white font-bold px-6 py-3 rounded-full shadow-lg transition duration-300">
					뒤로가기</button>
			</div>
		</form>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>
