package com.sena.world_cup_2026.modules.worldCup.service;

import com.sena.world_cup_2026.modules.worldCup.dto.player.PlayerPatch;
import com.sena.world_cup_2026.modules.worldCup.dto.player.PlayerRequest;
import com.sena.world_cup_2026.modules.worldCup.dto.player.PlayerResponse;
import com.sena.world_cup_2026.shared.service.CrudService;

public interface PlayerService
        extends CrudService<PlayerRequest, PlayerResponse, PlayerPatch, Integer> {
}
