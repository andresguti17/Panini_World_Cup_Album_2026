package com.sena.world_cup_2026.modules.user.repository;

import com.sena.world_cup_2026.modules.user.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
}
