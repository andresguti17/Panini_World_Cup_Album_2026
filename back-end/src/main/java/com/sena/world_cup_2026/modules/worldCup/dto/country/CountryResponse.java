package com.sena.world_cup_2026.modules.worldCup.dto.country;

import java.time.LocalDateTime;

public record CountryResponse(
    Integer id,
    String name,
    String fifa_code,
    String flag_url,
    boolean status,
    LocalDateTime createdAt,
    LocalDateTime updatedAt
) {
}
