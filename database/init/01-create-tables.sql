-- ============================================================
--  Sticker Album 2026 – SQL Server DDL  v2
--  Migrado desde PostgreSQL
--  Cambios aplicados:
--    - SERIAL → INT IDENTITY(1,1)
--    - SERIAL en tablas restantes → INT IDENTITY(1,1)
--    - NOW() → GETDATE()
--    - TIMESTAMP → DATETIME2
--    - TEXT → NVARCHAR(MAX)
--    - VARCHAR → NVARCHAR
--    - CHAR → NCHAR
--    - DECIMAL → DECIMAL (compatible)
--    - Tipos ENUM (sticker_type, sticker_rarity, trade_status,
--      purchase_status, trade_side) → NVARCHAR con CHECK constraints
--    - Función plpgsql set_updated_at() → Triggers T-SQL nativos
--    - CREATE OR REPLACE FUNCTION → no existe en SQL Server
--    - CROSS JOIN en VIEW → compatible, se mantiene
--    - CHECK ... BETWEEN → compatible, se mantiene
-- ============================================================

-- ── 1. TIPOS ENUM (reemplazados por CHECK constraints inline) ─
--  PostgreSQL: CREATE TYPE sticker_type AS ENUM (...)
--  SQL Server:  Se usan NVARCHAR(30) + CHECK en cada columna


-- ── 2. TABLAS INDEPENDIENTES ──────────────────────────────────

CREATE TABLE countries (
    id            INT            IDENTITY(1,1) PRIMARY KEY,
    name          NVARCHAR(100)  NOT NULL,
    fifa_code     NVARCHAR(10),
    flag_url      NVARCHAR(255)
);

CREATE TABLE sticker_categories (
    id            INT            IDENTITY(1,1) PRIMARY KEY,
    name          NVARCHAR(50),
    description   NVARCHAR(MAX)
);

CREATE TABLE sticker_packs (
    id               INT           IDENTITY(1,1) PRIMARY KEY,
    name             NVARCHAR(50),
    price_coins      INT           NOT NULL  CONSTRAINT chk_packs_price        CHECK (price_coins > 0),
    sticker_quantity INT           DEFAULT 7 CONSTRAINT chk_packs_qty          CHECK (sticker_quantity > 0),
    release_date     DATE
);

CREATE TABLE achievements (
    id            INT            IDENTITY(1,1) PRIMARY KEY,
    title         NVARCHAR(100),
    description   NVARCHAR(MAX),
    reward_coins  INT            CONSTRAINT chk_achievements_coins CHECK (reward_coins >= 0)
);


-- ── 3. TABLAS CON FK A INDEPENDIENTES ─────────────────────────

CREATE TABLE users (
    id            INT            IDENTITY(1,1) PRIMARY KEY,
    username      NVARCHAR(50)   NOT NULL,
    email         NVARCHAR(100)  NOT NULL,
    password_hash NVARCHAR(255)  NOT NULL,
    country_id    INT,
    coins         INT            NOT NULL DEFAULT 0
                                 CONSTRAINT chk_users_coins CHECK (coins >= 0),
    created_at    DATETIME2      NOT NULL DEFAULT GETDATE(),
    updated_at    DATETIME2      NOT NULL DEFAULT GETDATE(),
    deleted_at    DATETIME2,

    CONSTRAINT uq_users_email    UNIQUE (email),
    CONSTRAINT uq_users_username UNIQUE (username),
    CONSTRAINT fk_countries_id_users
        FOREIGN KEY (country_id) REFERENCES countries (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE teams (
    id           INT           IDENTITY(1,1) PRIMARY KEY,
    country_id   INT,
    name         NVARCHAR(100) NOT NULL,
    group_letter NCHAR(1),
    coach_name   NVARCHAR(100),

    CONSTRAINT fk_countries_id_teams
        FOREIGN KEY (country_id) REFERENCES countries (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);


-- ── 4. TABLAS CON FK A users / teams ──────────────────────────

CREATE TABLE albums (
    id                    INT            IDENTITY(1,1) PRIMARY KEY,
    user_id               INT,
    completion_percentage DECIMAL(5, 2)  DEFAULT 0.00
                                         CONSTRAINT chk_albums_completion
                                         CHECK (completion_percentage BETWEEN 0 AND 100),
    completed_at          DATETIME2,
    created_at            DATETIME2      NOT NULL DEFAULT GETDATE(),
    updated_at            DATETIME2      NOT NULL DEFAULT GETDATE(),

    CONSTRAINT fk_users_id_albums
        FOREIGN KEY (user_id) REFERENCES users (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE players (
    id             INT           IDENTITY(1,1) PRIMARY KEY,
    team_id        INT,
    first_name     NVARCHAR(50),
    last_name      NVARCHAR(50),
    jersey_number  INT,
    position       NVARCHAR(30),
    birth_date     DATE,

    CONSTRAINT fk_teams_id_players
        FOREIGN KEY (team_id) REFERENCES teams (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);


-- ── 5. STICKERS ───────────────────────────────────────────────
--  Enums PostgreSQL → NVARCHAR + CHECK:
--    sticker_type    : 'player' | 'team' | 'badge' | 'special'  (ampliar si hace falta)
--    sticker_rarity  : 'common' | 'rare' | 'epic' | 'legendary'

CREATE TABLE stickers (
    id                  INT            IDENTITY(1,1) PRIMARY KEY,
    code                NVARCHAR(20)   NOT NULL,
    name                NVARCHAR(100)  NOT NULL,
    sticker_type        NVARCHAR(30)   NOT NULL
                                       CONSTRAINT chk_stickers_type
                                       CHECK (sticker_type IN ('player','team','badge','special')),
    rarity              NVARCHAR(30)   NOT NULL
                                       CONSTRAINT chk_stickers_rarity
                                       CHECK (rarity IN ('common','rare','epic','legendary')),
    category_id         INT,
    player_id           INT,
    team_id             INT,
    image_url           NVARCHAR(255),
    market_value_coins  INT            CONSTRAINT chk_stickers_market CHECK (market_value_coins >= 0),
    created_at          DATETIME2      NOT NULL DEFAULT GETDATE(),
    deleted_at          DATETIME2,

    CONSTRAINT uq_stickers_code   UNIQUE (code),

    -- #6: si es tipo 'player', debe tener player_id
    CONSTRAINT chk_sticker_player CHECK (
        sticker_type <> 'player' OR player_id IS NOT NULL
    ),
    -- #6: si es tipo 'team', debe tener team_id
    CONSTRAINT chk_sticker_team CHECK (
        sticker_type <> 'team'   OR team_id   IS NOT NULL
    ),

    CONSTRAINT fk_sticker_categories_id_stickers
        FOREIGN KEY (category_id) REFERENCES sticker_categories (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_players_id_stickers
        FOREIGN KEY (player_id)   REFERENCES players (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_teams_id_stickers
        FOREIGN KEY (team_id)     REFERENCES teams (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);


-- ── 6. PACK OPENINGS ──────────────────────────────────────────

CREATE TABLE pack_openings (
    id          INT       IDENTITY(1,1) PRIMARY KEY,
    user_id     INT,
    pack_id     INT,
    opened_at   DATETIME2 NOT NULL DEFAULT GETDATE(),

    CONSTRAINT fk_users_id_pack_openings
        FOREIGN KEY (user_id) REFERENCES users (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_sticker_packs_id_pack_openings
        FOREIGN KEY (pack_id) REFERENCES sticker_packs (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE pack_opening_stickers (
    id              INT  IDENTITY(1,1) PRIMARY KEY,
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

CREATE TABLE album_stickers (
    id          INT       IDENTITY(1,1) PRIMARY KEY,
    album_id    INT,
    sticker_id  INT,
    quantity    INT       NOT NULL DEFAULT 1
                          CONSTRAINT chk_album_stickers_qty CHECK (quantity >= 1),
    obtained_at DATETIME2 NOT NULL DEFAULT GETDATE(),
    updated_at  DATETIME2 NOT NULL DEFAULT GETDATE(),

    CONSTRAINT uq_album_stickers UNIQUE (album_id, sticker_id),

    CONSTRAINT fk_albums_id_album_stickers
        FOREIGN KEY (album_id)   REFERENCES albums (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_stickers_id_album_stickers
        FOREIGN KEY (sticker_id) REFERENCES stickers (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);


-- ── 8. MISSING STICKERS (VIEW) ────────────────────────────────

CREATE VIEW missing_stickers AS
SELECT
    a.id   AS album_id,
    s.id   AS sticker_id,
    s.code AS sticker_code,
    s.name AS sticker_name,
    s.rarity,
    s.sticker_type
FROM
    albums  a
    CROSS JOIN stickers s
WHERE
    s.deleted_at IS NULL
    AND NOT EXISTS (
        SELECT 1
        FROM   album_stickers als
        WHERE  als.album_id  = a.id
          AND  als.sticker_id = s.id
    );
GO


-- ── 9. TRADES ─────────────────────────────────────────────────
--  Enum trade_status : 'pending' | 'accepted' | 'rejected' | 'completed' | 'cancelled'

CREATE TABLE trades (
    id               INT           IDENTITY(1,1) PRIMARY KEY,
    sender_user_id   INT,
    receiver_user_id INT,
    trade_status     NVARCHAR(20)  NOT NULL DEFAULT 'pending'
                                   CONSTRAINT chk_trades_status
                                   CHECK (trade_status IN ('pending','accepted','rejected','completed','cancelled')),
    created_at       DATETIME2     NOT NULL DEFAULT GETDATE(),
    updated_at       DATETIME2     NOT NULL DEFAULT GETDATE(),
    completed_at     DATETIME2,
    deleted_at       DATETIME2,

    CONSTRAINT chk_trades_different_users
        CHECK (sender_user_id <> receiver_user_id),

    CONSTRAINT fk_users_id_trades_sender
        FOREIGN KEY (sender_user_id)   REFERENCES users (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_users_id_trades_receiver
        FOREIGN KEY (receiver_user_id) REFERENCES users (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Enum trade_side : 'offering' | 'requesting'
CREATE TABLE trade_stickers (
    id               INT          IDENTITY(1,1) PRIMARY KEY,
    trade_id         INT,
    sticker_id       INT,
    offered_by_user_id INT,
    trade_side       NVARCHAR(20) NOT NULL
                                  CONSTRAINT chk_trade_stickers_side
                                  CHECK (trade_side IN ('offering','requesting')),
    quantity         INT          NOT NULL DEFAULT 1
                                  CONSTRAINT chk_trade_stickers_qty CHECK (quantity >= 1),

    CONSTRAINT fk_trades_id_trade_stickers
        FOREIGN KEY (trade_id)           REFERENCES trades (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_stickers_id_trade_stickers
        FOREIGN KEY (sticker_id)         REFERENCES stickers (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_users_id_trade_stickers
        FOREIGN KEY (offered_by_user_id) REFERENCES users (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);


-- ── 10. PURCHASES ─────────────────────────────────────────────
--  Enum purchase_status : 'pending' | 'completed' | 'refunded' | 'cancelled'

CREATE TABLE purchases (
    id              INT          IDENTITY(1,1) PRIMARY KEY,
    user_id         INT,
    total_coins     INT          NOT NULL
                                 CONSTRAINT chk_purchases_total CHECK (total_coins > 0),
    purchase_status NVARCHAR(20) NOT NULL DEFAULT 'pending'
                                 CONSTRAINT chk_purchases_status
                                 CHECK (purchase_status IN ('pending','completed','refunded','cancelled')),
    purchased_at    DATETIME2    NOT NULL DEFAULT GETDATE(),
    updated_at      DATETIME2    NOT NULL DEFAULT GETDATE(),

    CONSTRAINT fk_users_id_purchases
        FOREIGN KEY (user_id) REFERENCES users (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE purchase_items (
    id             INT  IDENTITY(1,1) PRIMARY KEY,
    purchase_id    INT,
    pack_id        INT,
    quantity       INT  NOT NULL DEFAULT 1
                        CONSTRAINT chk_purchase_items_qty      CHECK (quantity >= 1),
    subtotal_coins INT  NOT NULL CONSTRAINT chk_purchase_items_sub CHECK (subtotal_coins >= 0),

    CONSTRAINT fk_purchases_id_purchase_items
        FOREIGN KEY (purchase_id) REFERENCES purchases (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_sticker_packs_id_purchase_items
        FOREIGN KEY (pack_id)     REFERENCES sticker_packs (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);


-- ── 11. USER ACHIEVEMENTS ─────────────────────────────────────

CREATE TABLE user_achievements (
    id             INT       IDENTITY(1,1) PRIMARY KEY,
    user_id        INT,
    achievement_id INT,
    unlocked_at    DATETIME2 NOT NULL DEFAULT GETDATE(),

    CONSTRAINT uq_user_achievements UNIQUE (user_id, achievement_id),

    CONSTRAINT fk_users_id_user_achievements
        FOREIGN KEY (user_id)        REFERENCES users (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_achievements_id_user_achievements
        FOREIGN KEY (achievement_id) REFERENCES achievements (id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);


-- ── 12. TRIGGERS: auto-actualizar updated_at ──────────────────
--  PostgreSQL usaba una función plpgsql compartida reutilizada por varios triggers.
--  SQL Server no soporta ese patrón; cada trigger es independiente con T-SQL.

GO
CREATE TRIGGER trg_users_updated_at
ON users
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE users
       SET updated_at = GETDATE()
      FROM users u
      JOIN inserted i ON u.id = i.id;
END;
GO

CREATE TRIGGER trg_albums_updated_at
ON albums
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE albums
       SET updated_at = GETDATE()
      FROM albums a
      JOIN inserted i ON a.id = i.id;
END;
GO

CREATE TRIGGER trg_album_stickers_updated_at
ON album_stickers
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE album_stickers
       SET updated_at = GETDATE()
      FROM album_stickers als
      JOIN inserted i ON als.id = i.id;
END;
GO

CREATE TRIGGER trg_trades_updated_at
ON trades
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE trades
       SET updated_at = GETDATE()
      FROM trades t
      JOIN inserted i ON t.id = i.id;
END;
GO

CREATE TRIGGER trg_purchases_updated_at
ON purchases
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE purchases
       SET updated_at = GETDATE()
      FROM purchases p
      JOIN inserted i ON p.id = i.id;
END;
GO

-- ============================================================
--  FIN DEL SCRIPT v2 – SQL Server
-- ============================================================