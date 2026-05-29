import { Colors as C } from '../../../constants/colors';

export const COLOR_STRIP = [C.orange, C.lime, C.blue, C.purple, C.red, C.gold];

export const COUNTRIES = [
  // CONMEBOL
  'Argentina ᴬᴿᴳ', 'Brasil ᴮᴿᴬ', 'Colombia ᶜᴼᴸ', 'Ecuador ᴱᶜᵁ',
  'Paraguay ᴾᴬᴿ', 'Uruguay ᵁᴿᵁ',

  // UEFA
  'Alemania ᴳᴱᴿ', 'Austria ᴬᵁᵀ', 'Bélgica ᴮᴱᴸ', 'Bosnia y Herz. ᴮᴵᴴ',
  'Croacia ᶜᴿᴼ', 'España ᴱˢᴾ', 'Escocia ˢᶜᴼ', 'Francia ᶠᴿᴬ',
  'Inglaterra ᴱᴺᴳ', 'Noruega ᴺᴼᴿ', 'Países Bajos ᴺᴱᴰ', 'Portugal ᴾᴼᴿ',
  'Rep. Checa ᶜᶻᴱ', 'Suecia ˢᵂᴱ', 'Suiza ˢᵁᴵ', 'Turquía ᵀᵁᴿ',

  // CAF
  'Argelia ᴬᴸᴳ', 'Cabo Verde ᶜᴾᵛ', 'Costa de Marfil ᶜᴵᵛ', 'Egipto ᴱᴳʸ',
  'Ghana ᴳᴴᴬ', 'Marruecos ᴹᴬᴿ', 'R.D. Congo ᶜᴼᴰ', 'Senegal ˢᴱᴺ',
  'Sudáfrica ᴿˢᴬ', 'Túnez ᵀᵁᴺ',

  // AFC
  'Arabia Saudita ᴷˢᴬ', 'Australia ᴬᵁˢ', 'Catar ᵠᴬᵀ', 'Corea del Sur ᴷᴼᴿ',
  'Irak ᴵᴿᵠ', 'Irán ᴵᴿᴺ', 'Japón ᴶᴾᴺ', 'Jordania ᴶᴼᴿ',
  'Uzbekistán ᵁᶻᴮ',

  // CONCACAF
  'Canadá ᶜᴬᴺ', 'Costa Rica ᶜᴿᶜ', 'Curazao ᶜᵁᵂ', 'Honduras ᴴᴼᴺ',
  'Jamaica ᴶᴬᴹ', 'México ᴹᴱˣ', 'Panamá ᴾᴬᴺ', 'USA ᵁˢᴬ',

  // OFC + Repechaje
  'Nueva Caledonia ᴺᶜᴸ', 'Surinam ˢᵁᴿ',
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