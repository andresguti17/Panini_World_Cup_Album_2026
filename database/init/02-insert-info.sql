-- ============================================================
--  Sticker Album 2026 – Seed Data – SQL Server
--  Migrado desde PostgreSQL
--  Cambios aplicados:
--    - NOW()                      → GETDATE()
--    - NOW() - INTERVAL 'N days'  → DATEADD(DAY, -N, GETDATE())
--    - Valores ENUM de texto      → compatibles (ya son NVARCHAR en el DDL)
--    - INSERT con IDs explícitos  → requieren SET IDENTITY_INSERT ON/OFF
--    - sticker_type 'collectible' → añadido al CHECK del DDL (ver nota al pie)
-- ============================================================

-- ── NOTA SOBRE IDENTITY ───────────────────────────────────────
--  El seed inserta IDs explícitos en tablas con IDENTITY(1,1).
--  SQL Server requiere habilitar IDENTITY_INSERT por tabla antes
--  de insertar valores manuales, y deshabilitarlo después.
--  Una vez cargados los seeds, los IDs quedan reservados y la
--  secuencia auto-incremental continuará desde el valor más alto.
--  Para resetear la semilla: DBCC CHECKIDENT ('tabla', RESEED, N)
-- ─────────────────────────────────────────────────────────────


-- ── 1. COUNTRIES ─────────────────────────────────────────────

SET IDENTITY_INSERT countries ON;
INSERT INTO countries (id, name, fifa_code, flag_url) VALUES
(1, N'Argentina', N'ARG', N'https://flagcdn.com/ar.svg'),
(2, N'Francia',   N'FRA', N'https://flagcdn.com/fr.svg'),
(3, N'Brasil',    N'BRA', N'https://flagcdn.com/br.svg'),
(4, N'Alemania',  N'GER', N'https://flagcdn.com/de.svg'),
(5, N'España',    N'ESP', N'https://flagcdn.com/es.svg'),
(6, N'Colombia',  N'COL', N'https://flagcdn.com/co.svg');
SET IDENTITY_INSERT countries OFF;


-- ── 2. STICKER CATEGORIES ─────────────────────────────────────

SET IDENTITY_INSERT sticker_categories ON;
INSERT INTO sticker_categories (id, name, description) VALUES
(1, N'Jugadores estrella', N'Las mejores figuras del torneo'),
(2, N'Escudos y equipos',  N'Figuritas representando a cada selección'),
(3, N'Especiales',         N'Badges, trofeos y figuritas coleccionables únicas');
SET IDENTITY_INSERT sticker_categories OFF;


-- ── 3. STICKER PACKS ──────────────────────────────────────────

SET IDENTITY_INSERT sticker_packs ON;
INSERT INTO sticker_packs (id, name, price_coins, sticker_quantity, release_date) VALUES
(1, N'Sobre básico',   50,  5, '2026-01-01'),
(2, N'Sobre premium', 120, 12, '2026-01-01');
SET IDENTITY_INSERT sticker_packs OFF;


-- ── 4. ACHIEVEMENTS ───────────────────────────────────────────

SET IDENTITY_INSERT achievements ON;
INSERT INTO achievements (id, title, description, reward_coins) VALUES
(1, N'Primera figurita',   N'Obtén tu primera figurita del álbum',              10),
(2, N'Primer sobre',       N'Abre tu primer sobre',                             25),
(3, N'Coleccionista',      N'Completa el 50% del álbum',                       100),
(4, N'Álbum completo',     N'Completa el 100% del álbum',                      500),
(5, N'Primer intercambio', N'Completa tu primer trade exitoso',                  30),
(6, N'Fanático',           N'Obtén todas las figuritas de un mismo equipo',      75);
SET IDENTITY_INSERT achievements OFF;


-- ── 5. USERS ──────────────────────────────────────────────────

SET IDENTITY_INSERT users ON;
INSERT INTO users (id, username, email, password_hash, country_id, coins, deleted_at) VALUES
(1, N'andres26',     N'andres@example.com',  N'$2b$12$hashAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 6, 350, NULL),
(2, N'mariana_gk',   N'mariana@example.com', N'$2b$12$hashBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB', 1, 120, NULL),
(3, N'test_borrado', N'borrado@example.com', N'$2b$12$hashCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC', NULL, 0, GETDATE());
-- user 3: deleted_at = ahora → prueba de soft delete
SET IDENTITY_INSERT users OFF;


-- ── 6. TEAMS ──────────────────────────────────────────────────

SET IDENTITY_INSERT teams ON;
INSERT INTO teams (id, country_id, name, group_letter, coach_name) VALUES
(1, 1, N'Argentina', N'A', N'Lionel Scaloni'),
(2, 2, N'Francia',   N'B', N'Didier Deschamps'),
(3, 3, N'Brasil',    N'C', N'Dorival Júnior'),
(4, 6, N'Colombia',  N'D', N'Néstor Lorenzo');
SET IDENTITY_INSERT teams OFF;


-- ── 7. PLAYERS ────────────────────────────────────────────────

SET IDENTITY_INSERT players ON;
INSERT INTO players (id, team_id, first_name, last_name, jersey_number, position, birth_date) VALUES
-- Argentina
(1,  1, N'Lionel',   N'Messi',       10, N'Delantero',     '1987-06-24'),
(2,  1, N'Emiliano', N'Martínez',     1, N'Portero',       '1992-09-02'),
(3,  1, N'Julián',   N'Álvarez',      9, N'Delantero',     '2000-01-31'),
(4,  1, N'Rodrigo',  N'De Paul',      7, N'Mediocampista', '1994-05-24'),
-- Francia
(5,  2, N'Kylian',   N'Mbappé',       7, N'Delantero',     '1998-12-20'),
(6,  2, N'Antoine',  N'Griezmann',    7, N'Mediocampista', '1991-03-21'),
(7,  2, N'Olivier',  N'Giroud',       9, N'Delantero',     '1986-09-30'),
(8,  2, N'Mike',     N'Maignan',      1, N'Portero',       '1995-07-03'),
-- Brasil
(9,  3, N'Vinícius', N'Jr.',          7, N'Delantero',     '2000-07-12'),
(10, 3, N'Rodrygo',  N'Goes',        11, N'Delantero',     '2001-01-09'),
(11, 3, N'Casemiro', N'Carlos',       5, N'Mediocampista', '1992-02-23'),
(12, 3, N'Alisson',  N'Becker',       1, N'Portero',       '1992-10-02'),
-- Colombia
(13, 4, N'James',    N'Rodríguez',   10, N'Mediocampista', '1991-07-12'),
(14, 4, N'Luis',     N'Díaz',        23, N'Delantero',     '1997-01-13'),
(15, 4, N'Radamel',  N'Falcao',       9, N'Delantero',     '1986-02-10'),
(16, 4, N'Davinson', N'Sánchez',      2, N'Defensa',       '1996-06-12');
SET IDENTITY_INSERT players OFF;


-- ── 8. STICKERS ───────────────────────────────────────────────
--  IMPORTANTE: el sticker_type 'collectible' (id=20) no estaba en
--  el CHECK del DDL original (solo: player, team, badge, special).
--  Opciones:
--    a) Cambiar 'collectible' → 'special' en este INSERT  ← opción conservadora
--    b) Ampliar el CHECK en el DDL:
--       ALTER TABLE stickers DROP CONSTRAINT chk_stickers_type;
--       ALTER TABLE stickers ADD CONSTRAINT chk_stickers_type
--           CHECK (sticker_type IN ('player','team','badge','special','collectible'));
--  Este script aplica la opción (b): amplía el CHECK antes de insertar.

ALTER TABLE stickers DROP CONSTRAINT chk_stickers_type;
ALTER TABLE stickers ADD CONSTRAINT chk_stickers_type
    CHECK (sticker_type IN ('player','team','badge','special','collectible'));
GO

SET IDENTITY_INSERT stickers ON;
INSERT INTO stickers (id, code, name, sticker_type, rarity, category_id, player_id, team_id, image_url, market_value_coins) VALUES
-- Jugadores Argentina
(1,  N'ARG-10',   N'Messi – Argentina',       N'player', N'legendary', 1,  1, NULL, N'https://cdn.example.com/stickers/arg10.png',  500),
(2,  N'ARG-01',   N'E. Martínez – Argentina', N'player', N'rare',      1,  2, NULL, N'https://cdn.example.com/stickers/arg01.png',  120),
(3,  N'ARG-09',   N'J. Álvarez – Argentina',  N'player', N'rare',      1,  3, NULL, N'https://cdn.example.com/stickers/arg09.png',  100),
(4,  N'ARG-07',   N'De Paul – Argentina',     N'player', N'common',    1,  4, NULL, N'https://cdn.example.com/stickers/arg07.png',   40),
-- Jugadores Francia
(5,  N'FRA-07',   N'Mbappé – Francia',        N'player', N'legendary', 1,  5, NULL, N'https://cdn.example.com/stickers/fra07.png',  480),
(6,  N'FRA-06',   N'Griezmann – Francia',     N'player', N'epic',      1,  6, NULL, N'https://cdn.example.com/stickers/fra06.png',  200),
(7,  N'FRA-09',   N'Giroud – Francia',        N'player', N'rare',      1,  7, NULL, N'https://cdn.example.com/stickers/fra09.png',   90),
(8,  N'FRA-01',   N'Maignan – Francia',       N'player', N'common',    1,  8, NULL, N'https://cdn.example.com/stickers/fra01.png',   35),
-- Jugadores Brasil
(9,  N'BRA-07',   N'Vinícius Jr. – Brasil',   N'player', N'epic',      1,  9, NULL, N'https://cdn.example.com/stickers/bra07.png',  300),
(10, N'BRA-11',   N'Rodrygo – Brasil',        N'player', N'rare',      1, 10, NULL, N'https://cdn.example.com/stickers/bra11.png',   80),
(11, N'BRA-05',   N'Casemiro – Brasil',       N'player', N'common',    1, 11, NULL, N'https://cdn.example.com/stickers/bra05.png',   40),
(12, N'BRA-01',   N'Alisson – Brasil',        N'player', N'rare',      1, 12, NULL, N'https://cdn.example.com/stickers/bra01.png',   95),
-- Jugadores Colombia
(13, N'COL-10',   N'James – Colombia',        N'player', N'epic',      1, 13, NULL, N'https://cdn.example.com/stickers/col10.png',  250),
(14, N'COL-23',   N'Luis Díaz – Colombia',    N'player', N'rare',      1, 14, NULL, N'https://cdn.example.com/stickers/col23.png',  110),
-- Escudos (team_id NOT NULL por CHECK constraint)
(15, N'TEAM-ARG', N'Escudo Argentina',        N'team',   N'common',    2, NULL, 1,  N'https://cdn.example.com/stickers/team_arg.png', 30),
(16, N'TEAM-FRA', N'Escudo Francia',          N'team',   N'common',    2, NULL, 2,  N'https://cdn.example.com/stickers/team_fra.png', 30),
(17, N'TEAM-BRA', N'Escudo Brasil',           N'team',   N'common',    2, NULL, 3,  N'https://cdn.example.com/stickers/team_bra.png', 30),
(18, N'TEAM-COL', N'Escudo Colombia',         N'team',   N'common',    2, NULL, 4,  N'https://cdn.example.com/stickers/team_col.png', 30),
-- Especiales
(19, N'BADGE-01', N'Trofeo Copa del Mundo',   N'badge',       N'legendary', 3, NULL, NULL, N'https://cdn.example.com/stickers/trophy.png', 600),
(20, N'COLL-01',  N'Logo Mundial 2026',       N'collectible', N'epic',      3, NULL, NULL, N'https://cdn.example.com/stickers/logo26.png', 180);
SET IDENTITY_INSERT stickers OFF;


-- ── 9. ALBUMS ─────────────────────────────────────────────────

SET IDENTITY_INSERT albums ON;
INSERT INTO albums (id, user_id, completion_percentage) VALUES
(1, 1, 35.00),
(2, 2, 15.00);
SET IDENTITY_INSERT albums OFF;


-- ── 10. ALBUM STICKERS ────────────────────────────────────────

INSERT INTO album_stickers (album_id, sticker_id, quantity) VALUES
-- andres26 (album 1)
(1,  1, 1),
(1,  2, 2),
(1,  5, 1),
(1,  9, 3),
(1, 15, 1),
(1, 18, 1),
(1, 19, 1),
-- mariana_gk (album 2)
(2,  1, 1),
(2,  6, 2),
(2, 17, 1);


-- ── 11. PURCHASES ─────────────────────────────────────────────

SET IDENTITY_INSERT purchases ON;
INSERT INTO purchases (id, user_id, total_coins, purchase_status, purchased_at) VALUES
(1, 1, 240, N'completed', DATEADD(DAY, -3, GETDATE())),
(2, 1,  50, N'completed', DATEADD(DAY, -1, GETDATE())),
(3, 2,  50, N'completed', DATEADD(DAY, -2, GETDATE())),
(4, 1, 120, N'pending',   GETDATE());
SET IDENTITY_INSERT purchases OFF;

INSERT INTO purchase_items (purchase_id, pack_id, quantity, subtotal_coins) VALUES
(1, 2, 2, 240),
(2, 1, 1,  50),
(3, 1, 1,  50),
(4, 2, 1, 120);


-- ── 12. PACK OPENINGS ─────────────────────────────────────────

SET IDENTITY_INSERT pack_openings ON;
INSERT INTO pack_openings (id, user_id, pack_id, opened_at) VALUES
(1, 1, 2, DATEADD(DAY, -3, GETDATE())),
(2, 1, 2, DATEADD(DAY, -3, GETDATE())),
(3, 1, 1, DATEADD(DAY, -1, GETDATE())),
(4, 2, 1, DATEADD(DAY, -2, GETDATE()));
SET IDENTITY_INSERT pack_openings OFF;

INSERT INTO pack_opening_stickers (pack_opening_id, sticker_id) VALUES
-- Apertura 1 (andres26, sobre premium, 12 figuritas)
(1, 1),  (1, 2),  (1, 5),
(1, 9),  (1, 15), (1, 19),
(1, 2),  (1, 9),  (1, 9),
(1, 18), (1, 13), (1, 7),
-- Apertura 2 (andres26, sobre premium, 12 figuritas)
(2, 4),  (2, 11), (2, 8),
(2, 16), (2, 14), (2, 10),
(2, 3),  (2, 6),  (2, 20),
(2, 2),  (2, 9),  (2, 17),
-- Apertura 3 (andres26, sobre básico, 5 figuritas)
(3, 6),  (3, 13), (3, 18),
(3, 4),  (3, 12),
-- Apertura 4 (mariana_gk, sobre básico, 5 figuritas)
(4, 1),  (4, 6),  (4, 17),
(4, 6),  (4, 10);


-- ── 13. TRADES ────────────────────────────────────────────────

SET IDENTITY_INSERT trades ON;
INSERT INTO trades (id, sender_user_id, receiver_user_id, trade_status, completed_at) VALUES
(1, 1, 2, N'accepted', DATEADD(DAY, -1, GETDATE())),
(2, 2, 1, N'pending',  NULL);
SET IDENTITY_INSERT trades OFF;

INSERT INTO trade_stickers (trade_id, sticker_id, offered_by_user_id, trade_side, quantity) VALUES
-- Trade 1 (aceptado)
(1, 9, 1, N'offering',   1),
(1, 6, 2, N'requesting', 1),
-- Trade 2 (pendiente)
(2, 6, 2, N'offering',   1),
(2, 1, 1, N'requesting', 1);


-- ── 14. USER ACHIEVEMENTS ─────────────────────────────────────

INSERT INTO user_achievements (user_id, achievement_id, unlocked_at) VALUES
(1, 1, DATEADD(DAY, -3, GETDATE())),
(1, 2, DATEADD(DAY, -3, GETDATE())),
(1, 5, DATEADD(DAY, -1, GETDATE())),
(2, 1, DATEADD(DAY, -2, GETDATE())),
(2, 2, DATEADD(DAY, -2, GETDATE()));


-- ============================================================
--  QUERIES DE VERIFICACIÓN
-- ============================================================

-- Álbum de andres26 con estado de cada figurita:
-- SELECT s.code, s.name, s.rarity, als.quantity,
--        CASE WHEN als.quantity > 1 THEN 'duplicado' ELSE 'único' END AS estado
-- FROM album_stickers als
-- JOIN stickers s ON s.id = als.sticker_id
-- WHERE als.album_id = 1
-- ORDER BY als.quantity DESC;

-- Figuritas que le faltan a andres26 (usa la VIEW):
-- SELECT sticker_code, sticker_name, rarity, sticker_type
-- FROM missing_stickers
-- WHERE album_id = 1
-- ORDER BY rarity, sticker_code;

-- Detalle completo de todos los trades:
-- SELECT t.id, u1.username AS sender, u2.username AS receiver,
--        t.trade_status, s.code AS sticker, ts.trade_side, ts.quantity
-- FROM trades t
-- JOIN users u1 ON u1.id = t.sender_user_id
-- JOIN users u2 ON u2.id = t.receiver_user_id
-- JOIN trade_stickers ts ON ts.trade_id = t.id
-- JOIN stickers s ON s.id = ts.sticker_id
-- WHERE t.deleted_at IS NULL
-- ORDER BY t.id, ts.trade_side;

-- Coins gastados vs saldo actual por usuario:
-- SELECT u.username, u.coins AS saldo_actual,
--        COALESCE(SUM(p.total_coins), 0) AS total_gastado
-- FROM users u
-- LEFT JOIN purchases p ON p.user_id = u.id AND p.purchase_status = N'completed'
-- WHERE u.deleted_at IS NULL
-- GROUP BY u.username, u.coins;

-- Verificar soft delete (user 3 no debe aparecer en activos):
-- SELECT id, username, deleted_at FROM users WHERE deleted_at IS NULL;

-- ============================================================
--  FIN DEL SEED – SQL Server
-- ============================================================