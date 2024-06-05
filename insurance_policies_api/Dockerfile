FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs && \
apt-get clean && rm -rf /var/lib/apt/lists/*

ARG UID=1000
ARG GID=1000

WORKDIR /app

COPY Gemfile* ./

RUN bundle install

COPY . .

COPY entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 5000

ENTRYPOINT [ "entrypoint.sh" ]

RUN addgroup --gid $GID mygroup && \
    adduser --disabled-password --gecos '' --uid $UID --gid $GID myuser

USER myuser

CMD [ "rails", "server", "-b", "0.0.0.0" ]
