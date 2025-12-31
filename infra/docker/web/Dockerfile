FROM node:20-slim

# 作業ディレクトリを設定
WORKDIR /app

# package.jsonとpackage-lock.jsonをコピー
COPY package*.json ./

# 依存関係をインストール
RUN npm install

# アプリケーションコードをコピー
COPY . .

# Next.jsのポートを公開
EXPOSE 3000

# デフォルトコマンド
CMD ["npm", "run", "dev"]
