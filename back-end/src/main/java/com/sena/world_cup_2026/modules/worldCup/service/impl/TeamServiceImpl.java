package com.sena.world_cup_2026.modules.worldCup.service.impl;

import com.sena.world_cup_2026.modules.worldCup.dto.team.TeamRequest;
import com.sena.world_cup_2026.modules.worldCup.dto.team.TeamResponse;
import com.sena.world_cup_2026.modules.worldCup.dto.team.TeamPatch;
import com.sena.world_cup_2026.modules.worldCup.entity.Team;
import com.sena.world_cup_2026.modules.worldCup.mapper.TeamMapper;
import com.sena.world_cup_2026.modules.worldCup.repository.TeamRepository;
import com.sena.world_cup_2026.modules.worldCup.service.TeamService;
import com.sena.world_cup_2026.shared.service.BaseServiceImpl;
import org.springframework.stereotype.Service;

@Service
public class TeamServiceImpl
        extends BaseServiceImpl<Team, TeamRequest, TeamResponse, TeamPatch, Integer>
        implements TeamService {

    public TeamServiceImpl(TeamRepository repository, TeamMapper mapper) {
        super(
                repository,
                mapper::toResponse,
                mapper::toEntity,
                mapper::updateEntity,
                mapper::partialUpdate,
                Team::setStatus,
                id -> new RuntimeException("Country not found with id: " + id)
        );
    }
}
