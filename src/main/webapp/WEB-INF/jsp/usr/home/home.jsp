<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:set var="pageTitle" value="메인" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Single+Day&display=swap" rel="stylesheet">

<style>
section {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin: 4rem auto;
    max-width: 1000px;
}

.home-2 {
    margin-top: 15rem;
}

.text-box {
    flex: 1;
    text-align: left;
    margin-right: 0.5rem;
}

.text-box h1 {
    font-size: 3.5rem;
    font-family: "Single Day", cursive;
    font-weight: 400;
    color: #000;
    line-height: 1.5;
}

.text-box-1{
	margin-left: 5rem;
}

.text-box a {
    display: inline-block;
    margin-top: 1rem;
    margin-left: 5rem;
    padding: 0.75rem 1.5rem;
    background-color: #ec4899;
    color: #fff;
    border-radius: 9999px;
    text-decoration: none;
    font-size: 1rem;
    font-weight: bold;
    transition: background-color 0.3s ease;
}

.text-box a:hover {
    background-color: #db2777;
}

.image-container {
    flex: 1;
    position: relative;
    height: 400px;
}

.image-container div {
    position: absolute;
    width: 250px;
    height: 250px;
    border-radius: 12px;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    overflow: hidden;
}

.image1 {
    top: 10px;
    left: 50px;
    transform: rotate(-10deg);
}

.image2 {
    top: 260px;
    right: 300px;
    transform: rotate(5deg);
}

.image3 {
    top: 200px;
    left: 230px;
    transform: rotate(-5deg);
}

.image-container img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.copi, .mein {
    color: #ec4899;
}

.review {
    flex-direction: column;
    align-items: center;
    position: relative;
    width: 600px;
    background-color: #fff;
    border-radius: 20px;
    box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    padding: 20px;
    margin-bottom: 20px;
    white-space: nowrap; /* 텍스트가 한 줄로 표시되도록 설정 */
    overflow: hidden; /* 내용이 넘치면 잘리도록 설정 */
    text-overflow: ellipsis; /* 텍스트가 넘칠 경우 생략 부호로 표시 */
}




.review:hover {
    transform: translateY(-10px);
    box-shadow: 0 12px 20px rgba(0, 0, 0, 0.15);
}

.review-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    background-color: #f0f4f8;
    padding: 2rem;
    margin-top: 5rem; /* 이 부분을 더 크게 조정하여 아래로 내려보세요 */
    margin-bottom: 5rem; /* 추가로 아래에 여백을 줄 수도 있습니다 */
    border-radius: 10px;
}


.review-box {
    display: none;
}

.review-box.active {
    display: block;
}
</style>


<section class="home-1">
    <div class="image-container">
        <div class="image1">
            <img src="/resource/img/couple1.jpg" alt="친구 1">
        </div>
        <div class="image2">
            <img src="/resource/img/couple2.jpg" alt="친구 2">
        </div>
        <div class="image3">
            <img src="/resource/img/couple3.jpg" alt="친구 3">
        </div>
    </div>
    <div class="text-box">
        <h1 class = text-box-1>
            전국 팔도 <span class="mein">미인</span>들<br>
            <span class="copi">코피</span>에 다 모였다!
        </h1>
        <a href="/usr/member/join">코피 회원가입하기</a>
    </div>
</section>





<section class="home-2">
    <div class="text-box">
        <h1 class="text-box-2">
             <span class="mein">실제 이용자</span>가 남긴 후기 
             <span class="mein">2000</span>개 이상!!
        </h1>
    </div>
    <div class="review-container" style="background-color: #f7d1d1; position: relative; left: 100px;">
        <!-- 첫 번째 5개의 리뷰 -->
        <div class="review-box active">
            <div class="review">“코피는 정말 편리하고, 빠르게 만날 수 있는 서비스입니다! 정말 좋아요!”</div>
            <div class="review">“매칭 시스템이 정말 좋고, 상대방도 적극적으로 대화를 나눠줘서 즐거웠어요.</div>
            <div class="review">“어떤 사람을 만날지 몰라서 기대되고 설렙니다.”</div>
            <div class="review">“회원가입이 쉬워서 금방 시작할 수 있었고, 빠르게 친구를 만났어요!”</div>
            <div class="review">“코피에서 만난 사람들과 진지한 대화를 나누고 있어서 뿌듯합니다.”</div>
        </div>
        <!-- 두 번째 5개의 리뷰 -->
        <div class="review-box">
            <div class="review">“소개팅 시스템이 마음에 들어요. 점점 더 좋은 사람을 만날 수 있을 것 같아요.”</div>
            <div class="review">“한 번도 실패한 적 없어요! 코피 덕분에 항상 좋은 만남이 이어집니다.”</div>
            <div class="review">“다양한 사람들이 있어서 매번 새로운 경험을 할 수 있어요.”</div>
            <div class="review">“매칭이 잘 되어가고 있어서 계속 사용하고 싶어요. 추천합니다!”</div>
            <div class="review">“코피에서 만난 사람과 정말 잘 맞아서 만남을 이어가고 있어요.”</div>
        </div>
        <!-- 세 번째 5개의 리뷰 -->
        <div class="review-box">
            <div class="review">“이용자가 많아서 정말 다양한 사람을 만날 수 있어요. 즐겁습니다!”</div>
            <div class="review">“인터페이스가 직관적이라 사용하기 편하고, 사람들도 친절해요.”</div>
            <div class="review">“데이트를 시작한 후 정말 많은 좋은 경험을 했습니다. 감사합니다, 코피!”</div>
            <div class="review">“서비스가 정말 만족스러워요. 적극 추천합니다!” </div>
            <div class="review">“매칭의 질이 너무 좋아서 계속해서 사용하고 있어요.”</div>
        </div>
        <!-- 네 번째 5개의 리뷰 -->
        <div class="review-box">
            <div class="review">“코피에서 만난 사람과 정말 잘 맞아서 행복한 시간을 보내고 있어요.”</div>
            <div class="review">“다양한 사람들과 소통할 수 있는 기회가 많아서 좋습니다.”</div>
            <div class="review">“앱이 정말 직관적이고 쉽게 사용할 수 있어서 만족스럽습니다.”  </div>
            <div class="review">“서비스가 매우 유용하고, 많은 사람들이 이용해서 신뢰감이 가요.”</div>
            <div class="review">“여기서 만난 사람들과 점점 친해져서 기분이 좋아요!</div>
        </div>
    </div>
</section>


<script>
let currentReviewSet = 0; // 현재 보이는 리뷰 세트

const showNextReviews = () => {
    const reviewBoxes = document.querySelectorAll('.review-box');
    reviewBoxes[currentReviewSet].classList.remove('active'); // 이전 리뷰 세트 숨기기
    currentReviewSet = (currentReviewSet + 1) % reviewBoxes.length; // 다음 리뷰 세트로 이동
    reviewBoxes[currentReviewSet].classList.add('active'); // 새로운 리뷰 세트 보이기
};
//5초마다 리뷰 세트를 변경
setInterval(showNextReviews, 5000);
</script>
<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>
