package com.sena.world_cup_2026.modules.worldCup.mapper;

import com.sena.world_cup_2026.modules.worldCup.dto.team.TeamRequest;
import com.sena.world_cup_2026.modules.worldCup.dto.team.TeamResponse;
import com.sena.world_cup_2026.modules.worldCup.dto.team.TeamUpdate;
import com.sena.world_cup_2026.modules.worldCup.entity.Team;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface TeamMapper {

    @Mapping(source = "countryId", target = "country.id")
    Team toEntity(TeamRequest request);

    TeamResponse toResponse(Team entity);

    void updateEntity(TeamUpdate update, @MappingTarget Team entity);
}
