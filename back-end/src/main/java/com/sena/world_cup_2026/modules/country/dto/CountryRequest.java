package com.sena.world_cup_2026.modules.country.dto;

public record CountryRequest(
        // Falta dependencia de Anotaciones.

        String name,
        String fifa_code,
        String flag_url
) {
}
