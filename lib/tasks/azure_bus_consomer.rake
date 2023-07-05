namespace :azure_bus do
  desc 'Consome as mensagem do SQS'
  task consomer: :environment do
    AzureBusConsumer.new.consume
    # AzureBusProducer.new.produce("oi")
  end
end