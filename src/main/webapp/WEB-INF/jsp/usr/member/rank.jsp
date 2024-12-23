<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:set var="pageTitle" value="랭킹" />
<%@ include file="/WEB-INF/jsp/common/header.jsp"%>


<style>
/* 전체 배경 */
body {
    font-family: 'Arial', sans-serif;
    background: linear-gradient(135deg, #f8f9fa, #e9ecef);
    color: #343a40;
    margin: 0;
    padding: 0;
}

/* 랭킹 컨테이너 */
.ranking-container {
    display: flex;
    justify-content: center;
    gap: 40px;
    align-items: flex-start;
    height: 100%;
    margin: 50px 0; /* 상단 여백 추가 */
}

/* 랭킹 카드 */
.ranking {
    display: flex;
    flex-direction: column;
    align-items: center;
    position: relative;
    width: 220px;
    background-color: #fff;
    border-radius: 20px;
    box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    padding: 20px;
}

.ranking:hover {
    transform: translateY(-10px);
    box-shadow: 0 12px 20px rgba(0, 0, 0, 0.15);
}

/* 메달 스타일 */
.medal {
    position: absolute;
    top: -30px;
    font-size: 3rem;
    font-weight: bold;
    text-shadow: 1px 1px 5px rgba(0, 0, 0, 0.2);
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

/* 회원 사진 */
.member-pic {
    width: 160px;
    height: 160px;
    object-fit: cover;
    border-radius: 50%;
    margin-top: 50px;
    border: 5px solid transparent;
    transition: border-color 0.3s ease, transform 0.3s ease;
}

.ranking-1st .member-pic {
    border-color: gold;
}

.ranking-2nd .member-pic {
    border-color: silver;
}

.ranking-3rd .member-pic {
    border-color: #cd7f32;
}

.member-pic:hover {
    transform: scale(1.1);
}

/* 회원 정보 */
.member-info {
    text-align: center;
    margin-top: 20px;
}

.member-info p {
    font-size: 1.2rem;
    font-weight: bold;
    margin: 5px 0;
}

/* 하트 아이콘 */
.heart-icon {
    color: #e63946;
    margin-right: 5px;
    transition: transform 0.3s ease, color 0.3s ease;
    cursor: pointer;
}

.heart-icon:hover {
    transform: scale(1.2);
    color: #d62828;
}

/* 추가 애니메이션 */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.ranking {
    animation: fadeIn 0.5s ease;
}
</style>


<section>
	<div class="ranking-container">
		<!-- 1등 회원 -->
		<div class="ranking ranking-1st">
			<div class="medal">🥇</div>
			<c:choose>
				<c:when test="${not empty HRFirstPic}">
					<a href="/usr/member/detail?id=${firstHeartRanker.id}"> <img
						src="/usr/pic/getImage?pic=${HRFirstPic.pic}" class="member-pic">
					</a>
				</c:when>
				<c:otherwise>
					<div class="member-pic bg-gray-200"></div>
				</c:otherwise>
			</c:choose>
			<div class="member-info">
				<c:if test="${not empty firstHeartRanker}">
					<p>${firstHeartRanker.name}</p>
					<p>
						<span id="likePointBtn" class="heart-icon"> <i
							class="fa-solid fa-heart"></i>
						</span>${like1stCount }
					</p>
				</c:if>
			</div>
		</div>

		<!-- 2등 회원 -->
		<div class="ranking ranking-2nd">
			<div class="medal">🥈</div>
			<c:choose>
				<c:when test="${not empty HRSecondPic}">
					<a href="/usr/member/detail?id=${secondHeartRanker.id}"> <img
						src="/usr/pic/getImage?pic=${HRSecondPic.pic}" class="member-pic">
					</a>
				</c:when>
				<c:otherwise>
					<div class="member-pic bg-gray-200"></div>
				</c:otherwise>
			</c:choose>
			<div class="member-info">
				<c:if test="${not empty secondHeartRanker}">
					<p>${secondHeartRanker.name}</p>
					<p>
						<span id="likePointBtn" class="heart-icon"> <i
							class="fa-solid fa-heart"></i>
						</span>${like2edCount }
					</p>
				</c:if>
			</div>
		</div>

		<!-- 3등 회원 -->
		<div class="ranking ranking-3rd">
			<div class="medal">🥉</div>
			<c:choose>
				<c:when test="${not empty HRThirdPic}">
					<a href="/usr/member/detail?id=${thirdHeartRanker.id}"> <img
						src="/usr/pic/getImage?pic=${HRThirdPic.pic}" class="member-pic">
					</a>
				</c:when>
				<c:otherwise>
					<div class="member-pic bg-gray-200"></div>
				</c:otherwise>
			</c:choose>
			<div class="member-info">
				<c:if test="${not empty thirdHeartRanker}">
					<p>${thirdHeartRanker.name}</p>
					<p>
						<span id="likePointBtn" class="heart-icon"> <i
							class="fa-solid fa-heart"></i>
						</span>${like3rdCount }
					</p>
				</c:if>
			</div>
		</div>
	</div>
</section>

<section>
	<div class="ranking-container">
		<!-- 1등 회원 -->
		<div class="ranking ranking-1st">
			<div class="medal">🥇</div>
			<c:choose>
				<c:when test="${not empty VRFirstPic}">
					<a href="/usr/member/detail?id=${firstviewsRanker.id}"> <img
						src="/usr/pic/getImage?pic=${VRFirstPic.pic}" class="member-pic">
					</a>
				</c:when>
				<c:otherwise>
					<div class="member-pic bg-gray-200"></div>
				</c:otherwise>
			</c:choose>
			<div class="member-info">
				<c:if test="${not empty firstviewsRanker}">
					<p>${firstviewsRanker.name}</p>
					<p>
                        <span class="icon">👁️ </span>${firstviewsRanker.views}
                    </p>
				</c:if>
			</div>
		</div>

		<!-- 2등 회원 -->
		<div class="ranking ranking-2nd">
			<div class="medal">🥈</div>
			<c:choose>
				<c:when test="${not empty VRSecondPic}">
					<a href="/usr/member/detail?id=${secondviewsRanker.id}"> <img
						src="/usr/pic/getImage?pic=${VRSecondPic.pic}" class="member-pic">
					</a>
				</c:when>
				<c:otherwise>
					<div class="member-pic bg-gray-200"></div>
				</c:otherwise>
			</c:choose>
			<div class="member-info">
				<c:if test="${not empty secondviewsRanker}">
					<p>${secondviewsRanker.name}</p>
					<p>
                        <span class="icon">👁️ </span>${secondviewsRanker.views}
                    </p>
				</c:if>
			</div>
		</div>

		<!-- 3등 회원 -->
		<div class="ranking ranking-3rd">
			<div class="medal">🥉</div>
			<c:choose>
				<c:when test="${not empty VRThirdPic}">
					<a href="/usr/member/detail?id=${thirdviewsRanker.id}"> <img
						src="/usr/pic/getImage?pic=${VRThirdPic.pic}" class="member-pic">
					</a>
				</c:when>
				<c:otherwise>
					<div class="member-pic bg-gray-200"></div>
				</c:otherwise>
			</c:choose>
			<div class="member-info">
				<c:if test="${not empty thirdviewsRanker}">
					<p>${thirdviewsRanker.name}</p>
					<p>
                        <span class="icon">👁️ </span>${thirdviewsRanker.views}
                    </p>
				</c:if>
			</div>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>
