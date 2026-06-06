package com.sena.world_cup_2026.modules.worldCup.controller;

import com.sena.world_cup_2026.modules.worldCup.dto.team.TeamRequest;
import com.sena.world_cup_2026.modules.worldCup.dto.team.TeamResponse;
import com.sena.world_cup_2026.modules.worldCup.dto.team.TeamUpdate;
import com.sena.world_cup_2026.modules.worldCup.service.TeamService;
import com.sena.world_cup_2026.shared.controller.AbstractController;
import com.sena.world_cup_2026.shared.service.CrudService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@AllArgsConstructor
@RestController
@RequestMapping("/api/teams")
public class TeamController
        extends AbstractController<TeamRequest, TeamResponse, TeamUpdate, Integer> {

    private final TeamService service;

    @Override
    protected CrudService<TeamRequest, TeamResponse, TeamUpdate, Integer> getService() {
        return service;
    }
}
