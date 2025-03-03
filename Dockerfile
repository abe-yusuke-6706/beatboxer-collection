FROM ruby:3.2.3
# ベースにするイメージを指定

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - \
  && wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn

RUN mkdir /testapp
WORKDIR /testapp
COPY Gemfile /testapp/
COPY Gemfile.lock /testapp/
RUN bundle install
# COPY package.json yarn.lock ./
# COPY package.json ./
# RUN yarn install
COPY . .

RUN yarn install --check-files

# RUN echo "Dockerfile.lock created" > Dockerfile.lock

CMD ["rails", "server", "-b", "0.0.0.0"]
# Dockerイメージ内のコンテナが起動されたときに自動的に実行されるデフォルトのコマンドを指定するためのDockerfileの命令
