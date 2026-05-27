import { Colors as C } from '../../../constants/colors';

export const COLOR_STRIP = [C.orange, C.lime, C.blue, C.purple, C.red, C.gold];

export const COUNTRIES = [
  'Argentina 🇦🇷', 'Brasil 🇧🇷', 'Francia 🇫🇷', 'Colombia 🇨🇴',
  'España 🇪🇸', 'México 🇲🇽', 'Alemania 🇩🇪', 'Portugal 🇵🇹',
  'Uruguay 🇺🇾', 'Japón 🇯🇵', 'Marruecos 🇲🇦', 'USA 🇺🇸',
];

export const STATS: { value: string; label: string; color: string }[] = [
  { value: '700', label: 'Figuritas',   color: C.orange },
  { value: '48',  label: 'Selecciones', color: C.blue   },
  { value: '3',   label: 'Sedes',       color: C.purple },
  { value: '104', label: 'Partidos',    color: C.lime   },
];

export const FEATURES: { emoji: string; title: string; desc: string; accent: string; bg: string }[] = [
  { emoji: '📋', title: 'Registra',     desc: 'Marca tus figuritas y controla tu progreso.',          accent: C.orange, bg: '#fff5f0' },
  { emoji: '🔍', title: 'Busca',        desc: 'Por número, jugador o selección.',                     accent: C.blue,   bg: '#f0f6ff' },
  { emoji: '🔄', title: 'Intercambia',  desc: 'Conecta con coleccionistas que tienen tus faltantes.', accent: C.lime,   bg: '#f6fadf' },
  { emoji: '📊', title: 'Estadísticas', desc: 'Visualiza tu progreso por selección o grupo.',         accent: C.purple, bg: '#f7f0ff' },
];

export const MINI_STATS: { value: string; label: string; color: string }[] = [
  { value: '238', label: 'Pegadas',   color: C.lime   },
  { value: '94',  label: 'Repetidas', color: C.gold   },
  { value: '462', label: 'Faltantes', color: C.orange },
];

export const STICKERS: { num: string; flag: string; name: string; team: string; from: string; to: string; labelColor: string }[] = [
  { num: '#001', flag: '🇦🇷', name: 'Lionel Messi', team: 'Argentina', from: C.blue,    to: '#002060', labelColor: C.gold  },
  { num: '#047', flag: '🇧🇷', name: 'Vinicius Jr.', team: 'Brasil',    from: C.orange,  to: '#8a2000', labelColor: C.white },
  { num: '#112', flag: '🇫🇷', name: 'K. Mbappé',    team: 'Francia',   from: C.purple,  to: '#2a0038', labelColor: C.lime  },
  { num: '#089', flag: '🇨🇴', name: 'L. Díaz',      team: 'Colombia',  from: '#c8a200', to: '#7a6000', labelColor: C.white },
];

export const CTA_PILLS: string[] = [
  '⚽ 700 figuritas',
  '🌍 48 selecciones',
  '🔄 Intercambios',
];