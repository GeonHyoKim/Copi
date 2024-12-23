<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="ha">
<head>
  <meta charset="utf-8" />
  <title>결제하기</title>
  <!-- 토스페이먼츠 결제창 SDK 추가 -->
  <script src="https://js.tosspayments.com/v1/payment"></script>
</head>
<body>
  <script>
    var clientKey = 'test_ck_EP59LybZ8BKvwNzyLRkW36GYo7pR'
    var tossPayments = TossPayments(clientKey)

    tossPayments.requestPayment('카드', { 
      amount: ${point},
      orderId: '${orderId}',
      orderName: '포인트 충전',
      customerName: '${customerName}',
      successUrl: 'http://localhost:8080/usr/point/paymentSuccess',
      failUrl: 'http://localhost:8080/usr/point/paymentFail',
    })
    .catch(function (error) {
      if (error.code === 'USER_CANCEL') {
          alert("결제가 취소되었습니다.");
          window.location.href = '/usr/member/myPage';
      } else if (error.code === 'INVALID_CARD_COMPANY') {
          alert("결제에 실패했습니다: " + error.message);
          window.location.href = '/usr/member/myPage';
      }
    });
  </script>
</body>
</html>