package com.sena.world_cup_2026.modules.user.dto.user;

import com.sena.world_cup_2026.modules.worldCup.dto.country.CountryResponse;

import java.time.LocalDateTime;

public record UserResponse(
        String username,
        String email,
        String passwordHash,
        CountryResponse country,
        int coins,
        boolean status,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {
}
