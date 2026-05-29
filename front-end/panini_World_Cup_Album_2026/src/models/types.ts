export interface AlbumStats {
  total: number;
  owned: number;
  duplicates: number;
  missing: number;
  progressPercent: number;
}

export interface Action {
  emoji: string;
  title: string;
  sub: string;
}

export interface User {
  id: number;
  username: string;
  email: string;
  avatarUrl?: string;
}