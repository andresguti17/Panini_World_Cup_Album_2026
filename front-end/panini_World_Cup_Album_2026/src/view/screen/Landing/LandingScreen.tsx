import React, { useEffect, useRef } from "react";
import { Ionicons } from "@expo/vector-icons";
import { useNavigation } from '@react-navigation/native';
import { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { RootStackParamList } from '../../../navigations/AppNavigator';
import {
  View,
  Text,
  ScrollView,
  TouchableOpacity,
  Animated,
} from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Colors as C } from "../../../constants/colors";
import { s } from "./LandingScreen.styles";
import {
  COLOR_STRIP,
  COUNTRIES,
  STATS,
  FEATURES,
  MINI_STATS,
  CTA_PILLS,
} from "./LandingScreen.data";

// ── Sub-componentes ────────────────────────────────────────────────────────

function Nav() {
  const navigation = useNavigation<NativeStackNavigationProp<RootStackParamList>>();

  return (
    <View style={s.nav}>
      <Text style={s.navLogo}>
        Panini <Text style={s.navLogoAccent}>WC 2026</Text>
      </Text>
    </View>
  );
}

function Hero() {
  const b1 = useRef(new Animated.Value(0)).current;
  const b2 = useRef(new Animated.Value(0)).current;
  const b3 = useRef(new Animated.Value(0)).current;
  const b4 = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    const anim = (val: Animated.Value, duration: number) =>
      Animated.loop(
        Animated.sequence([
          Animated.timing(val, { toValue: 1, duration, useNativeDriver: true }),
          Animated.timing(val, { toValue: 0, duration, useNativeDriver: true }),
        ]),
      );
    Animated.parallel([
      anim(b1, 5000),
      anim(b2, 7000),
      anim(b3, 6000),
      anim(b4, 4200),
    ]).start();
  }, []);

  const move = (val: Animated.Value, range: number) =>
    val.interpolate({ inputRange: [0, 1], outputRange: [0, range] });

  return (
    <View style={s.hero}>
      <Animated.View
        style={[
          s.heroBubble,
          {
            width: 300,
            height: 300,
            backgroundColor: C.purple,
            top: -80,
            left: -80,
          },
          {
            transform: [
              { translateY: move(b1, 50) },
              { translateX: move(b1, 30) },
            ],
          },
        ]}
      />
      <Animated.View
        style={[
          s.heroBubble,
          {
            width: 200,
            height: 200,
            backgroundColor: C.blue,
            bottom: -60,
            right: -40,
          },
          {
            transform: [
              { translateY: move(b2, -60) },
              { translateX: move(b2, -30) },
            ],
          },
        ]}
      />
      <Animated.View
        style={[
          s.heroBubble,
          {
            width: 120,
            height: 120,
            backgroundColor: C.orange,
            top: 30,
            right: "15%" as any,
          },
          {
            transform: [
              { translateY: move(b3, 40) },
              { translateX: move(b3, 25) },
            ],
          },
        ]}
      />
      <Animated.View
        style={[
          s.heroBubble,
          {
            width: 160,
            height: 160,
            backgroundColor: C.purple,
            top: "40%" as any,
            left: "35%" as any,
          },
          {
            transform: [
              { translateY: move(b4, -35) },
              { translateX: move(b4, 20) },
            ],
          },
        ]}
      />

      <View style={s.heroBadge}>
        <Text style={s.heroBadgeText}>Colección Oficial FIFA · 2026</Text>
      </View>
      <Text style={s.heroTitle}>
        <Text style={{ color: C.orange }}>Tu álbum{"\n"}</Text>
        {"Panini\n"}
        <Text style={{ color: C.lime }}>digital</Text>
      </Text>
      <Text style={s.heroSub}>
        Registra tus figuritas, encuentra tus faltantes e intercambia con
        coleccionistas de todo el mundo.
      </Text>
      <View style={s.heroBtns}>
        <TouchableOpacity style={s.btnPrimary}>
          <Text style={s.btnPrimaryText}>Comenzar ahora</Text>
        </TouchableOpacity>
        <TouchableOpacity style={s.btnSecondary}>
          <Text style={s.btnSecondaryText}>Ver demo</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
}

function ColorStrip() {
  return (
    <View style={s.colorStrip}>
      {COLOR_STRIP.map((color, i) => (
        <View key={i} style={[s.colorSeg, { backgroundColor: color }]} />
      ))}
    </View>
  );
}

function CountryStrip() {
  const translateX = useRef(new Animated.Value(0)).current;
  const ITEM_WIDTH = 180;
  const TOTAL_WIDTH = COUNTRIES.length * ITEM_WIDTH;

  useEffect(() => {
    const run = () => {
      translateX.setValue(0);
      Animated.timing(translateX, {
        toValue: -TOTAL_WIDTH,
        duration: COUNTRIES.length * 1500,
        useNativeDriver: true,
      }).start(({ finished }) => {
        if (finished) run();
      });
    };
    run();
  }, []);

  const doubled = [...COUNTRIES, ...COUNTRIES];

  return (
    <View style={[s.countryStrip, { overflow: "hidden" }]}>
      <Animated.View
        style={{ flexDirection: "row", transform: [{ translateX }] }}
      >
        {doubled.map((name: string, i: number) => (
          <View
            key={i}
            style={{
              width: ITEM_WIDTH,
              alignItems: "center",
              justifyContent: "center",
              paddingVertical: 13,
              borderRightWidth: 2,
              borderRightColor: "rgba(255,255,255,0.25)",
            }}
          >
            <Text style={s.countryItem}>{name}</Text>
          </View>
        ))}
      </Animated.View>
    </View>
  );
}

function StatsRow() {
  return (
    <View style={s.statsRow}>
      {STATS.map((st, i) => (
        <View key={i} style={s.statCard}>
          <Text style={[s.statNum, { color: st.color }]}>{st.value}</Text>
          <Text style={s.statLbl}>{st.label}</Text>
        </View>
      ))}
    </View>
  );
}

function FeaturesSection() {
  return (
    <View style={s.featSection}>
      <Text style={s.sectionTag}>¿Qué puedes hacer?</Text>
      <Text style={s.sectionTitle}>Todo tu álbum{"\n"}en un solo lugar</Text>
      <View style={s.featGrid}>
        {FEATURES.map((f, i) => (
          <View
            key={i}
            style={[
              s.featCard,
              { backgroundColor: f.bg, borderTopColor: f.accent },
            ]}
          >
            <View style={[s.featIconBox, { backgroundColor: f.accent + "22" }]}>
              <Ionicons name={f.icon as any} size={24} color={f.accent} />
            </View>
            <Text style={s.featTitle}>{f.title}</Text>
            <Text style={s.featDesc}>{f.desc}</Text>
          </View>
        ))}
      </View>
    </View>
  );
}

function CtaSection() {
  return (
    <View style={s.ctaSection}>
      <Text style={s.ctaTitle}>
        {"¿Listo para\n"}
        <Text style={{ color: C.orange }}>completar tu álbum?</Text>
      </Text>
      <Text style={s.ctaSub}>
        Únete a miles de coleccionistas del Mundial 2026
      </Text>

      <View style={s.ctaPills}>
        {CTA_PILLS.map((pill, i) => (
          <View key={i} style={s.pill}>
            <Ionicons
              name={pill.icon as any}
              size={16}
              color="#555"
              style={{ marginRight: 6 }}
            />
            <Text style={s.pillText}>{pill.label}</Text>
          </View>
        ))}
      </View>

      <TouchableOpacity style={s.ctaBtn}>
        <Ionicons
          name="trophy-outline"
          size={20}
          color={C.white}
          style={{ marginRight: 8 }}
        />
        <Text style={s.ctaBtnText}>Empezar gratis</Text>
      </TouchableOpacity>
    </View>
  );
}

function Footer() {
  const dots = [C.orange, C.lime, C.blue, C.purple];
  return (
    <View style={s.footer}>
      <Text style={s.footerLogo}>
        Panini <Text style={{ color: "rgba(255,255,255,0.4)" }}>WC 2026</Text>
      </Text>
      <View style={s.footerDots}>
        {dots.map((color, i) => (
          <View key={i} style={[s.footerDot, { backgroundColor: color }]} />
        ))}
      </View>
      <Text style={s.footerCopy}>© 2026 Panini WC Album · SENA</Text>
    </View>
  );
}

// ── Pantalla principal ─────────────────────────────────────────────────────

export default function LandingScreen() {
  return (
    <SafeAreaView style={s.safe} edges={["top"]}>
      <Nav />
      <ScrollView style={s.scroll} showsVerticalScrollIndicator={false}>
        <Hero />
        <ColorStrip />
        <CountryStrip />
        <StatsRow />
        <FeaturesSection />
        <CtaSection />
        <Footer />
      </ScrollView>
    </SafeAreaView>
  );
}
