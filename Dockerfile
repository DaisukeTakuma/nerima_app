FROM ruby:2.5.1

ENV APP_ROOT /usr/src/nerima_app
WORKDIR $APP_ROOT

RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list

#参考：https://qiita.com/haessal/items/0a83fe9fa1ac00ed5ee9
ENV DEBCONF_NOWARNINGS yes

RUN apt-get update
RUN apt-get install -y nodejs \
    npm \
    vim \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

ENV BUNDLER_VERSION 2.0.2
RUN \
  gem update bundler \
  echo 'gem: --no-document' >> ~/.gemrc && \
  cp ~/.gemrc /etc/gemrc && \
  chmod uog+r /etc/gemrc && \
  rm -rf ~/.gem && \
  bundle config --global build.nokogiri --use-system-libraries && \
  bundle config --global jobs 4 && \
  bundle install

COPY . $APP_ROOT
EXPOSE  3000

RUN npm install n -g \
    n stable \
    apt purge -y nodejs npm

RUN rm -f nerima_app/tmp/pids/server.pid
CMD ["bundle", "exec", "rails", "s", "puma", "-b", "0.0.0.0", "-p", "3000"]