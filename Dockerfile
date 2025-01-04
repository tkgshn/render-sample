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

# フロントエンドのビルド成果物をバックエンドに統合
COPY --from=frontend-build /app/frontend/build ./public

# ポートの設定
ENV PORT=3000
EXPOSE 3000

# サーバーを起動
CMD ["yarn", "start"]
