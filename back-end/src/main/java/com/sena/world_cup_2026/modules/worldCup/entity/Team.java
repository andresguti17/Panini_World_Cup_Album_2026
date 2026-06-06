package com.sena.world_cup_2026.modules.worldCup.entity;

import com.sena.world_cup_2026.shared.entity.BaseEntity;
import jakarta.persistence.*;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "teams")
@Entity
public class Team extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "country_id", nullable = false)
    private Country country;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "group_letter")
    private Character groupLetter;

    @Column(name = "coach_name")
    @Size(max = 100, message = "Coach name must be at most 100 characters")
    private String coachName;
}
