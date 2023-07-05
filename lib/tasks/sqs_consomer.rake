namespace :sqs do
  desc 'Consome as mensagem do SQS'
  task consomer: :environment do
    SqsConsumer.new.consume
  end
end