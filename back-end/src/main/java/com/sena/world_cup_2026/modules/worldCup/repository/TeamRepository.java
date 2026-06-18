package com.sena.world_cup_2026.modules.worldCup.repository;

import com.sena.world_cup_2026.modules.worldCup.entity.Team;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TeamRepository extends JpaRepository<Team, Integer> {
}
