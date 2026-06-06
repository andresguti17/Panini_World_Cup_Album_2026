package com.sena.world_cup_2026.modules.worldCup.dto.team;

import java.time.LocalDateTime;

public record TeamResponse(
        Integer id,
        Integer country_id,
        String name,
        String group_letter,
        String coach_name,
        boolean status,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {
}