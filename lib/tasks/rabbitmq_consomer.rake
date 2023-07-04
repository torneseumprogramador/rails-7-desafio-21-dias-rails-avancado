namespace :rabbitmq do
  desc 'Consome as mensagem do RabbitMQ'
  task consomer: :environment do
    RabbitMqConsumer.new.consume
  end
end