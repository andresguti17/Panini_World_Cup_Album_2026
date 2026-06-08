package com.sena.world_cup_2026.modules.worldCup.dto.player;

import jakarta.validation.constraints.*;

import java.time.LocalDate;

public record PlayerPatch(
        @Positive(message = "Team ID must be a positive number")
        Integer teamId,

        @Size(max = 50, message = "First name must be at most 50 characters")
        String firstName,

        @Size(max = 50, message = "Last name must be at most 50 characters")
        String lastName,

        @Min(value = 1, message = "Jersey number must be at least 1")
        @Max(value = 99, message = "Jersey number must be at most 99")
        Integer jerseyNumber,

        @Size(max = 30, message = "Position must be at most 30 characters")
        String position,

        @Past(message = "Birth date must be in the past")
        LocalDate birthDate,

        Boolean status
) {
}
