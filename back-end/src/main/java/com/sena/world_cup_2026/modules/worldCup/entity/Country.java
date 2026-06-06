package com.sena.world_cup_2026.modules.worldCup.entity;

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
@Table(name = "countries")
@Entity
public class Country extends BaseEntity {

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "fifa_code", nullable = false, unique = true)
    private String fifa_code;

    @Column(name = "flag_url", nullable = false)
    private String flag_url;
}
