package com.sena.world_cup_2026.modules.worldCup.repository;

import com.sena.world_cup_2026.modules.worldCup.entity.Player;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PlayerRepository extends JpaRepository<Player, Integer> {
}
