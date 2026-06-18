package com.sena.world_cup_2026.modules.catalog.controller;

import com.sena.world_cup_2026.modules.catalog.dto.stickerCategory.StickerCategoryPatch;
import com.sena.world_cup_2026.modules.catalog.dto.stickerCategory.StickerCategoryRequest;
import com.sena.world_cup_2026.modules.catalog.dto.stickerCategory.StickerCategoryResponse;
import com.sena.world_cup_2026.modules.catalog.service.StickerCategoryService;
import com.sena.world_cup_2026.shared.controller.AbstractController;
import com.sena.world_cup_2026.shared.service.CrudService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@AllArgsConstructor
@RestController
@RequestMapping("/api/sticker_categories")
public class StickerCategoryController
        extends AbstractController<StickerCategoryRequest, StickerCategoryResponse, StickerCategoryPatch, Integer> {

    private final StickerCategoryService service;

    @Override
    protected CrudService<StickerCategoryRequest, StickerCategoryResponse, StickerCategoryPatch, Integer> getService() {
        return service;
    }
}
