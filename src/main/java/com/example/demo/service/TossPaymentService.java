package com.example.demo.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class TossPaymentService {
    private final String secretKey = "test_sk_oEjb0gm23PY9MXL026DkVpGwBJn5";

    public boolean verifyPayment(String orderId, String paymentKey, int amount) {
        String apiUrl = "https://api.tosspayments.com/v1/payments/confirm";
        HttpHeaders headers = new HttpHeaders();
        headers.setBasicAuth(secretKey, ""); // Basic Auth 사용
        headers.setContentType(MediaType.APPLICATION_JSON);

        Map<String, Object> body = new HashMap<>();
        body.put("paymentKey", paymentKey);
        body.put("orderId", orderId);
        body.put("amount", amount);

        HttpEntity<Map<String, Object>> request = new HttpEntity<>(body, headers);
        RestTemplate restTemplate = new RestTemplate();

        try {
            ResponseEntity<String> response = restTemplate.postForEntity(apiUrl, request, String.class);
            System.out.println("Response Status Code: " + response.getStatusCode());
            System.out.println("Response Body: " + response.getBody());
            return response.getStatusCode() == HttpStatus.OK;
        } catch (Exception e) {
        	System.out.println("Error during payment verification: " + e.getMessage());
            return false;
        }
    }
}