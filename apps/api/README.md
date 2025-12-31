# Zairly API (Backend)

在庫管理アプリ Zairly のバックエンド API

## 技術スタック

- Python 3.11+
- FastAPI
- Poetry (パッケージ管理)
- Pydantic (スキーマ定義)

## セットアップ

### 1. 依存関係のインストール

```bash
poetry install
```

### 2. 環境変数の設定

```bash
cp .env.example .env
# .env を編集して必要な設定を追加
```

### 3. 開発サーバーの起動

```bash
poetry run uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

または、ルートディレクトリの開発スクリプトを使用:

```bash
# リポジトリルートから
./scripts/dev.sh
```

## API ドキュメント

サーバー起動後、以下のURLでAPIドキュメントを確認できます:

- Swagger UI: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc

## ディレクトリ構成

```
app/
├── main.py          # エントリポイント
├── api/             # APIエンドポイント
│   └── chat.py      # チャット関連エンドポイント
├── core/            # 設定・依存関係
│   └── config.py    # アプリケーション設定
├── schemas/         # Pydanticスキーマ
│   └── chat.py      # チャット関連スキーマ
└── services/        # ビジネスロジック
    └── nlp.py       # 自然言語処理サービス
```

## 開発

### Linting / Formatting

```bash
poetry run ruff check .
poetry run ruff format .
```

### テスト実行

```bash
poetry run pytest
```
