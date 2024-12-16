<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html lang="ko">
<head>
<meta charset="UTF-8">
<title>여러 마커 표시</title>
</head>
<body>
    <h1>Kakao Maps - 여러 마커 표시</h1>
    <style>
        /* 동그라미 마커 스타일 */
        .marker {
            width: 50px;
            height: 50px;
            background-color: transparent;
            border-radius: 50%;  /* 동그라미 모양 */
            overflow: hidden;
            position: relative;
            border: 2px solid;  /* 테두리 색상은 나중에 설정 */
        }

        .marker img {
            width: 100%;
            height: 100%;
            object-fit: cover;  /* 이미지를 마커 안에 맞게 자르기 */
        }
    </style>
    
    <div id="map" style="width: 800px; height: 600px;"></div>

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

          geocoder.addressSearch(areaId, function(result, status) {
            if (status === kakao.maps.services.Status.OK) {
              // 여러 개의 결과가 있을 경우 모두 처리
              result.forEach(r => {
                var coords = new kakao.maps.LatLng(r.y, r.x);
                let borderColor = sex === '여성' ? '#FF69B4' : '#87CEEB';  // 성별에 따라 테두리 색 변경

                // CustomOverlay를 위한 HTML 요소 생성
                var markerElement = document.createElement('div');
                markerElement.className = 'marker';
                markerElement.style.borderColor = borderColor;  // 테두리 색상 적용

                var imgElement = document.createElement('img');
                imgElement.src = member.picUrl || '/images/default.png';  // 이미지 URL
                markerElement.appendChild(imgElement);

                // CustomOverlay로 마커 표시
                var customOverlay = new kakao.maps.CustomOverlay({
                  position: coords,
                  content: markerElement
                });

                customOverlay.setMap(map);

                // 마커 클릭 이벤트: 해당 회원의 상세 페이지로 이동
                markerElement.addEventListener('click', function() {
                  window.location.href = `/usr/member/detail?id=\${member.id}`;
                });

                // 정보창 콘텐츠 설정
                var infoContent = `<div style="padding:5px;">\${member.name} (\${member.areaId})</div>`;
                var infowindow = new kakao.maps.InfoWindow({
                  content: infoContent
                });

                // 마우스 오버 이벤트: 정보 창 열기
                markerElement.addEventListener('mouseover', function() {
                  infowindow.open(map, coords);  // coords를 기준으로 InfoWindow 열기
                });

                // 마우스 아웃 이벤트: 정보 창 닫기
                markerElement.addEventListener('mouseout', function() {
                  infowindow.close();
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
