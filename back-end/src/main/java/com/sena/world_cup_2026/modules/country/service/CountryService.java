package com.sena.world_cup_2026.modules.country.service;

import com.sena.world_cup_2026.modules.country.dto.CountryRequest;
import com.sena.world_cup_2026.modules.country.dto.CountryResponse;

import java.util.List;

public interface CountryService {

    CountryResponse findById(Integer id);

    List<CountryResponse> findAll();

    CountryResponse save(CountryRequest request);

    CountryResponse update(Integer id, CountryRequest request);

    void deleteById(Integer id);
}
