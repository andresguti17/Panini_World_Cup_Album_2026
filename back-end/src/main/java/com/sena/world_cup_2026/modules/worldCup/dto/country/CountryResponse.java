package com.sena.world_cup_2026.modules.worldCup.dto.country;

import java.time.LocalDateTime;

public record CountryResponse(
    Integer id,
    String name,
    String fifaCode,
    String flagUrl,
    boolean status,
    LocalDateTime createdAt,
    LocalDateTime updatedAt
) {
}
