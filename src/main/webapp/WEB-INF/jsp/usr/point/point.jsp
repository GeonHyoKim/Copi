<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
 <!-- jQuery -->
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
 <!-- iamport.payment.js -->
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
  
  
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>포인트 충전</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <section class="container mx-auto p-4">
        <h2 class="text-3xl font-bold text-pink-600 mb-6">포인트 충전하기</h2>
        <form action="/usr/point/doPointCharge" method="post" class="bg-white p-6 rounded-lg shadow-md" target="_blank">
            <div class="mb-4">
                <label for="point" class="block text-lg font-medium text-gray-700 mb-2">충전할 금액</label>
                <!-- 금액 버튼 목록 -->
                <div class="grid grid-cols-4 gap-4">
                    <button type="button" class="bg-pink-500 hover:bg-pink-600 text-white font-bold px-4 py-2 rounded-lg"
                            onclick="addPoint(1000)">1,000원</button>
                    <button type="button" class="bg-pink-500 hover:bg-pink-600 text-white font-bold px-4 py-2 rounded-lg"
                            onclick="addPoint(2000)">2,000원</button>
                    <button type="button" class="bg-pink-500 hover:bg-pink-600 text-white font-bold px-4 py-2 rounded-lg"
                            onclick="addPoint(3000)">3,000원</button>
                    <button type="button" class="bg-pink-500 hover:bg-pink-600 text-white font-bold px-4 py-2 rounded-lg"
                            onclick="addPoint(5000)">5,000원</button>
                    <button type="button" class="bg-pink-500 hover:bg-pink-600 text-white font-bold px-4 py-2 rounded-lg"
                            onclick="addPoint(10000)">10,000원</button>
                    <button type="button" class="bg-pink-500 hover:bg-pink-600 text-white font-bold px-4 py-2 rounded-lg"
                            onclick="addPoint(30000)">30,000원</button>
                    <button type="button" class="bg-pink-500 hover:bg-pink-600 text-white font-bold px-4 py-2 rounded-lg"
                            onclick="addPoint(50000)">50,000원</button>
                    <button type="button" class="bg-pink-500 hover:bg-pink-600 text-white font-bold px-4 py-2 rounded-lg"
                            onclick="addPoint(100000)">100,000원</button>
                </div>
                
                <!-- 선택된 금액을 입력할 input 필드 -->
                <div class="mt-4">
                    <label for="inputPoint" class="block text-lg font-medium text-gray-700 mb-2">선택된 금액</label>
                    <input type="number" id="inputPoint" name="point" class="w-full border border-gray-300 rounded-lg px-4 py-2 text-gray-800 focus:ring-pink-500 focus:border-pink-500"
                           min="1000" required>
                </div>
            </div>
            
            <!-- 버튼들을 오른쪽으로 정렬 -->
            <div class="flex justify-between items-center mt-4">
                <button type="button" onclick="resetPoint()" class="bg-gray-500 hover:bg-gray-600 text-white font-bold px-6 py-3 rounded-lg shadow-md">
                    초기화
                </button>
                <button type="submit" class="bg-pink-600 hover:bg-pink-700 text-white font-bold px-6 py-3 rounded-lg shadow-md transition duration-300">
                    충전하기
                </button>
            </div>
        </form>
        
        <div class="mt-6">
            <button onclick="history.back()" class="bg-gray-500 hover:bg-gray-600 text-white px-6 py-3 rounded-lg shadow-md">
                뒤로가기
            </button>
        </div>
    </section>
    
    <script>
        // 현재 입력된 포인트 값을 가져오는 함수
        function getCurrentPoint() {
            var currentPoint = document.getElementById('inputPoint').value;
            return currentPoint ? parseInt(currentPoint) : 0;
        }

        // 금액을 더하는 함수
        function addPoint(amount) {
            var currentPoint = getCurrentPoint();
            var newPoint = currentPoint + amount;
            document.getElementById('inputPoint').value = newPoint;
        }

        // 금액을 초기화하는 함수
        function resetPoint() {
            document.getElementById('inputPoint').value = '';
        }
    </script>
</body>
</html>
