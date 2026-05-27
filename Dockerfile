FROM ruby:3.4

# 必要パッケージ
#   gemのネイティブ拡張をコンパイルするため（Cコンパイル環境）
#   PostgreSQL接続用ライブラリ（pg gemに必要）
#   RailsのJS関連（importmap / webpack / esbuildなど）
#   DB接続確認・マイグレーション用ツール
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  postgresql-client

# 作業ディレクトリ
WORKDIR /app

# 以降は初期化後にコメント解除する ==================

# bundler高速化
COPY Gemfile Gemfile.lock ./

RUN bundle install

# アプリコピー
COPY . .

# Rails起動ポート
EXPOSE 3000

# サーバ起動
CMD ["bash"]
