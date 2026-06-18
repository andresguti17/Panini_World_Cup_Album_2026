package com.sena.world_cup_2026.modules.country.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

// Lo que el cliente ENVÍA (POST / PUT)
public class StickerCategoryDTO {

    // Request (entrada)
    public static class Request {
        @NotBlank(message = "El nombre es obligatorio")
        @Size(max = 50, message = "El nombre no puede superar 50 caracteres")
        private String name;

        private String description; // opcional, puede ser null

        public String getName() { return name; }
        public void setName(String name) { this.name = name; }

        public String getDescription() { return description; }
        public void setDescription(String description) { this.description = description; }
    }

    // Response (lo que devolvemos al cliente)
    public static class Response {
        private Integer id;
        private String name;
        private String description;

        public Response(Integer id, String name, String description) {
            this.id = id;
            this.name = name;
            this.description = description;
        }

        public Integer getId() { return id; }
        public String getName() { return name; }
        public String getDescription() { return description; }
    }
}
