package com.sena.world_cup_2026.modules.country.repository;

import com.sena.world_cup_2026.modules.country.dto.CountryRequest;
import com.sena.world_cup_2026.modules.country.dto.CountryResponse;
import com.sena.world_cup_2026.modules.country.entity.CountryEntity;
import com.sena.world_cup_2026.modules.country.mapper.CountryMapper;
import lombok.AllArgsConstructor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CountryRepository extends JpaRepository<CountryEntity, Integer> {
    /* Código cometnado
    private final JpaRepository<CountryEntity, Integer> jpaRepository;
    private final CountryMapper mapper;

    public CountryResponse save(CountryRequest request) {

        CountryEntity entity = mapper.toEntity(request);

        CountryEntity saved = jpaRepository.save(entity);

        return mapper.toResponse(saved);
    }

    public Optional<CountryResponse> findById(Integer id) {
        return jpaRepository.findById(id).map(mapper::toResponse);
    }

    public List<CountryResponse> findAll() {
        return mapper.toResponseList(jpaRepository.findAll());
    }
    */



    /*
    public List<CountryResponse> findAll() {
        return jpaRepository.findAll()
                .stream()
                .map(mapper::toResponse)
                .toList();
    }
    */


    /* Código comentado
    public CountryResponse update(Integer id, CountryRequest request) {
        CountryEntity entity = mapper.toEntity(request);
        entity.setId(id);

        CountryEntity updated = jpaRepository.save(entity);

        return mapper.toResponse(updated);
    }

    public void deleteById(Integer id) {
        jpaRepository.deleteById(id);
    }
    */



    /*
    public boolean existsByName(String name) {
        return jpaRepository.existsByName(name);
    }
    */
}
