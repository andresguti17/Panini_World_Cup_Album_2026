package com.sena.world_cup_2026.modules.catalog.controller;

import com.sena.world_cup_2026.modules.catalog.dto.sticker.StickerPatch;
import com.sena.world_cup_2026.modules.catalog.dto.sticker.StickerRequest;
import com.sena.world_cup_2026.modules.catalog.dto.sticker.StickerResponse;
import com.sena.world_cup_2026.modules.catalog.service.StickerService;
import com.sena.world_cup_2026.shared.controller.AbstractController;
import com.sena.world_cup_2026.shared.service.CrudService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@AllArgsConstructor
@RestController
@RequestMapping("/api/stickers")
public class StickerController
        extends AbstractController<StickerRequest, StickerResponse, StickerPatch, Integer> {

    private final StickerService service;

    @Override
    protected CrudService<StickerRequest, StickerResponse, StickerPatch, Integer> getService() {
        return service;
    }
}
