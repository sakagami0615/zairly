FROM python:3.11-slim

# 作業ディレクトリを設定
WORKDIR /app

# システムパッケージの更新とPoetryのインストール
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    build-essential && \
    curl -sSL https://install.python-poetry.org | python3 - && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Poetryのパスを通す
ENV PATH="/root/.local/bin:$PATH"

# Poetryの設定（仮想環境を作成しない）
RUN poetry config virtualenvs.create false

# 依存関係ファイルをコピー
COPY pyproject.toml ./

# 依存関係をインストール（開発用も含む）
RUN poetry install --no-root --with dev

# アプリケーションコードをコピー
COPY . .

# ポートを公開
EXPOSE 8000

# デフォルトコマンド
CMD ["poetry", "run", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
