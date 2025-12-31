# Zairly - AI在庫管理アプリ

チャット形式の自然言語で消耗品・食材の在庫を管理するアプリケーション

<em>[TODO.md spec & Kanban Board](https://bit.ly/3fCwKfM)</em>

### Todo

- [ ] フロントエンド: チャットUI実装（メッセージ送信・表示）
- [ ] フロントエンド: 在庫一覧表示機能
- [ ] フロントエンド: APIクライアント実装（fetch/axios）
- [ ] フロントエンド: エラーハンドリング実装
- [ ] バックエンド: LLM統合（OpenAI API等）
- [ ] バックエンド: データベース実装（SQLite）
- [ ] バックエンド: 在庫CRUD API実装
- [ ] バックエンド: アイテム名正規化ロジック実装
- [ ] バックエンド: 在庫イベント履歴機能
- [ ] インフラ: 環境変数の設定（LLM APIキー等）
- [ ] インフラ: テスト実装（バックエンド）
- [ ] インフラ: テスト実装（フロントエンド）
- [ ] インフラ: CI/CD設定（GitHub Actions等）
- [ ] 拡張: Supabaseへの移行準備
- [ ] 拡張: 認証機能（Auth）
- [ ] 拡張: マルチユーザー対応
- [ ] 拡張: 在庫アラート機能

### In Progress


### Done ✓

- [x] 環境構築: モノレポ構成の作成
- [x] 環境構築: バックエンド（FastAPI）基本構造実装
- [x] 環境構築: フロントエンド（Next.js）基本構造実装
- [x] 環境構築: プロンプト管理ディレクトリ作成
- [x] 環境構築: Docker環境構築
- [x] 環境構築: 開発用スクリプト作成（dev.sh, docker-dev.sh, lint.sh）
- [x] 環境構築: .gitignore設定
- [x] 環境構築: README作成
- [x] ドキュメント: 開発者向けドキュメント作成（DEVELOPERS.md）
- [x] ドキュメント: Docker環境ドキュメント作成
- [x] ドキュメント: プロジェクト仕様書作成（SPECIFICATION.md）
- [x] バックエンド基盤: FastAPIエントリポイント実装
- [x] バックエンド基盤: レイヤ構成（api/core/schemas/services）
- [x] バックエンド基盤: チャットAPIエンドポイント（スタブ）
- [x] バックエンド基盤: Pydanticスキーマ定義（ChatRequest/ChatResponse/InventoryEvent）
- [x] バックエンド基盤: 在庫イベント種別定義（BUY/USE/ADJUST）
- [x] バックエンド基盤: 設定管理（core/config.py）
- [x] フロントエンド基盤: Next.js App Router構成
- [x] フロントエンド基盤: 基本ページ実装（ホーム）
- [x] フロントエンド基盤: Tailwind CSS設定
- [x] フロントエンド基盤: TypeScript設定
