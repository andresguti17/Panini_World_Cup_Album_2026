package com.sena.world_cup_2026.shared.service;

import java.util.List;

public interface CrudService<Request, Response, Update, ID> {
    List<Response> findAll();
    Response findById(ID id);
    Response save(Request request);
    Response partialUpdate(ID id, Update request);
    Response update(ID id, Request request);
    void logicalDeleteById(ID id);
    void deleteById(ID id);
}
