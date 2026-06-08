package com.sena.world_cup_2026.modules.worldCup.dto.player;

import com.sena.world_cup_2026.modules.worldCup.dto.team.TeamResponse;

import java.time.LocalDate;
import java.time.LocalDateTime;

public record PlayerResponse(
        Integer id,
        TeamResponse team,
        String firstName,
        String lastName,
        Integer jerseyNumber,
        String position,
        LocalDate birthDate,
        boolean status,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {
}
