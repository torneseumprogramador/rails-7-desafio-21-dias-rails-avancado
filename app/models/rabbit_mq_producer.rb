require 'bunny'

class RabbitMqProducer
  def initialize
    connection = Bunny.new(connection_params)
    connection.start
    @channel = connection.create_channel
  end

  def produce(message, queue_name="desafio_rails")
    queue = @channel.queue(queue_name)
    queue.publish(message)
  end

  private

  def connection_params
    Rails.application.config_for(:rabbitmq).symbolize_keys
  end
end
