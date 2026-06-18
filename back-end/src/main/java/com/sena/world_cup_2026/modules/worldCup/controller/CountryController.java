package com.sena.world_cup_2026.modules.worldCup.controller;

import com.sena.world_cup_2026.modules.worldCup.dto.country.CountryPatch;
import com.sena.world_cup_2026.modules.worldCup.dto.country.CountryRequest;
import com.sena.world_cup_2026.modules.worldCup.dto.country.CountryResponse;
import com.sena.world_cup_2026.modules.worldCup.service.CountryService;
import com.sena.world_cup_2026.shared.controller.AbstractController;
import com.sena.world_cup_2026.shared.service.CrudService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@AllArgsConstructor
@RestController
@RequestMapping("/api/countries")
public class CountryController
        extends AbstractController<CountryRequest, CountryResponse, CountryPatch, Integer> {

    private final CountryService service;

    @Override
    protected CrudService<CountryRequest, CountryResponse, CountryPatch, Integer> getService() {
        return service;
    }
}
