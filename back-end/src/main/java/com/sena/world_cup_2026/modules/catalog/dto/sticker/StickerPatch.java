package com.sena.world_cup_2026.modules.catalog.dto.sticker;

import com.sena.world_cup_2026.modules.catalog.validator.ValidStickerType;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.Size;

@ValidStickerType
public record StickerPatch(
        @Size(max = 20, message = "El código no puede superar los 20 caracteres")
        @Pattern(
                regexp = "^[A-Z0-9\\-]+$",
                message = "El código solo puede contener letras mayúsculas, números y guiones"
        )
        String code,

        @Size(max = 100, message = "El nombre no puede superar los 100 caracteres")
        String name,

        @Pattern(
                regexp = "^(player|team|badge|special)$",
                message = "stickerType debe ser: player, team, badge o special"
        )
        String stickerType,

        @Pattern(
                regexp = "^(common|rare|epic|legendary)$",
                message = "rarity debe ser: common, rare, epic o legendary"
        )
        String rarity,

        @Positive(message = "El ID de categoría debe ser positivo")
        Integer categoryId,

        @Positive(message = "El ID de jugador debe ser positivo")
        Integer playerId,

        @Positive(message = "El ID de equipo debe ser positivo")
        Integer teamId,

        @Size(max = 255, message = "La URL de imagen no puede superar los 255 caracteres")
        @Pattern(
                regexp = "^(https?://.*)?$",
                message = "La URL de imagen debe comenzar con http:// o https://"
        )
        String imageUrl,

        @Min(value = 0, message = "El valor de mercado no puede ser negativo")
        int marketValueCoins
) {
}
