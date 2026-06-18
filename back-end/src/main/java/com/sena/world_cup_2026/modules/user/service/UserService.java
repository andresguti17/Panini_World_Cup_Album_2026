package com.sena.world_cup_2026.modules.user.service;

import com.sena.world_cup_2026.modules.user.dto.user.UserPatch;
import com.sena.world_cup_2026.modules.user.dto.user.UserRequest;
import com.sena.world_cup_2026.modules.user.dto.user.UserResponse;
import com.sena.world_cup_2026.shared.service.CrudService;

public interface UserService
        extends CrudService<UserRequest, UserResponse, UserPatch, Integer> {
}
