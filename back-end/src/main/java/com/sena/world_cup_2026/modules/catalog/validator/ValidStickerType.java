package com.sena.world_cup_2026.modules.catalog.validator;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.*;

@Documented
@Constraint(validatedBy = ValidStickerTypeConstraintValidator.class)
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
public @interface ValidStickerType {
    String message() default "Relación inválida entre stickerType, playerId y teamId";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}