package com.sena.world_cup_2026.modules.catalog.dto.stickerCategory;

import jakarta.validation.constraints.Size;

public record StickerCategoryPatch(
        @Size(max = 100, message = "El nombre no puede superar los 100 caracteres")
        String name,

        @Size(max = 500, message = "La descripción no puede superar los 500 caracteres")
        String description
) {
}
