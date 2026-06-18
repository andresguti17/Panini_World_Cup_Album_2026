package com.sena.world_cup_2026.modules.user.controller;

import com.sena.world_cup_2026.modules.user.dto.user.UserPatch;
import com.sena.world_cup_2026.modules.user.dto.user.UserRequest;
import com.sena.world_cup_2026.modules.user.dto.user.UserResponse;
import com.sena.world_cup_2026.modules.user.service.UserService;
import com.sena.world_cup_2026.shared.controller.AbstractController;
import com.sena.world_cup_2026.shared.service.CrudService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@AllArgsConstructor
@RestController
@RequestMapping("/api/users")
public class UserController
        extends AbstractController<UserRequest, UserResponse, UserPatch, Integer> {

    private final UserService service;

    @Override
    protected CrudService<UserRequest, UserResponse, UserPatch, Integer> getService() {
        return service;
    }
}
