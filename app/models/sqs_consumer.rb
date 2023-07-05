require 'aws-sdk-sqs'

class SqsConsumer
  def initialize(queue = "desafio-rails")
    sqs_config = Rails.application.config_for(:aws_sqs)
    @sqs = Aws::SQS::Client.new(
      access_key_id: sqs_config[:access_key],
      secret_access_key: sqs_config[:secret_key],
      region: sqs_config[:region]
    )
    @queue_url = @sqs.create_queue(queue_name: queue).queue_url
  end

  def consume(queue_name="desafio_rails")
    puts "Consumidor SQS iniciado, aguardando mensagens"
  
    loop do
      puts "."
      
      messages = @sqs.receive_message(queue_url: @queue_url, max_number_of_messages: 10, wait_time_seconds: 20).messages
      messages.each do |message|
        puts "Processando csv clientes no SQS #{message.body}"
        CsvClientes.processar(message.body)
  
        @sqs.delete_message(queue_url: @queue_url, receipt_handle: message.receipt_handle)
      end

    end
  end
  
end
