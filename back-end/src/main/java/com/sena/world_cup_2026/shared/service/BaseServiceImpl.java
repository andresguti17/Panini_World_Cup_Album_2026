package com.sena.world_cup_2026.shared.service;

import lombok.AllArgsConstructor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.function.BiConsumer;
import java.util.function.Function;

@AllArgsConstructor
public abstract class BaseServiceImpl<Entity, Request, Response, Update, ID>
        implements CrudService<Request, Response, Update, ID> {

    // Implementación del JpaRepository
    private final JpaRepository<Entity, ID> repository;

    // Creación de métodos de mapeo
    private final Function<Entity, Response> toResponse;
    private final Function<Request, Entity> toEntity;
    private final BiConsumer<Request, Entity> updateEntity;
    private final BiConsumer<Update, Entity> partialUpdate;

    // Creación de método de definir estado
    private final BiConsumer<Entity, Boolean> setStatus;

    private final Function<ID, RuntimeException> notFound;

    @Override
    @Transactional
    public Response findById(ID id) {
        return toResponse.apply(
                repository.findById(id).orElseThrow(() -> notFound.apply(id))
        );
    }

    @Override
    @Transactional
    public List<Response> findAll() {
        return repository.findAll().stream().map(toResponse::apply).toList();
    }

    @Override
    @Transactional
    public Response save(Request request) {
        return toResponse.apply(repository.save(toEntity.apply(request)));
    }

    @Override
    @Transactional
    public Response partialUpdate(ID id, Update patch) {
        Entity existing = repository.findById(id).orElseThrow(() -> notFound.apply(id));
        partialUpdate.accept(patch, existing);
        Entity saved = repository.save(existing);
        return toResponse.apply(saved);
    }

    @Override
    @Transactional
    public Response update(ID id, Request request) {
        Entity existing = repository.findById(id).orElseThrow(() -> notFound.apply(id));
        updateEntity.accept(request, existing);
        return toResponse.apply(repository.save(existing));
    }

    @Override
    @Transactional
    public void logicalDeleteById(ID id) {
        Entity existing = repository.findById(id).orElseThrow(() -> notFound.apply(id));
        setStatus.accept(existing, false);
    }

    @Override
    @Transactional
    public void deleteById(ID id) {
        repository.deleteById(id);
    }
}
