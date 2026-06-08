package com.sena.world_cup_2026.modules.worldCup.service;

import com.sena.world_cup_2026.modules.worldCup.dto.team.TeamRequest;
import com.sena.world_cup_2026.modules.worldCup.dto.team.TeamResponse;
import com.sena.world_cup_2026.modules.worldCup.dto.team.TeamPatch;
import com.sena.world_cup_2026.shared.service.CrudService;

public interface TeamService
        extends CrudService<TeamRequest, TeamResponse, TeamPatch, Integer> {
}
