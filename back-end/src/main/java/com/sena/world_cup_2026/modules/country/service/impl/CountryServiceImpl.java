package com.sena.world_cup_2026.modules.country.service.impl;

import com.sena.world_cup_2026.modules.country.dto.CountryRequest;
import com.sena.world_cup_2026.modules.country.dto.CountryResponse;
import com.sena.world_cup_2026.modules.country.entity.CountryEntity;
import com.sena.world_cup_2026.modules.country.mapper.CountryMapper;
import com.sena.world_cup_2026.modules.country.repository.CountryRepository;
import com.sena.world_cup_2026.modules.country.service.CountryService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@AllArgsConstructor
@Service
public class CountryServiceImpl implements CountryService {

    private final CountryRepository repository;
    private final CountryMapper mapper;

    @Override
    public CountryResponse findById(Integer id) {
        CountryEntity entity = repository.findById(id)
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
        CountryEntity entity = mapper.toEntity(request);
        CountryEntity saved = repository.save(entity);
        return mapper.toResponse(saved);
    }

    @Override
    public CountryResponse update(Integer id, CountryRequest request) {
        CountryEntity entity = mapper.toEntity(request);
        CountryEntity saved = repository.save(entity);
        return mapper.toResponse(saved);
    }

    @Override
    public void deleteById(Integer id) {
        repository.deleteById(id);
    }
}
