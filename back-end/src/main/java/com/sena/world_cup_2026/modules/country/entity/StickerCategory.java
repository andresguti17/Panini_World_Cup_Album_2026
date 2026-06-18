package com.sena.world_cup_2026.modules.country.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "sticker_categories")
public class StickerCategory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // autoincrement
    private Integer id;

    @Column(nullable = false, length = 50)
    private String name;

    @Column(columnDefinition = "TEXT")
    private String description;
}