require 'kafka'

class KafkaProducer
  def initialize
    kafka_config = Rails.application.config_for(:kafka)
    @kafka = Kafka.new(seed_brokers: kafka_config[:bootstrap_servers])
    @topic = kafka_config[:topic]
  end

  def produce(message)
    @kafka.deliver_message(message, topic: @topic)
  end
end
