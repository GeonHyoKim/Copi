<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
<c:set var="pageTitle" value="친구 찾기" />

<style>
    /* 회원 카드 */
    .member-card {
        width: 180px; /* 카드의 너비 */
        height: 240px; /* 카드의 높이 */
        background-color: #fff;
        border-radius: 20px;
        box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        padding: 20px;
        text-align: center;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        cursor: pointer; /* 클릭 커서로 변경 */
        border: 2px solid transparent; /* 기본 경계선은 투명 */
    }

    /* 카드 hover시 강조 */
    .member-card:hover {
        transform: scale(1.05); /* 카드 크기 확대 */
        box-shadow: 0 12px 20px rgba(0, 0, 0, 0.2); /* 그림자 효과 강화 */
        border-color: #ec4899; /* 경계선 색상 변경 */
    }

    /* 사진 */
    .member-pic {
        width: 160px; /* 사진의 가로 크기 */
        height: 160px; /* 사진의 세로 크기 */
        object-fit: cover; /* 이미지가 영역에 맞게 잘리도록 */
        margin-bottom: 10px; /* 사진과 이름 사이의 간격 */
        border-radius: 10px; /* 사진의 테두리 둥글게 */
    }

    /* 회색 배경색 (사진이 없을 때) */
    .bg-gray-200 {
        background-color: #e2e8f0;
        border-radius: 10px; /* 사진이 없을 때도 둥근 테두리 */
    }

    /* 회원 리스트를 한 줄에 5명씩 배치 */
    .members-container {
        display: flex;
        flex-wrap: wrap; /* 여러 줄로 나누기 */
        gap: 20px; /* 각 항목 사이의 간격 */
        justify-content: center; /* 가운데 정렬 */
    }

    /* 이름 텍스트 */
    .member-name {
        font-size: 16px;
        font-weight: bold;
        margin-top: 10px;
    }

    /* 필터 버튼 */
    .filter-btn {
        margin: 10px;
        padding: 10px 20px;
        background-color: #ec4899;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
    }

    .filter-btn:hover {
        background-color: #d2368d;
    }
</style>

<div style="text-align: center; margin-bottom: 50px;">
    <ul style="list-style-type: none; padding: 0; margin: 0;">
        <li style="display: inline; margin-right: 20px;">
            <a href="/usr/member/list" style="text-decoration: none; padding: 10px 20px; background-color: #3498db; color: white; border-radius: 5px; font-weight: bold; transition: background-color 0.3s;">전체</a>
        </li>
        <li style="display: inline; margin-right: 20px;">
            <a href="/usr/member/list?sex=남성" style="text-decoration: none; padding: 10px 20px; background-color: #2ecc71; color: white; border-radius: 5px; font-weight: bold; transition: background-color 0.3s;">남자</a>
        </li>
        <li style="display: inline;">
            <a href="/usr/member/list?sex=여성" style="text-decoration: none; padding: 10px 20px; background-color: #e74c3c; color: white; border-radius: 5px; font-weight: bold; transition: background-color 0.3s;">여자</a>
        </li>
    </ul>
</div>


<div class="members-container" id="membersContainer">
    <c:forEach var="member" items="${members}">
        <div class="member-card" data-sex="${member.sex}">
            <a href="/usr/member/detail?id=${member.id}">
                <c:choose>
                    <c:when test="${not empty member.pic}">
                        <img src="/usr/pic/getImage?pic=${member.pic.pic}" class="member-pic" />
                    </c:when>
                    <c:otherwise>
                        <div class="member-pic bg-gray-200"></div>
                    </c:otherwise>
                </c:choose>
                <div class="member-name">
                    <c:if test="${not empty member}">
                        <p>${member.name} ${member.age}세</p>
                    </c:if>
                </div>
            </a>
        </div>
    </c:forEach>
</div>




<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>