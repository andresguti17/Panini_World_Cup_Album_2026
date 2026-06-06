package com.sena.world_cup_2026.modules.worldCup.service.impl;

import com.sena.world_cup_2026.modules.worldCup.dto.country.CountryRequest;
import com.sena.world_cup_2026.modules.worldCup.dto.country.CountryResponse;
import com.sena.world_cup_2026.modules.worldCup.dto.country.CountryUpdate;
import com.sena.world_cup_2026.modules.worldCup.entity.Country;
import com.sena.world_cup_2026.modules.worldCup.mapper.CountryMapper;
import com.sena.world_cup_2026.modules.worldCup.repository.CountryRepository;
import com.sena.world_cup_2026.modules.worldCup.service.CountryService;
import com.sena.world_cup_2026.shared.service.BaseServiceImpl;
import org.springframework.stereotype.Service;

@Service
public class CountryServiceImpl
        extends BaseServiceImpl<Country, CountryRequest, CountryResponse, CountryUpdate, Integer>
        implements CountryService {

    public CountryServiceImpl(CountryRepository repository, CountryMapper mapper) {
        super(
                repository,
                mapper::toResponse,
                mapper::toEntity,
                mapper::updateEntity,
                id -> new RuntimeException("Country not found with id: " + id)
        );
    }
}
