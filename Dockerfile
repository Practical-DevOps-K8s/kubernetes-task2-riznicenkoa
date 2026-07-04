FROM ruby:3.3-slim

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    git \
    curl \
    patch \
    ruby-dev \
    zlib1g-dev \
    liblzma-dev \
    pkg-config \
    libffi-dev \
    libssl-dev \
    libyaml-dev \
    libreadline-dev \
    libgmp-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler -v $(awk '/BUNDLED WITH/{getline; print $1}' Gemfile.lock || echo "2.4.20")
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
