# SPECIFICATION

## 1. 目的
本アプリは、ユーザが「買った」「使った」消耗品や食材を **チャット形式の自然言語**で入力することで、  
AI が内容を理解し、バックエンドの DB に登録されている在庫情報を自動で更新することを目的とする。

ユーザは個数を直接指定せず、自然な会話のみで在庫管理ができる。

---

## 2. 全体アーキテクチャ

```text
[ User ]
   ↓（チャット入力）
[ Next.js Web（Frontend） ]
   ↓（APIリクエスト）
[ FastAPI（Backend / BFF） ]
   ↓（自然言語解析 / 正規化）
[ DB（初期: ローカル or SQLite）
   将来: Supabase (Postgres) ]
```

-	フロントエンドは UI に専念
-	自然言語の解釈・在庫更新ロジックはすべてバックエンドで処理
-	将来的に Supabase を DB / Auth 基盤として利用予定

## 3. 技術スタック

### フロントエンド
-	Next.js（App Router）
-	TypeScript
-	チャット UI

### バックエンド
-	Python
-	FastAPI
-	Pydantic（入出力スキーマ）
-	LLM（自然言語 → 在庫イベント変換）

### データベース
- 初期: シンプルな DB（SQLite 等）
- 将来: Supabase（PostgreSQL）

## 4. リポジトリ構成

```text
repo/
  apps/
    web/                 # Next.js (TypeScript)
      src/
      public/
      package.json
      next.config.mjs
      tsconfig.json
      .env.local.example

    api/                 # FastAPI (Python)
      app/
        main.py          # エントリポイント
        api/             # ルーティング層
        core/            # 設定・依存関係
        schemas/         # Pydantic（入出力モデル）
        services/        # 在庫更新・LLM解釈ロジック
      tests/
      pyproject.toml
      .env.example

  packages/
    prompts/             # LLM用プロンプト・辞書
      system.md
      templates/
      dictionaries/

  infra/
    docker/
      compose.dev.yml    # ローカル開発用（必要に応じて）

  scripts/
    dev.sh               # 開発用起動スクリプト
    lint.sh              # lint 統合スクリプト

  README.md
  .gitignore
```

## 5. バックエンド設計方針

### レイヤ責務

-	api/
    -	HTTP エンドポイント定義
    -	Request / Response の変換
-	schemas/
    -	API の入出力スキーマ
-	services/
    -	自然言語の解釈
    -	消耗品・食材名の正規化
    -	在庫増減ロジック
-	core/
    -	環境変数
    -	設定管理
    -	共通依存関係

### 処理フロー（例）

1. ユーザがチャットで入力
    - 「ティッシュを2箱買った」
2.	LLM が内容を解析
    -	item: ティッシュ
    -	action: buy
    -	quantity: 2
3.	DB 内の該当アイテムを特定
4.	在庫数を加算
5.	更新結果をレスポンスとして返却
6. プロンプト管理方針
    -	LLM の挙動をコードから切り離すため、packages/prompts/ に集約
    -	以下を管理対象とする：
    -	system prompt
    -	few-shot examples
    -	同義語・正規化辞書（例: ティッシュ / 箱ティッシュ）
7. 将来拡張を見据えた設計ポイント
    -	DB を Supabase に切り替え可能な構造
    -	在庫イベント（buy / use / adjust）を抽象化
    -	LLM 処理を worker に分離できる構成
    -	OpenAPI / 型共有を packages/ に追加可能

