<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:set var="pageTitle" value="회원 상세보기" />
<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<script>
const clickLikePoint = async function() {
    let likePointBtn = $('#likePointBtn > i').hasClass('fa-solid'); // 하트가 채워졌는지 확인
    
    await $.ajax({
        url : '/usr/heart/clickLikePoint',
        type : 'GET',
        data : {
            senderId : ${loginedMember.getId()},  // 로그인한 사용자 ID
            receiverId : ${member.getId()},      // 현재 회원 ID
            likePointBtn : likePointBtn           // 하트 상태 (채워짐/비어 있음)
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
}


const getLikePoint = function() {
    $.ajax({
        url : '/usr/heart/getLikePoint',
        type : 'GET',
        data : {
            senderId : ${loginedMember.getId()},  // 로그인한 사용자 ID
            receiverId : ${member.getId()}       // 현재 회원 ID
        },
        success : function(response) {
            if (response === "좋아요 상태: 이미 좋아요 누름") {
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

	<div class="bg-white p-6 rounded-lg shadow-md">
		<table class="table-auto w-full border-collapse">
			<tbody>
				<tr class="border-b">
					<th class="px-4 py-2 bg-pink-100 text-gray-700 text-left w-1/3">회원
						번호</th>
					<td class="px-4 py-2 text-gray-800">${member.getId()}</td>
				</tr>
				<tr class="border-b">
					<th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">가입일</th>
					<td class="px-4 py-2 text-gray-800">${member.getRegDate().substring(2, 16)}</td>
				</tr>
				<tr class="border-b">
					<th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">성별</th>
					<td class="px-4 py-2 text-gray-800">${member.getSex()}</td>
				</tr>
				<tr class="border-b">
					<th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">이름</th>
					<td class="px-4 py-2 text-gray-800">${member.getName()}</td>
				</tr>
				<tr class="border-b">
					<th class="px-4 py-2 bg-pink-100 text-gray-700 text-left">나이</th>
					<td class="px-4 py-2 text-gray-800">${member.getAge()}</td>
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
									class="fa fa-heart fa-regular"></i> <!-- 기본적으로 빈 하트 -->
								</span>
							</button>
						</c:if> <span id="likeCnt">${likeCount}</span> <!-- 좋아요 개수 표시 --></td>
				</tr>

			</tbody>
		</table>
	</div>

	<div class="mt-8 text-center">
		<button onclick="history.back()"
			class="bg-gray-600 hover:bg-gray-700 text-white font-bold px-6 py-3 rounded-full shadow-lg transition duration-300 mr-4">
			뒤로가기</button>
		<c:if test="${not empty loginedMember}">
			<a href="/usr/message/send?receiverId=${member.getId()}"
				class="bg-pink-600 hover:bg-pink-700 text-white font-bold px-6 py-3 rounded-full shadow-lg transition duration-300">
				메세지 보내기 </a>
		</c:if>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>
