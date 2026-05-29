-- ============================================================
--  Sticker Album 2026 – Views – SQL Server
--  Migrado desde PostgreSQL
--  Cambios aplicados:
--    - DROP VIEW IF EXISTS ... CASCADE  → IF OBJECT_ID + DROP VIEW
--    - COMMENT ON VIEW                  → no existe en SQL Server (eliminado)
--    - FILTER (WHERE ...)               → CASE WHEN dentro de COUNT/SUM
--    - ARRAY_AGG(... ORDER BY ...)      → STRING_AGG con WITHIN GROUP
--    - (als.quantity > 1) AS bool       → CAST(CASE WHEN ... END AS BIT)
--    - ORDER BY en vistas               → eliminado (no permitido en SQL Server)
--    - ORDER BY ... NULLS LAST          → ORDER BY ... (NULLs van al final por defecto en DESC)
-- ============================================================


-- ============================================================
--  A. ÁLBUM Y FIGURITAS
-- ============================================================

-- ── A1. missing_stickers ──────────────────────────────────────
IF OBJECT_ID('missing_stickers', 'V') IS NOT NULL DROP VIEW missing_stickers;
GO
CREATE VIEW missing_stickers ASt
SELECT
    a.id                    AS album_id,
    s.id                    AS sticker_id,
    s.code                  AS sticker_code,
    s.name                  AS sticker_name,
    s.sticker_type,
    s.rarity,
    s.image_url,
    s.market_value_coins
FROM albums a
CROSS JOIN stickers s
WHERE s.deleted_at IS NULL
  AND NOT EXISTS (
      SELECT 1
      FROM album_stickers als
      WHERE als.album_id   = a.id
        AND als.sticker_id = s.id
  );
GO


-- ── A2. v_album_stickers_detail ───────────────────────────────
IF OBJECT_ID('v_album_stickers_detail', 'V') IS NOT NULL DROP VIEW v_album_stickers_detail;
GO
CREATE VIEW v_album_stickers_detail AS
SELECT
    als.album_id,
    a.user_id,
    als.sticker_id,
    s.code                                      AS sticker_code,
    s.name                                      AS sticker_name,
    s.sticker_type,
    s.rarity,
    s.image_url,
    s.market_value_coins,
    sc.name                                     AS category_name,
    p.first_name                                AS player_first_name,
    p.last_name                                 AS player_last_name,
    p.jersey_number,
    p.position,
    COALESCE(t_direct.name, t_via_player.name)  AS team_name,
    als.quantity,
    -- PostgreSQL: (als.quantity > 1) como boolean
    -- SQL Server: BIT equivalente
    CAST(CASE WHEN als.quantity > 1 THEN 1 ELSE 0 END AS BIT) AS is_duplicate,
    als.obtained_at,
    als.updated_at
FROM album_stickers als
JOIN albums              a            ON a.id  = als.album_id
JOIN stickers            s            ON s.id  = als.sticker_id
LEFT JOIN sticker_categories sc       ON sc.id = s.category_id
LEFT JOIN players            p        ON p.id  = s.player_id
LEFT JOIN teams              t_direct     ON t_direct.id     = s.team_id
LEFT JOIN teams              t_via_player ON t_via_player.id = p.team_id
WHERE s.deleted_at IS NULL;
GO


-- ── A3. v_album_summary ───────────────────────────────────────
IF OBJECT_ID('v_album_summary', 'V') IS NOT NULL DROP VIEW v_album_summary;
GO
CREATE VIEW v_album_summary AS
SELECT
    a.id                                            AS album_id,
    a.user_id,
    u.username,
    COUNT(DISTINCT s_all.id)                        AS total_stickers,
    COUNT(DISTINCT als.sticker_id)                  AS obtained_distinct,
    -- FILTER (WHERE ...) → CASE WHEN dentro de COUNT
    COUNT(DISTINCT CASE WHEN als.quantity > 1 THEN als.sticker_id END)
                                                    AS stickers_with_duplicates,
    COALESCE(SUM(als.quantity), 0)                  AS total_copies,
    ROUND(
        COUNT(DISTINCT als.sticker_id) * 100.0
        / NULLIF(COUNT(DISTINCT s_all.id), 0),
        2
    )                                               AS completion_pct,
    a.completed_at,
    a.created_at                                    AS album_created_at
FROM albums a
JOIN users u ON u.id = a.user_id
CROSS JOIN (SELECT id FROM stickers WHERE deleted_at IS NULL) s_all
LEFT JOIN album_stickers als ON als.album_id = a.id
WHERE u.deleted_at IS NULL
GROUP BY a.id, a.user_id, u.username, a.completed_at, a.created_at;
GO


-- ── A4. v_duplicated_stickers ─────────────────────────────────
IF OBJECT_ID('v_duplicated_stickers', 'V') IS NOT NULL DROP VIEW v_duplicated_stickers;
GO
CREATE VIEW v_duplicated_stickers AS
SELECT
    als.album_id,
    a.user_id,
    u.username,
    als.sticker_id,
    s.code              AS sticker_code,
    s.name              AS sticker_name,
    s.sticker_type,
    s.rarity,
    s.market_value_coins,
    als.quantity,
    (als.quantity - 1)  AS tradeable_quantity
FROM album_stickers als
JOIN albums   a ON a.id  = als.album_id
JOIN users    u ON u.id  = a.user_id
JOIN stickers s ON s.id  = als.sticker_id
WHERE als.quantity > 1
  AND s.deleted_at IS NULL
  AND u.deleted_at IS NULL;
GO


-- ── A5. v_sticker_catalog ─────────────────────────────────────
--  ORDER BY eliminado: las vistas en SQL Server no permiten ORDER BY
--  salvo con TOP. Ordenar en la consulta del cliente.
IF OBJECT_ID('v_sticker_catalog', 'V') IS NOT NULL DROP VIEW v_sticker_catalog;
GO
CREATE VIEW v_sticker_catalog AS
SELECT
    s.id                                                    AS sticker_id,
    s.code,
    s.name,
    s.sticker_type,
    s.rarity,
    s.image_url,
    s.market_value_coins,
    sc.name                                                 AS category_name,
    p.first_name                                            AS player_first_name,
    p.last_name                                             AS player_last_name,
    p.jersey_number,
    p.position,
    p.birth_date                                            AS player_birth_date,
    COALESCE(t_direct.name,      t_via_player.name)         AS team_name,
    COALESCE(c_direct.fifa_code, c_via_player.fifa_code)    AS team_fifa_code,
    s.created_at
FROM stickers s
LEFT JOIN sticker_categories sc           ON sc.id = s.category_id
LEFT JOIN players             p           ON p.id  = s.player_id
LEFT JOIN teams               t_direct     ON t_direct.id     = s.team_id
LEFT JOIN teams               t_via_player ON t_via_player.id = p.team_id
LEFT JOIN countries           c_direct     ON c_direct.id     = t_direct.country_id
LEFT JOIN countries           c_via_player ON c_via_player.id = t_via_player.country_id
WHERE s.deleted_at IS NULL;
GO


-- ============================================================
--  B. TRADES
-- ============================================================

-- ── B1. v_trades_detail ───────────────────────────────────────
IF OBJECT_ID('v_trades_detail', 'V') IS NOT NULL DROP VIEW v_trades_detail;
GO
CREATE VIEW v_trades_detail AS
SELECT
    t.id                    AS trade_id,
    t.trade_status,
    t.created_at            AS trade_created_at,
    t.completed_at,
    t.sender_user_id,
    u_sender.username       AS sender_username,
    t.receiver_user_id,
    u_receiver.username     AS receiver_username,
    ts.sticker_id,
    s.code                  AS sticker_code,
    s.name                  AS sticker_name,
    s.rarity,
    s.sticker_type,
    ts.offered_by_user_id,
    u_offerer.username      AS offered_by_username,
    ts.trade_side,
    ts.quantity
FROM trades t
JOIN users          u_sender   ON u_sender.id   = t.sender_user_id
JOIN users          u_receiver ON u_receiver.id = t.receiver_user_id
JOIN trade_stickers ts         ON ts.trade_id   = t.id
JOIN stickers       s          ON s.id          = ts.sticker_id
JOIN users          u_offerer  ON u_offerer.id  = ts.offered_by_user_id
WHERE t.deleted_at IS NULL;
GO


-- ── B2. v_pending_trades ──────────────────────────────────────
--  ARRAY_AGG(... ORDER BY ...) FILTER (WHERE ...) →
--  STRING_AGG(... , ',') WITHIN GROUP (ORDER BY ...) con CASE WHEN
--  Nota: STRING_AGG no admite FILTER directo; se usa una subconsulta
--  por cada lado del trade para mantener la lógica limpia.
IF OBJECT_ID('v_pending_trades', 'V') IS NOT NULL DROP VIEW v_pending_trades;
GO
CREATE VIEW v_pending_trades AS
SELECT
    t.id                        AS trade_id,
    t.created_at                AS trade_created_at,
    t.sender_user_id,
    u_sender.username           AS sender_username,
    t.receiver_user_id,
    u_receiver.username         AS receiver_username,
    -- Figuritas ofrecidas (trade_side = 'offering')
    (
        SELECT STRING_AGG(s2.code, ',') WITHIN GROUP (ORDER BY s2.code)
        FROM trade_stickers ts2
        JOIN stickers s2 ON s2.id = ts2.sticker_id
        WHERE ts2.trade_id   = t.id
          AND ts2.trade_side = N'offering'
    )                           AS offering_sticker_codes,
    -- Figuritas pedidas (trade_side = 'requesting')
    (
        SELECT STRING_AGG(s3.code, ',') WITHIN GROUP (ORDER BY s3.code)
        FROM trade_stickers ts3
        JOIN stickers s3 ON s3.id = ts3.sticker_id
        WHERE ts3.trade_id   = t.id
          AND ts3.trade_side = N'requesting'
    )                           AS requesting_sticker_codes
FROM trades t
JOIN users u_sender   ON u_sender.id   = t.sender_user_id
JOIN users u_receiver ON u_receiver.id = t.receiver_user_id
WHERE t.trade_status = N'pending'
  AND t.deleted_at   IS NULL;
GO


-- ── B3. v_trade_history ───────────────────────────────────────
--  ORDER BY ... NULLS LAST: en SQL Server DESC ya deja NULLs al final
--  en completed_at, así que ORDER BY se elimina de la vista.
IF OBJECT_ID('v_trade_history', 'V') IS NOT NULL DROP VIEW v_trade_history;
GO
CREATE VIEW v_trade_history AS
SELECT
    t.id                    AS trade_id,
    t.trade_status,
    t.created_at,
    t.completed_at,
    t.sender_user_id,
    u_sender.username       AS sender_username,
    t.receiver_user_id,
    u_receiver.username     AS receiver_username,
    COUNT(ts.id)            AS stickers_involved
FROM trades t
JOIN users          u_sender   ON u_sender.id   = t.sender_user_id
JOIN users          u_receiver ON u_receiver.id = t.receiver_user_id
JOIN trade_stickers ts         ON ts.trade_id   = t.id
WHERE t.trade_status IN (N'accepted', N'rejected', N'cancelled')
  AND t.deleted_at   IS NULL
GROUP BY
    t.id, t.trade_status, t.created_at, t.completed_at,
    t.sender_user_id,   u_sender.username,
    t.receiver_user_id, u_receiver.username;
GO


-- ============================================================
--  C. COMPRAS Y SOBRES
-- ============================================================

-- ── C1. v_purchases_detail ────────────────────────────────────
IF OBJECT_ID('v_purchases_detail', 'V') IS NOT NULL DROP VIEW v_purchases_detail;
GO
CREATE VIEW v_purchases_detail AS
SELECT
    p.id                    AS purchase_id,
    p.user_id,
    u.username,
    p.purchase_status,
    p.purchased_at,
    p.total_coins,
    pi.id                   AS item_id,
    sp.id                   AS pack_id,
    sp.name                 AS pack_name,
    sp.sticker_quantity     AS stickers_per_pack,
    pi.quantity             AS packs_bought,
    pi.subtotal_coins
FROM purchases      p
JOIN users          u  ON u.id           = p.user_id
JOIN purchase_items pi ON pi.purchase_id = p.id
JOIN sticker_packs  sp ON sp.id          = pi.pack_id
WHERE u.deleted_at IS NULL;
GO


-- ── C2. v_pack_opening_detail ─────────────────────────────────
IF OBJECT_ID('v_pack_opening_detail', 'V') IS NOT NULL DROP VIEW v_pack_opening_detail;
GO
CREATE VIEW v_pack_opening_detail AS
SELECT
    po.id               AS opening_id,
    po.opened_at,
    po.user_id,
    u.username,
    po.pack_id,
    sp.name             AS pack_name,
    sp.sticker_quantity AS expected_quantity,
    pos.sticker_id,
    s.code              AS sticker_code,
    s.name              AS sticker_name,
    s.sticker_type,
    s.rarity,
    s.image_url,
    s.market_value_coins
FROM pack_openings         po
JOIN users                 u   ON u.id   = po.user_id
JOIN sticker_packs         sp  ON sp.id  = po.pack_id
JOIN pack_opening_stickers pos ON pos.pack_opening_id = po.id
JOIN stickers              s   ON s.id   = pos.sticker_id
WHERE u.deleted_at IS NULL;
GO


-- ── C3. v_pack_opening_summary ────────────────────────────────
--  FILTER (WHERE ...) → CASE WHEN dentro de COUNT/SUM
IF OBJECT_ID('v_pack_opening_summary', 'V') IS NOT NULL DROP VIEW v_pack_opening_summary;
GO
CREATE VIEW v_pack_opening_summary AS
SELECT
    po.id                       AS opening_id,
    po.opened_at,
    po.user_id,
    u.username,
    sp.name                     AS pack_name,
    COUNT(pos.sticker_id)       AS total_stickers_received,
    -- duplicado = ya existe en el álbum con quantity > 1
    COUNT(CASE WHEN als.id IS NOT NULL AND als.quantity > 1
               THEN pos.sticker_id END)     AS duplicates_received,
    -- nueva = no existe en el álbum
    COUNT(CASE WHEN als.id IS NULL
               THEN pos.sticker_id END)     AS new_stickers_received,
    COALESCE(SUM(s.market_value_coins), 0)  AS total_market_value
FROM pack_openings         po
JOIN users                 u   ON u.id               = po.user_id
JOIN sticker_packs         sp  ON sp.id              = po.pack_id
JOIN pack_opening_stickers pos ON pos.pack_opening_id = po.id
JOIN stickers              s   ON s.id               = pos.sticker_id
LEFT JOIN albums           a   ON a.user_id          = po.user_id
LEFT JOIN album_stickers   als ON als.album_id       = a.id
                               AND als.sticker_id    = pos.sticker_id
WHERE u.deleted_at IS NULL
GROUP BY po.id, po.opened_at, po.user_id, u.username, sp.name;
GO


-- ── C4. v_user_spending ───────────────────────────────────────
--  FILTER (WHERE ...) → CASE WHEN dentro de SUM/COUNT
IF OBJECT_ID('v_user_spending', 'V') IS NOT NULL DROP VIEW v_user_spending;
GO
CREATE VIEW v_user_spending AS
SELECT
    u.id                        AS user_id,
    u.username,
    u.coins                     AS current_coins,
    COALESCE(SUM(CASE WHEN p.purchase_status = N'completed'
                      THEN p.total_coins END), 0)       AS total_coins_spent,
    COUNT(DISTINCT CASE WHEN p.purchase_status = N'completed'
                        THEN p.id END)                  AS completed_purchases,
    COUNT(DISTINCT po.id)       AS total_packs_opened,
    COUNT(pos.sticker_id)       AS total_stickers_received
FROM users u
LEFT JOIN purchases             p   ON p.user_id           = u.id
LEFT JOIN pack_openings         po  ON po.user_id          = u.id
LEFT JOIN pack_opening_stickers pos ON pos.pack_opening_id = po.id
WHERE u.deleted_at IS NULL
GROUP BY u.id, u.username, u.coins;
GO


-- ============================================================
--  D. USUARIOS
-- ============================================================

-- ── D1. v_active_users ────────────────────────────────────────
IF OBJECT_ID('v_active_users', 'V') IS NOT NULL DROP VIEW v_active_users;
GO
CREATE VIEW v_active_users AS
SELECT
    u.id                        AS user_id,
    u.username,
    u.email,
    u.coins,
    u.created_at,
    c.name                      AS country_name,
    c.fifa_code,
    c.flag_url,
    a.id                        AS album_id,
    a.completion_percentage,
    COUNT(DISTINCT ua.achievement_id) AS achievements_unlocked
FROM users u
LEFT JOIN countries         c  ON c.id     = u.country_id
LEFT JOIN albums            a  ON a.user_id = u.id
LEFT JOIN user_achievements ua ON ua.user_id = u.id
WHERE u.deleted_at IS NULL
GROUP BY
    u.id, u.username, u.email, u.coins, u.created_at,
    c.name, c.fifa_code, c.flag_url,
    a.id, a.completion_percentage;
GO


-- ── D2. v_user_achievements_detail ───────────────────────────
IF OBJECT_ID('v_user_achievements_detail', 'V') IS NOT NULL DROP VIEW v_user_achievements_detail;
GO
CREATE VIEW v_user_achievements_detail AS
SELECT
    u.id                AS user_id,
    u.username,
    ach.id              AS achievement_id,
    ach.title,
    ach.description,
    ach.reward_coins,
    ua.unlocked_at
FROM user_achievements ua
JOIN users        u   ON u.id   = ua.user_id
JOIN achievements ach ON ach.id = ua.achievement_id
WHERE u.deleted_at IS NULL;
GO


-- ============================================================
--  ÍNDICE DE VISTAS
-- ============================================================
--
--  MÓDULO A – ÁLBUM Y FIGURITAS
--    missing_stickers          → figuritas que faltan por álbum
--    v_album_stickers_detail   → figuritas obtenidas con detalle completo
--    v_album_summary           → progreso del álbum en tiempo real
--    v_duplicated_stickers     → duplicados disponibles para tradear
--    v_sticker_catalog         → catálogo completo de figuritas activas
--
--  MÓDULO B – TRADES
--    v_trades_detail           → detalle completo por trade
--    v_pending_trades          → trades pendientes de respuesta
--    v_trade_history           → historial de trades finalizados
--
--  MÓDULO C – COMPRAS Y SOBRES
--    v_purchases_detail        → historial de compras con ítems
--    v_pack_opening_detail     → figuritas que salieron en cada apertura
--    v_pack_opening_summary    → resumen nuevas vs duplicadas por apertura
--    v_user_spending           → gasto total y estadísticas por usuario
--
--  MÓDULO D – USUARIOS
--    v_active_users            → usuarios activos con país y álbum
--    v_user_achievements_detail → logros desbloqueados con detalle
--
-- ============================================================
--  FIN DEL SCRIPT DE VISTAS – SQL Server
-- ============================================================