package com.sena.world_cup_2026.modules.catalog.service.impl;

import com.sena.world_cup_2026.modules.catalog.dto.stickerCategory.StickerCategoryPatch;
import com.sena.world_cup_2026.modules.catalog.dto.stickerCategory.StickerCategoryRequest;
import com.sena.world_cup_2026.modules.catalog.dto.stickerCategory.StickerCategoryResponse;
import com.sena.world_cup_2026.modules.catalog.entity.StickerCategory;
import com.sena.world_cup_2026.modules.catalog.mapper.StickerCategoryMapper;
import com.sena.world_cup_2026.modules.catalog.repository.StickerCategoryRepository;
import com.sena.world_cup_2026.modules.catalog.service.StickerCategoryService;
import com.sena.world_cup_2026.shared.service.BaseServiceImpl;
import org.springframework.stereotype.Service;

@Service
public class StickerCategoryServiceImpl
        extends BaseServiceImpl<StickerCategory, StickerCategoryRequest, StickerCategoryResponse, StickerCategoryPatch, Integer>
        implements StickerCategoryService {

    public StickerCategoryServiceImpl(StickerCategoryRepository repository, StickerCategoryMapper mapper) {
        super(
                repository,
                mapper::toResponse,
                mapper::toEntity,
                mapper::updateEntity,
                mapper::partialUpdate,
                StickerCategory::setStatus,
                id -> new RuntimeException("StickerCategory not found with id: " + id)
        );
    }
}
