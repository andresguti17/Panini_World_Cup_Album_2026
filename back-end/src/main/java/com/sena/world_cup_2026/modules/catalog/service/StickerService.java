package com.sena.world_cup_2026.modules.catalog.service;

import com.sena.world_cup_2026.modules.catalog.dto.sticker.StickerPatch;
import com.sena.world_cup_2026.modules.catalog.dto.sticker.StickerRequest;
import com.sena.world_cup_2026.modules.catalog.dto.sticker.StickerResponse;
import com.sena.world_cup_2026.shared.service.CrudService;

public interface StickerService
        extends CrudService<StickerRequest, StickerResponse, StickerPatch, Integer> {
}
