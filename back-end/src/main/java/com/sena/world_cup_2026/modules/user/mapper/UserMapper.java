package com.sena.world_cup_2026.modules.user.mapper;

import com.sena.world_cup_2026.modules.user.dto.user.UserPatch;
import com.sena.world_cup_2026.modules.user.dto.user.UserRequest;
import com.sena.world_cup_2026.modules.user.dto.user.UserResponse;
import com.sena.world_cup_2026.modules.user.entity.User;
import org.mapstruct.*;

@Mapper(componentModel = "spring")
public interface UserMapper {

    @Mapping(source = "teamId", target = "team.id")
    User toEntity(UserRequest request);

    UserResponse toResponse(User entity);

    void updateEntity(UserRequest update, @MappingTarget User entity);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    void partialUpdate(UserPatch patch, @MappingTarget User entity);
}
