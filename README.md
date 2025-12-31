# Zairly（ザイリー）

購入したモノ（主に消耗品）をチャットで管理する、AI在庫管理アプリです。

## 特徴

- データベースでモノの個数を管理
- フリーフォーマットで購入した・使用したモノおよび個数を入力
- 入力したモノがデータベース未登録なら新規作成、登録済みなら個数を更新
- 現在、モノの個数がどのくらい残っているかをチャットで問い合わせ可能

## 技術スタック

### フロントエンド
- Next.js 15 (App Router)
- TypeScript
- Tailwind CSS

### バックエンド
- Python 3.11+
- FastAPI
- Poetry

### プロンプト管理
- packages/prompts/ で一元管理
- システムプロンプト、テンプレート、辞書

### 開発環境
- Docker + Docker Compose

## プロジェクト構成

```
zairly/
├── apps/
│   ├── web/          # Next.js フロントエンド
│   └── api/          # FastAPI バックエンド
├── packages/
│   └── prompts/      # LLMプロンプト・辞書
├── infra/
│   └── docker/       # Docker設定
├── scripts/          # 開発用スクリプト
└── docs/             # ドキュメント
```

## セットアップ

### 前提条件

- Docker Desktop（または Docker + Docker Compose）
- Git

### 1. リポジトリのクローン

```bash
git clone <repository-url>
cd zairly
```

### 2. Docker環境で起動

本プロジェクトはDocker環境での開発を前提としています。

```bash
# 起動
./scripts/docker-dev.sh up

# ログ確認
./scripts/docker-dev.sh logs

# 停止
./scripts/docker-dev.sh down
```

アクセス先:
- フロントエンド: http://localhost:3000
- バックエンドAPI: http://localhost:8000
- APIドキュメント: http://localhost:8000/docs

詳細は [infra/docker/README.md](infra/docker/README.md) を参照してください。

## その他のコマンド

### Lint実行

```bash
./scripts/docker-dev.sh lint
```

### コンテナに入る

```bash
# APIコンテナ
./scripts/docker-dev.sh exec-api

# Webコンテナ
./scripts/docker-dev.sh exec-web
```

### イメージ再ビルド

```bash
./scripts/docker-dev.sh rebuild
```

### 完全クリーンアップ

```bash
./scripts/docker-dev.sh clean
```

## ドキュメント

- [仕様書](docs/SPECIFICATION.md)
- [開発者ガイド](docs/DEVEOPERS.md)
- [開発ガイドライン](CLAUDE.md)
- [タスク管理](docs/TODO.md)
- [Docker環境](infra/docker/README.md)
- [バックエンドREADME](apps/api/README.md)
- [フロントエンドREADME](apps/web/README.md)

## ライセンス

[LICENSE](LICENSE) を参照してください。
