package com.ApplicationBuilder.web;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.OffsetDateTime;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*") // simple dev convenience; tighten for production
public class InfoController {

    private final JdbcTemplate jdbcTemplate;
    private final String appName;

    public InfoController(JdbcTemplate jdbcTemplate,
                          @Value("${spring.application.name:application}") String appName) {
        this.jdbcTemplate = jdbcTemplate;
        this.appName = appName;
    }

    @GetMapping("/info")
    public InfoResponse info() {
        String dbTime;
        try {
            // Works on PostgreSQL; fallback if DB not reachable
            dbTime = jdbcTemplate.queryForObject("SELECT now()::text", String.class);
        } catch (Exception ex) {
            dbTime = "unavailable (" + ex.getClass().getSimpleName() + ")";
        }
        return new InfoResponse("Hello World", appName, dbTime);
    }
}
