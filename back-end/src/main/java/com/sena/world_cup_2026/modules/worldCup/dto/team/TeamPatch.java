package com.sena.world_cup_2026.modules.worldCup.dto.team;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public record TeamPatch(
        Integer countryId,

        @Size(min = 2, max = 100, message = "El nombre debe tener entre 2 y 100 caracteres")
        String name,

        @Size(min = 1, max = 1, message = "La letra del grupo debe ser un único carácter")
        @Pattern(regexp = "^[A-H]$", message = "La letra del grupo debe ser entre A y H")
        Character groupLetter,

        @Size(max = 100, message = "El nombre del entrenador no debe exceder 100 caracteres")
        String coachName
) {
}
