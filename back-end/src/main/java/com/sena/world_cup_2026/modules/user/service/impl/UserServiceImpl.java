package com.sena.world_cup_2026.modules.user.service.impl;

import com.sena.world_cup_2026.modules.user.dto.user.UserPatch;
import com.sena.world_cup_2026.modules.user.dto.user.UserRequest;
import com.sena.world_cup_2026.modules.user.dto.user.UserResponse;
import com.sena.world_cup_2026.modules.user.entity.User;
import com.sena.world_cup_2026.modules.user.mapper.UserMapper;
import com.sena.world_cup_2026.modules.user.repository.UserRepository;
import com.sena.world_cup_2026.modules.user.service.UserService;
import com.sena.world_cup_2026.modules.worldCup.dto.player.PlayerPatch;
import com.sena.world_cup_2026.modules.worldCup.dto.player.PlayerRequest;
import com.sena.world_cup_2026.modules.worldCup.dto.player.PlayerResponse;
import com.sena.world_cup_2026.modules.worldCup.entity.Player;
import com.sena.world_cup_2026.modules.worldCup.mapper.PlayerMapper;
import com.sena.world_cup_2026.modules.worldCup.repository.PlayerRepository;
import com.sena.world_cup_2026.modules.worldCup.service.PlayerService;
import com.sena.world_cup_2026.shared.service.BaseServiceImpl;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl
        extends BaseServiceImpl<User, UserRequest, UserResponse, UserPatch, Integer>
        implements UserService {

    public UserServiceImpl(UserRepository repository, UserMapper mapper) {
        super(
                repository,
                mapper::toResponse,
                mapper::toEntity,
                mapper::updateEntity,
                mapper::partialUpdate,
                User::setStatus,
                id -> new RuntimeException("User not found with id: " + id)
        );
    }
}
