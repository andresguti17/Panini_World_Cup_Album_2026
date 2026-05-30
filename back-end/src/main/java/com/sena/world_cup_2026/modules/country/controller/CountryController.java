package com.sena.world_cup_2026.modules.country.controller;

import com.sena.world_cup_2026.modules.country.dto.CountryRequest;
import com.sena.world_cup_2026.modules.country.dto.CountryResponse;
import com.sena.world_cup_2026.modules.country.service.CountryService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping("/api/countries")
public class CountryController {

    private final CountryService service;

    @GetMapping
    public ResponseEntity<List<CountryResponse>> findAll() {
        return ResponseEntity.ok(service.findAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<CountryResponse> findById(@PathVariable Integer id) {
        return ResponseEntity.ok(service.findById(id));
    }

    @PostMapping
    public ResponseEntity<CountryResponse> save( @RequestBody CountryRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(service.save(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<CountryResponse> update(@PathVariable Integer id, @RequestBody CountryRequest request) {
        return ResponseEntity.ok(service.update(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteById(@PathVariable Integer id) {
        service.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
