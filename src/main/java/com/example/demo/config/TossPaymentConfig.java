package com.example.demo.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

import lombok.Getter;

@Getter
@Configuration
public class TossPaymentConfig {
  
	@Value("${payment.toss.test_client_api_key")
	private String testClientApiKey;
	
	@Value("${payment.toss.success_url")
	private String successUrl;
	
	@Value("${payment.toss.fail.url")
	private String failUrl;
	
	public static final String URL = "https://api.tosspayments.com/v1/payments/";
}
