# Docker環境

Zairlyの開発環境をDockerで構築するための資材です。

## 構成

```
docker/
├── compose.dev.yml    # Docker Compose設定（開発用）
├── api/
│   └── Dockerfile     # FastAPI用Dockerfile
└── web/
    └── Dockerfile     # Next.js用Dockerfile
```

## 使用方法

### 1. Docker環境の起動

リポジトリルートから以下のコマンドを実行:

```bash
docker compose -f infra/docker/compose.dev.yml up -d
```

または、専用スクリプトを使用:

```bash
./scripts/docker-dev.sh up
```

### 2. ログの確認

```bash
docker compose -f infra/docker/compose.dev.yml logs -f
```

特定のサービスのみ:

```bash
docker compose -f infra/docker/compose.dev.yml logs -f api
docker compose -f infra/docker/compose.dev.yml logs -f web
```

### 3. Docker環境の停止

```bash
docker compose -f infra/docker/compose.dev.yml down
```

または:

```bash
./scripts/docker-dev.sh down
```

### 4. コンテナに入る

バックエンド:

```bash
docker compose -f infra/docker/compose.dev.yml exec api bash
```

フロントエンド:

```bash
docker compose -f infra/docker/compose.dev.yml exec web sh
```

## アクセス先

- フロントエンド: http://localhost:3000
- バックエンドAPI: http://localhost:8000
- APIドキュメント: http://localhost:8000/docs

## 注意事項

### ホットリロード

- バックエンド: `--reload` オプションにより、コード変更時に自動でリロードされます
- フロントエンド: Next.jsのdev serverにより、コード変更時に自動でリロードされます

### ボリュームマウント

- ローカルのコードがコンテナにマウントされているため、ローカルでの変更が即座に反映されます
- `node_modules`と`.next`は名前付きボリュームとして管理され、ホストとは分離されています

### 依存関係の更新

依存関係を追加した場合は、コンテナを再ビルドしてください:

```bash
docker compose -f infra/docker/compose.dev.yml up -d --build
```

## トラブルシューティング

### ポートが既に使用されている

既にポート3000や8000が使用されている場合は、`compose.dev.yml`のポート設定を変更してください。

### ボリュームの削除

コンテナとボリュームを完全に削除する場合:

```bash
docker compose -f infra/docker/compose.dev.yml down -v
```
