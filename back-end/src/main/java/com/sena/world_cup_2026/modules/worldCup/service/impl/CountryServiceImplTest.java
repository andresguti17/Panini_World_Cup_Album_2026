package com.sena.world_cup_2026.modules.worldCup.service.impl;

import com.sena.world_cup_2026.modules.worldCup.dto.country.CountryRequest;
import com.sena.world_cup_2026.modules.worldCup.dto.country.CountryResponse;
import com.sena.world_cup_2026.modules.worldCup.dto.country.CountryUpdate;
import com.sena.world_cup_2026.modules.worldCup.entity.Country;
import com.sena.world_cup_2026.modules.worldCup.mapper.CountryMapper;
import com.sena.world_cup_2026.modules.worldCup.repository.CountryRepository;
import com.sena.world_cup_2026.modules.worldCup.service.CountryService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@AllArgsConstructor
public class CountryServiceImplTest implements CountryService {
    private final CountryRepository repository;
    private final CountryMapper mapper;

    @Override
    public CountryResponse findById(Integer id) {
        Country entity = repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Country not found with id: " + id));
        return mapper.toResponse(entity);
    }

    @Override
    public List<CountryResponse> findAll() {
        return repository.findAll()
                .stream()
                .map(mapper::toResponse)
                .toList();
    }

    @Override
    public CountryResponse save(CountryRequest request) {
        Country entity = mapper.toEntity(request);
        Country saved = repository.save(entity);
        return mapper.toResponse(saved);
    }

    @Override
    public CountryResponse update(Integer id, CountryUpdate request) {
        Country existing = repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Country not found with id: " + id));
        mapper.updateEntity(request, existing);
        Country updated = repository.save(existing);
        return mapper.toResponse(updated);
    }

    @Override
    public void deleteById(Integer id) {
        repository.deleteById(id);
    }
}
