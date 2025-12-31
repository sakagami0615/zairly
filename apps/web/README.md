# Zairly Web (Frontend)

在庫管理アプリ Zairly のフロントエンド

## 技術スタック

- Next.js 15 (App Router)
- TypeScript
- Tailwind CSS
- React 19

## セットアップ

### 1. 依存関係のインストール

```bash
npm install
```

### 2. 環境変数の設定

```bash
cp .env.local.example .env.local
# .env.local を編集して必要な設定を追加
```

### 3. 開発サーバーの起動

```bash
npm run dev
```

または、ルートディレクトリの開発スクリプトを使用:

```bash
# リポジトリルートから
./scripts/dev.sh
```

ブラウザで http://localhost:3000 を開きます。

## スクリプト

- `npm run dev` - 開発サーバーを起動
- `npm run build` - プロダクションビルド
- `npm run start` - プロダクションサーバーを起動
- `npm run lint` - ESLintでコードをチェック

## ディレクトリ構成

```
app/
├── layout.tsx       # ルートレイアウト
├── page.tsx         # ホームページ
└── globals.css      # グローバルスタイル
```

## 設計方針

- UI とユーザインタラクションに専念
- すべてのデータ操作は FastAPI 経由で実行
- DB や永続層を直接操作しない
- 在庫計算ロジックをクライアント側で実装しない
