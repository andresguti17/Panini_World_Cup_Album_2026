-- ============================================================
--  Sticker Album 2026 – Seed Data
--  Datos de prueba suficientes para cubrir todos los flujos:
--    - 2 usuarios activos + 1 eliminado (soft delete)
--    - 6 países, 4 equipos, 16 jugadores
--    - 3 categorías, 20 figuritas (player/team/badge/collectible)
--    - 2 tipos de sobres, compras, aperturas
--    - Álbumes con figuritas obtenidas y duplicados
--    - 2 trades (1 aceptado, 1 pendiente)
--    - Logros y desbloqueos
-- ============================================================

-- ── 1. COUNTRIES ─────────────────────────────────────────────

INSERT INTO countries (id, name, fifa_code, flag_url) VALUES
(1, 'Argentina', 'ARG', 'https://flagcdn.com/ar.svg'),
(2, 'Francia',   'FRA', 'https://flagcdn.com/fr.svg'),
(3, 'Brasil',    'BRA', 'https://flagcdn.com/br.svg'),
(4, 'Alemania',  'GER', 'https://flagcdn.com/de.svg'),
(5, 'España',    'ESP', 'https://flagcdn.com/es.svg'),
(6, 'Colombia',  'COL', 'https://flagcdn.com/co.svg');


-- ── 2. STICKER CATEGORIES ─────────────────────────────────────

INSERT INTO sticker_categories (id, name, description) VALUES
(1, 'Jugadores estrella', 'Las mejores figuras del torneo'),
(2, 'Escudos y equipos',  'Figuritas representando a cada selección'),
(3, 'Especiales',         'Badges, trofeos y figuritas coleccionables únicas');


-- ── 3. STICKER PACKS ──────────────────────────────────────────

INSERT INTO sticker_packs (id, name, price_coins, sticker_quantity, release_date) VALUES
(1, 'Sobre básico',   50,  5, '2026-01-01'),
(2, 'Sobre premium', 120, 12, '2026-01-01');


-- ── 4. ACHIEVEMENTS ───────────────────────────────────────────

INSERT INTO achievements (id, title, description, reward_coins) VALUES
(1, 'Primera figurita',   'Obtén tu primera figurita del álbum',              10),
(2, 'Primer sobre',       'Abre tu primer sobre',                             25),
(3, 'Coleccionista',      'Completa el 50% del álbum',                       100),
(4, 'Álbum completo',     'Completa el 100% del álbum',                      500),
(5, 'Primer intercambio', 'Completa tu primer trade exitoso',                  30),
(6, 'Fanático',           'Obtén todas las figuritas de un mismo equipo',      75);


-- ── 5. USERS ──────────────────────────────────────────────────

INSERT INTO users (id, username, email, password_hash, country_id, coins, deleted_at) VALUES
(1, 'andres26',    'andres@example.com',  '$2b$12$hashAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 6, 350, NULL),
(2, 'mariana_gk',  'mariana@example.com', '$2b$12$hashBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB', 1, 120, NULL),
(3, 'test_borrado','borrado@example.com', '$2b$12$hashCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC', NULL, 0, NOW());
-- user 3 tiene deleted_at → prueba de soft delete (no debe aparecer en listados activos)


-- ── 6. TEAMS ──────────────────────────────────────────────────

INSERT INTO teams (id, country_id, name, group_letter, coach_name) VALUES
(1, 1, 'Argentina', 'A', 'Lionel Scaloni'),
(2, 2, 'Francia',   'B', 'Didier Deschamps'),
(3, 3, 'Brasil',    'C', 'Dorival Júnior'),
(4, 6, 'Colombia',  'D', 'Néstor Lorenzo');


-- ── 7. PLAYERS ────────────────────────────────────────────────

INSERT INTO players (id, team_id, first_name, last_name, jersey_number, position, birth_date) VALUES
-- Argentina
(1,  1, 'Lionel',   'Messi',       10, 'Delantero',     '1987-06-24'),
(2,  1, 'Emiliano', 'Martínez',     1, 'Portero',       '1992-09-02'),
(3,  1, 'Julián',   'Álvarez',      9, 'Delantero',     '2000-01-31'),
(4,  1, 'Rodrigo',  'De Paul',      7, 'Mediocampista', '1994-05-24'),
-- Francia
(5,  2, 'Kylian',   'Mbappé',       7, 'Delantero',     '1998-12-20'),
(6,  2, 'Antoine',  'Griezmann',    7, 'Mediocampista', '1991-03-21'),
(7,  2, 'Olivier',  'Giroud',       9, 'Delantero',     '1986-09-30'),
(8,  2, 'Mike',     'Maignan',      1, 'Portero',       '1995-07-03'),
-- Brasil
(9,  3, 'Vinícius', 'Jr.',          7, 'Delantero',     '2000-07-12'),
(10, 3, 'Rodrygo',  'Goes',        11, 'Delantero',     '2001-01-09'),
(11, 3, 'Casemiro', 'Carlos',       5, 'Mediocampista', '1992-02-23'),
(12, 3, 'Alisson',  'Becker',       1, 'Portero',       '1992-10-02'),
-- Colombia
(13, 4, 'James',    'Rodríguez',   10, 'Mediocampista', '1991-07-12'),
(14, 4, 'Luis',     'Díaz',        23, 'Delantero',     '1997-01-13'),
(15, 4, 'Radamel',  'Falcao',       9, 'Delantero',     '1986-02-10'),
(16, 4, 'Davinson', 'Sánchez',      2, 'Defensa',       '1996-06-12');


-- ── 8. STICKERS ───────────────────────────────────────────────
-- id numérico (SERIAL), code = identificador de negocio único
-- player_id y team_id referencia las tablas anteriores

INSERT INTO stickers (id, code, name, sticker_type, rarity, category_id, player_id, team_id, image_url, market_value_coins) VALUES
-- Jugadores Argentina
(1,  'ARG-10',   'Messi – Argentina',       'player', 'legendary', 1,  1, NULL, 'https://cdn.example.com/stickers/arg10.png',  500),
(2,  'ARG-01',   'E. Martínez – Argentina', 'player', 'rare',      1,  2, NULL, 'https://cdn.example.com/stickers/arg01.png',  120),
(3,  'ARG-09',   'J. Álvarez – Argentina',  'player', 'rare',      1,  3, NULL, 'https://cdn.example.com/stickers/arg09.png',  100),
(4,  'ARG-07',   'De Paul – Argentina',     'player', 'common',    1,  4, NULL, 'https://cdn.example.com/stickers/arg07.png',   40),
-- Jugadores Francia
(5,  'FRA-07',   'Mbappé – Francia',        'player', 'legendary', 1,  5, NULL, 'https://cdn.example.com/stickers/fra07.png',  480),
(6,  'FRA-06',   'Griezmann – Francia',     'player', 'epic',      1,  6, NULL, 'https://cdn.example.com/stickers/fra06.png',  200),
(7,  'FRA-09',   'Giroud – Francia',        'player', 'rare',      1,  7, NULL, 'https://cdn.example.com/stickers/fra09.png',   90),
(8,  'FRA-01',   'Maignan – Francia',       'player', 'common',    1,  8, NULL, 'https://cdn.example.com/stickers/fra01.png',   35),
-- Jugadores Brasil
(9,  'BRA-07',   'Vinícius Jr. – Brasil',   'player', 'epic',      1,  9, NULL, 'https://cdn.example.com/stickers/bra07.png',  300),
(10, 'BRA-11',   'Rodrygo – Brasil',        'player', 'rare',      1, 10, NULL, 'https://cdn.example.com/stickers/bra11.png',   80),
(11, 'BRA-05',   'Casemiro – Brasil',       'player', 'common',    1, 11, NULL, 'https://cdn.example.com/stickers/bra05.png',   40),
(12, 'BRA-01',   'Alisson – Brasil',        'player', 'rare',      1, 12, NULL, 'https://cdn.example.com/stickers/bra01.png',   95),
-- Jugadores Colombia
(13, 'COL-10',   'James – Colombia',        'player', 'epic',      1, 13, NULL, 'https://cdn.example.com/stickers/col10.png',  250),
(14, 'COL-23',   'Luis Díaz – Colombia',    'player', 'rare',      1, 14, NULL, 'https://cdn.example.com/stickers/col23.png',  110),
-- Escudos (team_id NOT NULL por CHECK constraint)
(15, 'TEAM-ARG', 'Escudo Argentina',        'team',   'common',    2, NULL, 1,  'https://cdn.example.com/stickers/team_arg.png', 30),
(16, 'TEAM-FRA', 'Escudo Francia',          'team',   'common',    2, NULL, 2,  'https://cdn.example.com/stickers/team_fra.png', 30),
(17, 'TEAM-BRA', 'Escudo Brasil',           'team',   'common',    2, NULL, 3,  'https://cdn.example.com/stickers/team_bra.png', 30),
(18, 'TEAM-COL', 'Escudo Colombia',         'team',   'common',    2, NULL, 4,  'https://cdn.example.com/stickers/team_col.png', 30),
-- Especiales (player_id y team_id NULL, son badge/collectible)
(19, 'BADGE-01', 'Trofeo Copa del Mundo',   'badge',       'legendary', 3, NULL, NULL, 'https://cdn.example.com/stickers/trophy.png', 600),
(20, 'COLL-01',  'Logo Mundial 2026',       'collectible', 'epic',      3, NULL, NULL, 'https://cdn.example.com/stickers/logo26.png', 180);


-- ── 9. ALBUMS ─────────────────────────────────────────────────

INSERT INTO albums (id, user_id, completion_percentage) VALUES
(1, 1, 35.00),  -- andres26: 7/20 figuritas distintas
(2, 2, 15.00);  -- mariana_gk: 3/20 figuritas distintas


-- ── 10. ALBUM STICKERS ────────────────────────────────────────
-- quantity > 1 = duplicado (sin campo is_duplicate)

INSERT INTO album_stickers (album_id, sticker_id, quantity) VALUES
-- andres26 (album 1): 7 figuritas distintas, 2 con duplicados
(1,  1, 1),  -- Messi x1
(1,  2, 2),  -- E. Martínez x2 → duplicado
(1,  5, 1),  -- Mbappé x1
(1,  9, 3),  -- Vinícius x3 → duplicado
(1, 15, 1),  -- Escudo Argentina x1
(1, 18, 1),  -- Escudo Colombia x1
(1, 19, 1),  -- Trofeo x1
-- mariana_gk (album 2): 3 figuritas distintas
(2,  1, 1),  -- Messi x1
(2,  6, 2),  -- Griezmann x2 → duplicado
(2, 17, 1);  -- Escudo Brasil x1


-- ── 11. PURCHASES ─────────────────────────────────────────────

INSERT INTO purchases (id, user_id, total_coins, purchase_status, purchased_at) VALUES
(1, 1, 240, 'completed', NOW() - INTERVAL '3 days'),  -- andres26: 2x premium
(2, 1,  50, 'completed', NOW() - INTERVAL '1 day'),   -- andres26: 1x básico
(3, 2,  50, 'completed', NOW() - INTERVAL '2 days'),  -- mariana_gk: 1x básico
(4, 1, 120, 'pending',   NOW());                       -- andres26: pendiente de procesar

INSERT INTO purchase_items (purchase_id, pack_id, quantity, subtotal_coins) VALUES
(1, 2, 2, 240),
(2, 1, 1,  50),
(3, 1, 1,  50),
(4, 2, 1, 120);


-- ── 12. PACK OPENINGS ─────────────────────────────────────────

INSERT INTO pack_openings (id, user_id, pack_id, opened_at) VALUES
(1, 1, 2, NOW() - INTERVAL '3 days'),
(2, 1, 2, NOW() - INTERVAL '3 days'),
(3, 1, 1, NOW() - INTERVAL '1 day'),
(4, 2, 1, NOW() - INTERVAL '2 days');

-- Figuritas que salieron en cada apertura (sticker_id = int)
INSERT INTO pack_opening_stickers (pack_opening_id, sticker_id) VALUES
-- Apertura 1 (andres26, sobre premium, 12 figuritas)
(1, 1),  (1, 2),  (1, 5),
(1, 9),  (1, 15), (1, 19),
(1, 2),  (1, 9),  (1, 9),   -- duplicados
(1, 18), (1, 13), (1, 7),
-- Apertura 2 (andres26, sobre premium, 12 figuritas)
(2, 4),  (2, 11), (2, 8),
(2, 16), (2, 14), (2, 10),
(2, 3),  (2, 6),  (2, 20),
(2, 2),  (2, 9),  (2, 17),  -- más duplicados
-- Apertura 3 (andres26, sobre básico, 5 figuritas)
(3, 6),  (3, 13), (3, 18),
(3, 4),  (3, 12),
-- Apertura 4 (mariana_gk, sobre básico, 5 figuritas)
(4, 1),  (4, 6),  (4, 17),
(4, 6),  (4, 10);  -- Griezmann sale 2 veces → duplicado


-- ── 13. TRADES ────────────────────────────────────────────────
-- Trade 1: andres26 ofrece Vinícius duplicado, pide Griezmann → ACEPTADO
-- Trade 2: mariana_gk ofrece Griezmann, pide Messi → PENDIENTE

INSERT INTO trades (id, sender_user_id, receiver_user_id, trade_status, completed_at) VALUES
(1, 1, 2, 'accepted', NOW() - INTERVAL '1 day'),
(2, 2, 1, 'pending',  NULL);

INSERT INTO trade_stickers (trade_id, sticker_id, offered_by_user_id, trade_side, quantity) VALUES
-- Trade 1 (aceptado)
(1, 9, 1, 'offering',   1),  -- andres26 ofrece Vinícius (id=9)
(1, 6, 2, 'requesting', 1),  -- andres26 pide Griezmann (id=6)
-- Trade 2 (pendiente)
(2, 6, 2, 'offering',   1),  -- mariana_gk ofrece Griezmann (id=6)
(2, 1, 1, 'requesting', 1);  -- mariana_gk quiere Messi (id=1)


-- ── 14. USER ACHIEVEMENTS ─────────────────────────────────────

INSERT INTO user_achievements (user_id, achievement_id, unlocked_at) VALUES
(1, 1, NOW() - INTERVAL '3 days'),  -- andres26: Primera figurita
(1, 2, NOW() - INTERVAL '3 days'),  -- andres26: Primer sobre
(1, 5, NOW() - INTERVAL '1 day'),   -- andres26: Primer intercambio
(2, 1, NOW() - INTERVAL '2 days'),  -- mariana_gk: Primera figurita
(2, 2, NOW() - INTERVAL '2 days');  -- mariana_gk: Primer sobre


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
-- LEFT JOIN purchases p ON p.user_id = u.id AND p.purchase_status = 'completed'
-- WHERE u.deleted_at IS NULL
-- GROUP BY u.id, u.username, u.coins;

-- Verificar que el soft delete funciona (user 3 no debe aparecer en activos):
-- SELECT id, username, deleted_at FROM users WHERE deleted_at IS NULL;

-- ============================================================
--  FIN DEL SEED
-- ============================================================