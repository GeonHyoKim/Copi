<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:set var="pageTitle" value="하트 랭킹" />
<%@ include file="/WEB-INF/jsp/common/header.jsp"%>


<style>
    .ranking-container {
        display: flex;
        justify-content: center;
        gap: 40px; /* 간격 조정 */
        align-items: flex-start;
        height: 100%; /* 컨테이너의 높이 조정 */
    }

    .ranking {
        display: flex;
        flex-direction: column;
        align-items: center;
        position: relative;
        width: 220px; /* 랭킹 카드 너비 */
    }

    .medal {
        position: absolute;
        top: -40px; /* 메달 위치 조정 */
        font-size: 3rem; /* 메달 크기 확대 */
    }

    .ranking-1st .medal {
        color: gold;
    }

    .ranking-2nd .medal {
        color: silver;
    }

    .ranking-3rd .medal {
        color: #cd7f32; /* 동메달 색상 */
    }

    .member-pic {
        width: 200px; /* 사진 크기 */
        height: 200px; /* 사진 크기 */
        object-fit: cover;
        border-radius: 50%;
        margin-top: 50px; /* 메달과의 간격 조정 */
        border: 5px solid transparent; /* 기본 상태 */
    }

    .ranking-1st .member-pic {
        border-color: gold; /* 금메달 */
    }

    .ranking-2nd .member-pic {
        border-color: silver; /* 은메달 */
    }

    .ranking-3rd .member-pic {
        border-color: #cd7f32; /* 동메달 */
    }

    .member-info {
        text-align: center;
        margin-top: 15px;
    }

    .member-info p {
        font-size: 1.5rem; /* 글씨 크기 확대 */
        font-weight: bold; /* 글씨 굵게 */
    }
    
</style>

<div class="ranking-container">
    <!-- 1등 회원 -->
    <div class="ranking ranking-1st">
        <div class="medal">🥇</div>
        <c:choose>
            <c:when test="${not empty firstPic}">
                <a href="/usr/member/detail?id=${firstMember.id}">
                    <img src="/usr/member/getImage?pic=${firstPic.pic}" class="member-pic">
                </a>
            </c:when>
            <c:otherwise>
                <div class="member-pic bg-gray-200"></div>
            </c:otherwise>
        </c:choose>
        <div class="member-info">
            <c:if test="${not empty firstMember}">
                <p>${firstMember.name}</p>
                <p><span id="likePointBtn" class="heart-icon"> 
                	<i class="fa-solid fa-heart"></i> 
					</span>${like1stCount }
				</p>
            </c:if>
        </div>
    </div>

    <!-- 2등 회원 -->
    <div class="ranking ranking-2nd">
        <div class="medal">🥈</div>
        <c:choose>
            <c:when test="${not empty secondPic}">
                <a href="/usr/member/detail?id=${secondMember.id}">
                    <img src="/usr/member/getImage?pic=${secondPic.pic}" class="member-pic">
                </a>
            </c:when>
            <c:otherwise>
                <div class="member-pic bg-gray-200"></div>
            </c:otherwise>
        </c:choose>
        <div class="member-info">
            <c:if test="${not empty secondMember}">
                <p>${secondMember.name}</p>
                <p><span id="likePointBtn" class="heart-icon"> 
                	<i class="fa-solid fa-heart"></i> 
					</span>${like2edCount }
				</p>
            </c:if>
        </div>
    </div>

    <!-- 3등 회원 -->
    <div class="ranking ranking-3rd">
        <div class="medal">🥉</div>
        <c:choose>
            <c:when test="${not empty thirdPic}">
                <a href="/usr/member/detail?id=${thirdMember.id}">
                    <img src="/usr/member/getImage?pic=${thirdPic.pic}" class="member-pic">
                </a>
            </c:when>
            <c:otherwise>
                <div class="member-pic bg-gray-200"></div>
            </c:otherwise>
        </c:choose>
        <div class="member-info">
            <c:if test="${not empty thirdMember}">
                <p>${thirdMember.name}</p>
                <p><span id="likePointBtn" class="heart-icon"> 
                	<i class="fa-solid fa-heart"></i> 
					</span>${like3rdCount }
				</p>
            </c:if>
        </div>
    </div>
</div>
