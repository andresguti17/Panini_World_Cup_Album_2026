package com.sena.world_cup_2026.modules.catalog.entity;

import com.sena.world_cup_2026.shared.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "sticker_categories")
@Entity
public class StickerCategory extends BaseEntity {
    @Column(name = "name")
    private String name;

    @Column(name = "description")
    private String description;
}
