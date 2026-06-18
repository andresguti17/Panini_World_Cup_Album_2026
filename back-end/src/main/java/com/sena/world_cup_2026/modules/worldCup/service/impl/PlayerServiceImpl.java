package com.sena.world_cup_2026.modules.worldCup.service.impl;

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
public class PlayerServiceImpl
        extends BaseServiceImpl<Player, PlayerRequest, PlayerResponse, PlayerPatch, Integer>
        implements PlayerService {

    public PlayerServiceImpl(PlayerRepository repository, PlayerMapper mapper) {
        super(
                repository,
                mapper::toResponse,
                mapper::toEntity,
                mapper::updateEntity,
                mapper::partialUpdate,
                Player::setStatus,
                id -> new RuntimeException("Player not found with id: " + id)
        );
    }
}
