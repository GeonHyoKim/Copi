<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:set var="pageTitle" value="회원정보 수정" />
<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<section class="container mx-auto p-4">
	<!-- 회원 정보 -->
	<div class="bg-white p-6 rounded-lg shadow-md">
	<form action="doModify" method="post" enctype="multipart/form-data">
		<h2 class="text-3xl font-semibold text-pink-600 mb-6">회원 정보</h2>
		<input type="hidden" name="id" value="${member.getId() }" />
		<table class="table-auto w-full text-left border-collapse">
			<thead>
				<tr>
					<th class="px-4 py-2 bg-pink-100 border-b text-lg text-pink-600">항목</th>
					<th class="px-4 py-2 bg-pink-100 border-b text-lg text-pink-600">정보</th>
					<th class="px-4 py-2 bg-pink-100 border-b text-lg text-pink-600">수정할 내용</th>
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
					<td><input id="name" name="name" type="text" placeholder="변경할 이름을 입력해주세요" value="${member.getName() }"/></td>
				</tr>
				<tr>  	
					<td class="px-4 py-2 border-b font-medium">나이</td>
					<td class="px-4 py-2 border-b">${member.age}</td>
					<td><input id="age" name="age" type="text" placeholder="변경할 나이를 입력해주세요" value="${member.getAge() }"/></td>
				</tr>
				<tr>
					<td class="px-4 py-2 border-b font-medium">성별</td>
					<td class="px-4 py-2 border-b" >${member.sex}</td>
					<td class="px-4 py-2 border-b">변경할 수 없습니다</td>
				</tr>
				<tr>
					<td class="px-4 py-2 border-b font-medium">지역</td>
					<td class="px-4 py-2 border-b">${member.areaId}</td>
					<td><input id="areaId" name="areaId" type="text" placeholder="변경할 지역을 입력해주세요" value="${member.getAreaId() }"/></td>
				</tr>
				<tr>
					<td class="px-4 py-2 border-b font-medium">사진</td>
					<td class="px-4 py-2 border-b">
						<c:choose>
						    <c:when test="${not empty pics}">
						        <c:forEach var="pic" items="${pics}">
						            <div class="avatar">
										<div class="w-24 rounded mb-3">
										 	<img src="/usr/member/getImage?pic=${pic.pic}" alt="사진" />
										</div>
										<!-- 사진 삭제 버튼 -->
										<a href="/usr/member/picDelete?id=${member.getId() }&picId=${pic.getId()}" class="text-red-500 hover:text-red-700 font-semibold">
											삭제
										</a>
									</div>
						        </c:forEach>
						    </c:when>
						    <c:otherwise>
						        <p>등록된 사진이 없습니다.</p>
						    </c:otherwise>
						</c:choose>
					</td>
					<td><input type="file" name="pic" class="border px-3 py-2 rounded-md" /></td>	
				</tr>
			</tbody>
		</table>
		
		<!-- 수정하기 버튼 -->
		<div class="mt-6 flex justify-between">
			<button type="submit" class="bg-pink-600 text-white font-bold px-6 py-3 rounded-full shadow-lg hover:bg-pink-700 transition duration-300">
				수정하기
			</button>
			<!-- 뒤로가기 버튼 -->
			<button type="button" onclick="history.back()" class="bg-gray-600 hover:bg-gray-700 text-white font-bold px-6 py-3 rounded-full shadow-lg transition duration-300">
				뒤로가기
			</button>
		</div>
	</form>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>
