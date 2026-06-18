package com.sena.world_cup_2026.modules.catalog.mapper;

import com.sena.world_cup_2026.modules.catalog.dto.sticker.StickerPatch;
import com.sena.world_cup_2026.modules.catalog.dto.sticker.StickerRequest;
import com.sena.world_cup_2026.modules.catalog.dto.sticker.StickerResponse;
import com.sena.world_cup_2026.modules.catalog.entity.Sticker;
import org.mapstruct.*;

@Mapper(componentModel = "spring")
public interface StickerMapper {

    @Mapping(source = "categoryId", target = "stickerCategory.id")
    @Mapping(source = "playerId", target = "player.id")
    @Mapping(source = "teamId", target = "team.id")
    Sticker toEntity(StickerRequest request);

    StickerResponse toResponse(Sticker entity);

    void updateEntity(StickerRequest update, @MappingTarget Sticker entity);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    void partialUpdate(StickerPatch patch, @MappingTarget Sticker entity);
}
