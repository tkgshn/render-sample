# ---- Build Frontend ----
FROM node:18 AS frontend-build
WORKDIR /app/frontend
COPY frontend/package.json ./
RUN yarn install
COPY frontend/ ./
RUN yarn build

# ---- Setup Backend ----
FROM node:18
WORKDIR /app/backend
COPY backend/package.json ./  
RUN yarn install
COPY backend/ ./

# フロントエンドのビルド成果物をバックエンドにコピー
COPY --from=frontend-build /app/frontend/build ./public

# 環境変数を設定
ENV PORT=3000

# 必要なポートを公開
EXPOSE 3000

# アプリケーションを起動
CMD ["yarn", "start"]
