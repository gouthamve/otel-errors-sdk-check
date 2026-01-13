FROM ruby:3.3-slim

RUN apt-get update && apt-get install -y build-essential && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile ./
RUN bundle install

COPY app.rb .

EXPOSE 8080

CMD ["ruby", "app.rb"]
