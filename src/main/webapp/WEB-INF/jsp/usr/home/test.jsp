<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:set var="pageTitle" value="테스트" />


<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Geolocation API 사용 예시</title>
</head>
<body>
	<h1>Geolocation API로 현재 위치 가져오기</h1>
	<button onclick="getLocation()">위치 찾기</button>
	<p id="status">위치를 찾지 못했습니다</p>
	<p id="address"></p>
	<div id="map" style="width: 500px; height: 400px;"></div>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=893e98e2b5e6b7a1f3f211e9af4eb5d4&libraries=services"></script>

	<script>
    function getLocation() {
      const status = document.getElementById("status");
      const addressElement = document.getElementById("address");
      // Geolocation API 지원 여부 확인
      if ("geolocation" in navigator) {
        navigator.geolocation.getCurrentPosition(
          (position) => {
            const { latitude, longitude, accuracy } = position.coords;
            status.textContent = `위도: \${latitude}, 경도: \${longitude}, 정확도: \${accuracy}미터`;
            
//             var container = document.getElementById('map');
//             var options = {
//               center: new kakao.maps.LatLng(latitude, longitude),
//               level: 3
//             };

//             var map = new kakao.maps.Map(container, options);
//             var markerPosition  = new kakao.maps.LatLng(latitude, longitude); 
//             var marker = new kakao.maps.Marker({
//               position: markerPosition
//             });

//             // 지도에 마커 추가
//             marker.setMap(map);	
            
            var geocoder = new kakao.maps.services.Geocoder();
            geocoder.coord2Address(longitude, latitude, function(result, status) {
            	if (status === kakao.maps.services.Status.OK) {                // 주소를 결과에서 찾기
            		var address = result[0].address.address_name;
            		var addressParts = address.split(' ');
            		var simplifiedAddress = addressParts[0] + " " + addressParts[1];
            	    addressElement.textContent = `주소: \${simplifiedAddress}`;
            } else {
                addressElement.textContent = "주소를 찾을 수 없습니다.";
              }
            });
          },
          (error) => {
            status.textContent = `위치 정보를 가져올 수 없습니다: ${error.message}`;
          },
          {
            enableHighAccuracy: true, // 정확도 우선 모드
            timeout: 10000,           // 10초 이내에 응답 없으면 에러 발생
            maximumAge: 0             // 항상 최신 위치 정보 수집
          }
        );
      } else {
        status.textContent = "브라우저가 위치 서비스를 지원하지 않습니다.";
      }
    }
  </script>
</body>
</html>