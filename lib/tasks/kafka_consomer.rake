namespace :kafka do
  desc 'Consome as mensagem do Kafka'
  task consomer: :environment do
    KafkaConsumer.new.consume
  end
end