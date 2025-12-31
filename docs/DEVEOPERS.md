# 開発者向けドキュメント

このドキュメントは、Zairlyの開発に参加する開発者向けの情報をまとめています。

## 目次

- [環境構築](#環境構築)
- [アプリケーションの起動方法](#アプリケーションの起動方法)
- [開発ワークフロー](#開発ワークフロー)
- [コーディング規約](#コーディング規約)
- [トラブルシューティング](#トラブルシューティング)

---

## 環境構築

### 前提条件

- Docker Desktop（または Docker + Docker Compose）
- Git

### リポジトリのクローン

```bash
git clone <repository-url>
cd zairly
```

---

## アプリケーションの起動方法

本プロジェクトはDocker環境での開発を前提としています。

### 起動

```bash
# リポジトリルートから実行
./scripts/docker-dev.sh up
```

初回起動時はDockerイメージのビルドが行われるため、数分かかる場合があります。

### 起動確認

以下のURLでアクセスできることを確認してください：

- **フロントエンド**: http://localhost:3000
- **バックエンドAPI**: http://localhost:8000
- **APIドキュメント（Swagger UI）**: http://localhost:8000/docs

### ログの確認

```bash
# 全サービスのログを表示
./scripts/docker-dev.sh logs

# 特定サービスのログのみ表示
./scripts/docker-dev.sh logs api
./scripts/docker-dev.sh logs web
```

### 停止

```bash
./scripts/docker-dev.sh down
```

### その他の便利なコマンド

```bash
# サービスの再起動
./scripts/docker-dev.sh restart

# イメージの再ビルド
./scripts/docker-dev.sh rebuild

# コンテナに入る
./scripts/docker-dev.sh exec-api   # APIコンテナ
./scripts/docker-dev.sh exec-web   # Webコンテナ

# 完全クリーンアップ（ボリュームも削除）
./scripts/docker-dev.sh clean

# Lintの実行
./scripts/docker-dev.sh lint
```

詳細は [../infra/docker/README.md](../infra/docker/README.md) を参照してください。

---

## 開発ワークフロー

### 1. ブランチ戦略

- `main`: 本番環境用ブランチ
- `develop`: 開発用ブランチ（存在する場合）
- `feature/*`: 機能開発用ブランチ
- `fix/*`: バグ修正用ブランチ

新しい機能を開発する場合：

```bash
git checkout -b feature/your-feature-name
```

### 2. コード変更

コードを変更する前に、必ず [../CLAUDE.md](../CLAUDE.md) の開発ガイドラインを確認してください。

### 3. Lint / Format

コミット前に必ずLintを実行してください：

```bash
./scripts/docker-dev.sh lint
```

エラーがある場合は修正してください。自動修正も可能です：

**バックエンド:**
```bash
./scripts/docker-dev.sh exec-api
poetry run ruff check . --fix
poetry run ruff format .
exit
```

**フロントエンド:**
```bash
./scripts/docker-dev.sh exec-web
npx eslint . --fix
exit
```

### 4. コミット

```bash
git add .
git commit -m "feat: 新機能の説明"
```

コミットメッセージは以下のプレフィックスを使用：
- `feat:` - 新機能
- `fix:` - バグ修正
- `docs:` - ドキュメント変更
- `style:` - コードフォーマット
- `refactor:` - リファクタリング
- `test:` - テスト追加・修正
- `chore:` - その他の変更

### 5. プッシュとプルリクエスト

```bash
git push origin feature/your-feature-name
```

その後、GitHubでプルリクエストを作成してください。

---

## コーディング規約

### 全般
- [CLAUDE.md](../CLAUDE.md) の全ルールに従うこと
- ハードコーディングを避け、設定ファイルや環境変数を使用する
- 型アノテーションを必ず使用する（Python、TypeScript両方）

### バックエンド（Python / FastAPI）

#### レイヤ責務の厳守
- `api/`: HTTPエンドポイント定義のみ
- `schemas/`: Pydanticスキーマ定義
- `services/`: ビジネスロジック
- `core/`: 設定・共通依存関係

#### Docstring
- Google Styleを使用
- 全ての関数に型アノテーションとdocstringを記述

```python
def process_message(message: str) -> ChatResponse:
    """チャットメッセージを処理する.

    Args:
        message: ユーザからのメッセージ

    Returns:
        ChatResponse: 処理結果
    """
    pass
```

#### Linter
- Ruffを使用（設定は `pyproject.toml` に記載）
- 行の長さ: 100文字まで

### フロントエンド（TypeScript / Next.js）

#### ディレクトリ構成
- App Routerを使用
- コンポーネントは `app/components/` に配置（将来的に）
- ページは `app/` 直下に配置

#### コーディングスタイル
- ESLintのルールに従う
- 関数コンポーネントを使用
- 型定義を明示的に行う

```typescript
type Props = {
  message: string;
}

export function ChatMessage({ message }: Props) {
  return <div>{message}</div>;
}
```

### プロンプト管理

- LLMプロンプトは `packages/prompts/` に配置
- コード内に直接プロンプトを記述しない
- プロンプト変更はコード変更と同等に扱う

---

## トラブルシューティング

### Docker関連

#### ポートが既に使用されている

エラー: `Bind for 0.0.0.0:3000 failed: port is already allocated`

**解決方法:**
1. ポートを使用しているプロセスを停止する
2. または `infra/docker/compose.dev.yml` のポート設定を変更する

```yaml
ports:
  - "3001:3000"  # ホスト側のポートを変更
```

#### コンテナが起動しない

**解決方法:**
```bash
# ログを確認
./scripts/docker-dev.sh logs

# 完全にクリーンアップしてから再起動
./scripts/docker-dev.sh clean
./scripts/docker-dev.sh up
```

#### 依存関係が反映されない

`pyproject.toml` や `package.json` を変更した場合は、イメージの再ビルドが必要です：

```bash
./scripts/docker-dev.sh rebuild
```

#### ホットリロードが効かない

- ボリュームマウントが正しく設定されているか確認
- `compose.dev.yml` の `volumes` 設定を確認

---

## その他の情報

- [プロジェクト仕様書](SPECIFICATION.md)
- [開発ガイドライン](../CLAUDE.md)
- [タスク管理（TODO）](TODO.md)
- [Docker環境詳細](../infra/docker/README.md)
- [バックエンドREADME](../apps/api/README.md)
- [フロントエンドREADME](../apps/web/README.md)
