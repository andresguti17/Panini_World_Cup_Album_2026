package com.sena.world_cup_2026.modules.worldCup.dto.country;

import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public record CountryPatch(
        @Size(min = 2, max = 100, message = "El nombre debe tener entre 2 y 100 caracteres")
        String name,

        @Size(min = 2, max = 3, message = "El código FIFA debe tener entre 2 y 3 caracteres")
        @Pattern(regexp = "^[A-Z]+$", message = "El código FIFA debe contener solo letras mayúsculas")
        String fifaCode,

        @Size(min = 2, max = 3, message = "El código de la bandera no está en el límite")
        String flagUrl
) {
}
