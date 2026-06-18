package com.sena.world_cup_2026.modules.country.service;

import com.sena.world_cup_2026.modules.country.dto.StickerCategoryDTO;
import com.sena.world_cup_2026.modules.country.entity.StickerCategory;
import com.sena.world_cup_2026.modules.country.repository.StickerCategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class StickerCategoryService {

    @Autowired
    private StickerCategoryRepository repository;

    // Mapeo privado: Entidad → ResponseDTO
    private StickerCategoryDTO.Response toResponse(StickerCategory entity) {
        return new StickerCategoryDTO.Response(
                entity.getId(),
                entity.getName(),
                entity.getDescription()
        );
    }

    // GET - listar todas
    public List<StickerCategoryDTO.Response> findAll() {
        return repository.findAll()
                .stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    // GET - buscar por ID
    public StickerCategoryDTO.Response findById(Integer id) {
        StickerCategory entity = repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Categoría no encontrada con id: " + id));
        return toResponse(entity);
    }

    // POST - crear
    public StickerCategoryDTO.Response create(StickerCategoryDTO.Request dto) {
        StickerCategory entity = new StickerCategory();
        entity.setName(dto.getName());
        entity.setDescription(dto.getDescription());
        return toResponse(repository.save(entity));
    }

    // PUT - actualizar
    public StickerCategoryDTO.Response update(Integer id, StickerCategoryDTO.Request dto) {
        StickerCategory entity = repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Categoría no encontrada con id: " + id));
        entity.setName(dto.getName());
        entity.setDescription(dto.getDescription());
        return toResponse(repository.save(entity));
    }

    // DELETE - eliminar
    public void delete(Integer id) {
        if (!repository.existsById(id)) {
            throw new RuntimeException("Categoría no encontrada con id: " + id);
        }
        repository.deleteById(id);
    }
}
