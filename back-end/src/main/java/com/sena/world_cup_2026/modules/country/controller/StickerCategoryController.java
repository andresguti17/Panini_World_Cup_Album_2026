package com.sena.world_cup_2026.modules.country.controller;

import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.sena.world_cup_2026.modules.country.dto.StickerCategoryDTO;
import com.sena.world_cup_2026.modules.country.service.StickerCategoryService;

import java.util.List;

@RestController
@RequestMapping("/api/sticker-categories")
public class StickerCategoryController {

    @Autowired
    private StickerCategoryService service;

    // GET /api/sticker-categories
    @GetMapping
    public ResponseEntity<List<StickerCategoryDTO.Response>> getAll() {
        return ResponseEntity.ok(service.findAll());
    }

    // GET /api/sticker-categories/1
    @GetMapping("/{id}")
    public ResponseEntity<StickerCategoryDTO.Response> getById(@PathVariable Integer id) {
        return ResponseEntity.ok(service.findById(id));
    }

    // POST /api/sticker-categories
    @PostMapping
    public ResponseEntity<StickerCategoryDTO.Response> create(
            @Valid @RequestBody StickerCategoryDTO.Request dto) {
        return ResponseEntity.status(201).body(service.create(dto));
    }

    // PUT /api/sticker-categories/1
    @PutMapping("/{id}")
    public ResponseEntity<StickerCategoryDTO.Response> update(
            @PathVariable Integer id,
            @Valid @RequestBody StickerCategoryDTO.Request dto) {
        return ResponseEntity.ok(service.update(id, dto));
    }

    // DELETE /api/sticker-categories/1
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Integer id) {
        service.delete(id);
        return ResponseEntity.noContent().build(); // 204
    }
}
