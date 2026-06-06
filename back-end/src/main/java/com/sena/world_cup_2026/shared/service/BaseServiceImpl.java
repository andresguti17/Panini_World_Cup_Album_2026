package com.sena.world_cup_2026.shared.service;

import lombok.AllArgsConstructor;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.function.BiConsumer;
import java.util.function.Function;

@AllArgsConstructor
public abstract class BaseServiceImpl<Entity, Request, Response, Update, ID>
        implements CrudService<Request, Response, Update, ID> {

    private final JpaRepository<Entity, ID> repository;
    private final Function<Entity, Response> toResponse;
    private final Function<Request, Entity> toEntity;
    private final BiConsumer<Update, Entity> updateEntity;
    private final Function<ID, RuntimeException> notFound;

    @Override
    public Response findById(ID id) {
        return toResponse.apply(
                repository.findById(id).orElseThrow(() -> notFound.apply(id))
        );
    }

    @Override
    public List<Response> findAll() {
        return repository.findAll().stream().map(toResponse::apply).toList();
    }

    @Override
    public Response save(Request request) {
        return toResponse.apply(repository.save(toEntity.apply(request)));
    }

    @Override
    public Response update(ID id, Update request) {
        Entity existing = repository.findById(id).orElseThrow(() -> notFound.apply(id));
        updateEntity.accept(request, existing);
        return toResponse.apply(repository.save(existing));
    }

    @Override
    public void deleteById(ID id) {
        repository.deleteById(id);
    }
}
