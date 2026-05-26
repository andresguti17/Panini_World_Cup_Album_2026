import React from "react";
import {
    View,
    Text,
    ScrollView,
    TouchableOpacity,
    StyleSheet,
    SafeAreaView,
    StatusBar,
    Dimensions,
} from "react-native";

const { width } = Dimensions.get("window");

// ── Types ──────────────────────────────────────────────────────────────────

type StatCardProps = {
    value: number;
    label: string;
    color: string;
};

type ActionRowProps = {
    emoji: string;
    title: string;
    sub: string;
    onPress?: () => void;
};

// ── Sub-components ─────────────────────────────────────────────────────────

function StatCard({ value, label, color }: StatCardProps) {
    return (
        <View style={[styles.statCard, { borderTopColor: color }]}>
            <Text style={[styles.statVal, { color }]}>{value}</Text>
            <Text style={styles.statLbl}>{label}</Text>
        </View>
    );
}

function ActionRow({ emoji, title, sub, onPress }: ActionRowProps) {
    return (
        <TouchableOpacity style={styles.actionRow} onPress={onPress} activeOpacity={0.85}>
            <Text style={styles.actionEmoji}>{emoji}</Text>
            <View style={styles.actionText}>
                <Text style={styles.actionTitle}>{title}</Text>
                <Text style={styles.actionSub} numberOfLines={1}>{sub}</Text>
            </View>
            <Text style={styles.actionArrow}>›</Text>
        </TouchableOpacity>
    );
}

// ── Main screen ────────────────────────────────────────────────────────────

export default function HomeScreen() {
    const totalStickers    = 700;
    const ownedStickers    = 238;
    const duplicateStickers = 94;
    const missingStickers  = totalStickers - ownedStickers;
    const progressPercent  = Math.round((ownedStickers / totalStickers) * 100);

    return (
        <SafeAreaView style={styles.safe}>
            <StatusBar barStyle="light-content" backgroundColor="#208AEF" />

            <View style={{
                backgroundColor: "#208AEF",
                display: "flex",
                flexDirection: "row"}}>
                <Text>Álbum WC 2026</Text>
                <View>
                    <View>
                        <Text>Iniciar sesión</Text>
                    </View>
                    <View>
                        <Text>Registrarse</Text>
                    </View>
                </View>
            </View>

            <ScrollView
                style={styles.scroll}
                contentContainerStyle={styles.scrollContent}
                showsVerticalScrollIndicator={false}
            >

                {/* ── Hero ── */}
                <View style={styles.hero}>
                    <View style={styles.heroTop}>
                        <View>
                            <Text style={styles.heroLabel}>Mi álbum</Text>
                            <Text style={styles.heroTitle}>World Cup 2026 🏆</Text>
                        </View>
                        <View style={styles.avatar}>
                            <Text style={styles.avatarText}>⚽</Text>
                        </View>
                    </View>

                    <View style={styles.progressBox}>
                        <View style={styles.progressHeader}>
                            <Text style={styles.progressLabel}>Progreso del álbum</Text>
                            <Text style={styles.progressPct}>{progressPercent}%</Text>
                        </View>
                        <View style={styles.track}>
                            <View style={[styles.fill, { width: `${progressPercent}%` }]} />
                        </View>
                        <Text style={styles.progressSub}>
                            {ownedStickers} / {totalStickers} figuritas pegadas
                        </Text>
                    </View>
                </View>

                {/* ── Stats ── */}
                <Text style={styles.sectionLabel}>Resumen</Text>
                <View style={styles.statsGrid}>
                    <StatCard value={ownedStickers}      label="Pegadas"   color="#208AEF" />
                    <StatCard value={duplicateStickers}  label="Repetidas" color="#E9A520" />
                    <StatCard value={missingStickers}    label="Faltantes" color="#E24B4A" />
                </View>

                {/* ── Actions ── */}
                <Text style={styles.sectionLabel}>Acciones rápidas</Text>
                <View style={styles.actionsList}>
                    <ActionRow emoji="🔍" title="Buscar figurita"    sub="Encuentra por número o jugador" />
                    <ActionRow emoji="🔄" title="Mis repetidas"      sub="Ofrece o intercambia con amigos" />
                    <ActionRow emoji="📋" title="Lista de faltantes" sub="Exporta o comparte tu lista" />
                    <ActionRow emoji="🌍" title="Selecciones"         sub="Explora los 48 equipos" />
                </View>

                {/* ── Banner ── */}
                <View style={styles.banner}>
                    <Text style={styles.bannerIcon}>🎯</Text>
                    <View style={styles.bannerText}>
                        <Text style={styles.bannerTitle}>¡Conseguiste 3 nuevas!</Text>
                        <Text style={styles.bannerSub}>Pégalas en tu álbum ahora</Text>
                    </View>
                    <TouchableOpacity style={styles.bannerBtn} activeOpacity={0.85}>
                        <Text style={styles.bannerBtnText}>Ir</Text>
                    </TouchableOpacity>
                </View>

            </ScrollView>
        </SafeAreaView>
    );
}

// ── Styles ─────────────────────────────────────────────────────────────────

const styles = StyleSheet.create({

    // Layout
    safe: {
        flex: 1,
        backgroundColor: "#F0F6FF",
    },
    scroll: {
        flex: 1,
    },
    scrollContent: {
        paddingHorizontal: 16,
        paddingTop: 20,
        paddingBottom: 40,
    },

    // Hero
    hero: {
        backgroundColor: "#208AEF",
        borderRadius: 20,
        padding: 20,
        marginBottom: 24,
    },
    heroTop: {
        flexDirection: "row",
        justifyContent: "space-between",
        alignItems: "flex-start",
        marginBottom: 16,
    },
    heroLabel: {
        fontSize: 11,
        letterSpacing: 1.4,
        textTransform: "uppercase",
        color: "#BDDEFF",
        marginBottom: 4,
        fontWeight: "500",
    },
    heroTitle: {
        fontSize: 22,
        fontWeight: "700",
        color: "#ffffff",
        letterSpacing: -0.3,
    },
    avatar: {
        width: 46,
        height: 46,
        borderRadius: 23,
        backgroundColor: "rgba(255,255,255,0.2)",
        alignItems: "center",
        justifyContent: "center",
    },
    avatarText: {
        fontSize: 22,
    },

    // Progress
    progressBox: {
        backgroundColor: "rgba(255,255,255,0.15)",
        borderRadius: 12,
        padding: 14,
    },
    progressHeader: {
        flexDirection: "row",
        justifyContent: "space-between",
        marginBottom: 8,
    },
    progressLabel: {
        fontSize: 13,
        color: "#DDEEFF",
    },
    progressPct: {
        fontSize: 13,
        fontWeight: "600",
        color: "#ffffff",
    },
    track: {
        height: 7,
        backgroundColor: "rgba(255,255,255,0.25)",
        borderRadius: 4,
        marginBottom: 8,
        overflow: "hidden",
    },
    fill: {
        height: "100%",
        backgroundColor: "#ffffff",
        borderRadius: 4,
    },
    progressSub: {
        fontSize: 12,
        color: "#BDDEFF",
    },

    // Section label
    sectionLabel: {
        fontSize: 11,
        fontWeight: "600",
        letterSpacing: 1.2,
        textTransform: "uppercase",
        color: "#5A7A9A",
        marginBottom: 10,
    },

    // Stats
    statsGrid: {
        flexDirection: "row",
        gap: 10,
        marginBottom: 24,
    },
    statCard: {
        flex: 1,
        backgroundColor: "#ffffff",
        borderRadius: 14,
        borderWidth: 1,
        borderColor: "#E2EAF4",
        borderTopWidth: 3,
        padding: 14,
        alignItems: "center",
        gap: 4,
    },
    statVal: {
        fontSize: 26,
        fontWeight: "700",
        lineHeight: 28,
    },
    statLbl: {
        fontSize: 11,
        color: "#7A9AB8",
        fontWeight: "500",
    },

    // Actions
    actionsList: {
        gap: 8,
        marginBottom: 24,
    },
    actionRow: {
        backgroundColor: "#ffffff",
        borderWidth: 1,
        borderColor: "#E2EAF4",
        borderRadius: 14,
        paddingVertical: 13,
        paddingHorizontal: 16,
        flexDirection: "row",
        alignItems: "center",
        gap: 14,
    },
    actionEmoji: {
        fontSize: 22,
        lineHeight: 26,
    },
    actionText: {
        flex: 1,
    },
    actionTitle: {
        fontSize: 14,
        fontWeight: "600",
        color: "#1A3A5C",
        marginBottom: 2,
    },
    actionSub: {
        fontSize: 12,
        color: "#7A9AB8",
    },
    actionArrow: {
        fontSize: 22,
        color: "#B0C8E0",
    },

    // Banner
    banner: {
        backgroundColor: "#1A3A5C",
        borderRadius: 16,
        padding: 16,
        flexDirection: "row",
        alignItems: "center",
        gap: 12,
    },
    bannerIcon: {
        fontSize: 26,
    },
    bannerText: {
        flex: 1,
    },
    bannerTitle: {
        fontSize: 14,
        fontWeight: "600",
        color: "#ffffff",
        marginBottom: 2,
    },
    bannerSub: {
        fontSize: 12,
        color: "#7AABCC",
    },
    bannerBtn: {
        backgroundColor: "#208AEF",
        borderRadius: 20,
        paddingVertical: 8,
        paddingHorizontal: 20,
    },
    bannerBtnText: {
        fontSize: 13,
        fontWeight: "600",
        color: "#ffffff",
    },
});