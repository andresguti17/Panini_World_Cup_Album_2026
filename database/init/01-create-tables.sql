-- ============================================================
--  Sticker Album 2026 – PostgreSQL DDL  v2
--  Mejoras aplicadas:
--    #2  Eliminado is_duplicate (derivado de quantity > 1)
--    #3  missing_stickers convertida a VIEW
--    #4  trade_stickers con columna trade_side (offering/requesting)
--    #5  users.coins con CHECK >= 0
--    #6  stickers con CHECK por tipo (player_id / team_id)
--    #10 UNIQUE en users.email y users.username
--    #11 UNIQUE en stickers.code
--    #12 updated_at en tablas clave
--    #13 deleted_at (soft delete) en users, stickers, trades
-- ============================================================


-- ── 1. ENUMS ─────────────────────────────────────────────────

CREATE TYPE sticker_type AS ENUM (
    'player',
    'team',
    'badge',
    'collectible'
);

CREATE TYPE sticker_rarity AS ENUM (
    'common',
    'rare',
    'epic',
    'legendary'
);

CREATE TYPE trade_status AS ENUM (
    'pending',
    'accepted',
    'rejected',
    'cancelled'
);

CREATE TYPE purchase_status AS ENUM (
    'pending',
    'completed',
    'failed'
);

-- #4 – lado del trade: quién ofrece y quién pide
CREATE TYPE trade_side AS ENUM (
    'offering',
    'requesting'
);


-- ── 2. TABLAS INDEPENDIENTES ──────────────────────────────────

CREATE TABLE countries (
    id        SERIAL       PRIMARY KEY,
    name      VARCHAR(100) NOT NULL,
    fifa_code VARCHAR(10),
    flag_url  VARCHAR(255)
);

CREATE TABLE sticker_categories (
    id          SERIAL      PRIMARY KEY,
    name        VARCHAR(50),
    description TEXT
);

CREATE TABLE sticker_packs (
    id               SERIAL        PRIMARY KEY,
    name             VARCHAR(50),
    -- precio en coins (sin decimales tiene sentido, pero se mantiene por compatibilidad)
    price_coins      INT           NOT NULL CHECK (price_coins > 0),
    sticker_quantity INT           DEFAULT 7 CHECK (sticker_quantity > 0),
    release_date     DATE
);

CREATE TABLE achievements (
    id           SERIAL       PRIMARY KEY,
    title        VARCHAR(100),
    description  TEXT,
    reward_coins INT          CHECK (reward_coins >= 0)
);


-- ── 3. TABLAS CON FK A INDEPENDIENTES ─────────────────────────

CREATE TABLE users (
    id            SERIAL       PRIMARY KEY,
    username      VARCHAR(50)  NOT NULL,
    email         VARCHAR(100) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    country_id    INT,
    -- #5: coins nunca puede ser negativo
    coins         INT          NOT NULL DEFAULT 0 CHECK (coins >= 0),
    created_at    TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP    NOT NULL DEFAULT NOW(),   -- #12
    -- #13: soft delete
    deleted_at    TIMESTAMP,

    -- #10: unicidad en credenciales
    CONSTRAINT uq_users_email    UNIQUE (email),
    CONSTRAINT uq_users_username UNIQUE (username),

    CONSTRAINT fk_countries_id_users
        FOREIGN KEY (country_id) REFERENCES countries (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE teams (
    id           SERIAL       PRIMARY KEY,
    country_id   INT,
    name         VARCHAR(100) NOT NULL,
    group_letter CHAR(1),
    coach_name   VARCHAR(100),

    CONSTRAINT fk_countries_id_teams
        FOREIGN KEY (country_id) REFERENCES countries (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);


-- ── 4. TABLAS CON FK A users / teams ──────────────────────────

CREATE TABLE albums (
    id                    SERIAL        PRIMARY KEY,
    user_id               INT,
    completion_percentage DECIMAL(5, 2) DEFAULT 0.00
                              CHECK (completion_percentage BETWEEN 0 AND 100),
    completed_at          TIMESTAMP,
    created_at            TIMESTAMP     NOT NULL DEFAULT NOW(),
    updated_at            TIMESTAMP     NOT NULL DEFAULT NOW(),  -- #12

    CONSTRAINT fk_users_id_albums
        FOREIGN KEY (user_id) REFERENCES users (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE players (
    id            SERIAL      PRIMARY KEY,
    team_id       INT,
    first_name    VARCHAR(50),
    last_name     VARCHAR(50),
    jersey_number INT,
    position      VARCHAR(30),
    birth_date    DATE,

    CONSTRAINT fk_teams_id_players
        FOREIGN KEY (team_id) REFERENCES teams (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);


-- ── 5. STICKERS ───────────────────────────────────────────────

CREATE TABLE stickers (
    id           SERIAL         PRIMARY KEY,
    -- #11: el código de figurita debe ser único (ej: "ARG-10", "BADGE-01")
    code         VARCHAR(20)    NOT NULL,
    name         VARCHAR(100)   NOT NULL,
    sticker_type sticker_type   NOT NULL,
    rarity       sticker_rarity NOT NULL,
    category_id  INT,
    player_id    INT,
    team_id      INT,
    image_url    VARCHAR(255),
    market_value_coins INT      CHECK (market_value_coins >= 0),
    created_at   TIMESTAMP      NOT NULL DEFAULT NOW(),
    -- #13: soft delete de figuritas descontinuadas
    deleted_at   TIMESTAMP,

    CONSTRAINT uq_stickers_code UNIQUE (code),  -- #11

    -- #6: si es tipo 'player', debe tener player_id
    CONSTRAINT chk_sticker_player
        CHECK (sticker_type <> 'player' OR player_id IS NOT NULL),

    -- #6: si es tipo 'team', debe tener team_id
    CONSTRAINT chk_sticker_team
        CHECK (sticker_type <> 'team' OR team_id IS NOT NULL),

    CONSTRAINT fk_sticker_categories_id_stickers
        FOREIGN KEY (category_id) REFERENCES sticker_categories (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,

    CONSTRAINT fk_players_id_stickers
        FOREIGN KEY (player_id) REFERENCES players (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,

    CONSTRAINT fk_teams_id_stickers
        FOREIGN KEY (team_id) REFERENCES teams (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);


-- ── 6. PACK OPENINGS ──────────────────────────────────────────

CREATE TABLE pack_openings (
    id        SERIAL    PRIMARY KEY,
    user_id   INT,
    pack_id   INT,
    opened_at TIMESTAMP NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_users_id_pack_openings
        FOREIGN KEY (user_id) REFERENCES users (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,

    CONSTRAINT fk_sticker_packs_id_pack_openings
        FOREIGN KEY (pack_id) REFERENCES sticker_packs (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE pack_opening_stickers (
    id              SERIAL PRIMARY KEY,
    pack_opening_id INT,
    sticker_id      INT,

    CONSTRAINT fk_pack_openings_id_pack_opening_stickers
        FOREIGN KEY (pack_opening_id) REFERENCES pack_openings (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,

    CONSTRAINT fk_stickers_id_pack_opening_stickers
        FOREIGN KEY (sticker_id) REFERENCES stickers (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);


-- ── 7. ALBUM STICKERS ─────────────────────────────────────────
--  #2: se elimina is_duplicate — se deriva con: quantity > 1

CREATE TABLE album_stickers (
    id          SERIAL    PRIMARY KEY,
    album_id    INT,
    sticker_id  INT,
    -- quantity >= 1 siempre; duplicado = quantity > 1
    quantity    INT       NOT NULL DEFAULT 1 CHECK (quantity >= 1),
    obtained_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP NOT NULL DEFAULT NOW(),  -- #12

    CONSTRAINT uq_album_stickers UNIQUE (album_id, sticker_id),

    CONSTRAINT fk_albums_id_album_stickers
        FOREIGN KEY (album_id) REFERENCES albums (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,

    CONSTRAINT fk_stickers_id_album_stickers
        FOREIGN KEY (sticker_id) REFERENCES stickers (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);


-- ── 8. MISSING STICKERS (VIEW) ────────────────────────────────
--  #3: ya no es una tabla — se deriva comparando stickers vs album_stickers
--  Muestra todas las figuritas que un álbum aún no tiene (quantity = 0)

CREATE VIEW missing_stickers AS
SELECT
    a.id   AS album_id,
    s.id   AS sticker_id,
    s.code AS sticker_code,
    s.name AS sticker_name,
    s.rarity,
    s.sticker_type
FROM albums a
CROSS JOIN stickers s
WHERE s.deleted_at IS NULL
  AND NOT EXISTS (
      SELECT 1
      FROM album_stickers als
      WHERE als.album_id  = a.id
        AND als.sticker_id = s.id
  );


-- ── 9. TRADES ─────────────────────────────────────────────────

CREATE TABLE trades (
    id               SERIAL       PRIMARY KEY,
    sender_user_id   INT,
    receiver_user_id INT,
    trade_status     trade_status NOT NULL DEFAULT 'pending',
    created_at       TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at       TIMESTAMP    NOT NULL DEFAULT NOW(),  -- #12
    completed_at     TIMESTAMP,
    -- #13: soft delete para trades cancelados/expirados
    deleted_at       TIMESTAMP,

    -- un usuario no puede hacer trade consigo mismo
    CONSTRAINT chk_trades_different_users
        CHECK (sender_user_id <> receiver_user_id),

    CONSTRAINT fk_users_id_trades_sender
        FOREIGN KEY (sender_user_id) REFERENCES users (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,

    CONSTRAINT fk_users_id_trades_receiver
        FOREIGN KEY (receiver_user_id) REFERENCES users (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- #4: trade_side indica si la figurita es "ofrecida" o "pedida" por ese usuario
CREATE TABLE trade_stickers (
    id                 SERIAL     PRIMARY KEY,
    trade_id           INT,
    sticker_id         INT,
    offered_by_user_id INT,
    -- 'offering' = lo que ese usuario pone en la mesa
    -- 'requesting' = lo que ese usuario quiere recibir
    trade_side         trade_side NOT NULL,
    quantity           INT        NOT NULL DEFAULT 1 CHECK (quantity >= 1),

    CONSTRAINT fk_trades_id_trade_stickers
        FOREIGN KEY (trade_id) REFERENCES trades (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,

    CONSTRAINT fk_stickers_id_trade_stickers
        FOREIGN KEY (sticker_id) REFERENCES stickers (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,

    CONSTRAINT fk_users_id_trade_stickers
        FOREIGN KEY (offered_by_user_id) REFERENCES users (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);


-- ── 10. PURCHASES (en coins) ──────────────────────────────────

CREATE TABLE purchases (
    id              SERIAL          PRIMARY KEY,
    user_id         INT,
    -- total en coins, nunca negativo
    total_coins     INT             NOT NULL CHECK (total_coins > 0),
    purchase_status purchase_status NOT NULL DEFAULT 'pending',
    purchased_at    TIMESTAMP       NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMP       NOT NULL DEFAULT NOW(),  -- #12

    CONSTRAINT fk_users_id_purchases
        FOREIGN KEY (user_id) REFERENCES users (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE purchase_items (
    id          SERIAL PRIMARY KEY,
    purchase_id INT,
    pack_id     INT,
    quantity    INT    NOT NULL DEFAULT 1 CHECK (quantity >= 1),
    subtotal_coins INT NOT NULL CHECK (subtotal_coins >= 0),

    CONSTRAINT fk_purchases_id_purchase_items
        FOREIGN KEY (purchase_id) REFERENCES purchases (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,

    CONSTRAINT fk_sticker_packs_id_purchase_items
        FOREIGN KEY (pack_id) REFERENCES sticker_packs (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);


-- ── 11. USER ACHIEVEMENTS ─────────────────────────────────────

CREATE TABLE user_achievements (
    id             SERIAL    PRIMARY KEY,
    user_id        INT,
    achievement_id INT,
    unlocked_at    TIMESTAMP NOT NULL DEFAULT NOW(),

    CONSTRAINT uq_user_achievements UNIQUE (user_id, achievement_id),

    CONSTRAINT fk_users_id_user_achievements
        FOREIGN KEY (user_id) REFERENCES users (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,

    CONSTRAINT fk_achievements_id_user_achievements
        FOREIGN KEY (achievement_id) REFERENCES achievements (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);


-- ── 12. TRIGGER: auto-actualizar updated_at ───────────────────
--  Se aplica a todas las tablas que tienen updated_at

CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_albums_updated_at
    BEFORE UPDATE ON albums
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_album_stickers_updated_at
    BEFORE UPDATE ON album_stickers
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_trades_updated_at
    BEFORE UPDATE ON trades
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_purchases_updated_at
    BEFORE UPDATE ON purchases
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ============================================================
--  FIN DEL SCRIPT v2
-- ============================================================