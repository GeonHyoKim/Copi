<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:set var="pageTitle" value="회원가입" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<script>
	// 서버에서 전달된 메시지가 있으면 알림을 띄우고 리다이렉트
	<c:if test="${not empty message}">
	alert("${message}"); // 회원가입 성공 메시지
	setTimeout(function() {
		window.location.href = "/usr/home/home"; // 홈으로 리다이렉트
	});
	</c:if>

	<c:if test="${not empty failMessage}">
	alert("${failMessage}"); // 회원가입 실패 메시지
	</c:if>
</script>

<script>
const joinForm_onSubmit = function(form) {
    // 기타 유효성 검사...

    const phoneRegex = /^(010|011|016|017|018|019)-\d{3,4}-\d{4}$/;
    if (!phoneRegex.test(form.num.value)) {
        alert('전화번호 형식이 올바르지 않습니다. (예: 010-1234-5678)');
        form.num.focus();
        return;
    }

    form.submit();
}

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
		form.pic.value = form.pic.value.trim();

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

		if (form.pic.value.length == 0) {
			alert('사진을 등록해주세요');
			return;
		}
		
		console.log(form.areaId.value);
		form.submit();
		
	}
</script>
<script>
	// 이미지 미리보기 처리 함수
	function previewImage(event) {
		const file = event.target.files[0]; // 선택된 파일
		const reader = new FileReader(); // FileReader 객체 생성

		// FileReader로 파일을 읽었을 때 처리할 함수
		reader.onload = function(e) {
			// 이미지 미리보기 추가
			const imagePreviewContainer = document.getElementById('imagePreviewContainer');

			// 미리보기 이미지와 삭제 버튼을 포함할 div 생성
			const previewWrapper = document.createElement('div');
			previewWrapper.classList.add('relative'); // 삭제 버튼을 위한 상대적 위치 지정

			const imagePreview = document.createElement('img');
			imagePreview.src = e.target.result; // 미리보기 이미지로 설정
			imagePreview.classList.add('w-32', 'h-32', 'object-cover', 'mr-2'); // 이미지 스타일 설정

			// 삭제 버튼 생성
			const deleteButton = document.createElement('button');
			deleteButton.innerHTML = 'X'; // 버튼에 "X" 텍스트
			deleteButton.classList.add('absolute', 'top-0', 'right-0', 'bg-red-500', 'text-white', 'rounded-full', 'w-6', 'h-6', 'flex', 'items-center', 'justify-center');
			deleteButton.onclick = function() {
				// 해당 이미지를 삭제
				previewWrapper.remove();
			};

			// 이미지와 삭제 버튼을 감싸는 div에 이미지와 삭제 버튼을 추가
			previewWrapper.appendChild(imagePreview);
			previewWrapper.appendChild(deleteButton);

			// 미리보기 컨테이너에 추가
			imagePreviewContainer.appendChild(previewWrapper);

			// 최초 이미지 선택 버튼은 한 개만 유지
			if (!imagePreviewContainer.querySelector('input[type="file"]')) {
				const newUploadButton = document.createElement('label');
				newUploadButton.classList.add('cursor-pointer');
				newUploadButton.innerHTML = '<img src="/upload/image.png" alt="파일 선택" class="w-32 h-32" />';
				const inputFile = document.createElement('input');
				inputFile.type = 'file';
				inputFile.name = 'pic';
				inputFile.classList.add('hidden');
				inputFile.addEventListener('change', previewImage); // 파일 선택 시 미리보기 실행

				// 파일 선택 버튼을 다시 추가
				newUploadButton.appendChild(inputFile);
				imagePreviewContainer.appendChild(newUploadButton); // 버튼을 마지막에 추가
			}
		}

		if (file) {
			reader.readAsDataURL(file); // 선택된 파일을 base64 URL로 변환
		}
	}
</script>
<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=893e98e2b5e6b7a1f3f211e9af4eb5d4&libraries=services"></script>
		
<section
	class="bg-gradient-to-r from-pink-300 via-pink-200 to-pink-100 py-12">
	<!-- 부드러운 연핑크 그라디언트 배경 -->
	<div class="container mx-auto">
		<div class="bg-white rounded-lg shadow-xl p-10 max-w-2xl mx-auto">
			<!-- 흰색 배경을 사용하고 그림자 효과 강화 -->
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
						<label class="block text-sm font-medium text-gray-700">비밀번호
							확인</label> <input type="password" name="pwChk"
							placeholder="비밀번호를 다시 입력해주세요"
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
						<select name="sex"
							class="select select-bordered w-full py-3 px-4 border rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-pink-500">
							<option value="" disabled selected>성별을 선택해주세요</option>
							<option value="남성">남성</option>
							<option value="여성">여성</option>
						</select>
					</div>
					<div>
    <label class="block text-sm font-medium text-gray-700">번호</label>
    <input type="tel" name="num" placeholder="번호를 입력해주세요"
        class="input input-bordered w-full py-3 px-4 border rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-pink-500" 
        pattern="^(010|011|016|017|018|019)-\d{3,4}-\d{4}$" 
        title="전화번호는 010-XXXX-XXXX 형식으로 입력해주세요" required />
</div>
					<div>
						<label class="block text-sm font-medium text-gray-700">지역 - <button type="button" onclick="getLocation()">위치 찾기</button></label>
						주소 : <input name="areaId" id="areaId" />
					</div>
					<div>
						<label class="block text-sm font-medium text-gray-700">사진</label>
						<div id="imagePreviewContainer"
							class="flex items-center space-x-4 mb-4">
							<!-- 최초 이미지 선택 버튼 -->
							<label for="pic" class="cursor-pointer"> <img
								src="/upload/image.png" alt="파일 선택" class="w-32 h-32" />
							</label> <input type="file" name="pic" id="pic" class="hidden"
								onchange="previewImage(event)" />
						</div>
					</div>
				</div>
				<div class="mt-6 flex justify-between">
					<button type="button" onclick="history.back();"
						class="btn btn-outline btn-secondary text-pink-500 border-pink-500 hover:bg-pink-100 hover:text-pink-600">
						뒤로가기</button>
					<button type="submit"
						class="btn bg-pink-500 text-white hover:bg-pink-600 py-3 px-6 rounded-lg transition-colors duration-300 ease-in-out">
						회원가입 하기</button>
				</div>
			</form>
		</div>
	</div>
</section>
<script>
    function getLocation() {
      const addressElement = document.getElementById("areaId");
      // Geolocation API 지원 여부 확인
      if ("geolocation" in navigator) {
        navigator.geolocation.getCurrentPosition(
          (position) => {
            const { latitude, longitude, accuracy } = position.coords;
            
//             var container = document.getElementById('map');
//             var options = {
//               center: new kakao.maps.LatLng(latitude, longitude),
//               level: 3
//             };

//             var map = new kakao.maps.Map(container, options);
//             var markerPosition  = new kakao.maps.LatLng(latitude, longitude); 
//             var marker = new kakao.maps.Marker({
//               position: markerPosition
//             });

//             // 지도에 마커 추가
//             marker.setMap(map);	
            
            var geocoder = new kakao.maps.services.Geocoder();
            geocoder.coord2Address(longitude, latitude, function(result, status) {
            	if (status === kakao.maps.services.Status.OK) {                // 주소를 결과에서 찾기
            		var address = result[0].address.address_name;
            		var addressParts = address.split(' ');
            		var simplifiedAddress = addressParts[0] + " " + addressParts[1];
            	    addressElement.textContent = `\${simplifiedAddress}`;
            	    addressElement.value = `\${simplifiedAddress}`;
            } else {
                addressElement.textContent = "주소를 찾을 수 없습니다.";
              }
            });
          },
          (error) => {
        	  
          },
          {
            enableHighAccuracy: true, // 정확도 우선 모드
            timeout: 10000,           // 10초 이내에 응답 없으면 에러 발생
            maximumAge: 0             // 항상 최신 위치 정보 수집
          }
        );
      } else {
        status.textContent = "브라우저가 위치 서비스를 지원하지 않습니다.";
      }
    }
  </script>
<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>
