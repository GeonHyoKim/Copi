<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<html lang="ko">
<head>
<meta charset="UTF-8">
<title>주변 친구 찾기</title>
</head>
<body>
	<h1>주변 친구 찾기</h1>
<style>
/* 동그라미 마커 스타일 */
.marker {
	width: 50px;
	height: 50px;
	background-color: transparent;
	border-radius: 50%; /* 동그라미 모양 */
	overflow: hidden;
	position: relative;
	border: 2px solid; /* 테두리 색상은 나중에 설정 */
}

.marker img {
	width: 100%;
	height: 100%;
	object-fit: cover; /* 이미지를 마커 안에 맞게 자르기 */
}
/* 지도 요소를 화면 중앙에 배치 */
#map {
	width: 1500px;
	height: 650px;
	margin: 0 auto; /* 수평 가운데 정렬 */
	display: block; /* 블록 요소로 처리 */
}
</style>

	<div id="map"></div>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=893e98e2b5e6b7a1f3f211e9af4eb5d4&libraries=services"></script>

	<script>
      // 서버에서 전달된 members 데이터를 JavaScript 배열로 변환
      const members = [
        <c:forEach var="member" items="${members}">
          {
            "id": "${member.id}",
            "name": "${member.name}",
            "sex": "${member.sex}",
            "age": "${member.age}",
            "areaId": "${member.areaId}",
            "picUrl": "/usr/pic/getImage?pic=${member.pic.pic}"  // pic 객체의 pic 필드를 URL로 사용
          }<c:if test="${!empty member.id}">,</c:if>
        </c:forEach>
      ];

      function initializeMap() {
    	    var container = document.getElementById('map');
    	    var options = {
    	        center: new kakao.maps.LatLng(36.35, 127.38), // 지도 초기 중심 (대전)
    	        level: 7 // 확대 레벨
    	    };

    	    var map = new kakao.maps.Map(container, options);
    	    var geocoder = new kakao.maps.services.Geocoder();

    	    // members 리스트를 순회하며 마커 생성
    	    members.forEach(member => {
    	        const areaId = member.areaId;
    	        const sex = member.sex;
				const age = member.age;
    	        geocoder.addressSearch(areaId, function(result, status) {
    	            if (status === kakao.maps.services.Status.OK) {
    	                result.forEach(r => {
    	                    var coords = new kakao.maps.LatLng(r.y, r.x);
    	                    let borderColor = sex === '여성' ? '#FF69B4' : '#87CEEB';

    	                    // 커스텀 마커 생성
    	                    var markerElement = document.createElement('div');
    	                    markerElement.className = 'marker';
    	                    markerElement.style.borderColor = borderColor;

    	                    var imgElement = document.createElement('img');
    	                    imgElement.src = member.picUrl || '/images/default.png';
    	                    markerElement.appendChild(imgElement);

    	                    var customOverlay = new kakao.maps.CustomOverlay({
    	                        position: coords,
    	                        content: markerElement,
    	                        xAnchor: 0.5,
    	                        yAnchor: 1.1
    	                    });
    	                    customOverlay.setMap(map);

    	                    // 정보 표시용 CustomOverlay 생성
    	                    var infoOverlay = new kakao.maps.CustomOverlay({
    	                        position: coords,
    	                        content: `<div style="background-color:white; border:1px solid black; padding:5px; border-radius:5px;">
    	                                    \${member.name} (\${member.age}세)
    	                                  </div>`,
    	                        xAnchor: 0.5,
    	                        yAnchor: 1.5,
    	                        zIndex: 2
    	                    });

    	                    // 마우스 이벤트
    	                    markerElement.addEventListener('mouseover', function() {
    	                        infoOverlay.setMap(map); // 정보창 표시
    	                    });

    	                    markerElement.addEventListener('mouseout', function() {
    	                        infoOverlay.setMap(null); // 정보창 숨기기
    	                    });

    	                    // 마커 클릭 이벤트
    	                    markerElement.addEventListener('click', function() {
    	                        window.location.href = `/usr/member/detail?id=\${member.id}`;
    	                    });
    	                });
    	            } else {
    	                console.error(`주소 검색 실패: ${areaId}`);
    	            }
    	        });
    	    });
    	}

      // 지도 초기화
      document.addEventListener("DOMContentLoaded", initializeMap);
    </script>
</body>
</html>
