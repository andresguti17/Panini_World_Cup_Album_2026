package com.sena.world_cup_2026.modules.catalog.dto.sticker;

import com.sena.world_cup_2026.modules.catalog.dto.stickerCategory.StickerCategoryResponse;
import com.sena.world_cup_2026.modules.worldCup.dto.player.PlayerResponse;
import com.sena.world_cup_2026.modules.worldCup.dto.team.TeamResponse;

import java.time.LocalDateTime;

public record StickerResponse(
        Integer id,
        String code,
        String name,
        String stickerType,
        String rarity,
        StickerCategoryResponse category,
        PlayerResponse player,
        TeamResponse team,
        String imageUrl,
        int marketValueCoins,
        boolean status,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {
}
