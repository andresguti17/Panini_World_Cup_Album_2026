import { StyleSheet, Platform } from 'react-native';
import { Colors as C } from '../../../constants/colors';

const WEB = Platform.OS === 'web';

export const s = StyleSheet.create({
  // ── Layout
  safe:   { flex: 1, backgroundColor: C.offwhite },
  scroll: { flex: 1 },

  // ── Nav
  nav:           { backgroundColor: C.dark, flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', paddingHorizontal: 20, paddingVertical: 14 },
  navLogo:       { fontSize: 20, fontWeight: '800', color: C.white, letterSpacing: 1 },
  navLogoAccent: { color: C.orange },
  navBtn:        { backgroundColor: C.orange, borderRadius: 30, paddingHorizontal: 18, paddingVertical: 8 },
  navBtnText:    { fontSize: 13, fontWeight: '800', color: C.white },

  // ── Hero
  hero:          { backgroundColor: C.dark, paddingHorizontal: 24, paddingTop: 48, paddingBottom: 48, overflow: 'hidden' },
  heroBubble:    { position: 'absolute', borderRadius: 999, opacity: 0.18 },
  heroBadge:     { alignSelf: 'flex-start', backgroundColor: C.orange, borderRadius: 30, paddingHorizontal: 16, paddingVertical: 6, marginBottom: 20 },
  heroBadgeText: { fontSize: 11, fontWeight: '800', color: C.white, letterSpacing: 1.2 },
  heroTitle:     { fontSize: WEB ? 80 : 54, fontWeight: '900', color: C.white, lineHeight: WEB ? 78 : 56, marginBottom: 16 },
  heroSub:       { fontSize: 15, color: 'rgba(255,255,255,0.65)', lineHeight: 24, marginBottom: 32, maxWidth: 420 },
  heroBtns:      { flexDirection: 'row', gap: 12, flexWrap: 'wrap' },

  // ── Botones
  btnPrimary:       { backgroundColor: C.orange, borderRadius: 50, paddingHorizontal: 28, paddingVertical: 13 },
  btnPrimaryText:   { fontSize: 15, fontWeight: '800', color: C.white },
  btnSecondary:     { borderRadius: 50, paddingHorizontal: 26, paddingVertical: 12, borderWidth: 2, borderColor: 'rgba(255,255,255,0.3)' },
  btnSecondaryText: { fontSize: 15, fontWeight: '700', color: C.white },

  // ── Color strip
  colorStrip: { flexDirection: 'row', height: 7 },
  colorSeg:   { flex: 1 },

  // ── Country strip
  countryStrip: { backgroundColor: C.orange, paddingVertical: 13 },
  countryRow:   { paddingHorizontal: 8 },
  countryItem:  { fontSize: 15, fontWeight: '800', color: C.white, paddingHorizontal: 20, borderRightWidth: 2, borderRightColor: 'rgba(255,255,255,0.25)' },

  // ── Stats
  statsRow: { backgroundColor: C.white, flexDirection: 'row', flexWrap: 'wrap' },
  statCard: { flex: 1, minWidth: 80, alignItems: 'center', paddingVertical: 18, paddingHorizontal: 8, borderRightWidth: 1, borderRightColor: '#eee' },
  statNum:  { fontSize: 38, fontWeight: '900', lineHeight: 42 },
  statLbl:  { fontSize: 10, fontWeight: '800', color: '#888', letterSpacing: 0.8, textTransform: 'uppercase', marginTop: 4, textAlign: 'center' },

  // ── Encabezados de sección
  sectionTag:   { fontSize: 11, fontWeight: '800', letterSpacing: 2, textTransform: 'uppercase', color: C.orange, marginBottom: 8 },
  sectionTitle: { fontSize: WEB ? 48 : 34, fontWeight: '900', color: C.dark, lineHeight: WEB ? 46 : 36, marginBottom: 24 },

  // ── Features
  featSection: { paddingHorizontal: 20, paddingVertical: 40, backgroundColor: C.offwhite },
  featGrid:    { flexDirection: 'row', flexWrap: 'wrap', gap: 14 },
  featCard:    { width: WEB ? 200 : '47%', borderRadius: 18, padding: 22, borderTopWidth: 4 },
  featEmoji:   { fontSize: 30, marginBottom: 12 },
  featTitle:   { fontSize: 15, fontWeight: '800', color: C.dark, marginBottom: 8 },
  featDesc:    { fontSize: 13, color: '#666', lineHeight: 20 },

  // ── Sección álbum
  albumSection: { backgroundColor: C.dark, paddingHorizontal: 20, paddingVertical: 40 },
  albumTag:     { fontSize: 11, fontWeight: '800', letterSpacing: 2, textTransform: 'uppercase', color: C.lime, marginBottom: 8 },
  albumTitle:   { fontSize: WEB ? 48 : 34, fontWeight: '900', color: C.white, lineHeight: WEB ? 46 : 36, marginBottom: 24 },

  // ── Progreso
  progressBox:    { backgroundColor: 'rgba(255,255,255,0.07)', borderRadius: 16, padding: 20, borderWidth: 1, borderColor: 'rgba(255,255,255,0.1)', marginBottom: 16 },
  progressHeader: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', marginBottom: 12 },
  progressLabel:  { fontSize: 13, fontWeight: '700', color: 'rgba(255,255,255,0.8)' },
  progressPct:    { fontSize: 22, fontWeight: '900', color: C.lime },
  progressTrack:  { height: 10, backgroundColor: 'rgba(255,255,255,0.1)', borderRadius: 10, overflow: 'hidden' },
  progressFill:   { height: '100%', backgroundColor: C.lime, borderRadius: 10 },
  progressSub:    { fontSize: 12, color: 'rgba(255,255,255,0.4)', marginTop: 8 },

  // ── Mini stats
  miniRow:  { flexDirection: 'row', gap: 10, marginBottom: 28 },
  miniCard: { flex: 1, backgroundColor: 'rgba(255,255,255,0.07)', borderRadius: 12, padding: 14, alignItems: 'center', borderWidth: 1, borderColor: 'rgba(255,255,255,0.08)' },
  miniNum:  { fontSize: 28, fontWeight: '900', lineHeight: 30 },
  miniLbl:  { fontSize: 10, fontWeight: '800', color: 'rgba(255,255,255,0.45)', textTransform: 'uppercase', letterSpacing: 0.5, marginTop: 2 },

  // ── Figuritas
  stickerScroll: { paddingVertical: 8 },
  stickerCard:   { width: 130, borderRadius: 14, overflow: 'hidden', marginRight: 12 },
  stickerTop:    { padding: 16, alignItems: 'center' },
  stickerNum:    { fontSize: 9, fontWeight: '800', color: 'rgba(255,255,255,0.7)', letterSpacing: 1, marginBottom: 6 },
  stickerFlag:   { fontSize: 36, marginBottom: 6 },
  stickerName:   { fontSize: 12, fontWeight: '800', color: C.white, textAlign: 'center' },
  stickerTeam:   { fontSize: 10, color: 'rgba(255,255,255,0.65)', marginTop: 2 },
  stickerBottom: { paddingVertical: 7, alignItems: 'center' },
  stickerLabel:  { fontSize: 9, fontWeight: '800', letterSpacing: 1.2, textTransform: 'uppercase' },

  // ── CTA
  ctaSection: { backgroundColor: C.offwhite, paddingHorizontal: 24, paddingVertical: 60, alignItems: 'center' },
  ctaTitle:   { fontSize: WEB ? 60 : 38, fontWeight: '900', color: C.dark, textAlign: 'center', lineHeight: WEB ? 58 : 40, marginBottom: 12 },
  ctaSub:     { fontSize: 15, color: '#777', marginBottom: 24, textAlign: 'center' },
  ctaPills:   { flexDirection: 'row', flexWrap: 'wrap', gap: 8, justifyContent: 'center', marginBottom: 28 },
  pill:       { backgroundColor: C.white, borderWidth: 2, borderColor: '#eee', borderRadius: 50, paddingHorizontal: 16, paddingVertical: 8 },
  pillText:   { fontSize: 13, fontWeight: '700', color: '#555' },
  ctaBtn:     { backgroundColor: C.orange, borderRadius: 50, paddingHorizontal: 44, paddingVertical: 16 },
  ctaBtnText: { fontSize: 17, fontWeight: '800', color: C.white },

  // ── Footer
  footer:     { backgroundColor: C.dark, paddingHorizontal: 24, paddingVertical: 26, flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap', gap: 12 },
  footerLogo: { fontSize: 18, fontWeight: '900', color: C.orange },
  footerDots: { flexDirection: 'row', gap: 8 },
  footerDot:  { width: 10, height: 10, borderRadius: 5 },
  footerCopy: { fontSize: 12, color: 'rgba(255,255,255,0.35)' },
});