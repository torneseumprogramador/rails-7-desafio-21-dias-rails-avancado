FROM ruby:latest

RUN gem install bundler

RUN mkdir app

WORKDIR app

COPY . /app

RUN bundle instal

# Exponha a porta padrão do Rails
EXPOSE 3000

# Configure o comando padrão a ser executado
CMD ["rails", "server", "-b", "0.0.0.0"]
