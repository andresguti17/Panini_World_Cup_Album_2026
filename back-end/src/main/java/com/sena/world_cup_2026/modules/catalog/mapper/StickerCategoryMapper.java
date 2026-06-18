package com.sena.world_cup_2026.modules.catalog.mapper;

import com.sena.world_cup_2026.modules.catalog.dto.stickerCategory.StickerCategoryPatch;
import com.sena.world_cup_2026.modules.catalog.dto.stickerCategory.StickerCategoryRequest;
import com.sena.world_cup_2026.modules.catalog.dto.stickerCategory.StickerCategoryResponse;
import com.sena.world_cup_2026.modules.catalog.entity.StickerCategory;
import org.mapstruct.BeanMapping;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;
import org.mapstruct.NullValuePropertyMappingStrategy;

@Mapper(componentModel = "spring")
public interface StickerCategoryMapper {

    StickerCategory toEntity(StickerCategoryRequest request);

    StickerCategoryResponse toResponse(StickerCategory entity);

    void updateEntity(StickerCategoryRequest update, @MappingTarget StickerCategory entity);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    void partialUpdate(StickerCategoryPatch patch, @MappingTarget StickerCategory entity);
}
