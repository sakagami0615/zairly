# Prompts

LLM用のプロンプトと辞書を管理するパッケージ

## ディレクトリ構成

```
prompts/
├── system.md           # システムプロンプト
├── templates/          # プロンプトテンプレート
│   └── inventory.md    # 在庫イベント抽出用テンプレート
└── dictionaries/       # 正規化辞書
    └── items.json      # アイテム名の同義語辞書
```

## 使用方法

バックエンド（FastAPI）のservices層から参照します。

```python
# 例: プロンプトファイルの読み込み
import os
from pathlib import Path

PROMPTS_DIR = Path(__file__).parent.parent.parent / "packages" / "prompts"
system_prompt = (PROMPTS_DIR / "system.md").read_text()
```

## 設計方針

- プロンプトをコードから分離し、独立して管理
- プロンプト変更時はコード変更と同等に扱う
- バージョン管理の対象とする
