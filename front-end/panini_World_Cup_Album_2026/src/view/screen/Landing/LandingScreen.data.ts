import { Colors as C } from '../../../constants/colors';

export const COLOR_STRIP = [C.orange, C.lime, C.blue, C.purple, C.red, C.gold];

export const COUNTRIES = [
  'Argentina 🇦🇷', 'Brasil 🇧🇷', 'Francia 🇫🇷', 'Colombia 🇨🇴',
  'España 🇪🇸', 'México 🇲🇽', 'Alemania 🇩🇪', 'Portugal 🇵🇹',
  'Uruguay 🇺🇾', 'Japón 🇯🇵', 'Marruecos 🇲🇦', 'USA 🇺🇸',
];

export const STATS: { value: string; label: string; color: string }[] = [
  { value: '700', label: 'Stickers',   color: C.orange },
  { value: '48',  label: 'Selecciones', color: C.blue   },
  { value: '3',   label: 'Sedes',       color: C.purple },
  { value: '104', label: 'Partidos',    color: C.lime   },
];

export const FEATURES: { icon: string; title: string; desc: string; accent: string; bg: string }[] = [
  { icon: 'bookmark-outline',      title: 'Registra',     desc: 'Marca tus figuritas y controla tu progreso.',          accent: C.orange, bg: '#fff5f0' },
  { icon: 'search-outline',        title: 'Busca',        desc: 'Por número, jugador o selección.',                     accent: C.blue,   bg: '#f0f6ff' },
  { icon: 'repeat-outline',        title: 'Intercambia',  desc: 'Conecta con coleccionistas que tienen tus faltantes.', accent: C.lime,   bg: '#f6fadf' },
  { icon: 'stats-chart-outline',   title: 'Estadísticas', desc: 'Visualiza tu progreso por selección o grupo.',         accent: C.purple, bg: '#f7f0ff' },
];

export const MINI_STATS: { value: string; label: string; color: string }[] = [
  { value: '238', label: 'Pegadas',   color: C.lime   },
  { value: '94',  label: 'Repetidas', color: C.gold   },
  { value: '462', label: 'Faltantes', color: C.orange },
];

export const CTA_PILLS: { icon: string; label: string }[] = [
  { icon: 'football-outline',      label: '700 Stickers'    },
  { icon: 'earth-outline',         label: '48 selecciones'  },
  { icon: 'repeat-outline',        label: 'Intercambios'    },
];