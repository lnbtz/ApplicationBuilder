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
        
        // If allowedOrigins is "*", we need to use setAllowedOriginPatterns instead of setAllowedOrigins
        // to support credentials with wildcard origins
        if ("*".equals(allowedOrigins.trim())) {
            config.addAllowedOriginPattern("*");
        } else {
            // Parse comma-separated origins if provided
            String[] origins = allowedOrigins.split(",");
            for (String origin : origins) {
                if (!origin.trim().isEmpty()) {
                    config.addAllowedOrigin(origin.trim());
                }
            }
        }
        
        // Explicitly add localhost origin for local development
        config.addAllowedOrigin("http://localhost:5173");
        
        // Allow standard HTTP methods and headers
        config.addAllowedMethod("*");
        config.addAllowedHeader("*");
        config.setAllowCredentials(true);
        
        source.registerCorsConfiguration("/api/**", config);
        return new CorsFilter(source);
    }
}
