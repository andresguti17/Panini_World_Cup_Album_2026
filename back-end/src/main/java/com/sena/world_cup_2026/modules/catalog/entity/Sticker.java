package com.sena.world_cup_2026.modules.catalog.entity;

import com.sena.world_cup_2026.modules.user.entity.User;
import com.sena.world_cup_2026.modules.worldCup.entity.Team;
import com.sena.world_cup_2026.shared.entity.BaseEntity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "stickers")
@Entity
public class Sticker extends BaseEntity {
    @Column(name = "code")
    private String code;

    @Column(name = "name")
    private String name;

    @Column(name = "sticker_type")
    private String stickerType; //ENUM

    @Column(name = "rarity")
    private String stickerRarity; //ENUM

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "category_id")
    private StickerCategory stickerCategory;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "player_id")
    private User player;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "team_id")
    private Team team;

    @Column(name = "image_url")
    private String imageUrl;

    @Column(name = "market_value_coins")
    private int marketValueCoins;
}
