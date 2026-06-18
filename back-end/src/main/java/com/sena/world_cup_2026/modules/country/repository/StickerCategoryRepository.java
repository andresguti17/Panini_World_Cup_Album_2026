package com.sena.world_cup_2026.modules.country.repository;

import com.sena.world_cup_2026.modules.country.entity.StickerCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StickerCategoryRepository extends JpaRepository<StickerCategory, Integer> {
    // JpaRepository ya te da: findAll, findById, save, deleteById, etc.
    // No necesitas escribir nada más por ahora
}
