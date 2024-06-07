FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y libpq-dev nodejs && \
apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile* ./

RUN bundle install

COPY . .

COPY entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 5000

ENTRYPOINT [ "entrypoint.sh" ]

CMD [ "rails", "server", "-b", "0.0.0.0" ]
