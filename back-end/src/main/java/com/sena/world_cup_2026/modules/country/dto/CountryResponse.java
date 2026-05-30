package com.sena.world_cup_2026.modules.country.dto;

public record CountryResponse(
    Integer id,
    String name,
    String fifa_code,
    String flag_url
) {
}
