package com.sena.world_cup_2026.modules.worldCup.mapper;

import com.sena.world_cup_2026.modules.worldCup.dto.country.CountryRequest;
import com.sena.world_cup_2026.modules.worldCup.dto.country.CountryResponse;
import com.sena.world_cup_2026.modules.worldCup.dto.country.CountryUpdate;
import com.sena.world_cup_2026.modules.worldCup.entity.Country;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface CountryMapper {

    Country toEntity(CountryRequest request);

    CountryResponse toResponse(Country entity);

    void updateEntity(CountryUpdate update, @MappingTarget Country entity);
}
