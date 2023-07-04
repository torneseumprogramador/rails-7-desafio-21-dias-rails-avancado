require 'bunny'

class RabbitMqConsumer
  def initialize
    connection = Bunny.new(connection_params)
    connection.start
    @channel = connection.create_channel
  end

  def consume(queue_name="desafio_rails")
    puts "Consumidor RabbitMQ iniciado, aguardando mensagens"

    queue = @channel.queue(queue_name)
    queue.subscribe(block: true) do |delivery_info, properties, payload|
      puts "Processando csv clientes no RabbitMQ #{payload}"
      CsvClientes.processar(payload)
    end
  end

  private

  def connection_params
    Rails.application.config_for(:rabbitmq).symbolize_keys
  end
end
