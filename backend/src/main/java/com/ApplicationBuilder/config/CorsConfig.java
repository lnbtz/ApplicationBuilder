package com.ApplicationBuilder.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

@Configuration
public class CorsConfig {
    
    @Value("${application.cors.allowed-origins:*}")
    private String allowedOrigins;
    
    @Bean
    public CorsFilter corsFilter() {
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        CorsConfiguration config = new CorsConfiguration();
        
        // Parse comma-separated origins if provided
        String[] origins = allowedOrigins.split(",");
        for (String origin : origins) {
            if (!origin.trim().isEmpty()) {
                config.addAllowedOrigin(origin.trim());
            }
        }
        
        // Allow standard HTTP methods and headers
        config.addAllowedMethod("*");
        config.addAllowedHeader("*");
        config.setAllowCredentials(true);
        
        source.registerCorsConfiguration("/api/**", config);
        return new CorsFilter(source);
    }
}
