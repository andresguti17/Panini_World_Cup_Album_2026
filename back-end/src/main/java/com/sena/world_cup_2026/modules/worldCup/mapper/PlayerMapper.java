package com.sena.world_cup_2026.modules.worldCup.mapper;

import com.sena.world_cup_2026.modules.worldCup.dto.player.PlayerPatch;
import com.sena.world_cup_2026.modules.worldCup.dto.player.PlayerRequest;
import com.sena.world_cup_2026.modules.worldCup.dto.player.PlayerResponse;
import com.sena.world_cup_2026.modules.worldCup.entity.Player;
import org.mapstruct.*;

@Mapper(componentModel = "spring")
public interface PlayerMapper {

    @Mapping(source = "teamId", target = "team.id")
    Player toEntity(PlayerRequest request);

    PlayerResponse toResponse(Player entity);

    void updateEntity(PlayerRequest update, @MappingTarget Player entity);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    void partialUpdate(PlayerPatch patch, @MappingTarget Player entity);
}
