package com.sena.world_cup_2026.modules.catalog.dto.stickerCategory;

import java.time.LocalDateTime;

public record StickerCategoryResponse(
        Integer id,
        String name,
        String description,
        boolean status,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {
}
