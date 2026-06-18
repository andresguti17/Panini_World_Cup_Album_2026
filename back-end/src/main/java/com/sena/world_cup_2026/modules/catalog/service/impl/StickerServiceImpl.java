package com.sena.world_cup_2026.modules.catalog.service.impl;

import com.sena.world_cup_2026.modules.catalog.dto.sticker.StickerPatch;
import com.sena.world_cup_2026.modules.catalog.dto.sticker.StickerRequest;
import com.sena.world_cup_2026.modules.catalog.dto.sticker.StickerResponse;
import com.sena.world_cup_2026.modules.catalog.entity.Sticker;
import com.sena.world_cup_2026.modules.catalog.mapper.StickerMapper;
import com.sena.world_cup_2026.modules.catalog.repository.StickerRepository;
import com.sena.world_cup_2026.modules.catalog.service.StickerService;
import com.sena.world_cup_2026.shared.service.BaseServiceImpl;
import org.springframework.stereotype.Service;

@Service
public class StickerServiceImpl
        extends BaseServiceImpl<Sticker, StickerRequest, StickerResponse, StickerPatch, Integer>
        implements StickerService {

    public StickerServiceImpl(StickerRepository repository, StickerMapper mapper) {
        super(
                repository,
                mapper::toResponse,
                mapper::toEntity,
                mapper::updateEntity,
                mapper::partialUpdate,
                Sticker::setStatus,
                id -> new RuntimeException("Sticker not found with id: " + id)
        );
    }
}
