package com.sena.world_cup_2026.shared.controller;

import com.sena.world_cup_2026.shared.service.CrudService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

public abstract class AbstractController<Request, Response, Update, ID> {
    protected abstract CrudService<Request, Response, Update, ID> getService();

    @GetMapping
    public ResponseEntity<List<Response>> findAll() {
        return ResponseEntity.ok(getService().findAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Response> findById(@PathVariable ID id) {
        return ResponseEntity.ok(getService().findById(id));
    }

    @PostMapping
    public ResponseEntity<Response> save(@Valid @RequestBody Request request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(getService().save(request));
    }

    @PatchMapping("/{id}")
    public ResponseEntity<Response> partialUpdate(@PathVariable ID id, @RequestBody Update patch) {
        return ResponseEntity.ok(getService().partialUpdate(id, patch));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Response> update(@PathVariable ID id, @RequestBody Request update) {
        return ResponseEntity.ok(getService().update(id, update));
    }

    @PatchMapping("/{id}/disable")
    public ResponseEntity<Response> logicalDelete(@PathVariable ID id) {
        getService().logicalDeleteById(id);
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteById(@PathVariable ID id) {
        getService().deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
