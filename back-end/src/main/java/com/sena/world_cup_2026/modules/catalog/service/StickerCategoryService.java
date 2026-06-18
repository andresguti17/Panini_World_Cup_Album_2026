package com.sena.world_cup_2026.modules.catalog.service;

import com.sena.world_cup_2026.modules.catalog.dto.stickerCategory.StickerCategoryPatch;
import com.sena.world_cup_2026.modules.catalog.dto.stickerCategory.StickerCategoryRequest;
import com.sena.world_cup_2026.modules.catalog.dto.stickerCategory.StickerCategoryResponse;
import com.sena.world_cup_2026.shared.service.CrudService;

public interface StickerCategoryService
        extends CrudService<StickerCategoryRequest, StickerCategoryResponse, StickerCategoryPatch, Integer> {
}
