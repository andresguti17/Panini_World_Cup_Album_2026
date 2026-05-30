package com.sena.world_cup_2026.modules.country.mapper;

import com.sena.world_cup_2026.modules.country.dto.CountryRequest;
import com.sena.world_cup_2026.modules.country.dto.CountryResponse;
import com.sena.world_cup_2026.modules.country.entity.CountryEntity;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface CountryMapper {

    CountryEntity toEntity(CountryRequest request);

    CountryResponse toResponse(CountryEntity entity);

    List<CountryResponse> toResponseList(List<CountryEntity> entities);
}
