package com.sena.world_cup_2026.modules.catalog.repository;

import com.sena.world_cup_2026.modules.catalog.entity.Sticker;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StickerRepository extends JpaRepository<Sticker, Integer> {
}
