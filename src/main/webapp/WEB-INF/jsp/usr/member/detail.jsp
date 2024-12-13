<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:set var="pageTitle" value="회원 상세보기" />
<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<script>
    $(document).ready(function() {
        getLikePoint();  // 페이지 로딩 시 좋아요 상태 확인
    });

    // 좋아요 버튼 클릭 시 처리
    const clickLikePoint = async function(code) {
    let likePointBtn = $('#likePointBtn > i').hasClass('fa-solid'); // 하트가 채워졌는지 확인
    await $.ajax({
        url : '/usr/heart/clickLikePoint',
        type : 'GET',
        data : {
            senderId : ${loginedMember.getId()},
            receiverId : ${member.getId()}, // 이 부분은 게시물 ID로 변환
            code : code,
            likePointBtn : likePointBtn
        },
        success: function(response) {
            const [likeCount, message] = response.split(";"); // 메시지와 likeCount 분리
            alert(message); // 서버에서 받은 메시지 표시

            // 하트 버튼 상태 갱신
            if (likeCount > 0) {
                $('#likePointBtn').html(`<i class="fa-solid fa-heart"></i>`); // 하트 채운 아이콘
            } else {
                $('#likePointBtn').html(`<i class="fa-regular fa-heart"></i>`); // 빈 하트 아이콘
            }
            
            // 하트 개수 갱신
            $('#likeCnt').text(likeCount); // 화면에 새로운 좋아요 개수 반영
        },
        error : function(xhr, status, error) {
            console.log(error);
        }
    });
};


    // 페이지 로딩 시 좋아요 상태 확인
    const getLikePoint = function() {
        $.ajax({
            url : '/usr/heart/getLikePoint',
            type : 'GET',
            data : {
                senderId : ${loginedMember.getId()},  // 로그인한 사용자 ID
                receiverId : ${member.getId()}       // 현재 회원 ID
            },
            success : function(response) {
                const status = response.split(",")[0]; // 좋아요 상태
                if (status.includes("이미 좋아요 누름")) {
                    $('#likePointBtn').html(`<i class="fa-solid fa-heart"></i>`); // 하트 채운 아이콘
                } else {
                    $('#likePointBtn').html(`<i class="fa-regular fa-heart"></i>`); // 빈 하트 아이콘
                }
            },
            error : function(xhr, status, error) {
                console.log(error);
            }
        })
    }
</script>

<section class="container mx-auto p-6 bg-gray-50 rounded-lg shadow-lg">
	<h2 class="text-3xl font-bold text-pink-600 mb-8 text-center">회원
		상세보기</h2>
	<div class="bg-white p-6 rounded-lg shadow-md flex">
		<div class="flex-shrink-0">
			<div class="relative w-64">
				<c:choose>
					<c:when test="${not empty pics}">
						<div id="photo-slider" class="relative overflow-hidden">
							<div class="w-full">
								<c:forEach var="pic" items="${pics}" varStatus="status">
									<img src="/usr/pic/getImage?pic=${pic.pic}"
										class="photo-slide ${status.index == 0 ? '' : 'hidden'} w-64 h-64 object-cover rounded">
								</c:forEach>
							</div>
							<button id="prev-btn"
								class="absolute left-0 top-1/2 transform -translate-y-1/2 text-white px-2 py-1 rounded-full shadow">&lt;</button>
							<button id="next-btn"
								class="absolute right-0 top-1/2 transform -translate-y-1/2 text-white px-2 py-1 rounded-full shadow">&gt;</button>
						</div>
					</c:when>
					<c:otherwise>
						<p class="text-center">등록된 사진이 없습니다.</p>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="bg-white p-6 rounded-lg shadow-md">
			<table class="table-auto w-full border-collapse">
				<tbody>
					<tr class="border-b">
						<th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">이름</th>
						<td class="px-4 py-2 text-gray-800">${member.getName()}</td>
					</tr>
					<tr class="border-b">
						<th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">나이</th>
						<td class="px-4 py-2 text-gray-800">${member.getAge()}</td>
					</tr>
					<tr class="border-b">
						<th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">성별</th>
						<td class="px-4 py-2 text-gray-800">${member.getSex()}</td>
					</tr>
					<tr>
						<th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">지역</th>
						<td class="px-4 py-2 text-gray-800">${member.getAreaId()}</td>
					</tr>
					<tr>
						<th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">하트
							갯수</th>
						<td class="px-4 py-2 text-gray-800"><c:if
								test="${not empty loginedMember}">
								<button class="btn-like" onclick="clickLikePoint();">
									<span id="likePointBtn" class="heart-icon"> <i
										class="fa-regular fa-heart"></i>
									</span>
								</button>
							</c:if> <span id="likeCnt">${likeCount}</span></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div class="mt-8 text-center space-y-4">
    <button onclick="history.back()"
        class="bg-gray-600 hover:bg-gray-700 text-white font-bold px-6 py-3 rounded-full shadow-lg transition duration-300 w-full sm:w-auto">뒤로가기</button>
    
    <c:if test="${not empty loginedMember}">
        <div class="flex justify-center gap-4">
            <a href="/usr/message/send?receiverId=${member.getId()}"
                class="bg-pink-600 hover:bg-pink-700 text-white font-bold px-6 py-3 rounded-full shadow-lg transition duration-300 w-full sm:w-auto">
                쪽지 보내기
            </a>
<%--             <a href="/usr/chat/chat?receiverId=${member.getId()}" --%>
<!--                 class="bg-pink-600 hover:bg-pink-700 text-white font-bold px-6 py-3 rounded-full shadow-lg transition duration-300 w-full sm:w-auto"> -->
<!--                 채팅방 열기 -->
<!--             </a> -->
            <button 
                class="in" data-id="${member.getId()}">
                채팅방 열기
            </button>
        </div>
    </c:if>
</div>
</section>
<script>
	
		$('.in').click(function() {
			let senderId = $(this).data('id');  // 부모 창에서 ID 가져오기
		    let child = window.open('/usr/chat/chat?receiverId=' + senderId, 'chat', 'width=405', 'height=510');
			
			child.addEventListener('load', function() {
				//자식창 다 뜨고 나면 발생
				child.document.getElementById('receiverId').value = receiverId;
			});
		});
	
	</script>
<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>
