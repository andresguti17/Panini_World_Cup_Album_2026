package com.sena.world_cup_2026.modules.user.dto.user;

public record UserPatch(
        String username,
        String email,
        String password,
        Integer countryId,
        Integer coins
) {
}
