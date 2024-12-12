package com.example.demo.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

public class GeoLocationExample {
    public static void main(String[] args) {
        try {
            // Naver API URL과 파라미터 설정
            String url = "https://openapi.naver.com/v1/map/reversegeocode?query=";
            double latitude = 37.5665;  // 예시: 서울의 위도
            double longitude = 126.9780; // 예시: 서울의 경도
            
            // URL에 위도, 경도 추가
            String query = URLEncoder.encode(longitude + "," + latitude, "UTF-8");
            URL obj = new URL(url + query);
            
            // HTTP 연결 설정
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("X-Naver-Client-Id", "your-client-id"); // 발급받은 Client ID
            con.setRequestProperty("X-Naver-Client-Secret", "your-client-secret"); // 발급받은 Client Secret
            
            // 응답 받기
            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();
            
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();
            
            // 응답 출력 (JSON 형태로 반환됨)
            System.out.println(response.toString());
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

