package com.sena.world_cup_2026.shared.service;

import java.util.List;

public interface CrudService<Request, Response, Update, ID> {
    List<Response> findAll();
    Response findById(ID id);
    Response save(Request request);
    Response update(ID id, Update request);
    // void logicalDeleteById(ID id);
    void deleteById(ID id);
}
