package com.sena.world_cup_2026.modules.worldCup.service;

import com.sena.world_cup_2026.modules.worldCup.dto.country.CountryRequest;
import com.sena.world_cup_2026.modules.worldCup.dto.country.CountryResponse;
import com.sena.world_cup_2026.modules.worldCup.dto.country.CountryPatch;
import com.sena.world_cup_2026.shared.service.CrudService;

public interface CountryService
        extends CrudService<CountryRequest, CountryResponse, CountryPatch, Integer> {
}
