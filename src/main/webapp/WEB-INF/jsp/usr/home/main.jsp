<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
<c:set var="pageTitle" value="메인" />

<script>
    document.addEventListener("DOMContentLoaded", () => {
        const slidesLeft = document.querySelectorAll(".photo-slide-left");
        const slidesCenter = document.querySelectorAll(".photo-slide-center");
        const slidesRight = document.querySelectorAll(".photo-slide-right");
        
        let currentIndexLeft = 0, currentIndexCenter = 0, currentIndexRight = 0;

        const showSlide = (slides, index) => {
            slides.forEach((slide, i) => {
                slide.style.display = i === index ? "block" : "none";
            });
        };

        document.getElementById("prev-btn-left").addEventListener("click", () => {
            currentIndexLeft = (currentIndexLeft > 0) ? currentIndexLeft - 1 : slidesLeft.length - 1;
            showSlide(slidesLeft, currentIndexLeft);
        });

        document.getElementById("next-btn-left").addEventListener("click", () => {
            currentIndexLeft = (currentIndexLeft < slidesLeft.length - 1) ? currentIndexLeft + 1 : 0;
            showSlide(slidesLeft, currentIndexLeft);
        });

        document.getElementById("prev-btn-center").addEventListener("click", () => {
            currentIndexCenter = (currentIndexCenter > 0) ? currentIndexCenter - 1 : slidesCenter.length - 1;
            showSlide(slidesCenter, currentIndexCenter);
        });

        document.getElementById("next-btn-center").addEventListener("click", () => {
            currentIndexCenter = (currentIndexCenter < slidesCenter.length - 1) ? currentIndexCenter + 1 : 0;
            showSlide(slidesCenter, currentIndexCenter);
        });

        document.getElementById("prev-btn-right").addEventListener("click", () => {
            currentIndexRight = (currentIndexRight > 0) ? currentIndexRight - 1 : slidesRight.length - 1;
            showSlide(slidesRight, currentIndexRight);
        });

        document.getElementById("next-btn-right").addEventListener("click", () => {
            currentIndexRight = (currentIndexRight < slidesRight.length - 1) ? currentIndexRight + 1 : 0;
            showSlide(slidesRight, currentIndexRight);
        });
    });
</script>

<div class="flex justify-center items-center space-x-8">
    <!-- 첫 번째 회원 사진과 정보 (왼쪽) -->
    <div class="flex flex-col items-center">
        <div class="relative w-64">
            <c:choose>
                <c:when test="${not empty prevMemberPic}">
                    <div class="relative overflow-hidden">
                        <c:forEach var="pic" items="${prevMemberPic}" varStatus="status">
                            <img id="prev-member-pic" src="/usr/member/getImage?pic=${pic.pic}" class="photo-slide-left ${status.index == 0 ? '' : 'hidden'} w-64 h-64 object-cover rounded">
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- 왼쪽에 아무것도 보이지 않게 하기 위해 공백 처리 -->
                    <div class="w-64 h-64"></div>
                </c:otherwise>
            </c:choose>
        </div>
        <c:choose>
            <c:when test="${not empty prevMember}">
                <div id="prev-member-info" class="flex flex-col items-center space-y-2">
                    <p class="text-lg font-semibold">회원 이름: ${prevMember.name}</p>
                    <p>회원 ID: ${prevMember.id}</p>
                    <p>나이: ${prevMember.age}</p>
                    <p>성별: ${prevMember.sex}</p>
                    <p>지역: ${prevMember.areaId}</p>
                </div>
            </c:when>
            <c:otherwise>
                <!-- 왼쪽에는 아무것도 표시하지 않음 -->
            </c:otherwise>
        </c:choose>
    </div>

    <!-- 두 번째 회원 사진과 정보 (가운데) -->
    <div class="flex flex-col items-center">
        <div class="relative w-64">
            <c:choose>
                <c:when test="${not empty pics}">
                    <div class="relative overflow-hidden">
                        <c:forEach var="pic" items="${pics}" varStatus="status">
                            <!-- 사진을 클릭하면 해당 회원의 상세 페이지로 이동 -->
                            <a href="/usr/member/detail?id=${member.id}">
                                <img src="/usr/member/getImage?pic=${pic.pic}" class="photo-slide-center ${status.index == 0 ? '' : 'hidden'} w-64 h-64 object-cover rounded">
                            </a>
                        </c:forEach>
                        
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="text-center">등록된 사진이 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="flex flex-col items-center space-y-2">
            <p class="text-lg font-semibold">회원 이름: ${member.name}</p>
            <p>회원 ID: ${member.id}</p>
            <p>나이: ${member.age}</p>
            <p>성별: ${member.sex}</p>
            <p>지역: ${member.areaId}</p>
            <div class="flex space-x-4">
                <a href="/usr/home/main?memberId=${prevMember.id}" class="btn btn-info">이전 회원</a>
                <a href="/usr/home/main?memberId=${nextMember.id}" class="btn btn-info">다음 회원</a>
            </div>
        </div>
    </div>

    <!-- 세 번째 회원 사진과 정보 (오른쪽) -->
    <div class="flex flex-col items-center">
        <div class="relative w-64">
            <c:choose>
                <c:when test="${not empty nextMemberPic}">
                    <div class="relative overflow-hidden">
                        <c:forEach var="pic" items="${nextMemberPic}" varStatus="status">
                            <img id="next-member-pic" src="/usr/member/getImage?pic=${pic.pic}" class="photo-slide-right ${status.index == 0 ? '' : 'hidden'} w-64 h-64 object-cover rounded">
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- 오른쪽에는 아무것도 보이지 않게 하기 위해 공백 처리 -->
                    <div class="w-64 h-64"></div>
                </c:otherwise>
            </c:choose>
        </div>
        <c:choose>
            <c:when test="${not empty nextMember}">
                <div id="next-member-info" class="flex flex-col items-center space-y-2">
                    <p class="text-lg font-semibold">회원 이름: ${nextMember.name}</p>
                    <p>회원 ID: ${nextMember.id}</p>
                    <p>나이: ${nextMember.age}</p>
                    <p>성별: ${nextMember.sex}</p>
                    <p>지역: ${nextMember.areaId}</p>
                </div>
            </c:when>
            <c:otherwise>
                <!-- 오른쪽에는 아무것도 표시하지 않음 -->
            </c:otherwise>
        </c:choose>
    </div>
</div>


<script>
    document.addEventListener("DOMContentLoaded", () => {
        const prevMemberPic = document.getElementById("prev-member-pic");
        const nextMemberPic = document.getElementById("next-member-pic");

        if (prevMemberPic) {
            prevMemberPic.style.filter = "blur(4px) opacity(30%)";  // 흐림 효과
        }

        if (nextMemberPic) {
            nextMemberPic.style.filter = "blur(4px) opacity(30%)";  // 흐림 효과
        }
    });
</script>
