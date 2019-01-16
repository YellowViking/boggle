FROM ruby:2.5-alpine

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

RUN gem install bundler

COPY Gemfile ./
RUN bundle lock
RUN bundle install --no-deployment

COPY . .

EXPOSE 3000

CMD ["ruby", "/usr/src/app/rails", "s"]