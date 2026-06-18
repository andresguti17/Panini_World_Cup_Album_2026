package com.sena.world_cup_2026.modules.user.dto.user;

import jakarta.validation.constraints.*;

public record UserRequest(
        @NotBlank(message = "El username es obligatorio")
        @Size(min = 3, max = 50, message = "El username debe tener entre 3 y 50 caracteres")
        String username,

        @NotBlank(message = "El email es obligatorio")
        @Email(message = "El email no tiene un formato válido")
        @Size(max = 100, message = "El email no puede superar los 100 caracteres")
        String email,

        @NotBlank(message = "La contraseña es obligatoria")
        @Size(min = 8, max = 255, message = "La contraseña debe tener entre 8 y 255 caracteres")
        String password,

        @Positive(message = "El ID del país debe ser un número positivo")
        Integer countryId,

        @NotNull(message = "Las monedas no pueden ser nulas")
        @Min(value = 0, message = "Las monedas no pueden ser negativas")
        Integer coins
) {
}
