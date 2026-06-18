package com.sena.world_cup_2026.modules.catalog.validator;

import com.sena.world_cup_2026.modules.catalog.dto.sticker.StickerRequest;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class ValidStickerTypeConstraintValidator
        implements ConstraintValidator<ValidStickerType, StickerRequest> {

    @Override
    public boolean isValid(StickerRequest request, ConstraintValidatorContext ctx) {
        if (request.stickerType() == null) return true; // @NotNull lo captura primero

        return switch (request.stickerType()) {
            case "player" -> request.playerId() != null && request.teamId() == null;
            case "team"   -> request.teamId()   != null && request.playerId() == null;
            default       -> request.playerId() == null && request.teamId() == null;
        };
    }
}