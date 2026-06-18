package com.sena.world_cup_2026.modules.worldCup.mapper;

import com.sena.world_cup_2026.modules.worldCup.dto.country.CountryPatch;
import com.sena.world_cup_2026.modules.worldCup.dto.country.CountryRequest;
import com.sena.world_cup_2026.modules.worldCup.dto.country.CountryResponse;
import com.sena.world_cup_2026.modules.worldCup.entity.Country;
import org.mapstruct.*;

@Mapper(componentModel = "spring")
public interface CountryMapper {

    Country toEntity(CountryRequest request);

    CountryResponse toResponse(Country entity);

    void updateEntity(CountryRequest update, @MappingTarget Country entity);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    void partialUpdate(CountryPatch patch, @MappingTarget Country entity);
}
