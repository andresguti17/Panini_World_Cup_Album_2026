package com.sena.world_cup_2026.modules.worldCup.controller;

import com.sena.world_cup_2026.modules.worldCup.dto.player.PlayerPatch;
import com.sena.world_cup_2026.modules.worldCup.dto.player.PlayerRequest;
import com.sena.world_cup_2026.modules.worldCup.dto.player.PlayerResponse;
import com.sena.world_cup_2026.modules.worldCup.service.PlayerService;
import com.sena.world_cup_2026.shared.controller.AbstractController;
import com.sena.world_cup_2026.shared.service.CrudService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@AllArgsConstructor
@RestController
@RequestMapping("/api/players")
public class PlayerController
        extends AbstractController<PlayerRequest, PlayerResponse, PlayerPatch, Integer> {

    private final PlayerService service;

    @Override
    protected CrudService<PlayerRequest, PlayerResponse, PlayerPatch, Integer> getService() {
        return service;
    }
}
