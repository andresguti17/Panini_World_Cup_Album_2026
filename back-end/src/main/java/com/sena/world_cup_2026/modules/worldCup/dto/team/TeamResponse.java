package com.sena.world_cup_2026.modules.worldCup.dto.team;

import com.sena.world_cup_2026.modules.worldCup.dto.country.CountryResponse;

import java.time.LocalDateTime;

public record TeamResponse(
        Integer id,
        CountryResponse country,
        String name,
        Character groupLetter,
        String coachName,
        boolean status,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {
}